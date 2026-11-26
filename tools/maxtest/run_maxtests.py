#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Runs max-test patchers (the tests in tests/integration) in Max 9 and reports PASS/FAIL/TIMEOUT per test.

    run_maxtests.py --all --out build/maxtests                 every test of the tree
    run_maxtests.py --dir j.model --dir j.ui --out build/maxtests   the tests in some folders of Modular/
    run_maxtests.py --list some-list.txt --out build/maxtests  the tests named in a list

The tests are the `*.maxtest.maxpat` files below `JamomaIntegrationTests/patchers/tests/Modular/<external>/` in --tests (default tests/integration of
this repository); --dir takes the name of a folder there (`j.model`, `j.parameter/general`). A list has one test patcher per line (paths relative to --tests;
blank lines and # comments are skipped).
The errors of the Max console (Max writes them to its log) are printed under the results of the launch that posted them and saved in
console.tsv; they do not change a verdict (some tests post errors on purpose).
For each batch of tests it writes a small driver patcher that sends ``;test.master run <name>.maxtest ...``
(max-test runs them in sequence and records every assertion in an sqlite database), launches Max 9 through
Launch Services, waits for Max's own log to say the run is complete, asks Max to quit through a UDP message
(never kills it: a killed Max restores its previous session on the next launch), and reads the database.

It temporarily links three packages into ~/Documents/Max 9/Packages (only those that are not already there,
and it removes only what it created): Jamoma (this repository's package), max-test, and JamomaIntegrationTests
(the tests, and test.list.equals). It refuses to run while a Max 9 process is open.
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


def console_errors(log_text: str) -> list:
    """Returns the errors of the Max console as Max's log has them (lines tagged `error]`), in order, each once with its count.

    The log does not say which object posted a message. Lines about missing objects are left out (see missing_objects).
    """
    counts = {}
    for message in re.findall(r"^\[[^\]\n]* error\] \[\d+\] (.*)$", log_text, re.MULTILINE):
        if "No such object" in message:
            continue
        counts[message] = counts.get(message, 0) + 1
    return [m if n == 1 else f"{m} ({n} times)" for m, n in counts.items()]


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


def read_log(newer_than: float = 0.0, path=None) -> str:
    """The text of Max's current log file; empty if it was last written before `newer_than` (the log of an earlier launch, before Max starts a new one)."""
    log = path if path is not None else SUPPORT / "Logs/Max.log"
    try:
        if log.stat().st_mtime < newer_than:
            return ""
        return log.read_text(errors="replace")
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


def needs_isolated_rerun(results: dict) -> list:
    """The names of the tests that did not pass in a batch run; each is run again alone, and that result counts."""
    return [name for name, (status, _detail) in results.items() if status != "PASS"]


def read_set(path) -> list:
    """Reads the test list: one path per line, skipping blank lines and # comments."""
    lines = [l.strip() for l in pathlib.Path(path).read_text(encoding="utf-8").splitlines()]
    return [l for l in lines if l and not l.startswith("#")]


MODULAR = pathlib.PurePosixPath("JamomaIntegrationTests/patchers/tests/Modular")


def find_tests(tests_root, folders=()) -> list:
    """Finds the tests below Modular/ in the tests folder: every `*.maxtest.maxpat` (in the given folders of Modular, or everywhere if there are none).

    Returns the paths relative to the tests folder, sorted. A folder that does not exist is an error (ValueError).
    """
    root = pathlib.Path(tests_root)
    found = []
    for folder in (folders or [""]):
        base = root / MODULAR / folder
        if not base.is_dir():
            raise ValueError(f"no test folder {MODULAR / folder} in {root}")
        found += [str(f.relative_to(root)) for f in base.rglob("*.maxtest.maxpat")]
    return sorted(set(found))


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
    """Launches Max once for the given test names; returns ({name: (status, detail)}, crashed, the console errors of the launch)."""
    before = last_test_id(DB_PATH)
    patch = pathlib.Path(workdir) / "driver.maxpat"
    patch.write_text(json.dumps(make_driver(names)), encoding="utf-8")
    subprocess.run(["open", "-a", MAX_APP, str(patch)], check=True)
    launched = time.time()
    deadline = launched + per_test_timeout * len(names) + 15
    crashed = False
    while time.time() < deadline and not run_complete(read_log(launched)):
        if crashed_early(max_running(), run_complete(read_log(launched)), time.time() - launched):
            crashed = True
            break
        time.sleep(1)
    log = read_log(launched)
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
    return results, crashed, console_errors(log)


def main() -> int:
    """Command line entry point. Returns 0 if every test passed."""
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--list", type=pathlib.Path, help="a file that names the tests to run, one path a line")
    p.add_argument("--dir", action="append", default=[], metavar="FOLDER", help="run the tests in this folder of Modular/ (repeat for more)")
    p.add_argument("--all", action="store_true", help="run every test of the tree")
    p.add_argument("--tests", "--old", dest="tests", type=pathlib.Path, default=pathlib.Path(__file__).resolve().parents[2] / "tests/integration",
                   help="folder that holds the JamomaIntegrationTests package; the paths are relative to it (default: tests/integration)")
    p.add_argument("--out", required=True, type=pathlib.Path, help="folder for results.tsv")
    p.add_argument("--max-test", type=pathlib.Path, default=pathlib.Path.home() / "Developer/Jamoma/max-test")
    p.add_argument("--package", type=pathlib.Path, default=pathlib.Path(__file__).resolve().parents[2] / "package/Jamoma")
    p.add_argument("--per-launch", type=int, default=1, help="tests per Max launch (1 isolates crashes)")
    p.add_argument("--fast", type=int, metavar="N", help="quick mode: N tests per Max launch, then every test that did not pass is run again alone "
                   "in a fresh Max and that result counts. Faster, with the same verdict for failures; run without --fast before a merge, "
                   "because a pass in a shared session could in principle depend on what ran before it")
    p.add_argument("--timeout", type=int, default=60, help="seconds per test")
    args = p.parse_args()

    if max_running():
        print("FAIL: Max 9 is already running; quit it first", file=sys.stderr)
        return 2
    if not (args.list or args.dir or args.all):
        p.error("say which tests to run: --all, --dir <folder> or --list <file>")
    try:
        paths = read_set(args.list) if args.list else []
        if args.all or args.dir:
            paths += find_tests(args.tests, [] if args.all else args.dir)
    except ValueError as e:
        print(f"FAIL: {e}", file=sys.stderr)
        return 2
    names = {test_name(path): path for path in paths}
    args.out.mkdir(parents=True, exist_ok=True)
    clear_recovery()
    links = Links()
    rows = []
    console_lines = []
    crashes = 0
    try:
        links.add("Jamoma", args.package)
        links.add("max-test", args.max_test)
        if (args.tests / "JamomaIntegrationTests").is_dir():
            links.add("JamomaIntegrationTests", args.tests / "JamomaIntegrationTests")
        ordered = list(names)
        with tempfile.TemporaryDirectory() as work:
            step = args.fast or args.per_launch
            for i in range(0, len(ordered), step):
                batch = ordered[i:i + step]
                results, crashed, errors = run_batch(batch, work, args.timeout)
                if args.fast:
                    for name in needs_isolated_rerun(results):
                        again, alone_crashed, alone_errors = run_batch([name], work, args.timeout)
                        results[name] = again[name]
                        crashed = crashed or alone_crashed
                        errors += [f"{names[name]} alone: {e}" for e in alone_errors]
                for name, (status, detail) in results.items():
                    rows.append((names[name], status, detail))
                    print(f"{progress_bar(len(rows), len(ordered))} {status:8} {names[name]}  {detail}", flush=True)
                for message in errors:
                    label = "console" if len(batch) == 1 else f"console (one of these {len(batch)} tests)"
                    print(f"    {label}: {message}", flush=True)
                    console_lines.append(f"{names[batch[0]] if len(batch) == 1 else 'batch of ' + str(len(batch))}\t{message}\n")
                crashes = crashes + 1 if crashed else 0
                if should_abort(crashes):
                    print("ABORT: Max disappeared in two batches in a row; not launching it again. Check the crash reports.", file=sys.stderr)
                    break
    finally:
        links.remove()
        if max_running():
            pass
    (args.out / "results.tsv").write_text("".join(f"{a}\t{b}\t{c}\n" for a, b, c in rows), encoding="utf-8")
    (args.out / "console.tsv").write_text("".join(console_lines), encoding="utf-8")
    passed = sum(1 for _, s, _ in rows if s == "PASS")
    print(f"{passed} of {len(rows)} passed")
    return 0 if passed == len(rows) else 1


if __name__ == "__main__":
    sys.exit(main())
