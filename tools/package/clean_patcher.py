#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Brings a patcher imported from the old Jamoma repository to the look of this package.

    clean_patcher.py <patcher>...

* Custom colours go: of comments, objects, messages, panels and every other box, and of the patcher backgrounds (subpatchers too). Jamoma objects
  (`j.…` boxes and bpatchers) keep theirs.
* Every font is Arial; a bold variant (`Lato Black`, `… Heavy`, `… Bold`) becomes Arial with the bold face.
* Font size 13 becomes 12.

Run it only on patchers that are being imported: it rewrites the whole file, so a patcher that has been arranged in Max by hand and saved is not
to be run through it without being asked.
"""

import json
import sys

#: Words in a font name that mean bold.
BOLD = ("bold", "black", "heavy")


def _is_jamoma(box) -> bool:
    """True for a Jamoma object: its class, the object in its text, or the patcher a bpatcher loads starts with `j.`."""
    words = str(box.get("text", "")).split()
    if str(box.get("maxclass", "")).startswith("j."):
        return True
    if box.get("maxclass") == "newobj" and words and words[0].startswith("j."):
        return True
    return box.get("maxclass") == "bpatcher" and str(box.get("name", "")).startswith("j.")


def _drop_colours(keys) -> None:
    """Removes every colour key (and the switches that turn a custom colour on) from a box or patcher dictionary."""
    for key in [k for k in keys if "color" in k]:
        del keys[key]


def _fonts(keys, name_key, size_key) -> None:
    """Arial (bold for a bold variant) and no size 13, for the font keys of a box or patcher dictionary."""
    name = keys.get(name_key)
    if name is not None:
        if any(word in str(name).lower() for word in BOLD) and name_key == "fontname":
            keys["fontface"] = 1
        keys[name_key] = "Arial"
    if keys.get(size_key) == 13:
        keys[size_key] = 12.0


def clean(patcher) -> None:
    """Cleans a patcher dictionary (and the patchers inside it) in place."""
    _drop_colours(patcher)
    _fonts(patcher, "default_fontname", "default_fontsize")
    for entry in patcher.get("boxes", []):
        box = entry["box"]
        if not _is_jamoma(box):
            _drop_colours(box)
        _fonts(box, "fontname", "fontsize")
        if "patcher" in box:
            clean(box["patcher"])


def main(paths) -> int:
    """Cleans each file in place (written with tabs, as the migration tool writes); returns 0."""
    for path in paths:
        with open(path, encoding="utf-8") as f:
            data = json.load(f)
        clean(data["patcher"])
        with open(path, "w", encoding="utf-8") as f:
            json.dump(data, f, indent="\t")
            f.write("\n")
        print(f"cleaned {path}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
