# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Tests for make_test.py: patchers built from a description are valid, laid out and have toggles in front of their checks."""

import json
import os
import tempfile
import unittest

from make_test import TestPatcher, delay, expect, send, step, wait, watch


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


def build_chain():
    """A chain of steps in subpatchers: one that waits and checks two things, one that only sets up."""
    t = TestPatcher()
    t.dut("m", "j.view", 1, 2, to="x_to_view", out={1: "x_from_view"})
    t.chain(("loadbang", 0), "Jamoma/Modular/j.view/x", [
        step("set_up", do=[wait(), send("x_to_view", "bang")]),
        step("binds", do=[send("x_to_view", "dump"), wait(2), send("x_to_view", 5)], expect=[
            expect("reports_its_model", watch("x_from_view", "route model:address", "sel /vu", "t 1")),
            expect("counts", [watch("x_from_view", "route a", hold="int -1"), watch("x_from_view", "route b", hold="int -1")],
                   check=["expr $i1*10+$i2", "== 12"]),
        ]),
    ])
    return t


def texts(patcher):
    """id -> text of the boxes of a patcher dictionary."""
    return {e["box"]["id"]: e["box"].get("text", e["box"]["maxclass"]) for e in patcher["boxes"]}


def cords(patcher):
    """The cords of a patcher dictionary as (source text, outlet, destination text, inlet)."""
    names = texts(patcher)
    return [(names[l["patchline"]["source"][0]], l["patchline"]["source"][1],
             names[l["patchline"]["destination"][0]], l["patchline"]["destination"][1]) for l in patcher["lines"]]


class ChainTests(unittest.TestCase):
    def setUp(self):
        self.t = build_chain()
        self.top = self.t.patcher()
        self.sub = {e["box"]["text"]: e["box"]["patcher"] for e in self.t.boxes if "patcher" in e["box"]}

    def test_steps_are_chained_through_their_left_outlets_to_the_terminate(self):
        c = cords(self.top)
        self.assertIn(("loadbang", 0, "p set_up", 0), c)
        self.assertIn(("p set_up", 0, "p binds", 0), c)
        self.assertIn(("p binds", 0, "test.terminate", 0), c)

    def test_every_result_leaves_on_its_own_outlet_into_its_assertion(self):
        c = cords(self.top)
        self.assertIn(("p binds", 1, "test.assert Jamoma/Modular/j.view/x/reports_its_model", 0), c)
        self.assertIn(("p binds", 2, "test.assert Jamoma/Modular/j.view/x/counts", 0), c)

    def test_the_object_under_test_has_its_receive_and_send(self):
        c = cords(self.top)
        self.assertIn(("r x_to_view", 0, "j.view", 0), c)
        self.assertIn(("j.view", 1, "s x_from_view", 0), c)

    def test_a_wait_is_a_deferlow_between_two_triggers_and_never_a_delay(self):
        all_texts = [t for p in self.sub.values() for t in texts(p).values()]
        self.assertEqual(sum(1 for t in all_texts if t == "deferlow"), 3)
        self.assertFalse([t for t in all_texts if t.startswith("delay")])

    def test_holders_are_reset_first_and_read_last(self):
        p = self.sub["p binds"]
        c = cords(p)
        first = next(d for s, o, d, i in c if s == "inlet")
        outlets = {o: d for s, o, d, i in c if s == first}
        top_outlet = max(outlets)
        self.assertEqual(outlets[top_outlet], "int 0")                   # the rightmost outlet fires first: a reset (of the first holder)
        self.assertEqual(outlets[0], "deferlow")                         # the leftmost fires last: wait
        self.assertIn((first, top_outlet, "int 0", 1), c)               # a constant of the trigger, into the cold inlet
        self.assertIn(("int -1", 0, "expr $i1*10+$i2", 0), c)
        self.assertIn(("int -1", 0, "expr $i1*10+$i2", 1), c)
        self.assertIn(("== 12", 0, "outlet", 0), c)

    def test_results_come_out_before_the_step_is_done(self):
        p = self.sub["p binds"]
        outlets = sorted((e["box"] for e in p["boxes"] if e["box"]["maxclass"] == "outlet"), key=lambda b: b["patching_rect"][0])
        done = outlets[0]["id"]
        final = [l["patchline"]["source"] for l in p["lines"] if l["patchline"]["destination"][0] == done]
        self.assertEqual(final[0][1], 0)                                 # done hangs on the leftmost outlet of the last trigger

    def test_a_start_value_that_is_not_a_number_is_a_message(self):
        t = TestPatcher()
        t.dut("m", "j.model pm", 1, 2, out={0: "x_from_m"})
        t.chain(("loadbang", 0), "Jamoma/Modular/j.model/x", [step("a", expect=[expect("b", watch("x_from_m", hold="zl reg none"), "zl compare 1 2")])])
        sub = next(e["box"]["patcher"] for e in t.boxes if "patcher" in e["box"])
        c = cords(sub)
        self.assertIn(("none", 0, "zl reg none", 1), c)
        self.assertNotIn("none", " ".join(x for x in texts(sub).values() if x.startswith("t ")))

    def test_a_delay_needs_a_reason_and_shows_it(self):
        with self.assertRaises(AssertionError):
            delay(100, "")
        t = TestPatcher()
        t.chain(("loadbang", 0), "Jamoma/Modular/j.map/x", [step("ramps", do=[delay(100, "the ramp needs time")])])
        sub = next(e["box"]["patcher"] for e in t.boxes if "patcher" in e["box"])
        self.assertIn("delay 100", texts(sub).values())
        self.assertIn("the ramp needs time", texts(sub).values())

    def test_a_receive_without_a_sender_is_refused(self):
        t = TestPatcher()
        with self.assertRaises(AssertionError):
            t.chain(("loadbang", 0), "Jamoma/Modular/j.map/x",
                    [step("a", expect=[expect("b", watch("x_from_nowhere", "== 1"))])])

    def test_a_send_without_a_receiver_is_refused(self):
        t = TestPatcher()
        with self.assertRaises(AssertionError):
            t.chain(("loadbang", 0), "Jamoma/Modular/j.map/x", [step("a", do=[send("x_to_nowhere", 1)])])

    def test_the_saved_chain_is_a_straight_column_with_apart_assertions(self):
        with tempfile.TemporaryDirectory() as d:
            path = os.path.join(d, "x.maxtest.maxpat")
            self.t.save(path)
            with open(path, encoding="utf-8") as f:
                data = json.load(f)["patcher"]
        boxes = [e["box"] for e in data["boxes"]]
        column = [b for b in boxes if b.get("text") in ("loadbang", "p set_up", "p binds", "test.terminate")]
        self.assertEqual(len({b["patching_rect"][0] for b in column}), 1)
        ys = [b["patching_rect"][1] for b in column]
        self.assertEqual(ys, sorted(ys))
        for i, a in enumerate(boxes):
            for b in boxes[i + 1:]:
                ax, ay, aw, ah = a["patching_rect"]
                bx, by, bw, bh = b["patching_rect"]
                self.assertFalse(ax < bx + bw and bx < ax + aw and ay < by + bh and by < ay + ah, (a.get("text"), b.get("text")))
        for b in boxes:
            if str(b.get("text", "")).startswith("test.assert"):
                feeder = next(l["patchline"]["source"][0] for l in data["lines"] if l["patchline"]["destination"][0] == b["id"])
                toggle = next(x for x in boxes if x["id"] == feeder)
                self.assertEqual(toggle["maxclass"], "toggle")
                self.assertEqual(toggle["patching_rect"][0], b["patching_rect"][0])
                self.assertLess(toggle["patching_rect"][1], b["patching_rect"][1])


if __name__ == "__main__":
    unittest.main()
