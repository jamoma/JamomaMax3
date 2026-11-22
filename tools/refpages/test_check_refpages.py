# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius
"""Tests for check_refpages.py (inline fixtures only)."""

import pathlib
import tempfile
import unittest

import check_refpages as c

PAGE = """<?xml version="1.0" encoding="utf-8"?>
<c74object name="j.x" category="Jamoma">
  <digest>x</digest>
  <methodlist><method name="bang"><digest>b</digest></method><method name="+"><digest>p</digest></method></methodlist>
  <attributelist><attribute name="type" get="1" set="1"><digest>t</digest></attribute></attributelist>
</c74object>"""

SOURCE = '''
class j_x : public c74::min::object<j_x> {
    c74::min::message<> bang{this, "bang", MIN_FUNCTION { return {}; }};
    c74::min::message<> setup{this, "setup", MIN_FUNCTION { return {}; }};
    if (selector == "+") {}
    const std::vector<std::string>& attribute_names() {
        static const std::vector<std::string> names{
            "type", "ramp/drive"};
        return names;
    }
};
void ext_main(void*) {
    class_addmethod(c, nullptr, "int", A_LONG, 0);
    class_addmethod(c, nullptr, "assist", A_CANT, 0);
    class_addattr(c, attr_offset_new("strip", gensym("long"), 0, nullptr, nullptr, 0));
}
'''


class CheckRefpages(unittest.TestCase):
    def test_parse_reads_names(self):
        attributes, methods = c.parse_refpage(PAGE)
        self.assertEqual(attributes, {"type"})
        self.assertEqual(methods, {"bang", "+"})

    def test_nested_attribute_lists_are_not_entries(self):
        page = PAGE.replace("<digest>t</digest></attribute>", "<digest>t</digest><attributelist><attribute name='enumvals'/></attributelist></attribute>")
        self.assertEqual(c.parse_refpage(page)[0], {"type"})

    def test_source_scan_finds_implemented_names(self):
        attributes, methods = c.scan_source(SOURCE)
        self.assertEqual(attributes, {"type", "ramp/drive", "strip"})
        self.assertEqual(methods, {"bang", "+", "int"})  # setup and the A_CANT assist are not messages of the object

    def test_missing_entry_is_reported(self):
        problems = c.compare("j.x", ({"type", "ramp/drive"}, {"bang"}), ({"type"}, {"bang"}))
        self.assertEqual(problems, ["j.x: attribute 'ramp/drive' is implemented but has no entry in its reference page"])

    def test_extra_entry_is_reported(self):
        problems = c.compare("j.x", ({"type"}, {"bang"}), ({"type", "bogus"}, {"bang", "dump"}))
        self.assertEqual(problems, ["j.x: attribute 'bogus' has an entry but the object does not have it",
                                    "j.x: message 'dump' has an entry but the object does not have it"])

    def test_matching_page_passes(self):
        implemented = c.scan_source(SOURCE)
        documented = ({"type", "ramp/drive", "strip"}, {"bang", "+", "int"})
        self.assertEqual(c.compare("j.x", implemented, documented), [])

    def test_builtin_box_attribute_needs_no_implementation(self):
        self.assertEqual(c.compare("j.x", ({"type"}, set()), ({"type", "style"}, set())), [])

    def test_malformed_xml_is_a_one_line_error(self):
        with self.assertRaises(c.RefpageError) as caught:
            c.parse_refpage("<c74object><oops></c74object>")
        self.assertNotIn("\n", str(caught.exception))

    def test_check_all_reports_a_missing_page(self):
        with tempfile.TemporaryDirectory() as d:
            root = pathlib.Path(d)
            (root / "package/docs/refpages/modular").mkdir(parents=True)
            (root / "ext").mkdir()
            problems = c.check_object("j.x", root / "package", root / "ext", {"j.x": ["x.cpp"]})
            self.assertEqual(len(problems), 1)
            self.assertIn("no reference page", problems[0])


if __name__ == "__main__":
    unittest.main()
