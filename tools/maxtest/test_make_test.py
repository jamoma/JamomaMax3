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


if __name__ == "__main__":
    unittest.main()
