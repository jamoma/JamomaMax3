#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Migrates old help patchers: every Jamoma object that this package does not have yet (j.remote, j.ui, j.view,
j.unit, j.send, ...) becomes a comment box naming it, and the patch cords to it are dropped.

    migrate_help.py --old ~/Developer/Jamoma/JamomaMax --package package/Jamoma --implemented conformance/implemented.txt

Works on the patcher and, recursively, on every subpatcher. Everything else is copied unchanged. Prints the
replaced objects per file.
"""

import argparse
import json
import pathlib
import sys

HELP_OBJECTS = ["j.parameter", "j.message", "j.return", "j.model", "j.init", "j.savebang", "j.pass", "j.send", "j.receive", "j.unit", "j.in", "j.out", "j.view", "j.remote", "j.ui", "j.node", "j.namespace", "j.map", "j.cue", "j.textslider"]


#: The dataspaces the core has (see jamoma::Dataspace::names()); a j.unit that asks for another one is replaced by a comment.
KNOWN_DATASPACES = {"gain", "time", "position", "temperature"}
#: Objects from other packages that the help patchers use and that are not part of this package.
OTHER_PACKAGE_OBJECTS = {"ambimonitor"}


def unavailable_name(box):
    """The name to show for a box that cannot work in this package, or '' if it can (other-package objects, unknown j.unit dataspaces)."""
    if box.get("maxclass") in OTHER_PACKAGE_OBJECTS:
        return box["maxclass"]
    text = box.get("text", "") if box.get("maxclass") == "newobj" else ""
    words = text.split()
    if words and words[0] in OTHER_PACKAGE_OBJECTS:
        return words[0]
    if words and words[0] == "j.unit" and "@dataspace" in words:
        index = words.index("@dataspace")
        if index + 1 < len(words) and words[index + 1] not in KNOWN_DATASPACES:
            return f"j.unit @dataspace {words[index + 1]}"
    return ""


def object_name(box):
    """The Jamoma object a box creates, else ''.

    That is the first word of its text, the bpatcher name or the maxclass (the user interface objects have their own
    maxclass), if it starts with 'j.' or ends with '.model' or '.view' (the DSP models and views of other Jamoma modules).
    """
    if str(box.get("maxclass", "")).startswith("j."):
        return box["maxclass"]
    if box.get("maxclass") == "bpatcher":
        name = str(box.get("name", ""))
        name = name[: -len(".maxpat")] if name.endswith(".maxpat") else name
    elif box.get("maxclass") == "newobj" and box.get("text"):
        name = box["text"].split()[0]
    else:
        return ""
    other_module = (name.endswith(".model") and name != "j.model") or name.endswith(".view") or ".view." in name or ".model." in name
    return name if name.startswith("j.") or other_module else ""


def comment_for(box, name):
    """The comment box that replaces a box."""
    rect = box.get("patching_rect", [20.0, 20.0, 200.0, 22.0])
    return {"box": {"id": box["id"], "maxclass": "comment", "text": f"[{name}: not in this version yet]",
                    "numinlets": 1, "numoutlets": 0, "patching_rect": [rect[0], rect[1], max(rect[2], 220.0), 20.0]}}


def migrate_patcher(patcher, implemented, replaced):
    """Replaces unavailable objects in a patcher dictionary (in place) and recurses into subpatchers."""
    gone = set()
    boxes = []
    for entry in patcher.get("boxes", []):
        box = entry["box"]
        name = unavailable_name(box) or object_name(box)
        if name and (name not in implemented or unavailable_name(box)):
            gone.add(box["id"])
            replaced.append(name)
            boxes.append(comment_for(box, name))
            continue
        if "patcher" in box:
            migrate_patcher(box["patcher"], implemented, replaced)
        boxes.append(entry)
    patcher["boxes"] = boxes
    patcher["lines"] = [l for l in patcher.get("lines", [])
                        if l["patchline"]["source"][0] not in gone and l["patchline"]["destination"][0] not in gone]


def set_fonts(patcher):
    """The fonts of the package: Arial, and size 12 where the old patcher had 13 (in place, subpatchers too)."""
    for entry in patcher.get("boxes", []):
        box = entry["box"]
        if "fontname" in box:
            box["fontname"] = "Arial"
        if box.get("fontsize") == 13 or box.get("fontsize") == 13.0:
            box["fontsize"] = 12.0
        if "patcher" in box:
            set_fonts(box["patcher"])


def main():
    """Command line entry point."""
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--old", required=True, type=pathlib.Path)
    p.add_argument("--package", required=True, type=pathlib.Path)
    p.add_argument("--implemented", required=True, type=pathlib.Path)
    p.add_argument("--only", nargs="*", default=[], help="migrate only these objects (the other help patchers, which may have been edited by hand, are left alone)")
    args = p.parse_args()
    implemented = {l.strip() for l in args.implemented.read_text().splitlines() if l.strip() and not l.startswith("#")}
    out_dir = args.package / "help"
    out_dir.mkdir(parents=True, exist_ok=True)
    for name in args.only or HELP_OBJECTS:
        source = args.old / "Jamoma/help" / f"{name}.maxhelp"
        data = json.loads(source.read_text(encoding="utf-8"))
        replaced = []
        migrate_patcher(data["patcher"], implemented, replaced)
        set_fonts(data["patcher"])
        (out_dir / f"{name}.maxhelp").write_text(json.dumps(data, indent="\t") + "\n", encoding="utf-8")
        print(f"{name}.maxhelp: replaced {len(replaced)}: {', '.join(sorted(set(replaced)))}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
