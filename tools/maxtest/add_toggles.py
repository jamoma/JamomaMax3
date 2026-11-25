#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Puts a toggle in front of every test.assert, so that a patcher shows by itself whether its checks passed.

    add_toggles.py <path>/<name>.maxtest.maxpat

Whatever fed a test.assert now feeds a toggle, and the toggle feeds the test.assert. The toggle passes its value on at once, so the test does
not change; when a check passes the toggle turns on, so you can open the patcher in Max and see it. A test.assert that already has a toggle
in front of it, or that nothing feeds, is left alone, so running the tool twice changes nothing. Subpatchers are handled too. Lay the files out
again afterwards (layout_patcher.py).
"""

import json
import sys


def _is_assert(box) -> bool:
    """True for a test.assert object."""
    words = (box.get("text") or "").split()
    return box.get("maxclass") == "newobj" and bool(words) and words[0] == "test.assert"


def _new_toggle(box_id) -> dict:
    """A toggle box as Max writes it."""
    return {"box": {"id": box_id, "maxclass": "toggle", "numinlets": 1, "numoutlets": 1, "outlettype": ["int"],
                    "parameter_enable": 0, "patching_rect": [0.0, 0.0, 24.0, 24.0]}}


def add_toggles(patcher) -> None:
    """Adds the toggles to a patcher dictionary (and the patchers inside it) in place."""
    boxes = patcher.get("boxes", [])
    for entry in boxes:
        if "patcher" in entry["box"]:
            add_toggles(entry["box"]["patcher"])
    lines = patcher.get("lines", [])
    kind = {e["box"]["id"]: e["box"] for e in boxes}
    taken = set(kind)
    for entry in list(boxes):
        assert_box = entry["box"]
        if not _is_assert(assert_box):
            continue
        aid = assert_box["id"]
        incoming = [l["patchline"] for l in lines if l["patchline"]["destination"][0] == aid]
        feeders = [l for l in incoming if kind.get(l["source"][0], {}).get("maxclass") != "toggle"]
        if not feeders:
            continue  # nothing feeds it, or only toggles do: nothing to add
        existing = [l["source"][0] for l in incoming if kind.get(l["source"][0], {}).get("maxclass") == "toggle"]
        if existing:
            toggle_id = existing[0]
        else:
            toggle_id = "tg_" + aid
            while toggle_id in taken:
                toggle_id += "_"
            taken.add(toggle_id)
            toggle = _new_toggle(toggle_id)
            boxes.append(toggle)
            kind[toggle_id] = toggle["box"]
            lines.append({"patchline": {"source": [toggle_id, 0], "destination": [aid, 0]}})
        for line in feeders:
            line["destination"] = [toggle_id, 0]


def main(paths) -> int:
    """Adds the toggles to each file in place; returns 0."""
    for path in paths:
        with open(path, encoding="utf-8") as f:
            data = json.load(f)
        add_toggles(data["patcher"])
        with open(path, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=1)
            f.write("\n")
        print(f"toggles added to {path}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
