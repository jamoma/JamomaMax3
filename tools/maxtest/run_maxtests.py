#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius
"""Runs max-test patchers (the old Jamoma integration tests) in Max 9 and reports PASS/FAIL/TIMEOUT per test.

    run_maxtests.py --list conformance/m1-tests.txt --old ~/Developer/Jamoma/JamomaMax --out build/maxtests

The list has one test patcher per line (paths relative to --old; blank lines and # comments are skipped).
For each batch of tests it writes a small driver patcher that sends ``;test.master run <name>.maxtest ...``
(max-test runs them in sequence and records every assertion in an sqlite database), launches Max 9 through
Launch Services, waits for Max's own log to say the run is complete, asks Max to quit through a UDP message
(never kills it: a killed Max restores its previous session on the next launch), and reads the database.

It temporarily links three packages into ~/Documents/Max 9/Packages (only those that are not already there,
and it removes only what it created): Jamoma (this repository's package), max-test, and JamomaIntegrationTests
(which supplies test.list.equals) and, when it exists, JamomaMax3Tests (this repository's own tests in tests/max). It refuses to run while a Max 9 process is open.
"""

import argparse
import json
import os
import pathlib
import re
import socket
import sqlite3
import subprocess
import sys
import tempfile
import time

MAX_APP = "/Applications/Max 9/Max.app"
MAX_PROCESS = "Max 9/Max.app/Contents/MacOS/Max"
DB_PATH = "/Applications/Max 9/Macintosh HD--Applications-Max 9--maxtestresults.db3"
SUPPORT = pathlib.Path.home() / "Library/Application Support/Cycling '74/Max 9"
PACKAGES = pathlib.Path.home() / "Documents/Max 9/Packages"
QUIT_PORT = 7390


def test_name(path: str) -> str:
    """Returns the name max-test runs for a test patcher path: the file name without '.maxpat'."""
    base = pathlib.PurePosixPath(path).name
    if not base.endswith(".maxtest.maxpat"):
        raise ValueError(f"{path}: not a .maxtest.maxpat file")
    return base[: -len(".maxpat")]


def _box(box_id, text, inlets, outlets, x, y, maxclass="newobj"):
    """One box of a patcher dictionary."""
    return {"box": {"id": box_id, "maxclass": maxclass, "text": text, "numinlets": inlets, "numoutlets": outlets,
                    "outlettype": [""] * outlets, "patching_rect": [x, y, 200.0, 22.0]}}


def make_driver(names, quit_port=QUIT_PORT) -> dict:
    """Builds the driver patcher: runs the named tests after launch and quits Max when it receives /quit by UDP."""
    boxes = [
        _box("obj-1", "loadbang", 1, 1, 20.0, 20.0),
        _box("obj-2", "delay 2000", 2, 1, 20.0, 50.0),
        _box("obj-3", ";test.master run " + " ".join(names), 2, 1, 20.0, 80.0, "message"),
        _box("obj-4", f"udpreceive {quit_port}", 1, 1, 320.0, 20.0),
        _box("obj-5", "route /quit", 1, 2, 320.0, 50.0),
        _box("obj-6", ";max quit", 2, 1, 320.0, 80.0, "message"),
    ]
    lines = [(1, 2), (2, 3), (4, 5), (5, 6)]
    return {"patcher": {"fileversion": 1, "appversion": {"major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1},
                        "classnamespace": "box", "rect": [100.0, 100.0, 640.0, 200.0], "boxes": boxes,
                        "lines": [{"patchline": {"source": [f"obj-{a}", 0], "destination": [f"obj-{b}", 0]}} for a, b in lines]}}


def summarize(db_path, after_test_id, wanted) -> dict:
    """Reads the results database and returns {name: (status, detail)} for each wanted test name.

    Only rows with test_id above after_test_id count. A test that never started or never finished is TIMEOUT;
    a finished test with no assertions or any assertion other than 'Pass' is FAIL; otherwise PASS.
    """
    result = {name: ("TIMEOUT", "did not start") for name in wanted}
    conn = sqlite3.connect(db_path)
    try:
        for test_id, name, finish in conn.execute("select test_id, test_name, test_finish from tests where test_id > ? order by test_id", (after_test_id,)):
            key = pathlib.PurePosixPath(str(name).split(":")[-1]).name
            key = key[: -len(".maxpat")] if key.endswith(".maxpat") else key
            if key not in result:
                continue
            if finish in (None, "", 0, "0"):
                result[key] = ("TIMEOUT", "did not finish")
                continue
            values = conn.execute("select assertion_name, assertion_value from assertions where test_id_ext = ?", (test_id,)).fetchall()
            failed = [n for n, v in values if v != "Pass"]
            if not values:
                result[key] = ("FAIL", "no assertions were recorded")
            elif failed:
                result[key] = ("FAIL", "failed: " + ", ".join(failed))
            else:
                result[key] = ("PASS", f"{len(values)} assertions")
    finally:
        conn.close()
    return result


def missing_objects(log_text: str) -> list:
    """Returns the sorted object names that Max's log reports as 'No such object'."""
    return sorted(set(re.findall(r"\] ([^\s:]+): No such object", log_text)))


def run_complete(log_text: str) -> bool:
    """True once max-test has written 'integration tests complete' to Max's log."""
    return "integration tests complete" in log_text


def crashed_early(max_alive: bool, complete: bool, seconds_since_launch: float) -> bool:
    """True if Max is gone although the run did not complete (it has had 10 s to appear): a crash or an early quit."""
    return (not max_alive) and (not complete) and seconds_since_launch > 10


def should_abort(consecutive_crashes: int) -> bool:
    """True after two batches in a row in which Max disappeared, so a crashing build cannot keep relaunching Max."""
    return consecutive_crashes >= 2


def max_running() -> bool:
    """True while a Max 9 process exists."""
    return subprocess.run(["pgrep", "-f", MAX_PROCESS], capture_output=True).returncode == 0


def last_test_id(db_path) -> int:
    """The highest test_id in the database, or 0 if there is no database yet."""
    if not os.path.exists(db_path):
        return 0
    conn = sqlite3.connect(db_path)
    try:
        return conn.execute("select coalesce(max(test_id), 0) from tests").fetchone()[0]
    except sqlite3.Error:
        return 0
    finally:
        conn.close()


def send_quit(port=QUIT_PORT) -> None:
    """Asks the driver patcher to quit Max, with the OSC message /quit."""
    packet = b"/quit\x00\x00\x00,\x00\x00\x00"
    socket.socket(socket.AF_INET, socket.SOCK_DGRAM).sendto(packet, ("127.0.0.1", port))


def read_log() -> str:
    """The text of Max's current log file."""
    try:
        return (SUPPORT / "Logs/Max.log").read_text(errors="replace")
    except OSError:
        return ""


def clear_recovery() -> None:
    """Removes Max's crash-recovery workspace files, which Max would restore (and run) on the next launch."""
    for f in (SUPPORT / "Crash Recovery").glob("maxworkspace-*.txt"):
        f.unlink()


def progress_bar(done: int, total: int, width: int = 30) -> str:
    """A text progress bar such as '[=====>        ]  12/82' for done of total tests."""
    total = max(total, 1)
    filled = min(width, width * done // total)
    head = ">" if filled < width else "="
    return "[" + "=" * max(filled - 1, 0) + (head if filled else "") + " " * (width - filled) + f"] {done:>3}/{total}"


def read_set(path) -> list:
    """Reads the test list: one path per line, skipping blank lines and # comments."""
    lines = [l.strip() for l in pathlib.Path(path).read_text(encoding="utf-8").splitlines()]
    return [l for l in lines if l and not l.startswith("#")]


class Links:
    """Temporary symlinks in Max's Packages folder; only links this object created are removed again."""

    def __init__(self):
        self.created = []

    def add(self, name, target):
        link = PACKAGES / name
        if link.exists() or link.is_symlink():
            return
        os.symlink(str(target), link)
        self.created.append(link)

    def remove(self):
        for link in self.created:
            if link.is_symlink():
                link.unlink()
        self.created = []


def run_batch(names, workdir, per_test_timeout) -> tuple:
    """Launches Max once for the given test names; returns ({name: (status, detail)}, crashed)."""
    before = last_test_id(DB_PATH)
    patch = pathlib.Path(workdir) / "driver.maxpat"
    patch.write_text(json.dumps(make_driver(names)), encoding="utf-8")
    subprocess.run(["open", "-a", MAX_APP, str(patch)], check=True)
    launched = time.time()
    deadline = launched + per_test_timeout * len(names) + 15
    crashed = False
    while time.time() < deadline and not run_complete(read_log()):
        if crashed_early(max_running(), run_complete(read_log()), time.time() - launched):
            crashed = True
            break
        time.sleep(1)
    log = read_log()
    send_quit()
    for _ in range(30):
        if not max_running():
            break
        time.sleep(1)
    else:
        subprocess.run(["pkill", "-f", MAX_PROCESS])
        time.sleep(2)
        clear_recovery()
    results = summarize(DB_PATH, before, names)
    if crashed:
        results = {n: (s, d + "; Max exited before the test finished (crash?)") if s != "PASS" else (s, d) for n, (s, d) in results.items()}
        clear_recovery()
    gaps = missing_objects(log)
    if gaps:
        results = {n: (s, d + ("; missing objects: " + ", ".join(gaps) if s != "PASS" else "")) for n, (s, d) in results.items()}
    return results, crashed


def main() -> int:
    """Command line entry point. Returns 0 if every test passed."""
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--list", required=True, type=pathlib.Path, help="the test list")
    p.add_argument("--old", required=True, type=pathlib.Path, help="folder the list paths are relative to")
    p.add_argument("--out", required=True, type=pathlib.Path, help="folder for results.tsv")
    p.add_argument("--max-test", type=pathlib.Path, default=pathlib.Path.home() / "Developer/Jamoma/max-test")
    p.add_argument("--package", type=pathlib.Path, default=pathlib.Path(__file__).resolve().parents[2] / "package/Jamoma")
    p.add_argument("--per-launch", type=int, default=1, help="tests per Max launch (1 isolates crashes)")
    p.add_argument("--timeout", type=int, default=60, help="seconds per test")
    args = p.parse_args()

    if max_running():
        print("FAIL: Max 9 is already running; quit it first", file=sys.stderr)
        return 2
    paths = read_set(args.list)
    names = {test_name(path): path for path in paths}
    args.out.mkdir(parents=True, exist_ok=True)
    clear_recovery()
    links = Links()
    rows = []
    crashes = 0
    try:
        links.add("Jamoma", args.package)
        links.add("max-test", args.max_test)
        if (args.old / "JamomaIntegrationTests").is_dir():
            links.add("JamomaIntegrationTests", args.old / "JamomaIntegrationTests")
        own = pathlib.Path(__file__).resolve().parents[2] / "tests/max"
        if own.is_dir():
            links.add("JamomaMax3Tests", own)
        ordered = list(names)
        with tempfile.TemporaryDirectory() as work:
            for i in range(0, len(ordered), args.per_launch):
                batch = ordered[i:i + args.per_launch]
                results, crashed = run_batch(batch, work, args.timeout)
                for name, (status, detail) in results.items():
                    rows.append((names[name], status, detail))
                    print(f"{progress_bar(len(rows), len(ordered))} {status:8} {names[name]}  {detail}", flush=True)
                crashes = crashes + 1 if crashed else 0
                if should_abort(crashes):
                    print("ABORT: Max disappeared in two batches in a row; not launching it again. Check the crash reports.", file=sys.stderr)
                    break
    finally:
        links.remove()
        if max_running():
            pass
    (args.out / "results.tsv").write_text("".join(f"{a}\t{b}\t{c}\n" for a, b, c in rows), encoding="utf-8")
    passed = sum(1 for _, s, _ in rows if s == "PASS")
    print(f"{passed} of {len(rows)} passed")
    return 0 if passed == len(rows) else 1


if __name__ == "__main__":
    sys.exit(main())
