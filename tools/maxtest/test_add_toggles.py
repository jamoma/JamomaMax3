# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius
"""Tests for add_toggles.py: a toggle in front of every test.assert shows whether the check passed."""

import unittest

import add_toggles as at


def box(box_id, text, maxclass="newobj", patcher=None):
    """A box dictionary as Max writes it."""
    b = {"id": box_id, "maxclass": maxclass, "text": text, "numinlets": 1, "numoutlets": 1, "outlettype": [""],
         "patching_rect": [0.0, 0.0, 50.0, 22.0]}
    if patcher is not None:
        b["patcher"] = patcher
    return {"box": b}


def line(src, dst):
    """A patch cord from outlet 0 to inlet 0."""
    return {"patchline": {"source": [src, 0], "destination": [dst, 0]}}


def patcher(boxes, lines):
    """A patcher dictionary."""
    return {"boxes": boxes, "lines": lines}


def pairs(p):
    """The cords of a patcher as (source, destination) pairs."""
    return {(l["patchline"]["source"][0], l["patchline"]["destination"][0]) for l in p["lines"]}


def by_id(p, box_id):
    """The box with this id."""
    return next(e["box"] for e in p["boxes"] if e["box"]["id"] == box_id)


class AddTogglesTests(unittest.TestCase):
    def test_a_toggle_goes_between_the_source_and_the_assert(self):
        p = patcher([box("eq", "== 5"), box("a", "test.assert x/y")], [line("eq", "a")])
        at.add_toggles(p)
        toggle = next(e["box"]["id"] for e in p["boxes"] if e["box"]["maxclass"] == "toggle")
        self.assertEqual(pairs(p), {("eq", toggle), (toggle, "a")})

    def test_one_toggle_serves_every_source_of_an_assert(self):
        p = patcher([box("a", "x"), box("b", "y"), box("t", "test.assert z")], [line("a", "t"), line("b", "t")])
        at.add_toggles(p)
        toggles = [e["box"]["id"] for e in p["boxes"] if e["box"]["maxclass"] == "toggle"]
        self.assertEqual(len(toggles), 1)
        self.assertEqual(pairs(p), {("a", toggles[0]), ("b", toggles[0]), (toggles[0], "t")})

    def test_the_toggle_is_a_toggle_with_one_inlet_and_one_outlet(self):
        p = patcher([box("eq", "== 5"), box("a", "test.assert x")], [line("eq", "a")])
        at.add_toggles(p)
        toggle = next(e["box"] for e in p["boxes"] if e["box"]["maxclass"] == "toggle")
        self.assertEqual((toggle["numinlets"], toggle["numoutlets"]), (1, 1))
        self.assertEqual(toggle["outlettype"], ["int"])

    def test_it_is_idempotent(self):
        p = patcher([box("eq", "== 5"), box("a", "test.assert x")], [line("eq", "a")])
        at.add_toggles(p)
        first = (len(p["boxes"]), len(p["lines"]))
        at.add_toggles(p)
        self.assertEqual((len(p["boxes"]), len(p["lines"])), first)

    def test_other_boxes_and_a_lonely_assert_are_left_alone(self):
        p = patcher([box("a", "test.terminate"), box("lonely", "test.assert nothing feeds me")], [])
        at.add_toggles(p)
        self.assertFalse(any(e["box"]["maxclass"] == "toggle" for e in p["boxes"]))

    def test_subpatchers_are_handled(self):
        inner = patcher([box("eq", "== 1"), box("a", "test.assert x")], [line("eq", "a")])
        p = patcher([box("sub", "p sub", patcher=inner)], [])
        at.add_toggles(p)
        self.assertTrue(any(e["box"]["maxclass"] == "toggle" for e in inner["boxes"]))

    def test_the_ids_are_unique(self):
        p = patcher([box("eq", "== 5"), box("a", "test.assert x"), box("tg_a", "taken")], [line("eq", "a")])
        at.add_toggles(p)
        ids = [e["box"]["id"] for e in p["boxes"]]
        self.assertEqual(len(ids), len(set(ids)))


if __name__ == "__main__":
    unittest.main()
