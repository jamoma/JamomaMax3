# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Tests for check_test_layout.py (run with `python3 -m unittest discover -s tools/maxtest`)."""

import json
import os
import tempfile
import unittest

import check_test_layout as c


def write_test(root, rel, assertions=("Jamoma/Modular/j.model/x/y",)):
    """Writes a test patcher below Modular/ (rel is relative to it, or starts with `..` to go outside)."""
    path = os.path.join(root, c.MODULAR, rel)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    boxes = [{"box": {"text": f"test.assert {a}"}} for a in assertions]
    with open(path, "w", encoding="utf-8") as f:
        json.dump({"patcher": {"boxes": boxes}}, f)


class CheckTestLayout(unittest.TestCase):
    """The rules of the layout, one at a time."""

    def test_a_good_tree_has_no_problems(self):
        with tempfile.TemporaryDirectory() as root:
            write_test(root, "j.model/j_model_a.maxtest.maxpat")
            write_test(root, "j.model/sub/j_model_b.maxtest.maxpat")
            write_test(root, "j.parameter/type_x/j_parameter_c.maxtest.maxpat", ["Jamoma/Modular/j.parameter/type_x/c"])
            self.assertEqual(c.problems(root), [])

    def test_a_test_outside_a_folder_is_reported(self):
        with tempfile.TemporaryDirectory() as root:
            write_test(root, "j_model_a.maxtest.maxpat")
            write_test(root, "../elsewhere/j_model_b.maxtest.maxpat")
            self.assertEqual(len(c.problems(root)), 2)

    def test_a_name_that_does_not_start_with_its_folder_is_reported(self):
        with tempfile.TemporaryDirectory() as root:
            write_test(root, "j.model/other_a.maxtest.maxpat")
            self.assertIn("must start with j_model_", c.problems(root)[0])

    def test_a_name_used_twice_is_reported(self):
        with tempfile.TemporaryDirectory() as root:
            write_test(root, "j.model/j_model_a.maxtest.maxpat")
            write_test(root, "j.model/sub/j_model_a.maxtest.maxpat")
            self.assertIn("also used by", c.problems(root)[0])

    def test_an_assertion_of_another_folder_is_reported(self):
        with tempfile.TemporaryDirectory() as root:
            write_test(root, "j.model/j_model_a.maxtest.maxpat", ["Jamoma/Modular/j.ui/x"])
            self.assertIn("must start with Jamoma/Modular/j.model/", c.problems(root)[0])

    def test_the_tests_of_this_repository_follow_the_layout(self):
        tests = os.path.join(os.path.dirname(__file__), "..", "..", "tests", "integration")
        self.assertEqual(c.problems(tests), [])


if __name__ == "__main__":
    unittest.main()
