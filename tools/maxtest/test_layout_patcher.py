# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
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



def test_patcher():
    """A test patcher as the author arranges them: a starter, one trigger, a block for each assertion, send/receive to the object under test.

    The cords are given in an unhelpful order and every box starts at 0,0. Block `one` has an extra message in front of its send; `two` is shorter.
    """
    boxes = [box("lb", "loadbang"), box("top", "t b b b", outlets=3), box("term", "test.terminate")]
    lines = [line("lb", 0, "top"), line("top", 0, "term")]
    for name, outlet, long_one in (("one", 1, True), ("two", 2, False)):
        boxes += [box(f"t{name}", "t b 0.5 b", outlets=3), box(f"s{name}", "s to_map"), box(f"h{name}", "float 0."),
                  box(f"c{name}", f"expr abs($f1 - 0.25) < 0.00001"), box(f"g{name}", "", maxclass="toggle"),
                  box(f"a{name}", f"test.assert Jamoma/Modular/j.map/functions/a_rather_long_name_of_{name}")]
        lines += [line("top", outlet, f"t{name}"), line(f"t{name}", 0, f"h{name}"), line(f"t{name}", 1, f"s{name}"),
                  line("m", 0, f"h{name}", 1), line(f"h{name}", 0, f"c{name}"), line(f"c{name}", 0, f"g{name}"), line(f"g{name}", 0, f"a{name}")]
        if long_one:
            boxes.append(box(f"msg{name}", "function easeOutBounce", maxclass="message"))
            lines += [line(f"t{name}", 2, f"msg{name}"), line(f"msg{name}", 0, f"s{name}")]
        else:
            lines.append(line(f"t{name}", 2, f"s{name}"))
    boxes += [box("rcv", "r to_map"), box("m", "j.map")]
    lines.append(line("rcv", 0, "m"))
    return patcher(boxes, lines)


def span(p, ids):
    """The left and right edge of a group of boxes."""
    return min(rect(p, i)[0] for i in ids), max(rect(p, i)[0] + rect(p, i)[2] for i in ids)


BLOCK_ONE = ("tone", "msgone", "sone", "hone", "cone", "gone", "aone")
BLOCK_TWO = ("ttwo", "stwo", "htwo", "ctwo", "gtwo", "atwo")


class TestPatcherLayoutTests(unittest.TestCase):
    def setUp(self):
        self.p = test_patcher()
        lp.layout(self.p)

    def y(self, box_id):
        return rect(self.p, box_id)[1]

    def test_starter_and_top_trigger_are_at_the_top_left(self):
        self.assertLess(self.y("lb"), self.y("top"))
        for other in BLOCK_ONE + BLOCK_TWO:
            self.assertLess(self.y("top"), self.y(other), other)
            self.assertLessEqual(rect(self.p, "top")[0], rect(self.p, other)[0], other)

    def test_all_assertions_are_on_one_line(self):
        self.assertEqual(self.y("aone"), self.y("atwo"))

    def test_terminate_is_at_the_bottom_left_below_the_assertions(self):
        self.assertGreater(self.y("term"), self.y("aone"))
        self.assertEqual(rect(self.p, "term")[0], rect(self.p, "top")[0])

    def test_blocks_stand_side_by_side_in_the_order_of_the_outlets(self):
        one, two = span(self.p, BLOCK_ONE), span(self.p, BLOCK_TWO)
        self.assertLess(one[1], two[0], "the block of outlet 1 is left of the block of outlet 2 and they do not overlap")

    def test_each_block_reads_from_top_to_bottom(self):
        for chain in (("tone", "msgone", "sone", "hone", "cone", "gone", "aone"), ("ttwo", "stwo", "htwo", "ctwo", "gtwo", "atwo")):
            for upper, lower in zip(chain, chain[1:]):
                self.assertLess(self.y(upper), self.y(lower), f"{upper} above {lower}")

    def test_the_same_stage_is_on_the_same_line_in_every_block(self):
        for a, b in (("tone", "ttwo"), ("hone", "htwo"), ("cone", "ctwo"), ("gone", "gtwo")):
            self.assertEqual(self.y(a), self.y(b), f"{a} and {b}")

    def test_a_toggle_sits_directly_above_its_assertion(self):
        for name in ("one", "two"):
            self.assertEqual(rect(self.p, f"g{name}")[0], rect(self.p, f"a{name}")[0])

    def test_the_object_under_test_and_its_receive_stand_beside_the_blocks(self):
        right = max(span(self.p, BLOCK_ONE)[1], span(self.p, BLOCK_TWO)[1])
        for i in ("rcv", "m"):
            self.assertGreater(rect(self.p, i)[0], right, i)
        self.assertLess(self.y("rcv"), self.y("m"))

    def test_nothing_overlaps(self):
        rects = [e["box"]["patching_rect"] for e in self.p["boxes"]]
        for i, a in enumerate(rects):
            for b in rects[i + 1:]:
                apart = a[0] + a[2] <= b[0] or b[0] + b[2] <= a[0] or a[1] + a[3] <= b[1] or b[1] + b[3] <= a[1]
                self.assertTrue(apart, f"{a} overlaps {b}")

    def test_laying_out_twice_gives_the_same_result(self):
        once = [e["box"]["patching_rect"][:] for e in self.p["boxes"]]
        lp.layout(self.p)
        self.assertEqual(once, [e["box"]["patching_rect"] for e in self.p["boxes"]])

    def test_the_window_is_big_enough(self):
        self.assertGreaterEqual(self.p["rect"][2], max(r["box"]["patching_rect"][0] + r["box"]["patching_rect"][2] for r in self.p["boxes"]))
        self.assertGreaterEqual(self.p["rect"][3], self.y("term") + 22.0)



if __name__ == "__main__":
    unittest.main()
