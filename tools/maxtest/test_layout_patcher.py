# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius
"""Tests for layout_patcher.py: objects are placed below the ones that feed them."""

import unittest

import layout_patcher as lp


def box(box_id, text="x", outlets=1, maxclass="newobj", patcher=None):
    """A box dictionary as Max writes it."""
    b = {"id": box_id, "maxclass": maxclass, "text": text, "numinlets": 1, "numoutlets": outlets,
         "outlettype": [""] * outlets, "patching_rect": [0.0, 0.0, 50.0, 22.0]}
    if patcher is not None:
        b["patcher"] = patcher
    return {"box": b}


def line(src, outlet, dst, inlet=0):
    """A patch cord."""
    return {"patchline": {"source": [src, outlet], "destination": [dst, inlet]}}


def patcher(boxes, lines):
    """A patcher dictionary."""
    return {"fileversion": 1, "rect": [0.0, 0.0, 100.0, 100.0], "boxes": boxes, "lines": lines}


def rect(p, box_id):
    """The patching_rect of a box in a patcher dictionary."""
    return next(e["box"]["patching_rect"] for e in p["boxes"] if e["box"]["id"] == box_id)


class LayoutTests(unittest.TestCase):
    def test_a_chain_flows_downward(self):
        p = patcher([box("a"), box("b"), box("c")], [line("a", 0, "b"), line("b", 0, "c")])
        lp.layout(p)
        self.assertLess(rect(p, "a")[1], rect(p, "b")[1])
        self.assertLess(rect(p, "b")[1], rect(p, "c")[1])

    def test_an_object_sits_below_every_object_that_feeds_it(self):
        p = patcher([box("a"), box("b"), box("c"), box("d")],
                    [line("a", 0, "b"), line("b", 0, "d"), line("a", 0, "c"), line("c", 0, "d", 1)])
        lp.layout(p)
        for src, dst in (("a", "b"), ("b", "d"), ("a", "c"), ("c", "d")):
            self.assertLess(rect(p, src)[1], rect(p, dst)[1], f"{src} -> {dst}")

    def test_left_outlet_targets_are_left_of_right_outlet_targets(self):
        p = patcher([box("t", outlets=2), box("left"), box("right")], [line("t", 1, "right"), line("t", 0, "left")])
        lp.layout(p)
        self.assertLess(rect(p, "left")[0], rect(p, "right")[0])

    def test_a_chain_is_left_aligned(self):
        p = patcher([box("a", "short"), box("b", "a much longer object text"), box("c", "mid size")],
                    [line("a", 0, "b"), line("b", 0, "c")])
        lp.layout(p)
        self.assertEqual(rect(p, "a")[0], rect(p, "b")[0])
        self.assertEqual(rect(p, "b")[0], rect(p, "c")[0])

    def test_the_first_child_is_under_its_parent_and_the_others_to_the_right(self):
        p = patcher([box("t", outlets=3), box("a"), box("b"), box("c")],
                    [line("t", 0, "a"), line("t", 1, "b"), line("t", 2, "c")])
        lp.layout(p)
        self.assertEqual(rect(p, "t")[0], rect(p, "a")[0])
        self.assertLess(rect(p, "a")[0], rect(p, "b")[0])
        self.assertLess(rect(p, "b")[0], rect(p, "c")[0])

    def test_a_box_with_two_parents_does_not_break_the_chains(self):
        p = patcher([box("a"), box("b"), box("c"), box("d")],
                    [line("a", 0, "c"), line("b", 0, "c", 1), line("c", 0, "d")])
        lp.layout(p)
        self.assertEqual(rect(p, "c")[0], rect(p, "d")[0])
        self.assertLess(rect(p, "a")[1], rect(p, "c")[1])
        self.assertLess(rect(p, "b")[1], rect(p, "c")[1])

    def test_boxes_in_one_row_do_not_overlap(self):
        p = patcher([box("t", outlets=3), box("a", "a long object text here"), box("b", "another long object text"), box("c", "third")],
                    [line("t", 0, "a"), line("t", 1, "b"), line("t", 2, "c")])
        lp.layout(p)
        spans = sorted((rect(p, i)[0], rect(p, i)[0] + rect(p, i)[2]) for i in ("a", "b", "c"))
        for (_, end), (start, _) in zip(spans, spans[1:]):
            self.assertLessEqual(end, start)

    def test_a_feedback_cord_does_not_hang_or_pull_a_box_up(self):
        p = patcher([box("a"), box("b")], [line("a", 0, "b"), line("b", 0, "a")])
        lp.layout(p)
        self.assertLess(rect(p, "a")[1], rect(p, "b")[1])

    def test_unconnected_boxes_are_laid_out_too(self):
        p = patcher([box("a"), box("lonely")], [])
        lp.layout(p)
        self.assertGreaterEqual(rect(p, "lonely")[1], 0)

    def test_subpatchers_are_laid_out(self):
        inner = patcher([box("i"), box("o")], [line("i", 0, "o")])
        p = patcher([box("sub", patcher=inner)], [])
        lp.layout(p)
        self.assertLess(rect(inner, "i")[1], rect(inner, "o")[1])

    def test_a_toggle_gets_its_own_square_size(self):
        p = patcher([box("a"), box("tg", "", maxclass="toggle"), box("b")], [line("a", 0, "tg"), line("tg", 0, "b")])
        lp.layout(p)
        self.assertEqual(rect(p, "tg")[2:], [24.0, 24.0])

    def test_a_toggle_sits_directly_above_its_target_even_in_a_crowded_row(self):
        boxes = [box("src", "source", outlets=3), box("t1", "", maxclass="toggle"), box("t2", "", maxclass="toggle"),
                 box("a1", "test.assert a very long assertion name number one"), box("a2", "test.assert a very long assertion name number two")]
        lines = [line("src", 0, "t1"), line("src", 1, "t2"), line("t1", 0, "a1"), line("t2", 0, "a2")]
        p = patcher(boxes, lines)
        lp.layout(p)
        for toggle, target in (("t1", "a1"), ("t2", "a2")):
            self.assertEqual(rect(p, toggle)[0], rect(p, target)[0], toggle)
            self.assertLess(rect(p, toggle)[1], rect(p, target)[1])

    def test_the_window_is_big_enough(self):
        p = patcher([box("a", "a fairly long text for an object box"), box("b")], [line("a", 0, "b")])
        lp.layout(p)
        right = max(e["box"]["patching_rect"][0] + e["box"]["patching_rect"][2] for e in p["boxes"])
        bottom = max(e["box"]["patching_rect"][1] + e["box"]["patching_rect"][3] for e in p["boxes"])
        self.assertGreaterEqual(p["rect"][2], right)
        self.assertGreaterEqual(p["rect"][3], bottom)

    def test_laying_out_twice_gives_the_same_result(self):
        p = patcher([box("a", outlets=2), box("b"), box("c")], [line("a", 0, "b"), line("a", 1, "c")])
        lp.layout(p)
        once = [e["box"]["patching_rect"][:] for e in p["boxes"]]
        lp.layout(p)
        self.assertEqual(once, [e["box"]["patching_rect"] for e in p["boxes"]])


if __name__ == "__main__":
    unittest.main()
