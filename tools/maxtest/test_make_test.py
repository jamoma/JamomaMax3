# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Tests for make_test.py: patchers built from a description are valid, laid out and have toggles in front of their checks."""

import json
import os
import tempfile
import unittest

from make_test import TestPatcher


def build():
    """A small patcher: a model, two steps and one check."""
    t = TestPatcher()
    t.obj("m", "j.model pm", 1, 2)
    t.obj("ji", "j.init", 1, 2)
    t.obj("eq", "== 1", 2, 1)
    t.step_chain(("ji", 1), [("preset:new one", [("m", 0)]), ("1", [("eq", 0)])])
    t.check("a1", "Jamoma/Modular/j.model/x/y", feed="eq")
    return t


class MakeTestTests(unittest.TestCase):
    def test_saved_file_is_valid_json_with_toggle_and_terminate(self):
        with tempfile.TemporaryDirectory() as d:
            path = os.path.join(d, "x.maxtest.maxpat")
            build().save(path)
            with open(path, encoding="utf-8") as f:
                data = json.load(f)
        boxes = {e["box"]["id"]: e["box"] for e in data["patcher"]["boxes"]}
        self.assertEqual(boxes["a1"]["text"], "test.assert Jamoma/Modular/j.model/x/y")
        self.assertEqual(boxes["tg_a1"]["maxclass"], "toggle")
        self.assertEqual(boxes["sterm"]["text"], "test.terminate")
        cords = {(l["patchline"]["source"][0], l["patchline"]["destination"][0]) for l in data["patcher"]["lines"]}
        self.assertIn(("eq", "tg_a1"), cords)
        self.assertIn(("tg_a1", "a1"), cords)
        self.assertIn(("send", "sterm"), cords)

    def test_steps_fire_in_order_through_delays(self):
        t = build()
        cords = {(l["patchline"]["source"][0], l["patchline"]["destination"][0]) for l in t.lines}
        self.assertIn(("s0", "sd0"), cords)
        self.assertIn(("sd0", "s1"), cords)
        self.assertIn((("ji"), "s0"), cords)

    def test_every_box_is_laid_out_apart(self):
        with tempfile.TemporaryDirectory() as d:
            path = os.path.join(d, "x.maxtest.maxpat")
            build().save(path)
            with open(path, encoding="utf-8") as f:
                data = json.load(f)
        spots = [tuple(e["box"]["patching_rect"][:2]) for e in data["patcher"]["boxes"]]
        self.assertEqual(len(spots), len(set(spots)))

    def test_duplicate_ids_are_refused(self):
        t = TestPatcher()
        t.obj("a", "bang")
        with self.assertRaises(AssertionError):
            t.obj("a", "bang")



def build_blocks():
    """Two assertion blocks, as the author arranges them."""
    t = TestPatcher()
    t.obj("m", "j.map", 1, 2)
    t.receive("to_map", [("m", 0)])
    t.obj("lb", "loadbang", 1, 1)
    t.blocks("lb", [
        {"name": "quad", "assert": "Jamoma/Modular/j.map/functions/ease_in_quadratic", "to": "to_map",
         "send": ["function easeInQuadratic", 0.5], "holder": ("float 0.", ("m", 0)), "check": "expr abs($f1 - 0.25) < 0.00001"},
        {"name": "kept", "assert": "Jamoma/Modular/j.map/functions/kept", "to": "to_map",
         "send": [0.5], "holder": ("float 0.", ("m", 0)), "check": "== 1"},
    ])
    return t


class BlockTests(unittest.TestCase):
    def setUp(self):
        self.t = build_blocks()
        self.boxes = {e["box"]["id"]: e["box"] for e in self.t.boxes}
        self.cords = {(l["patchline"]["source"][0], l["patchline"]["source"][1], l["patchline"]["destination"][0], l["patchline"]["destination"][1])
                      for l in self.t.lines}

    def test_one_trigger_runs_the_blocks_right_to_left_and_ends_the_test(self):
        self.assertEqual(self.boxes["top"]["text"], "t b b b")
        self.assertIn(("lb", 0, "top", 0), self.cords)
        self.assertIn(("top", 0, "term", 0), self.cords)       # leftmost outlet fires last
        self.assertIn(("top", 2, "quad_t", 0), self.cords)     # the first block listed runs first
        self.assertIn(("top", 1, "kept_t", 0), self.cords)
        self.assertEqual(self.boxes["term"]["text"], "test.terminate")

    def test_the_block_trigger_orders_the_sends_and_reads_last(self):
        self.assertEqual(self.boxes["quad_t"]["text"], "t b 0.5 b")
        self.assertIn(("quad_t", 2, "quad_m0", 0), self.cords)  # first: the message
        self.assertIn(("quad_m0", 0, "quad_s0", 0), self.cords)
        self.assertEqual(self.boxes["quad_s0"]["text"], "s to_map")
        self.assertIn(("quad_t", 1, "quad_s1", 0), self.cords)  # then the number, straight from the trigger
        self.assertIn(("quad_t", 0, "quad_h", 0), self.cords)   # last: read the holder
        self.assertEqual(self.boxes["kept_t"]["text"], "t b 0.5")

    def test_the_block_ends_in_holder_check_and_assert(self):
        self.assertIn(("m", 0, "quad_h", 1), self.cords)
        self.assertIn(("quad_h", 0, "quad_c", 0), self.cords)
        self.assertIn(("quad_c", 0, "quad_a", 0), self.cords)
        self.assertTrue(self.boxes["quad_a"]["text"].startswith("test.assert "))

    def test_an_item_can_go_to_another_receive(self):
        t = TestPatcher()
        t.obj("lb", "loadbang", 1, 1)
        t.obj("m", "j.cue", 1, 2)
        t.blocks("lb", [{"name": "x", "assert": "Jamoma/Modular/j.cue/x/y", "to": "to_cue", "send": [(7, "to_a"), "recall one"],
                         "holder": ("float 0.", ("m", 0)), "check": "== 1"}])
        texts = {e["box"]["id"]: e["box"].get("text") for e in t.boxes}
        self.assertEqual(texts["x_s0"], "s to_a")
        self.assertEqual(texts["x_s1"], "s to_cue")
        self.assertEqual(texts["x_t"], "t b b 7")

    def test_no_delay_objects_are_made(self):
        self.assertFalse([b for b in self.boxes.values() if str(b.get("text", "")).startswith("delay")])

    def test_receive_feeds_its_targets(self):
        r = next(i for i, b in self.boxes.items() if b.get("text") == "r to_map")
        self.assertIn((r, 0, "m", 0), self.cords)


if __name__ == "__main__":
    unittest.main()
