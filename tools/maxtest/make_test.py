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
`test.terminate` at the end (only for tests that must wait for postponed work). `blocks` builds the usual shape: one trigger running a block for each
assertion, with `receive` for the object under test. `save` adds the toggles, lays the patcher out (layout_patcher) and writes it as Max does.
"""

import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import add_toggles  # noqa: E402
import layout_patcher  # noqa: E402


def _number(value):
    """A number as Max writes it in a trigger: `2.` for a whole decimal number."""
    if isinstance(value, float) and value.is_integer():
        return f"{int(value)}."
    return repr(value)


class TestPatcher:
    """A patcher under construction."""

    def __init__(self, width=900.0, height=700.0):
        self.boxes = []
        self.lines = []
        self.rect = [34.0, 96.0, width, height]
        self._ids = set()

    def _add(self, box_id, text, maxclass, inlets, outlets, outlettype, extra=None):
        assert box_id not in self._ids, f"duplicate box id {box_id}"
        self._ids.add(box_id)
        box = {"id": box_id, "maxclass": maxclass, "numinlets": inlets, "numoutlets": outlets, "outlettype": outlettype,
               "patching_rect": [0.0, 0.0, 100.0, 22.0]}
        if text is not None:
            box["text"] = text
        if extra:
            box.update(extra)
        self.boxes.append({"box": box})

    def obj(self, box_id, text, inlets=1, outlets=1, **extra):
        """An object box; keyword arguments are more keys of the box (for example varname="x" for an object a script can delete)."""
        self._add(box_id, text, "newobj", inlets, outlets, [""] * outlets, extra)

    def msg(self, box_id, text):
        """A message box."""
        self._add(box_id, text, "message", 2, 1, [""])

    def line(self, source, destination):
        """A cord; each end is a box id or a (box id, index) pair (index 0 by default)."""
        s = source if isinstance(source, tuple) else (source, 0)
        d = destination if isinstance(destination, tuple) else (destination, 0)
        self.lines.append({"patchline": {"source": [s[0], s[1]], "destination": [d[0], d[1]]}})

    def counter(self, name, source, selector):
        """Counts the messages with this selector that come out of `source`.

        Returns (i, n): the id of the counter's `int` (reset by a `0` into its right inlet) and of the `int` that holds the count (reset the same way
        and read with a bang into its left inlet). Both right inlets have to be reset together, so a step "0" has the targets (i, 1) and (n, 1).
        """
        rt, t, i, p, n = (f"{name}_{k}" for k in ("rt", "t", "i", "p", "n"))
        self.obj(rt, f"route {selector}", 1, 2)
        self.obj(t, "t b", 1, 1)
        self.obj(i, "int", 2, 1)
        self.obj(p, "+ 1", 2, 1)
        self.obj(n, "int", 2, 1)
        self.line(source, rt)
        self.line(rt, t)
        self.line(t, i)
        self.line(i, p)
        self.line(p, (i, 1))
        self.line(p, (n, 1))
        return i, n

    def check(self, box_id, name, feed):
        """A test.assert with this assertion name, fed from an outlet (box id or (box id, outlet))."""
        self.obj(box_id, f"test.assert {name}", 1, 1)
        self.line(feed, box_id)

    def receive(self, name, targets):
        """A `r name` object whose cord goes to the targets (box id or (box id, inlet)), so that the blocks need no long cords to them."""
        rid = f"r_{name}"
        self.obj(rid, f"r {name}", 0, 1)
        for t in targets:
            self.line(rid, t)

    def blocks(self, start, blocks):
        """One trigger that runs a block for each assertion, the first block listed first, and ends the test.

        `start` is the outlet that begins the test (a loadbang, or the end outlet of j.init). Each block is a dictionary with: `name` (the prefix of
        its box ids), `assert` (the assertion name), `to` (the name of the receive that the object under test listens on), `send` (what to send to it,
        in order: a string becomes a message box, a number comes straight out of the block's trigger), `holder` (object text and the (box, outlet) whose
        value it holds, for example `("float 0.", ("m", 0))`) and `check` (an object that turns the held value into 1 for a pass).
        No delays are used: Max triggers fire from right to left, so the sends happen in order and the holder is read last.
        """
        count = len(blocks)
        self.obj("top", "t " + " ".join(["b"] * (count + 1)), 1, count + 1)
        self.line(start, "top")
        self.obj("term", "test.terminate", 1, 0)
        self.line(("top", 0), "term")
        for index, block in enumerate(blocks):
            name, items = block["name"], block["send"]
            tokens = ["b" if isinstance(v, str) else _number(v) for v in items]
            trigger = f"{name}_t"
            self.obj(trigger, "t " + " ".join(["b"] + tokens[::-1]), 1, len(items) + 1)
            self.line(("top", count - index), trigger)
            for k, item in enumerate(items):
                outlet = len(items) - k
                send = f"{name}_s{k}"
                if isinstance(item, str):
                    self.msg(f"{name}_m{k}", item)
                    self.line((trigger, outlet), f"{name}_m{k}")
                self.obj(send, f"s {block['to']}", 1, 0)
                self.line(f"{name}_m{k}" if isinstance(item, str) else (trigger, outlet), send)
            text, source = block["holder"]
            self.obj(f"{name}_h", text, 2, 1)
            self.line((trigger, 0), f"{name}_h")
            self.line(source, (f"{name}_h", 1))
            self.obj(f"{name}_c", block["check"], 1, 1)
            self.line(f"{name}_h", f"{name}_c")
            self.check(f"{name}_a", block["assert"], feed=f"{name}_c")

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
