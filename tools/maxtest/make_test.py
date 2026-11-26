#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Builds Max test patchers from a short description, so that new tests are written as code and come out laid out and with their toggles.

    from make_test import TestPatcher
    t = TestPatcher()
    t.obj("m", "j.model pm", 1, 2)
    t.step_chain(start=("ji", 1), steps=[("preset:new one", [("m", 0)])])
    t.check("a1", "Jamoma/Modular/j.model/edit/applies", feed=("eq", 0))
    t.save("path/j_model_preset_edit.maxtest.maxpat")

`obj` adds an object box (text, number of inlets and outlets), `msg` a message box, `line` a cord, `check` a `test.assert` with the name of the assertion
fed from an outlet (a toggle is put in front by add_toggles), `step_chain` a row of messages that fire one after the other (a delay between them) and a
`test.terminate` at the end. `save` adds the toggles, lays the patcher out (layout_patcher) and writes it as Max does.
"""

import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import add_toggles  # noqa: E402
import layout_patcher  # noqa: E402


class TestPatcher:
    """A patcher under construction."""

    def __init__(self, width=900.0, height=700.0):
        self.boxes = []
        self.lines = []
        self.rect = [34.0, 96.0, width, height]
        self._ids = set()

    def _add(self, box_id, text, maxclass, inlets, outlets, outlettype):
        assert box_id not in self._ids, f"duplicate box id {box_id}"
        self._ids.add(box_id)
        box = {"id": box_id, "maxclass": maxclass, "numinlets": inlets, "numoutlets": outlets, "outlettype": outlettype,
               "patching_rect": [0.0, 0.0, 100.0, 22.0]}
        if text is not None:
            box["text"] = text
        self.boxes.append({"box": box})

    def obj(self, box_id, text, inlets=1, outlets=1):
        """An object box."""
        self._add(box_id, text, "newobj", inlets, outlets, [""] * outlets)

    def msg(self, box_id, text):
        """A message box."""
        self._add(box_id, text, "message", 2, 1, [""])

    def line(self, source, destination):
        """A cord; each end is a box id or a (box id, index) pair (index 0 by default)."""
        s = source if isinstance(source, tuple) else (source, 0)
        d = destination if isinstance(destination, tuple) else (destination, 0)
        self.lines.append({"patchline": {"source": [s[0], s[1]], "destination": [d[0], d[1]]}})

    def check(self, box_id, name, feed):
        """A test.assert with this assertion name, fed from an outlet (box id or (box id, outlet))."""
        self.obj(box_id, f"test.assert {name}", 1, 1)
        self.line(feed, box_id)

    def step_chain(self, start, steps, delay=60, prefix="s"):
        """Messages that fire one after the other.

        steps is a list of (message text, [targets]) where the targets are the (box id, inlet) pairs the message goes to. The first message fires
        from `start` (an outlet), the next ones `delay` milliseconds apart, and a test.terminate follows the last one.
        """
        previous = start
        for i, (text, targets) in enumerate(steps):
            mid = f"{prefix}{i}"
            self.msg(mid, text)
            self.line(previous, mid)
            for t in targets:
                self.line(mid, t)
            did = f"{prefix}d{i}"
            self.obj(did, f"delay {delay}", 2, 1)
            self.line(mid, did)
            previous = did
        self.obj(f"{prefix}end", "delay 300", 2, 1)
        self.line(previous, f"{prefix}end")
        self.obj(f"{prefix}term", "test.terminate", 1, 0)
        self.line(f"{prefix}end", f"{prefix}term")

    def patcher(self):
        """The patcher dictionary."""
        return {"fileversion": 1, "appversion": {"major": 9, "minor": 2, "revision": 2, "architecture": "x64", "modernui": 1},
                "classnamespace": "box", "rect": list(self.rect), "boxes": self.boxes, "lines": self.lines}

    def save(self, path):
        """Adds the toggles, lays the patcher out and writes the file."""
        data = {"patcher": self.patcher()}
        add_toggles.add_toggles(data["patcher"])
        layout_patcher.layout(data["patcher"])
        with open(path, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=1)
            f.write("\n")
