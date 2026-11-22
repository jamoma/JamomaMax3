#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Reads the old package's maxref.xml reference pages and writes one Markdown inventory page per object.

    inventory.py --old ~/Developer/Jamoma/JamomaMax --out docs/inventory

The pages list what a patcher can see: arguments, inlets, outlets, messages and attributes. What the
objects actually do is written by hand below the generated part (see docs/inventory/*.md).
"""

import argparse
import pathlib
import xml.etree.ElementTree as ET
from dataclasses import dataclass, field

OBJECTS = ["j.model", "j.view", "j.parameter", "j.message", "j.return", "j.send", "j.receive", "j.ui"]
BLOCK_TAGS = {"li", "br", "ul", "p"}
MARKER = "<!-- HAND-WRITTEN: everything below this line is kept when this page is regenerated -->"


@dataclass
class Attribute:
    """An attribute of an object, as documented in its reference page."""
    name: str
    type: str
    size: str
    default: str
    description: str


@dataclass
class Message:
    """A message an object responds to."""
    name: str
    args: list
    description: str


@dataclass
class Argument:
    """An object argument (typed after the object name in the box)."""
    name: str
    type: str
    optional: bool
    description: str


@dataclass
class ObjectSpec:
    """Everything a reference page says about one object."""
    name: str
    digest: str
    attributes: list = field(default_factory=list)
    messages: list = field(default_factory=list)
    outlets: list = field(default_factory=list)
    inlets: list = field(default_factory=list)
    arguments: list = field(default_factory=list)


def text_of(element) -> str:
    """Flattens an element and its inline markup to one line of plain text."""
    if element is None:
        return ""
    parts = []

    def walk(node):
        if node.text:
            parts.append(node.text)
        for child in node:
            block = child.tag in BLOCK_TAGS
            if block:
                parts.append(" ")
            walk(child)
            if block:
                parts.append(" ")
            if child.tail:
                parts.append(child.tail)

    walk(element)
    return " ".join("".join(parts).split())


def _port(element) -> str:
    """Formats an inlet or outlet as '<id> <type>: <description>'."""
    return f"{element.get('id', '')} {element.get('type', '')}: {text_of(element.find('description'))}"


def parse_maxref(path: pathlib.Path) -> ObjectSpec:
    """Parses one maxref.xml file. Raises ValueError if it is not a c74object page."""
    root = ET.parse(path).getroot()
    if root.tag != "c74object":
        raise ValueError(f"{path}: not a c74object reference page")
    spec = ObjectSpec(name=root.get("name", ""), digest=text_of(root.find("digest")))
    spec.inlets = [_port(e) for e in root.findall("inletlist/inlet")]
    spec.outlets = [_port(e) for e in root.findall("outletlist/outlet")]
    for e in root.findall("objarglist/objarg"):
        spec.arguments.append(Argument(e.get("name", ""), e.get("type", ""), e.get("optional") == "1",
                                       text_of(e.find("description"))))
    for e in root.findall("methodlist/method"):
        args = [f"{a.get('name', '')}:{a.get('type', '')}" for a in e.findall("arglist/arg")]
        spec.messages.append(Message(e.get("name", ""), args, text_of(e.find("description"))))
    for e in root.findall("attributelist/attribute"):
        spec.attributes.append(Attribute(e.get("name", ""), e.get("type", ""), e.get("size", ""),
                                         e.get("value", ""), text_of(e.find("description"))))
    return spec


def render(spec: ObjectSpec) -> str:
    """Renders an ObjectSpec as a Markdown page."""
    out = [f"# {spec.name}", "", spec.digest, ""]
    out += ["## Arguments", ""]
    out += [f"- `{a.name}` ({a.type}{', optional' if a.optional else ''}): {a.description}" for a in spec.arguments] or ["(none)"]
    out += ["", "## Inlets", ""] + ([f"- {i}" for i in spec.inlets] or ["(none)"])
    out += ["", "## Outlets", ""] + ([f"- {o}" for o in spec.outlets] or ["(none)"])
    out += ["", "## Messages", ""]
    for m in spec.messages:
        out.append(f"- `{m.name}` {' '.join(m.args)}: {m.description}")
    if not spec.messages:
        out.append("(none)")
    out += ["", "## Attributes", "", "| Attribute | Type | Size | Default | Description |", "|---|---|---|---|---|"]
    for a in spec.attributes:
        out.append(f"| `{a.name}` | {a.type} | {a.size} | {a.default} | {a.description.replace('|', '/')} |")
    return "\n".join(out) + "\n\n" + MARKER + "\n"


def merge_hand_written(generated: str, existing) -> str:
    """Returns the generated page with the hand-written part of the existing page (from MARKER on) kept."""
    if existing is None or MARKER not in existing:
        return generated
    head = generated.split(MARKER)[0]
    return head + MARKER + existing.split(MARKER, 1)[1]


def main() -> None:
    """Command line entry point."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--old", required=True, type=pathlib.Path, help="the old JamomaMax checkout")
    parser.add_argument("--out", required=True, type=pathlib.Path, help="folder for the Markdown pages")
    args = parser.parse_args()
    folder = args.old / "Jamoma/docs/refpages/modular"
    args.out.mkdir(parents=True, exist_ok=True)
    for name in OBJECTS:
        spec = parse_maxref(folder / f"{name}.maxref.xml")
        page = args.out / f"{name}.md"
        existing = page.read_text(encoding="utf-8") if page.exists() else None
        page.write_text(merge_hand_written(render(spec), existing), encoding="utf-8")
        print(f"{name}: {len(spec.attributes)} attributes, {len(spec.messages)} messages")


if __name__ == "__main__":
    main()
