# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius
"""Tests for the maxref.xml inventory tool."""

import os
import pathlib
import tempfile
import unittest

import inventory

SAMPLE = """<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<c74object name="j.sample" module="" category="Jamoma">
  <digest>Sample object</digest>
  <description>A <o>sample</o>.</description>
  <inletlist>
    <inlet id="0" type="anything"><digest>in</digest><description>Value in</description></inlet>
  </inletlist>
  <outletlist>
    <outlet id="0" type="anything"><digest>out</digest><description>Value out</description></outlet>
    <outlet id="1" type="bang"><digest></digest><description>Done</description></outlet>
  </outletlist>
  <objarglist>
    <objarg id="0" name="address" type="symbol" optional="1"><digest>Address</digest><description>Node address</description></objarg>
  </objarglist>
  <methodlist>
    <method name="float">
      <arglist><arg name="number" type="float" optional="0" /></arglist>
      <digest>Set the value</digest>
      <description>Sets the <m>value</m>.</description>
    </method>
    <method name="bang"><arglist /><digest>Output</digest><description>Outputs.</description></method>
  </methodlist>
  <attributelist>
    <attribute name="ramp" get="1" set="1" type="int" size="1" value="0">
      <digest>Ramp time</digest>
      <description>The <at>@ramp</at> attribute sets the time.</description>
    </attribute>
    <attribute name="range" get="1" set="1" type="float" size="2">
      <digest>Range</digest>
      <description>Lower and upper bound.</description>
    </attribute>
  </attributelist>
</c74object>
"""


def write_sample(directory: str, name: str = "j.sample.maxref.xml", text: str = SAMPLE) -> pathlib.Path:
    """Writes a maxref fixture into a directory and returns its path."""
    path = pathlib.Path(directory) / name
    path.write_text(text, encoding="utf-8")
    return path


class ParseMaxrefTests(unittest.TestCase):
    def test_parse_maxref_reads_attributes(self):
        with tempfile.TemporaryDirectory() as d:
            spec = inventory.parse_maxref(write_sample(d))
        self.assertEqual(spec.name, "j.sample")
        self.assertEqual([a.name for a in spec.attributes], ["ramp", "range"])
        ramp = spec.attributes[0]
        self.assertEqual((ramp.type, ramp.size, ramp.default), ("int", "1", "0"))
        self.assertEqual(ramp.description, "The @ramp attribute sets the time.")
        self.assertEqual(spec.attributes[1].default, "")

    def test_parse_maxref_reads_messages(self):
        with tempfile.TemporaryDirectory() as d:
            spec = inventory.parse_maxref(write_sample(d))
        self.assertEqual([m.name for m in spec.messages], ["float", "bang"])
        self.assertEqual(spec.messages[0].args, ["number:float"])
        self.assertEqual(spec.messages[1].args, [])
        self.assertEqual(spec.messages[0].description, "Sets the value.")

    def test_parse_maxref_reads_outlets_inlets_arguments_and_digest(self):
        with tempfile.TemporaryDirectory() as d:
            spec = inventory.parse_maxref(write_sample(d))
        self.assertEqual(spec.digest, "Sample object")
        self.assertEqual(spec.outlets, ["0 anything: Value out", "1 bang: Done"])
        self.assertEqual(spec.inlets, ["0 anything: Value in"])
        self.assertEqual(spec.arguments[0].name, "address")
        self.assertTrue(spec.arguments[0].optional)

    def test_parse_maxref_rejects_a_file_that_is_not_a_c74object(self):
        with tempfile.TemporaryDirectory() as d:
            path = write_sample(d, "bad.maxref.xml", "<other/>")
            with self.assertRaises(ValueError):
                inventory.parse_maxref(path)


class RenderTests(unittest.TestCase):
    def test_render_lists_every_attribute_and_message(self):
        with tempfile.TemporaryDirectory() as d:
            spec = inventory.parse_maxref(write_sample(d))
        text = inventory.render(spec)
        self.assertTrue(text.startswith("# j.sample"))
        for name in ("ramp", "range", "float", "bang", "address"):
            self.assertIn("`" + name + "`", text)


    def test_render_marks_every_empty_section_as_none(self):
        text = inventory.render(inventory.ObjectSpec(name="j.empty", digest="Nothing"))
        for heading in ("## Arguments", "## Inlets", "## Outlets", "## Messages"):
            section = text.split(heading)[1].split("##")[0]
            self.assertIn("(none)", section, heading)


class MergeTests(unittest.TestCase):
    def test_regeneration_keeps_the_hand_written_section(self):
        generated = inventory.render(inventory.ObjectSpec(name="j.x", digest="New digest"))
        existing = inventory.render(inventory.ObjectSpec(name="j.x", digest="Old digest")) + "\n## Semantics\nWritten by hand.\n"
        merged = inventory.merge_hand_written(generated, existing)
        self.assertIn("New digest", merged)
        self.assertNotIn("Old digest", merged)
        self.assertTrue(merged.endswith("## Semantics\nWritten by hand.\n"))

    def test_regeneration_without_an_existing_page_is_the_generated_page(self):
        generated = inventory.render(inventory.ObjectSpec(name="j.x", digest="D"))
        self.assertEqual(inventory.merge_hand_written(generated, None), generated)


class RealFilesTests(unittest.TestCase):
    OBJECTS = ["j.model", "j.view", "j.parameter", "j.message", "j.return", "j.send", "j.receive", "j.ui"]

    def test_real_maxrefs_all_parse(self):
        old = pathlib.Path(os.environ.get("JAMOMA_OLD", pathlib.Path.home() / "Developer/Jamoma/JamomaMax"))
        folder = old / "Jamoma/docs/refpages/modular"
        if not folder.is_dir():
            self.skipTest("old package not found; set JAMOMA_OLD")
        for name in self.OBJECTS:
            with self.subTest(object=name):
                spec = inventory.parse_maxref(folder / (name + ".maxref.xml"))
                self.assertEqual(spec.name, name)
                self.assertTrue(spec.attributes or spec.messages)


if __name__ == "__main__":
    unittest.main()
