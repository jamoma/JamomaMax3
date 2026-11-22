#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius
"""Opens help patchers in Max 9 and reports every object Max could not create.

    open_help.py package/Jamoma/help/j.parameter.maxhelp ...

Launches Max once with a driver patcher that quits when it receives /quit by UDP, opens each help patcher through
Launch Services, waits, reads Max's log for 'No such object' and error lines, then quits Max (never kills it). Uses the
helpers of run_maxtests.py and its temporary package link for Jamoma. Exit status 0 if nothing was missing.
"""

import json
import pathlib
import subprocess
import sys
import tempfile
import time

import run_maxtests as r


def quit_driver() -> dict:
    """The driver patcher without the test run: it only quits Max on /quit."""
    driver = r.make_driver([])
    boxes = [b for b in driver["patcher"]["boxes"] if b["box"]["id"] not in ("obj-2", "obj-3")]
    lines = [l for l in driver["patcher"]["lines"] if l["patchline"]["source"][0] not in ("obj-1", "obj-2")]
    driver["patcher"]["boxes"], driver["patcher"]["lines"] = boxes, lines
    return driver


def error_lines(log_text: str) -> list:
    """The log lines that are errors (Max writes them as '[time error] ...')."""
    return [l.split("] ", 2)[-1] for l in log_text.splitlines() if " error]" in l]


def main(argv) -> int:
    """Opens the help files named in argv; returns 0 if every object was created and no error was logged."""
    files = [pathlib.Path(a).resolve() for a in argv]
    if not files:
        print(__doc__)
        return 2
    if r.max_running():
        print("FAIL: Max 9 is already running; quit it first", file=sys.stderr)
        return 2
    r.clear_recovery()
    links = r.Links()
    problems = 0
    try:
        links.add("Jamoma", pathlib.Path(__file__).resolve().parents[2] / "package/Jamoma")
        with tempfile.TemporaryDirectory() as work:
            driver = pathlib.Path(work) / "driver.maxpat"
            driver.write_text(json.dumps(quit_driver()), encoding="utf-8")
            subprocess.run(["open", "-a", r.MAX_APP, str(driver)], check=True)
            time.sleep(12)
            for f in files:
                before = len(r.read_log())
                subprocess.run(["open", "-a", r.MAX_APP, str(f)], check=True)
                time.sleep(6)
                new = r.read_log()[before:]
                missing = r.missing_objects(new)
                errors = [e for e in error_lines(new) if "No such object" not in e]
                status = "OK" if not missing and not errors else "FAIL"
                problems += status == "FAIL"
                print(f"{status:5} {f.name}" + (f"  missing: {', '.join(missing)}" if missing else "") + "".join(f"\n        {e}" for e in errors[:5]), flush=True)
            r.send_quit()
            for _ in range(30):
                if not r.max_running():
                    break
                time.sleep(1)
            else:
                subprocess.run(["pkill", "-f", r.MAX_PROCESS])
                time.sleep(2)
            r.clear_recovery()
    finally:
        links.remove()
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
