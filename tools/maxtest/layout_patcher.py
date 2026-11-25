#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Lays out Max patchers so that they read from top to bottom: every object sits below the objects that feed it.

    layout_patcher.py <path>/<name>.maxtest.maxpat

Rewrites the files in place. Rules:

* a box's row is one below the lowest box that feeds it (cords that would point upwards, feedback, are ignored for this);
* inside a row, boxes are placed under the boxes that feed them with their left edges aligned (a chain is a straight vertical line), and the targets of a left outlet are left of the targets of a right outlet
  (Max sends from the right outlet first, but patchers are read from the left);
* a toggle in front of another box (a check) sits directly above it;
* boxes in a row never overlap; boxes without cords go in the first row;
* subpatchers (boxes with a patcher inside) are laid out the same way; the window is made big enough.

Running it twice gives the same result: the positions depend only on the cords, the text of the boxes and their order in the file.
"""

import json
import sys

ROW = 64.0      # distance between rows
GAP = 24.0      # least space between two boxes in a row
MARGIN = 30.0   # space around the whole patcher
CHAR = 6.6      # width of one character of a box text
HEIGHT = 22.0   # height of a box


def box_width(box) -> float:
    """The width a box gets: its text (about 6.6 pixels a character, at least 40)."""
    maxclass = box.get("maxclass", "")
    if maxclass in ("toggle", "button"):
        return 24.0
    text = box.get("text", "") or ""
    return max(40.0, CHAR * len(text) + 22.0)


def _order_boxes(boxes):
    """The box dictionaries in file order, and a map from id to index."""
    items = [e["box"] for e in boxes]
    return items, {b["id"]: i for i, b in enumerate(items)}


def _forward_edges(count, edges):
    """The edges (src, outlet, dst) that point down: cords that close a loop (found by a depth-first walk) are dropped."""
    children = [[] for _ in range(count)]
    for s, o, d in edges:
        children[s].append((o, d))
    state = [0] * count  # 0 new, 1 on the stack, 2 done
    keep = []
    has_input = {d for _, _, d in edges}
    roots = [i for i in range(count) if i not in has_input] + [i for i in range(count) if i in has_input]
    for root in roots:
        if state[root]:
            continue
        stack = [(root, 0)]
        state[root] = 1
        while stack:
            node, index = stack.pop()
            if index < len(children[node]):
                stack.append((node, index + 1))
                outlet, target = children[node][index]
                if state[target] == 1:
                    continue  # back edge: a feedback cord
                keep.append((node, outlet, target))
                if state[target] == 0:
                    state[target] = 1
                    stack.append((target, 0))
            else:
                state[node] = 2
    return keep


def layout(patcher) -> None:
    """Lays out a patcher dictionary (and the patchers inside it) in place."""
    boxes, index = _order_boxes(patcher.get("boxes", []))
    for b in boxes:
        if "patcher" in b:
            layout(b["patcher"])
    count = len(boxes)
    if count == 0:
        return
    edges = []
    for entry in patcher.get("lines", []):
        line = entry["patchline"]
        s, d = line["source"][0], line["destination"][0]
        if s in index and d in index and s != d:
            edges.append((index[s], line["source"][1], index[d]))
    forward = sorted(set(_forward_edges(count, edges)))
    parents = [[] for _ in range(count)]
    children = [[] for _ in range(count)]
    for s, o, d in forward:
        parents[d].append((s, o))
        children[s].append((d, o))
    # rows: the longest path from a box without input
    row = [0] * count
    changed = True
    while changed:
        changed = False
        for s, _, d in forward:
            if row[d] < row[s] + 1:
                row[d] = row[s] + 1
                changed = True
    rows = {}
    for i in range(count):
        rows.setdefault(row[i], []).append(i)
    width = [box_width(b) for b in boxes]
    left = [0.0] * count

    def place(members, targets):
        """Puts a row left to right in the order of its targets (left edges to aim for), without overlaps."""
        x = 0.0
        for i in sorted(members, key=lambda k: (targets[k], k)):
            left[i] = max(x, targets[i])
            x = left[i] + width[i] + GAP

    def down(r):
        """Row r under its parents: each box aims at the left edge of the box that feeds it (the mean of them if there are several)."""
        targets = {}
        for i in rows[r]:
            aims = [left[p] + o * 0.001 for p, o in parents[i]]
            targets[i] = sum(aims) / len(aims) if aims else left[i]
        place(rows[r], targets)

    def up(r):
        """Row r over its children: each box aims at the left edge of its leftmost child, so that a chain is a straight line."""
        targets = {}
        for i in rows[r]:
            aims = [left[c] for c, _ in children[i]]
            targets[i] = min(aims) if aims else left[i]
        place(rows[r], targets)

    x = 0.0  # the first row keeps the file order, spaced by width
    for i in rows[0]:
        left[i] = x
        x += width[i] + GAP
    last = max(rows)
    for _ in range(3):
        for r in range(1, last + 1):
            down(r)
        for r in range(last - 1, 0, -1):
            up(r)
    for r in range(1, last + 1):  # the downward sweep: a child lines up with its parent
        down(r)
    # A toggle in front of a check (see add_toggles.py) sits directly above it, even when the row of the check is crowded: the toggle moves.
    for r in range(last - 1, -1, -1):
        members = [i for i in rows[r] if boxes[i].get("maxclass") == "toggle" and len(children[i]) == 1]
        if members and r > 0:
            targets = {i: left[i] for i in rows[r]}
            for i in members:
                targets[i] = left[children[i][0][0]]
            place(rows[r], targets)
    shift = MARGIN - min(left)
    right = bottom = 0.0
    for i, b in enumerate(boxes):
        h = {"comment": 20.0, "toggle": 24.0, "button": 24.0}.get(b.get("maxclass"), HEIGHT)
        x = round(left[i] + shift, 1)
        y = round(MARGIN + row[i] * ROW, 1)
        b["patching_rect"] = [x, y, round(width[i], 1), h]
        right = max(right, x + width[i])
        bottom = max(bottom, y + h)
    rect = patcher.get("rect", [60.0, 60.0, 400.0, 300.0])
    patcher["rect"] = [rect[0], rect[1], max(400.0, round(right + MARGIN, 1)), max(240.0, round(bottom + MARGIN, 1))]


def main(paths) -> int:
    """Lays out each file in place; returns 0."""
    for path in paths:
        with open(path, encoding="utf-8") as f:
            data = json.load(f)
        layout(data["patcher"])
        with open(path, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=1)
            f.write("\n")
        print(f"laid out {path}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
