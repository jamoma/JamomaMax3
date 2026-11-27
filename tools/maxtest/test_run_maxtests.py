# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Tests for the max-test runner's pure parts (driver patcher, result summary, log parsing)."""

import json
import sqlite3
import tempfile
import unittest
import pathlib
import os

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


class FindTestsTests(unittest.TestCase):
    """find_tests: the tests of a tree, or of some of its folders."""

    def make_tree(self, root):
        """Makes a small tree of tests and returns its root."""
        import pathlib
        for rel in ["j.model/j_model_a.maxtest.maxpat", "j.model/sub/j_model_b.maxtest.maxpat", "j.ui/j_ui_c.maxtest.maxpat", "j.ui/helper.maxpat"]:
            f = pathlib.Path(root) / rm.MODULAR / rel
            f.parent.mkdir(parents=True, exist_ok=True)
            f.write_text("{}")
        return root

    def test_all_tests_are_found_and_helpers_are_not(self):
        with tempfile.TemporaryDirectory() as root:
            found = rm.find_tests(self.make_tree(root))
            self.assertEqual([rm.test_name(f) for f in found], ["j_model_a.maxtest", "j_model_b.maxtest", "j_ui_c.maxtest"])

    def test_a_folder_gives_its_tests_with_those_of_its_subfolders(self):
        with tempfile.TemporaryDirectory() as root:
            found = rm.find_tests(self.make_tree(root), ["j.model"])
            self.assertEqual([rm.test_name(f) for f in found], ["j_model_a.maxtest", "j_model_b.maxtest"])

    def test_paths_are_relative_to_the_tests_folder(self):
        with tempfile.TemporaryDirectory() as root:
            found = rm.find_tests(self.make_tree(root), ["j.ui"])
            self.assertEqual(found, [str(rm.MODULAR / "j.ui/j_ui_c.maxtest.maxpat")])

    def test_an_unknown_folder_is_an_error(self):
        with tempfile.TemporaryDirectory() as root:
            with self.assertRaises(ValueError):
                rm.find_tests(self.make_tree(root), ["j.nothing"])


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


class ConsoleErrorTests(unittest.TestCase):
    def test_console_errors_are_the_error_lines_without_their_prefix(self):
        text = ("[2026-11-26 18:14:35.000000 info] [1] rnbo: args=[error]\n"
                "[2026-11-26 18:14:36.147476 error] [16263689] nonesuch is not a function (see function/library)\n"
                "[2026-11-26 18:14:36.200000 error] [16263689] expr: syntax error 1e30\n"
                "[2026-11-26 18:14:37.000000 info] [1] all fine\n")
        self.assertEqual(rm.console_errors(text), ["nonesuch is not a function (see function/library)", "expr: syntax error 1e30"])

    def test_a_repeated_error_is_listed_once_with_its_count(self):
        line = "[2026-11-26 18:14:36.1 error] [1] same thing\n"
        self.assertEqual(rm.console_errors(line * 3), ["same thing (3 times)"])

    def test_missing_objects_are_not_listed_twice(self):
        text = "[2026-11-26 18:14:36.1 error] [1] j.cue: No such object\n"
        self.assertEqual(rm.console_errors(text), [])

    def test_no_errors_give_an_empty_list(self):
        self.assertEqual(rm.console_errors("[x info] [1] fine"), [])


class ReadLogTests(unittest.TestCase):
    def test_the_log_of_an_earlier_launch_counts_as_empty(self):
        with tempfile.TemporaryDirectory() as d:
            log = pathlib.Path(d) / "Max.log"
            log.write_text("integration tests complete")
            os.utime(log, (1000.0, 1000.0))
            self.assertEqual(rm.read_log(newer_than=2000.0, path=log), "")

    def test_the_log_written_after_the_launch_is_read(self):
        with tempfile.TemporaryDirectory() as d:
            log = pathlib.Path(d) / "Max.log"
            log.write_text("new run")
            os.utime(log, (3000.0, 3000.0))
            self.assertEqual(rm.read_log(newer_than=2000.0, path=log), "new run")

    def test_a_missing_log_is_empty(self):
        self.assertEqual(rm.read_log(newer_than=0.0, path=pathlib.Path("/nonexistent/Max.log")), "")


class CrashTests(unittest.TestCase):
    def test_max_gone_before_completion_is_a_crash(self):
        self.assertTrue(rm.crashed_early(max_alive=False, complete=False, seconds_since_launch=30))

    def test_max_not_yet_started_is_not_a_crash(self):
        self.assertFalse(rm.crashed_early(max_alive=False, complete=False, seconds_since_launch=3))

    def test_max_gone_after_completion_is_fine(self):
        self.assertFalse(rm.crashed_early(max_alive=False, complete=True, seconds_since_launch=30))

    def test_running_max_is_not_a_crash(self):
        self.assertFalse(rm.crashed_early(max_alive=True, complete=False, seconds_since_launch=300))

    def test_two_crashes_in_a_row_abort_the_run(self):
        self.assertFalse(rm.should_abort(1))
        self.assertTrue(rm.should_abort(2))


class NameTests(unittest.TestCase):
    def test_test_name_is_the_file_name_without_maxpat(self):
        self.assertEqual(rm.test_name("JamomaIntegrationTests/patchers/tests/Modular/j.parameter/a/x_y.maxtest.maxpat"), "x_y.maxtest")

    def test_non_test_files_are_rejected(self):
        with self.assertRaises(ValueError):
            rm.test_name("Jamoma/help/j.send.maxhelp")


class FastModeTests(unittest.TestCase):
    def test_only_tests_that_did_not_pass_are_rerun(self):
        results = {"a": ("PASS", "1"), "b": ("FAIL", "x"), "c": ("TIMEOUT", "y")}
        self.assertEqual(rm.needs_isolated_rerun(results), ["b", "c"])


class ProgressBarTests(unittest.TestCase):
    def test_bar_shows_fraction_and_counts(self):
        self.assertEqual(rm.progress_bar(0, 4, 8), "[        ]   0/4")
        self.assertEqual(rm.progress_bar(2, 4, 8), "[===>    ]   2/4")
        self.assertEqual(rm.progress_bar(4, 4, 8), "[========]   4/4")


if __name__ == "__main__":
    unittest.main()
