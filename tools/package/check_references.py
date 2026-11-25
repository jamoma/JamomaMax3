#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Checks that the files a patcher of the package loads are in the package.

    check_references.py package/Jamoma

Every `bpatcher` (its `name`), every `js` object (the file in its text) and every `pictctrl` (its `name`) in a .maxpat or .maxhelp of the package must be
a file somewhere in the package (Max finds them through the package's search path, so only the file name counts). Prints each missing reference and exits with 1 if there is one.
"""

import json
import os
import sys


def references(patcher, source):
    """Yields (kind, file name, patcher file) for the files the boxes of a patcher (and its subpatchers) refer to."""
    for entry in patcher.get("boxes", []):
        box = entry["box"]
        cls = box.get("maxclass")
        if cls == "bpatcher" and box.get("name"):
            yield "bpatcher", box["name"], source
        elif cls == "pictctrl" and box.get("name"):
            yield "pictctrl", box["name"], source
        elif cls == "newobj":
            words = box.get("text", "").split()
            if len(words) >= 2 and words[0] == "js":
                yield "js", words[1], source
        if "patcher" in box:
            yield from references(box["patcher"], source)


def missing_references(package):
    """Returns the sorted list of (kind, file name, patcher file) that is not found below the package folder."""
    files = []
    present = set()
    for folder, _, names in os.walk(package):
        for name in names:
            present.add(name)
            if name.endswith((".maxpat", ".maxhelp")):
                files.append(os.path.join(folder, name))
    found = set()
    for path in files:
        with open(path, encoding="utf-8") as f:
            patcher = json.load(f)["patcher"]
        for kind, name, source in references(patcher, os.path.relpath(path, package)):
            if name not in present:
                found.add((kind, name, source))
    return sorted(found)


def main(argv):
    """Checks the package folder given as the only argument."""
    if len(argv) != 1:
        print(__doc__)
        return 2
    missing = missing_references(argv[0])
    for kind, name, source in missing:
        print(f"{source}: {kind} {name} is not in the package")
    return 1 if missing else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
