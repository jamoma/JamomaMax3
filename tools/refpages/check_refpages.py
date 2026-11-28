#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Checks that every attribute and message an external implements has an entry in its reference page, and that
no entry names something the object does not have.

    check_refpages.py --package package/Jamoma --externals externals

What an object implements is read from its C++ sources (and the shared data_object.hpp for j.parameter,
j.message and j.return), not from a running Max: Min-API's own generated pages only list what Min registers,
not the raw attributes of data objects, and a source scan runs anywhere, including CI without Max.
Recognised in the sources: Min ``attribute<T> name{this, "attr"``, ``message<> name{this, "msg"`` (not
``setup`` or ``maxclass_setup``), the strings of the table in ``Data::attribute_names()``, ``class_addmethod(... "msg", A_x``
(not A_CANT, which are internal) and ``attr_offset_new("attr"``, and the literal ``selector == "+"`` tests
of the anything handler. Exit status is non-zero if there is any difference.
"""

import argparse
import pathlib
import re
import sys
import xml.etree.ElementTree as ET

COMMON = "common/data_object.hpp"
CORE_DATA = "../core/src/data.cpp"  # the attribute table of the data objects
ARRAY = "common/array_object.hpp"  # the shared body of the data arrays

#: The sources of each object, relative to the externals folder.
OBJECT_SOURCES = {
    "j.parameter": [COMMON, CORE_DATA, "j.parameter/j.parameter.cpp"],
    "j.message": [COMMON, CORE_DATA, "j.message/j.message.cpp"],
    "j.return": [COMMON, CORE_DATA, "j.return/j.return.cpp"],
    "j.model": ["j.model/j.model.cpp"],
    "j.init": ["j.init/j.init.cpp"],
    "j.savebang": ["j.savebang/j.savebang.cpp"],
    "j.pass": ["j.pass/j.pass.cpp"],
    "j.send": ["j.send/j.send.cpp"],
    "j.receive": ["j.receive/j.receive.cpp"],
    "j.unit": ["j.unit/j.unit.cpp"],
    "j.in": ["j.in/j.in.cpp"],
    "j.out": ["j.out/j.out.cpp"],
    "j.view": ["j.view/j.view.cpp"],
    "j.remote": ["j.remote/j.remote.cpp"],
    "j.ui": ["j.ui/j.ui.cpp"],
    "j.node": ["j.node/j.node.cpp"],
    "j.namespace": ["j.namespace/j.namespace.cpp"],
    "j.map": ["j.map/j.map.cpp"],
    "j.cue": ["j.cue/j.cue.cpp"],
    "j.textslider": ["j.textslider/j.textslider.cpp"],
    "j.parameter_array": [ARRAY, CORE_DATA, "j.parameter_array/j.parameter_array.cpp"],
    "j.message_array": [ARRAY, CORE_DATA, "j.message_array/j.message_array.cpp"],
    "j.return_array": [ARRAY, CORE_DATA, "j.return_array/j.return_array.cpp"],
    "j.remote_array": ["j.remote_array/j.remote_array.cpp"],
    "j.oscinstance": ["j.oscinstance/j.oscinstance.cpp"],
    "j.oscroute": ["j.oscroute/j.oscroute.cpp"],
}

#: Min messages that are plumbing, not part of the object's interface.
INFRASTRUCTURE = {"setup", "maxclass_setup", "oksize"}  # oksize: Max asks a UI object whether a new size is fine


#: Attributes every Max box has; a page may document them and the sources never name them.
BUILTIN_ATTRIBUTES = {"style"}


class RefpageError(Exception):
    """A reference page could not be read; the text is one line."""


def parse_refpage(text):
    """Returns (attributes, methods) named in a .maxref.xml text; raises RefpageError on malformed XML."""
    try:
        root = ET.fromstring(text)
    except ET.ParseError as error:
        raise RefpageError(f"malformed XML: {error}") from None
    # Only the entries of the object itself: an attribute entry may contain a list of its own (enumvals).
    attributes = {e.get("name") for e in root.findall("attributelist/attribute")}
    methods = {e.get("name") for e in root.findall("methodlist/method")}
    return attributes, methods


def scan_source(text):
    """Returns (attributes, messages) that C++ source text implements (see the module description)."""
    attributes = set(re.findall(r'attribute<[^>]*>\s+\w+\s*\{\s*this\s*,\s*"([^"]+)"', text))
    attributes |= set(re.findall(r'attr_offset_new\(\s*"([^"]+)"', text))
    table = re.search(r"attribute_names\(\)\s*\{.*?names\s*\{(.*?)\};", text, re.S)
    if table:
        attributes |= set(re.findall(r'"([^"]+)"', table.group(1)))
    messages = set(re.findall(r'message<[^>]*>\s+\w+\s*\{\s*this\s*,\s*"([^"]+)"', text)) - INFRASTRUCTURE
    for name, kind in re.findall(r'class_addmethod\([^;]*?"([^"]+)"\s*,\s*(A_\w+)', text):
        if kind != "A_CANT":
            messages.add(name)
    messages |= set(re.findall(r'selector == "([^"]+)"', text))
    return attributes, messages


def compare(name, implemented, documented):
    """Returns a list of one-line problems between implemented and documented (attributes, messages) pairs."""
    problems = []
    documented = (documented[0] - BUILTIN_ATTRIBUTES, documented[1])
    for kind, have, written in (("attribute", implemented[0], documented[0]), ("message", implemented[1], documented[1])):
        for entry in sorted(have - written):
            problems.append(f"{name}: {kind} '{entry}' is implemented but has no entry in its reference page")
        for entry in sorted(written - have):
            problems.append(f"{name}: {kind} '{entry}' has an entry but the object does not have it")
    return problems


def check_object(name, package, externals, sources=OBJECT_SOURCES):
    """Checks one object; returns the list of problems."""
    pages = sorted((pathlib.Path(package) / "docs/refpages").glob(f"*/{name}.maxref.xml"))
    if not pages:
        return [f"{name}: no reference page under docs/refpages"]
    try:
        documented = parse_refpage(pages[0].read_text(encoding="utf-8"))
    except RefpageError as error:
        return [f"{pages[0]}: {error}"]
    attributes, messages = set(), set()
    for relative in sources[name]:
        a, m = scan_source((pathlib.Path(externals) / relative).read_text(encoding="utf-8"))
        attributes |= a
        messages |= m
    return compare(name, (attributes, messages), documented)


def main():
    """Command line entry point; returns the exit status."""
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--package", required=True, type=pathlib.Path)
    p.add_argument("--externals", required=True, type=pathlib.Path)
    p.add_argument("objects", nargs="*", help="objects to check (default: all)")
    args = p.parse_args()
    problems = []
    for name in args.objects or OBJECT_SOURCES:
        problems += check_object(name, args.package, args.externals)
    for line in problems:
        print(line)
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())
