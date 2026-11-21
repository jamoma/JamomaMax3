# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius
"""Tests for the max-test runner's pure parts (driver patcher, result summary, log parsing)."""

import json
import sqlite3
import tempfile
import unittest

import run_maxtests as rm


def make_db(path, tests, assertions):
    """Creates a results database like max-test's: tests(test_id, test_name, test_start, test_finish) and
    assertions(test_id_ext, assertion_name, assertion_value)."""
    c = sqlite3.connect(path)
    c.execute("create table tests (test_id integer primary key, test_name text, test_start text, test_finish text)")
    c.execute("create table assertions (assertion_id integer primary key, test_id_ext integer, assertion_name text, assertion_value text)")
    for tid, name, finish in tests:
        c.execute("insert into tests values (?,?,?,?)", (tid, name, "t0", finish))
    for tid, name, value in assertions:
        c.execute("insert into assertions (test_id_ext, assertion_name, assertion_value) values (?,?,?)", (tid, name, value))
    c.commit()
    c.close()


class DriverPatchTests(unittest.TestCase):
    def texts(self, patch):
        return [b["box"].get("text", "") for b in patch["patcher"]["boxes"]]

    def test_driver_runs_the_named_tests_in_one_message(self):
        patch = rm.make_driver(["a.maxtest", "b.maxtest"], quit_port=7390)
        self.assertIn(";test.master run a.maxtest b.maxtest", self.texts(patch))

    def test_driver_listens_for_a_quit_message(self):
        patch = rm.make_driver(["a.maxtest"], quit_port=7390)
        texts = self.texts(patch)
        self.assertIn("udpreceive 7390", texts)
        self.assertIn(";max quit", texts)

    def test_driver_patch_is_valid_json(self):
        json.dumps(rm.make_driver(["a.maxtest"], quit_port=7390))


class SummaryTests(unittest.TestCase):
    def run_summary(self, tests, assertions, wanted):
        with tempfile.TemporaryDirectory() as d:
            db = f"{d}/r.db3"
            make_db(db, tests, assertions)
            return rm.summarize(db, after_test_id=0, wanted=wanted)

    def test_all_passing_assertions_pass(self):
        r = self.run_summary([(1, "HD:/x/a.maxtest.maxpat", "t1")], [(1, "x", "Pass"), (1, "y", "Pass")], ["a.maxtest"])
        self.assertEqual(r["a.maxtest"][0], "PASS")

    def test_a_failing_assertion_fails_and_is_named(self):
        r = self.run_summary([(1, "HD:/x/a.maxtest.maxpat", "t1")], [(1, "good", "Pass"), (1, "Jamoma/bad", "Fail")], ["a.maxtest"])
        self.assertEqual(r["a.maxtest"][0], "FAIL")
        self.assertIn("Jamoma/bad", r["a.maxtest"][1])

    def test_no_assertions_is_a_fail(self):
        r = self.run_summary([(1, "HD:/x/a.maxtest.maxpat", "t1")], [], ["a.maxtest"])
        self.assertEqual(r["a.maxtest"][0], "FAIL")
        self.assertIn("no assertions", r["a.maxtest"][1])

    def test_test_that_never_started_is_a_timeout(self):
        r = self.run_summary([], [], ["a.maxtest"])
        self.assertEqual(r["a.maxtest"][0], "TIMEOUT")

    def test_test_that_never_finished_is_a_timeout(self):
        r = self.run_summary([(1, "HD:/x/a.maxtest.maxpat", "0")], [(1, "x", "Pass")], ["a.maxtest"])
        self.assertEqual(r["a.maxtest"][0], "TIMEOUT")

    def test_rows_from_an_earlier_run_are_ignored(self):
        with tempfile.TemporaryDirectory() as d:
            db = f"{d}/r.db3"
            make_db(db, [(1, "HD:/x/a.maxtest.maxpat", "t1")], [(1, "x", "Pass")])
            r = rm.summarize(db, after_test_id=1, wanted=["a.maxtest"])
        self.assertEqual(r["a.maxtest"][0], "TIMEOUT")


class LogTests(unittest.TestCase):
    def test_missing_objects_are_collected_from_the_log(self):
        text = "\n".join([
            "[2026-11-21 18:34:33.288 error] [1] j.parameter: No such object",
            "[2026-11-21 18:34:33.289 info] [1] something else",
            "[2026-11-21 18:34:33.290 error] [1] j.parameter: No such object",
            "[2026-11-21 18:34:33.291 error] [1] j.model: No such object",
        ])
        self.assertEqual(rm.missing_objects(text), ["j.model", "j.parameter"])

    def test_log_without_errors_has_no_missing_objects(self):
        self.assertEqual(rm.missing_objects("[x info] [1] all fine"), [])

    def test_completion_line_is_detected(self):
        self.assertTrue(rm.run_complete("[x info] [1] integration tests complete"))
        self.assertFalse(rm.run_complete("[x info] [1] startup"))


class NameTests(unittest.TestCase):
    def test_test_name_is_the_file_name_without_maxpat(self):
        self.assertEqual(rm.test_name("JamomaIntegrationTests/patchers/tests/Modular/j.parameter/a/x_y.maxtest.maxpat"), "x_y.maxtest")

    def test_non_test_files_are_rejected(self):
        with self.assertRaises(ValueError):
            rm.test_name("Jamoma/help/j.send.maxhelp")


if __name__ == "__main__":
    unittest.main()
