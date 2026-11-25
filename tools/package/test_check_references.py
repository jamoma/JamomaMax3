# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Tests for check_references.py (run with `python3 -m unittest discover -s tools/package`)."""

import json
import os
import tempfile
import unittest

import check_references


def write_patcher(folder, name, boxes):
    """Writes a patcher with the given boxes into a folder."""
    with open(os.path.join(folder, name), "w", encoding="utf-8") as f:
        json.dump({"patcher": {"boxes": [{"box": b} for b in boxes]}}, f)


class CheckReferences(unittest.TestCase):
    """Missing bpatchers, js files and pictures are found; present ones and subpatchers are handled."""

    def test_a_missing_bpatcher_is_reported(self):
        with tempfile.TemporaryDirectory() as package:
            write_patcher(package, "a.maxhelp", [{"maxclass": "bpatcher", "name": "gone.maxpat"}])
            self.assertEqual(check_references.missing_references(package), [("bpatcher", "gone.maxpat", "a.maxhelp")])

    def test_a_bpatcher_in_a_subfolder_is_found(self):
        with tempfile.TemporaryDirectory() as package:
            os.makedirs(os.path.join(package, "deep", "er"))
            write_patcher(os.path.join(package, "deep", "er"), "there.maxpat", [])
            write_patcher(package, "a.maxhelp", [{"maxclass": "bpatcher", "name": "there.maxpat"}])
            self.assertEqual(check_references.missing_references(package), [])

    def test_js_and_pictures_are_checked_and_subpatchers_are_searched(self):
        with tempfile.TemporaryDirectory() as package:
            inner = {"boxes": [{"box": {"maxclass": "newobj", "text": "js nowhere.js"}}, {"box": {"maxclass": "pictctrl", "name": "nothing.png"}}]}
            write_patcher(package, "a.maxpat", [{"maxclass": "newobj", "text": "p inner", "patcher": inner}])
            self.assertEqual(check_references.missing_references(package),
                             [("js", "nowhere.js", "a.maxpat"), ("pictctrl", "nothing.png", "a.maxpat")])

    def test_the_package_of_this_repository_is_complete(self):
        package = os.path.join(os.path.dirname(__file__), "..", "..", "package", "Jamoma")
        self.assertEqual(check_references.missing_references(package), [])


if __name__ == "__main__":
    unittest.main()
