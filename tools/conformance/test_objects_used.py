# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Tests for the conformance object-coverage tool."""

import json
import pathlib
import tempfile
import unittest

import objects_used


def patcher(*boxes):
    """Builds a patcher dictionary as it appears in a .maxpat file."""
    return {"patcher": {"boxes": [{"box": b} for b in boxes]}}


def newobj(text, **extra):
    """A plain object box with the given text."""
    return dict({"maxclass": "newobj", "text": text}, **extra)


def write(directory, name, content):
    """Writes a patcher fixture and returns its path."""
    path = pathlib.Path(directory) / name
    path.write_text(json.dumps(content), encoding="utf-8")
    return path


class ObjectsInPatcherTests(unittest.TestCase):
    def test_finds_class_from_newobj_text(self):
        with tempfile.TemporaryDirectory() as d:
            p = write(d, "a.maxpat", patcher(newobj("j.parameter gain @type decimal")))
            self.assertEqual(objects_used.objects_in_patcher(p), {"j.parameter"})

    def test_finds_user_interface_objects_by_maxclass(self):
        with tempfile.TemporaryDirectory() as d:
            p = write(d, "a.maxpat", patcher({"maxclass": "j.ui", "text": ""}))
            self.assertEqual(objects_used.objects_in_patcher(p), {"j.ui"})

    def test_recurses_into_subpatcher(self):
        inner = {"boxes": [{"box": newobj("j.send /x")}]}
        with tempfile.TemporaryDirectory() as d:
            p = write(d, "a.maxpat", patcher(newobj("p sub", patcher=inner)))
            self.assertEqual(objects_used.objects_in_patcher(p), {"j.send"})

    def test_ignores_non_j_objects(self):
        with tempfile.TemporaryDirectory() as d:
            p = write(d, "a.maxpat", patcher(newobj("metro 100"), newobj("pak 1 2"), {"maxclass": "comment", "text": "j.model is nice"}))
            self.assertEqual(objects_used.objects_in_patcher(p), set())

    def test_reports_a_file_that_is_not_json_by_raising_value_error(self):
        with tempfile.TemporaryDirectory() as d:
            path = pathlib.Path(d) / "bad.maxpat"
            path.write_text("not json", encoding="utf-8")
            with self.assertRaises(ValueError):
                objects_used.objects_in_patcher(path)


class CoverageTests(unittest.TestCase):
    def test_coverage_splits_covered_and_missing(self):
        covered, missing = objects_used.coverage({"j.model", "j.send", "j.cue"}, {"j.model", "j.loader"})
        self.assertEqual(covered, {"j.model"})
        self.assertEqual(missing, {"j.send", "j.cue"})


class ReadSetTests(unittest.TestCase):
    def test_read_set_skips_comments_and_blank_lines(self):
        with tempfile.TemporaryDirectory() as d:
            path = pathlib.Path(d) / "set.txt"
            path.write_text("# a comment\n\nJamoma/help/j.send.maxhelp\n  Jamoma/help/j.ui.maxhelp  \n", encoding="utf-8")
            self.assertEqual(objects_used.read_set(path), ["Jamoma/help/j.send.maxhelp", "Jamoma/help/j.ui.maxhelp"])


if __name__ == "__main__":
    unittest.main()
