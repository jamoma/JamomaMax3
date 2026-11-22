#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius
"""Starts the new reference pages from the old ones (same text where the behaviour is unchanged).

    migrate_refpages.py --old ~/Developer/Jamoma/JamomaMax --package package/Jamoma --externals externals

For every object: copies the old page, removes entries for attributes and messages the new object does not
implement, adds a stub entry (digest 'TODO') for anything implemented that the old page lacked, and writes the page
to <package>/docs/refpages/<module>/. The entries removed are listed on standard output so they can be recorded
(docs/changes.md); run check_refpages.py afterwards.
"""

import argparse
import pathlib
import sys
import xml.etree.ElementTree as ET

import check_refpages as check


#: Entries that are new in this version, with their text: name -> (get, set, type, digest, description).
NEW_ENTRIES = {
    "service": ("1", "0", "symbol", "The role of the object (read only)",
                "The role of the object in the model: parameter, message or return. It is fixed by the object: j.parameter, j.message and j.return."),
}


def implemented(name, externals):
    """(attributes, messages) the object implements, from its sources."""
    attributes, messages = set(), set()
    for relative in check.OBJECT_SOURCES[name]:
        a, m = check.scan_source((pathlib.Path(externals) / relative).read_text(encoding="utf-8"))
        attributes |= a
        messages |= m
    return attributes, messages


def migrate(old_page, attributes, messages):
    """Returns (new tree, removed entries) for an old page tree and the implemented names."""
    root = old_page.getroot()
    removed = []
    for list_tag, entry_tag, wanted, kind in (("attributelist", "attribute", attributes, "attribute"),
                                              ("methodlist", "method", messages, "message")):
        container = root.find(list_tag)
        if container is None:
            container = ET.SubElement(root, list_tag)
            root.remove(container)
            root.insert(list(root).index(root.find("objarglist")) + 1 if root.find("objarglist") is not None else len(root), container)
        present = set()
        for entry in list(container.findall(entry_tag)):
            if entry.get("name") in wanted:
                present.add(entry.get("name"))
            else:
                removed.append(f"{kind} {entry.get('name')}")
                container.remove(entry)
        for name in sorted(wanted - present):
            entry = ET.SubElement(container, entry_tag, {"name": name})
            known = NEW_ENTRIES.get(name) if kind == "attribute" else None
            if kind == "attribute":
                entry.set("get", known[0] if known else "1")
                entry.set("set", known[1] if known else "1")
                if known:
                    entry.set("type", known[2])
                    entry.set("size", "1")
            ET.SubElement(entry, "digest").text = known[3] if known else "TODO"
            ET.SubElement(entry, "description").text = known[4] if known else "TODO"
    ET.indent(root, space="\t")
    return old_page, removed


def main():
    """Command line entry point."""
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--old", required=True, type=pathlib.Path)
    p.add_argument("--package", required=True, type=pathlib.Path)
    p.add_argument("--externals", required=True, type=pathlib.Path)
    args = p.parse_args()
    for name in check.OBJECT_SOURCES:
        found = sorted((args.old / "Jamoma/docs/refpages").glob(f"*/{name}.maxref.xml"))
        if not found:
            print(f"{name}: no old page")
            continue
        tree, removed = migrate(ET.parse(found[0]), *implemented(name, args.externals))
        out = args.package / "docs/refpages" / found[0].parent.name / f"{name}.maxref.xml"
        out.parent.mkdir(parents=True, exist_ok=True)
        with open(out, "wb") as f:
            f.write(b'<?xml version="1.0" encoding="utf-8" standalone="yes"?>\n<?xml-stylesheet href="./_c74_ref.xsl" type="text/xsl"?>\n')
            tree.write(f, encoding="utf-8", xml_declaration=False)
        print(f"{name}: written {out}; removed: {', '.join(removed) or 'nothing'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
