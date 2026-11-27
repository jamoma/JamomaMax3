#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Lays out Max patchers so that they read from top to bottom: every object sits below the objects that feed it.

A test patcher built as the tests of this project are (a `loadbang` or `j.init` feeding one trigger whose outlets run a block for each assertion and,
last, the `test.terminate`) is arranged by blocks: starter and trigger at the top left, the blocks side by side in the order of the trigger's outlets,
every stage of the blocks on the same line with all `test.assert` boxes on one line, `test.terminate` at the bottom left, and the object under test with
its receives in a column to the right.

A test patcher built as a chain of steps (the starter feeds a subpatcher, whose left outlet feeds the next one, down to the `test.terminate`) is
arranged as one column: comments on top, then starter, steps and terminate, each result as a toggle and its assertion below the step, and the objects
under test to the right. The outlets of a step are kept in one line, in their order. Everything below holds inside a block, and for any other patcher.

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
CHAR = 5.8      # width of one character of a box text (Arial 12 needs about 5; the rest is margin, so that Max does not wrap the text)
HEIGHT = 22.0   # height of a box


def box_width(box) -> float:
    """The width a box gets: its text (CHAR pixels a character, at least 40)."""
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
    column = _chain(patcher)
    if column:
        _layout_chain(patcher, column)
        return
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
    width = [box_width(b) for b in boxes]
    placed = _test_layout(boxes, forward, width)
    if placed is None:
        row = _depths(count, forward)
        placed = _arrange(boxes, forward, row, width), row
    left, row = placed
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


def _chain(patcher):
    """The ids of the column of a chain of steps (starter, steps, terminate), or None if the patcher does not have that shape.

    The shape: the starter feeds a subpatcher, whose left outlet feeds the next one, and the last one's feeds the `test.terminate`.
    """
    boxes = {e["box"]["id"]: e["box"] for e in patcher.get("boxes", [])}
    following = {}
    for entry in patcher.get("lines", []):
        s, d = entry["patchline"]["source"], entry["patchline"]["destination"]
        following.setdefault((s[0], s[1]), []).append(d[0])
    for start, box in boxes.items():
        if _first_word(box) not in ("loadbang", "j.init"):
            continue
        column = [start]
        targets = following.get((start, 1 if _first_word(box) == "j.init" else 0), [])
        while len(targets) == 1 and "patcher" in boxes[targets[0]] and targets[0] not in column:
            column.append(targets[0])
            targets = following.get((targets[0], 0), [])
        if len(column) > 1 and len(targets) == 1 and _first_word(boxes[targets[0]]) == "test.terminate":
            return column + [targets[0]]
    return None


def _order_outlets(patcher):
    """Puts the outlets of a step in one line at the bottom, left to right in the order of the file (Max numbers outlets by their position)."""
    outlets = [e["box"] for e in patcher["boxes"] if e["box"]["maxclass"] == "outlet"]
    others = [e["box"]["patching_rect"] for e in patcher["boxes"] if e["box"]["maxclass"] != "outlet"]
    bottom = max(r[1] + r[3] for r in others) + ROW - HEIGHT
    for k, box in enumerate(outlets):
        box["patching_rect"] = [MARGIN + k * 90.0, round(bottom, 1), 30.0, 30.0]
    patcher["rect"][2] = max(patcher["rect"][2], MARGIN * 2 + len(outlets) * 90.0)
    patcher["rect"][3] = max(patcher["rect"][3], bottom + 30.0 + MARGIN)


def _layout_chain(patcher, column):
    """Lays out a chain of steps: the column on the left, each result as a toggle and its assertion under the outlet, everything else to the right."""
    boxes = {e["box"]["id"]: e["box"] for e in patcher["boxes"]}
    out = {}
    for entry in patcher["lines"]:
        s, d = entry["patchline"]["source"], entry["patchline"]["destination"]
        out.setdefault((s[0], s[1]), []).append(d[0])
    placed = set(column)
    y = MARGIN
    for box in boxes.values():
        if box["maxclass"] == "comment":
            box["patching_rect"] = [MARGIN, y, round(box_width(box), 1), 20.0]
            placed.add(box["id"])
            y += 30.0
    right = 0.0
    for ident in column:
        box = boxes[ident]
        if "patcher" in box:
            layout(box["patcher"])
            _order_outlets(box["patcher"])
        results = []
        for k in range(1, box.get("numoutlets", 1)) if "patcher" in box else []:
            toggle = out.get((ident, k), [None])[0]
            check = out.get((toggle, 0), [None])[0] if toggle and boxes[toggle]["maxclass"] == "toggle" else None
            results.append((toggle, check))
        spacing = max([box_width(boxes[c]) for _, c in results if c] or [0.0]) + GAP
        width = max(box_width(box), spacing * len(results) + 20.0)
        box["patching_rect"] = [MARGIN, y, round(width, 1), HEIGHT]
        for k, (toggle, check) in enumerate(results, start=1):
            # Where Max draws outlet k of n on a box of this width.
            x = round(MARGIN + k * (width - 19.0) / len(results), 1)
            if check:
                boxes[toggle]["patching_rect"] = [x, y + 36.0, 24.0, 24.0]
                boxes[check]["patching_rect"] = [x, y + 70.0, round(box_width(boxes[check]), 1), HEIGHT]
                placed.update((toggle, check))
                right = max(right, x + box_width(boxes[check]))
        right = max(right, MARGIN + width)
        y += 120.0 if results else ROW
    bottom = y
    rest = [e for e in patcher["boxes"] if e["box"]["id"] not in placed]
    if rest:
        ids = {e["box"]["id"] for e in rest}
        side = {"boxes": rest, "lines": [l for l in patcher["lines"] if l["patchline"]["source"][0] in ids and l["patchline"]["destination"][0] in ids]}
        layout(side)
        for e in rest:
            r = e["box"]["patching_rect"]
            r[0] = round(r[0] + right + GAP * 2, 1)
            bottom = max(bottom, r[1] + r[3])
        right = max(e["box"]["patching_rect"][0] + e["box"]["patching_rect"][2] for e in rest)
    rect = patcher.get("rect", [60.0, 60.0, 400.0, 300.0])
    patcher["rect"] = [rect[0], rect[1], max(400.0, round(right + MARGIN, 1)), max(240.0, round(bottom + MARGIN, 1))]


def _depths(count, forward):
    """The row of every box: the longest path of cords from a box without input."""
    row = [0] * count
    changed = True
    while changed:
        changed = False
        for s, _, d in forward:
            if row[d] < row[s] + 1:
                row[d] = row[s] + 1
                changed = True
    return row


def _arrange(boxes, forward, row, width):
    """The left edge of every box for the given rows: boxes under the boxes that feed them, chains straight, no overlaps in a row."""
    count = len(boxes)
    parents = [[] for _ in range(count)]
    children = [[] for _ in range(count)]
    for s, o, d in forward:
        parents[d].append((s, o))
        children[s].append((d, o))
    rows = {}
    for i in range(count):
        rows.setdefault(row[i], []).append(i)
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
        for i in rows.get(r, []):
            aims = [left[p] + o * 0.001 for p, o in parents[i]]
            targets[i] = sum(aims) / len(aims) if aims else left[i]
        place(rows.get(r, []), targets)

    def up(r):
        """Row r over its children: each box aims at the left edge of its leftmost child, so that a chain is a straight line."""
        targets = {}
        for i in rows.get(r, []):
            aims = [left[c] for c, _ in children[i]]
            targets[i] = min(aims) if aims else left[i]
        place(rows.get(r, []), targets)

    first = min(rows)
    x = 0.0  # the first row keeps the file order, spaced by width
    for i in rows[first]:
        left[i] = x
        x += width[i] + GAP
    last = max(rows)
    for _ in range(3):
        for r in range(first + 1, last + 1):
            down(r)
        for r in range(last - 1, first, -1):
            up(r)
    for r in range(first + 1, last + 1):  # the downward sweep: a child lines up with its parent
        down(r)
    # A toggle in front of a check (see add_toggles.py) sits directly above it, even when the row of the check is crowded: the toggle moves.
    for r in range(last - 1, first - 1, -1):
        members = [i for i in rows.get(r, []) if boxes[i].get("maxclass") == "toggle" and len(children[i]) == 1]
        if members and r > first:
            targets = {i: left[i] for i in rows[r]}
            for i in members:
                targets[i] = left[children[i][0][0]]
            place(rows[r], targets)
    return left


def _first_word(box):
    """The object name of a box ('' for a box without text)."""
    words = (box.get("text") or "").split()
    return words[0] if words and box.get("maxclass") == "newobj" else ""


def _test_layout(boxes, forward, width):
    """The (left edges, rows) of a test patcher, or None if the patcher does not have that shape.

    The shape: a `loadbang` or `j.init` feeds one trigger, and the outlets of that trigger lead to blocks of boxes that end in a `test.assert` (a
    block for each assertion) and to the `test.terminate`. Starter and trigger go to the top left, the blocks side by side in the order of the
    outlets, every stage of a block on the same line (the assertions on one line), the terminate at the bottom left below them, and everything
    that no outlet of the trigger reaches (the object under test, receives, models) in a column to the right.
    """
    count = len(boxes)
    children = [[] for _ in range(count)]
    parents = [[] for _ in range(count)]
    for s, o, d in forward:
        children[s].append((o, d))
        parents[d].append(s)
    starters = {i for i in range(count) if _first_word(boxes[i]) in ("loadbang", "j.init")}

    def reach(roots, excluded):
        seen, stack = [], list(roots)
        while stack:
            i = stack.pop()
            if i in excluded or i in seen:
                continue
            seen.append(i)
            stack.extend(d for _, d in children[i])
        return seen

    top = None
    for i in range(count):
        if _first_word(boxes[i]) in ("t", "trigger") and any(p in starters for p in parents[i]) and len({o for o, _ in children[i]}) > 1:
            if any(_first_word(boxes[j]) == "test.assert" for j in reach([d for _, d in children[i]], {i})):
                top = i
                break
    if top is None:
        return None
    taken = {top} | starters
    blocks, terminators = [], []
    for outlet in sorted({o for o, _ in children[top]}):
        members = sorted(reach([d for o, d in children[top] if o == outlet], taken))
        taken |= set(members)
        if any(_first_word(boxes[i]) == "test.terminate" for i in members) and not any(_first_word(boxes[i]) == "test.assert" for i in members):
            terminators += members
        elif members:
            blocks.append(members)

    # the rows inside the blocks: from the top of the block, except the chain that ends in the assertion, which is aligned at the bottom
    shapes = []
    for members in blocks:
        local = {g: k for k, g in enumerate(members)}
        edges = [(local[s], o, local[d]) for s, o, d in forward if s in local and d in local]
        depth = _depths(len(members), edges)
        fed = {d for _, _, d in edges}
        distance = {local[g]: 0 for g in members if _first_word(boxes[g]) == "test.assert"}
        changed = True
        while changed:
            changed = False
            for s, _, d in edges:
                if d in distance and s in fed and distance.get(s, -1) < distance[d] + 1:
                    distance[s] = distance[d] + 1
                    changed = True
        shapes.append((members, edges, depth, distance))
    upper = max((depth[k] for _, _, depth, distance in shapes for k in range(len(depth)) if k not in distance), default=0)
    tail = max((v for _, _, _, distance in shapes for v in distance.values()), default=0)
    longest = max((depth[k] for _, _, depth, _ in shapes for k in range(len(depth))), default=0)
    bottom = max(upper + 1 + tail, longest)

    left, row = [0.0] * count, [0] * count
    for i in starters:
        row[i] = 0
    row[top] = 1
    x = 0.0
    extra = 0.0
    for i in sorted(starters)[1:]:  # more than one starter: side by side
        extra += width[sorted(starters)[0]] + GAP
        left[i] = extra
    for members, edges, depth, distance in shapes:
        rows = [bottom - distance[k] if k in distance else depth[k] for k in range(len(members))]
        sub = [boxes[g] for g in members]
        lefts = _arrange(sub, edges, rows, [width[g] for g in members])
        low = min(lefts)
        for k, g in enumerate(members):
            left[g] = x + lefts[k] - low
            row[g] = 2 + rows[k]
        x = max(left[g] + width[g] for g in members) + 2 * GAP
    for n, g in enumerate(terminators):
        left[g], row[g] = 0.0, 2 + bottom + 2 + n
    aside = [i for i in range(count) if i not in taken]
    if aside:
        local = {g: k for k, g in enumerate(aside)}
        edges = [(local[s], o, local[d]) for s, o, d in forward if s in local and d in local]
        rows = _depths(len(aside), edges)
        lefts = _arrange([boxes[g] for g in aside], edges, rows, [width[g] for g in aside])
        low = min(lefts)
        for k, g in enumerate(aside):
            left[g] = x + lefts[k] - low
            row[g] = 2 + rows[k]
    return left, row


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
