#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Lists which j.* objects the conformance patchers use and which of them the new package implements.

    objects_used.py --old ~/Developer/Jamoma/JamomaMax --set conformance/set.txt --implemented implemented.txt

`set.txt` has one patcher path per line (relative to --old; blank lines and lines starting with # are skipped).
`implemented.txt` has one object name per line. The result is a Markdown report on standard output.
"""

import argparse
import json
import pathlib
import sys
from collections import Counter


def _walk(patcher: dict, found: set) -> None:
    """Collects the j.* object classes of a patcher dictionary and of every subpatcher in it."""
    for entry in patcher.get("boxes", []):
        box = entry.get("box", {})
        maxclass = box.get("maxclass", "")
        if maxclass == "newobj":
            words = box.get("text", "").split()
            if words and words[0].startswith("j."):
                found.add(words[0])
        elif maxclass.startswith("j."):
            found.add(maxclass)
        if isinstance(box.get("patcher"), dict):
            _walk(box["patcher"], found)


def objects_in_patcher(path: pathlib.Path) -> set:
    """Returns every j.* object class used in a .maxpat/.maxhelp file, including subpatchers.

    Raises ValueError if the file is not a patcher.
    """
    try:
        data = json.loads(pathlib.Path(path).read_text(encoding="utf-8"))
    except (json.JSONDecodeError, UnicodeDecodeError) as error:
        raise ValueError(f"{path}: not a patcher file ({error})") from error
    found: set = set()
    _walk(data.get("patcher", {}), found)
    return found


def coverage(used: set, implemented: set) -> tuple:
    """Splits the used classes into (covered, missing) by what is implemented."""
    return used & implemented, used - implemented


def read_set(path: pathlib.Path) -> list:
    """Reads the patcher list: one path per line, skipping blank lines and # comments."""
    lines = [line.strip() for line in pathlib.Path(path).read_text(encoding="utf-8").splitlines()]
    return [line for line in lines if line and not line.startswith("#")]


def main() -> int:
    """Command line entry point. Returns the process exit code."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--old", required=True, type=pathlib.Path)
    parser.add_argument("--set", required=True, type=pathlib.Path, dest="patcher_set")
    parser.add_argument("--implemented", required=True, type=pathlib.Path)
    args = parser.parse_args()

    implemented = set(read_set(args.implemented))
    per_patcher = {}
    unreadable = []
    for rel in read_set(args.patcher_set):
        path = args.old / rel
        if not path.is_file():
            unreadable.append(f"{rel} (missing)")
            continue
        try:
            per_patcher[rel] = objects_in_patcher(path)
        except ValueError as error:
            unreadable.append(f"{rel} ({error})")

    counts = Counter(name for used in per_patcher.values() for name in used)
    covered, missing = coverage(set(counts), implemented)
    print("# Conformance coverage baseline\n")
    print(f"Patchers read: {len(per_patcher)}; implemented objects: {len(implemented)}\n")
    print("## Objects used by the pass-bar set (patchers that use each)\n")
    for name, n in sorted(counts.items(), key=lambda item: (-item[1], item[0])):
        print(f"- `{name}`: {n} {'(implemented)' if name in covered else '(missing)'}")
    print("\n## Per patcher\n")
    for rel, used in sorted(per_patcher.items()):
        gaps = sorted(used - implemented)
        print(f"- `{rel}`: {len(used)} objects, missing: {', '.join('`'+g+'`' for g in gaps) or 'none'}")
    if unreadable:
        print("\n## Not read\n")
        for item in unreadable:
            print(f"- {item}")
    return 0 if not unreadable else 1


if __name__ == "__main__":
    sys.exit(main())
