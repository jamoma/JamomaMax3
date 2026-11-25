#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Checks that the Max tests follow the layout of tests/integration (see its README).

    check_test_layout.py tests

Every `*.maxtest.maxpat` below the given folder must be

- in `JamomaIntegrationTests/patchers/tests/Modular/<folder>/` (in a subfolder of it is fine),
- named after that folder: `<folder with its dots as underscores>_...` (`j_model_...` in `j.model`),
- the only one with its name in the whole tree (max-test finds a test by its name), and
- made of assertions whose names start with `Jamoma/Modular/<folder>/`.

Prints every problem and exits with 1 if there is one.
"""

import json
import os
import sys

MODULAR = os.path.join("JamomaIntegrationTests", "patchers", "tests", "Modular")


def assertion_names(patcher):
    """Yields the names of the test.assert objects of a patcher and its subpatchers."""
    for entry in patcher.get("boxes", []):
        box = entry["box"]
        words = box.get("text", "").split()
        if len(words) >= 2 and words[0] == "test.assert":
            yield words[1]
        if "patcher" in box:
            yield from assertion_names(box["patcher"])


def problems(root):
    """Returns the list of problems (text) of the tests below a folder."""
    found = []
    seen = {}
    for folder, _, names in os.walk(root):
        for name in sorted(names):
            if not name.endswith(".maxtest.maxpat"):
                continue
            path = os.path.join(folder, name)
            rel = os.path.relpath(path, root)
            if name in seen:
                found.append(f"{rel}: the name is also used by {seen[name]}")
            seen[name] = rel
            parts = os.path.relpath(path, os.path.join(root, MODULAR)).split(os.sep)
            if parts[0] == ".." or len(parts) < 2:
                found.append(f"{rel}: a test must be in a folder of {MODULAR}")
                continue
            external = parts[0]
            if not name.startswith(external.replace(".", "_") + "_"):
                found.append(f"{rel}: the name must start with {external.replace('.', '_')}_")
            with open(path, encoding="utf-8") as f:
                patcher = json.load(f)["patcher"]
            for assertion in assertion_names(patcher):
                if not assertion.startswith(f"Jamoma/Modular/{external}/"):
                    found.append(f"{rel}: the assertion {assertion} must start with Jamoma/Modular/{external}/")
    return found


def main(argv):
    """Checks the folder given as the only argument."""
    if len(argv) != 1:
        print(__doc__)
        return 2
    found = problems(argv[0])
    for line in found:
        print(line)
    return 1 if found else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
