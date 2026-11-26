# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Tests for clean_patcher.py: imported patchers use the default colours, Arial, and no font size 13."""

import unittest

import clean_patcher as cp


def box(maxclass="newobj", text=None, **keys):
    """A box entry."""
    b = {"id": "obj-1", "maxclass": maxclass, **keys}
    if text is not None:
        b["text"] = text
    return {"box": b}


def cleaned(*boxes, **patcher_keys):
    """A patcher with these boxes, cleaned."""
    p = {"boxes": list(boxes), "lines": [], **patcher_keys}
    cp.clean(p)
    return p


class ColourTests(unittest.TestCase):
    def test_comments_objects_messages_and_panels_lose_their_colours(self):
        c = [1.0, 0.0, 0.0, 1.0]
        p = cleaned(box("comment", "x", textcolor=c, bgcolor=c), box("newobj", "print", color=c, textcolor=c, bgcolor=c),
                    box("message", "y", bgcolor=c, bgcolor2=c, bgfillcolor_type="gradient", bgfillcolor_color1=c, bgfillcolor_angle=270.0,
                        bgfillcolor_autogradient=0, bgfillcolor_proportion=0.4),
                    box("panel", bgcolor=c, bordercolor=c), box("textbutton", "z", textovercolor=c, usebgoncolor=1, usetextovercolor=1, bgoncolor=c))
        for e in p["boxes"]:
            self.assertEqual([k for k in e["box"] if "color" in k], [], e["box"])

    def test_jamoma_objects_keep_their_colours(self):
        c = [0.1, 0.2, 0.3, 1.0]
        p = cleaned(box("newobj", "j.parameter a", color=c), box("j.textslider", bgcolor=c, knobcolor=c),
                    box("bpatcher", name="j.maxhelpui.maxpat", bgcolor=c))
        self.assertEqual(p["boxes"][0]["box"]["color"], c)
        self.assertEqual(p["boxes"][1]["box"]["knobcolor"], c)
        self.assertEqual(p["boxes"][2]["box"]["bgcolor"], c)

    def test_patcher_backgrounds_become_the_default_also_in_subpatchers(self):
        c = [0.5, 0.5, 0.5, 1.0]
        inner = {"boxes": [box("comment", "in", textcolor=c)], "lines": [], "bgcolor": c, "editing_bgcolor": c}
        p = cleaned(box("newobj", "p sub", patcher=inner), bgcolor=c, editing_bgcolor=c, default_bgcolor=c)
        self.assertEqual([k for k in p if "color" in k], [])
        self.assertEqual([k for k in inner if "color" in k], [])
        self.assertNotIn("textcolor", inner["boxes"][0]["box"])

    def test_nothing_else_changes(self):
        p = cleaned(box("comment", "x", linecount=2, patching_rect=[1, 2, 3, 4]))
        self.assertEqual(p["boxes"][0]["box"], {"id": "obj-1", "maxclass": "comment", "text": "x", "linecount": 2, "patching_rect": [1, 2, 3, 4]})


class FontTests(unittest.TestCase):
    def test_all_fonts_become_arial_also_on_jamoma_objects(self):
        p = cleaned(box("comment", "x", fontname="Lato Regular"), box("newobj", "j.model m", fontname="Verdana"), default_fontname="Helvetica Neue")
        self.assertEqual([e["box"]["fontname"] for e in p["boxes"]], ["Arial", "Arial"])
        self.assertEqual(p["default_fontname"], "Arial")

    def test_bold_font_variants_become_arial_bold(self):
        p = cleaned(box("comment", "x", fontname="Lato Black"), box("comment", "y", fontname="Arial Bold"), box("comment", "z", fontname="Helvetica Neue Bold"),
                    box("comment", "w", fontname="Lato Heavy"))
        for e in p["boxes"]:
            self.assertEqual((e["box"]["fontname"], e["box"]["fontface"]), ("Arial", 1))

    def test_size_13_becomes_12_and_other_sizes_stay(self):
        p = cleaned(box("comment", "a", fontsize=13.0), box("comment", "b", fontsize=13), box("comment", "c", fontsize=18.0), default_fontsize=13.0)
        self.assertEqual([e["box"]["fontsize"] for e in p["boxes"]], [12.0, 12.0, 18.0])
        self.assertEqual(p["default_fontsize"], 12.0)


if __name__ == "__main__":
    unittest.main()
