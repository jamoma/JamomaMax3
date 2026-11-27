#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
"""Builds Max test patchers from a short description, so that new tests are written as code and come out laid out and with their toggles.

    from make_test import TestPatcher
    t = TestPatcher()
    t.obj("m", "j.model pm", 1, 2)
    t.step_chain(start=("ji", 1), steps=[("preset:new one", [("m", 0)])])
    t.check("a1", "Jamoma/Modular/j.model/edit/applies", feed=("eq", 0))
    t.save("path/j_model_preset_edit.maxtest.maxpat")

`obj` adds an object box (text, number of inlets and outlets), `msg` a message box, `line` a cord, `check` a `test.assert` with the name of the assertion
fed from an outlet (a toggle is put in front by add_toggles), `step_chain` a row of messages that fire one after the other (a delay between them) and a
`test.terminate` at the end (only for tests that must wait for postponed work). `blocks` builds the usual shape: one trigger running a block for each
assertion, with `receive` for the object under test. `chain` builds the shape for tests that must wait: a column of steps in subpatchers
(`step`, with `send`, `wait`, `delay`, `watch` and `expect`), with `dut` for the objects under test. `save` adds the toggles, lays the patcher out (layout_patcher) and writes it as Max does.
"""

import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import add_toggles  # noqa: E402
import layout_patcher  # noqa: E402


def send(to, value):
    """An action of a step: send `value` (a number, "bang", or the text of a message) to the receive named `to`."""
    return ("send", to, value)


def wait(times=1):
    """An action of a step: let work that Max or an object has put off run first (one `deferlow` for each time)."""
    return ("wait", times)


def delay(ms, why):
    """An action of a step: wait `ms` milliseconds, only for what takes real time (a ramp, the network, the scheduler). `why` is shown in the patcher."""
    assert why, "a delay needs a reason"
    return ("delay", ms, why)


def watch(receive, *chain, hold="int 0", keep=False):
    """What a step listens to: the values from `r receive`, through the objects of `chain`, into the holder `hold`.

    An element of the chain is the text of an object, whose left outlet goes on, or `(text, [outlets])` to take other outlets. The last word of
    `hold` is its start value, which the holder gets again when the step begins, unless `keep` is true (for values that arrive before the step).
    """
    return {"receive": receive, "chain": list(chain), "hold": hold, "keep": keep}


def expect(case, watches, check=None):
    """One assertion of a step: `case` completes its name; the held values of the watches go through `check` (an object text, or a list of them in a row;
    several watches feed the inlets of the first one in order), which must give 1 for a pass. Without a check the held value is the result."""
    return {"case": case, "watches": watches if isinstance(watches, list) else [watches],
            "check": [] if check is None else (check if isinstance(check, list) else [check])}


def step(name, do=(), expect=()):
    """One step of a chain, a subpatcher `p name`: the actions `do` in order, then the assertions `expect`."""
    return {"name": name, "do": list(do), "expect": list(expect)}


def _ports(text):
    """The numbers of inlets and outlets of the common objects of a step (what Max makes of the text)."""
    words = text.split()
    name, args = words[0], words[1:]
    if name in ("route", "sel", "select"):
        return 1 + (len(args) == 1), max(1, len(args)) + 1
    if name in ("t", "trigger", "unpack"):
        return 1, max(1, len(args))
    if name == "expr":
        return max([int(n) for n in re.findall(r"\$[ifs](\d)", text)] or [1]), 1
    if name == "zl":
        return 2, 2
    return 2, 1


def _number(value):
    """A number as Max writes it in a trigger: `2.` for a whole decimal number."""
    if isinstance(value, float) and value.is_integer():
        return f"{int(value)}."
    return repr(value)


def _texts(patcher):
    """Yields the texts of the objects of a patcher dictionary and its subpatchers."""
    for entry in patcher["boxes"]:
        box = entry["box"]
        if box["maxclass"] == "newobj":
            yield box.get("text", "")
        if "patcher" in box:
            yield from _texts(box["patcher"])


class TestPatcher:
    """A patcher under construction."""

    def __init__(self, width=900.0, height=700.0):
        self.boxes = []
        self.lines = []
        self.rect = [34.0, 96.0, width, height]
        self._ids = set()

    def _add(self, box_id, text, maxclass, inlets, outlets, outlettype, extra=None):
        assert box_id not in self._ids, f"duplicate box id {box_id}"
        self._ids.add(box_id)
        box = {"id": box_id, "maxclass": maxclass, "numinlets": inlets, "numoutlets": outlets, "outlettype": outlettype,
               "patching_rect": [0.0, 0.0, 100.0, 22.0]}
        if text is not None:
            box["text"] = text
        if extra:
            box.update(extra)
        self.boxes.append({"box": box})

    def obj(self, box_id, text, inlets=1, outlets=1, **extra):
        """An object box; keyword arguments are more keys of the box (for example varname="x" for an object a script can delete)."""
        self._add(box_id, text, "newobj", inlets, outlets, [""] * outlets, extra)

    def msg(self, box_id, text):
        """A message box."""
        self._add(box_id, text, "message", 2, 1, [""])

    def line(self, source, destination):
        """A cord; each end is a box id or a (box id, index) pair (index 0 by default)."""
        s = source if isinstance(source, tuple) else (source, 0)
        d = destination if isinstance(destination, tuple) else (destination, 0)
        self.lines.append({"patchline": {"source": [s[0], s[1]], "destination": [d[0], d[1]]}})

    def counter(self, name, source, selector):
        """Counts the messages with this selector that come out of `source`.

        Returns (i, n): the id of the counter's `int` (reset by a `0` into its right inlet) and of the `int` that holds the count (reset the same way
        and read with a bang into its left inlet). Both right inlets have to be reset together, so a step "0" has the targets (i, 1) and (n, 1).
        """
        rt, t, i, p, n = (f"{name}_{k}" for k in ("rt", "t", "i", "p", "n"))
        self.obj(rt, f"route {selector}", 1, 2)
        self.obj(t, "t b", 1, 1)
        self.obj(i, "int", 2, 1)
        self.obj(p, "+ 1", 2, 1)
        self.obj(n, "int", 2, 1)
        self.line(source, rt)
        self.line(rt, t)
        self.line(t, i)
        self.line(i, p)
        self.line(p, (i, 1))
        self.line(p, (n, 1))
        return i, n

    def check(self, box_id, name, feed):
        """A test.assert with this assertion name, fed from an outlet (box id or (box id, outlet))."""
        self.obj(box_id, f"test.assert {name}", 1, 1)
        self.line(feed, box_id)

    def receive(self, name, targets):
        """A `r name` object whose cord goes to the targets (box id or (box id, inlet)), so that the blocks need no long cords to them."""
        rid = f"r_{name}"
        self.obj(rid, f"r {name}", 0, 1)
        for t in targets:
            self.line(rid, t)

    def blocks(self, start, blocks):
        """One trigger that runs a block for each assertion, the first block listed first, and ends the test.

        `start` is the outlet that begins the test (a loadbang, or the end outlet of j.init). Each block is a dictionary with: `name` (the prefix of
        its box ids), `assert` (the assertion name), `to` (the name of the receive that the object under test listens on), `send` (what to send to it,
        in order: a string becomes a message box, a number comes straight out of the block's trigger; a pair (value, receive) goes to another receive), `holder` (object text and the (box, outlet) whose
        value it holds, for example `("float 0.", ("m", 0))`) and `check` (an object that turns the held value into 1 for a pass).
        No delays are used: Max triggers fire from right to left, so the sends happen in order and the holder is read last.
        """
        count = len(blocks)
        self.obj("top", "t " + " ".join(["b"] * (count + 1)), 1, count + 1)
        self.line(start, "top")
        self.obj("term", "test.terminate", 1, 0)
        self.line(("top", 0), "term")
        for index, block in enumerate(blocks):
            name = block["name"]
            sends = [v if isinstance(v, tuple) else (v, block["to"]) for v in block["send"]]
            items = [v for v, _ in sends]
            tokens = ["b" if isinstance(v, str) else _number(v) for v in items]
            trigger = f"{name}_t"
            self.obj(trigger, "t " + " ".join(["b"] + tokens[::-1]), 1, len(items) + 1)
            self.line(("top", count - index), trigger)
            for k, item in enumerate(items):
                outlet = len(items) - k
                send = f"{name}_s{k}"
                if isinstance(item, str):
                    self.msg(f"{name}_m{k}", item)
                    self.line((trigger, outlet), f"{name}_m{k}")
                self.obj(send, f"s {sends[k][1]}", 1, 0)
                self.line(f"{name}_m{k}" if isinstance(item, str) else (trigger, outlet), send)
            text, source = block["holder"]
            self.obj(f"{name}_h", text, 2, 1)
            self.line((trigger, 0), f"{name}_h")
            self.line(source, (f"{name}_h", 1))
            self.obj(f"{name}_c", block["check"], 1, 1)
            self.line(f"{name}_h", f"{name}_c")
            self.check(f"{name}_a", block["assert"], feed=f"{name}_c")

    def step_chain(self, start, steps, delay=60, prefix="s"):
        """Messages that fire one after the other.

        steps is a list of (message text, [targets]) where the targets are the (box id, inlet) pairs the message goes to. The first message fires
        from `start` (an outlet), the next ones `delay` milliseconds apart, and a test.terminate follows the last one.
        """
        previous = start
        for i, (text, targets) in enumerate(steps):
            mid = f"{prefix}{i}"
            self.msg(mid, text)
            self.line(previous, mid)
            for t in targets:
                self.line(mid, t)
            did = f"{prefix}d{i}"
            self.obj(did, f"delay {delay}", 2, 1)
            self.line(mid, did)
            previous = did
        self.obj(f"{prefix}end", "delay 300", 2, 1)
        self.line(previous, f"{prefix}end")
        self.obj(f"{prefix}term", "test.terminate", 1, 0)
        self.line(f"{prefix}end", f"{prefix}term")

    def comment(self, box_id, text):
        """A comment box."""
        self._add(box_id, text, "comment", 1, 0, [])

    def dut(self, box_id, text, inlets=1, outlets=1, to=None, out=None, **extra):
        """An object under test (or beside it): `to` names a receive for its left inlet (or is a dictionary inlet -> name),
        `out` is a dictionary outlet -> name of the send that the outlet feeds."""
        self.obj(box_id, text, inlets, outlets, **extra)
        for inlet, name in ({0: to} if isinstance(to, str) else (to or {})).items():
            self.obj(f"{box_id}_r{inlet}", f"r {name}", 0, 1)
            self.line(f"{box_id}_r{inlet}", (box_id, inlet))
        for outlet, name in (out or {}).items():
            self.obj(f"{box_id}_s{outlet}", f"s {name}", 1, 0)
            self.line((box_id, outlet), f"{box_id}_s{outlet}")

    def chain(self, start, prefix, steps, external=(), tag=None):
        """A chain of steps from `start` (a starter object text or an outlet (box id, index)) to `test.terminate`, for tests that must wait.

        Every step is a subpatcher; its left outlet starts the next step when it is done, every other outlet is the result of one assertion,
        named `prefix/case`. `external` names sends and receives whose other end is in an abstraction of the test. `tag` is a short name of the test
        for the sends that give the holders of a step their start values (without it the name comes from the prefix).
        """
        if isinstance(start, tuple) and start[0] not in self._ids:
            self.obj(start[0], start[0], 1, 1)
        previous = start
        for number, one in enumerate(steps):
            box_id = f"step{number}"
            begin = "_".join(([tag] if tag else prefix.split("/")[2:]) + [one["name"], "begin"]).replace(".", "_")
            inner = self._step_patcher(one, begin)
            results = len(one["expect"])
            self._add(box_id, f"p {one['name']}", "newobj", 1, results + 1, [""] * (results + 1), {"patcher": inner})
            self.line(previous, box_id)
            for k, wanted in enumerate(one["expect"]):
                self.check(f"{box_id}_a{k}", f"{prefix}/{wanted['case']}", feed=(box_id, k + 1))
            previous = (box_id, 0)
        self.obj("term", "test.terminate", 1, 0)
        self.line(previous, "term")
        sends, receives = set(external), set(external)
        for text in _texts(self.patcher()):
            words = text.split()
            if len(words) > 1 and words[0] in ("s", "r"):
                (sends if words[0] == "s" else receives).add(words[1])
        assert not receives - sends, f"receive without a send: {sorted(receives - sends)}"
        assert not sends - receives, f"send without a receive: {sorted(sends - receives)}"

    def _step_patcher(self, one, begin):
        """The patcher inside a step: triggers for the order, a `deferlow` or `delay` for every wait, holders, checks and outlets.

        `begin` is the name of the send that tells the holders to take their start values."""
        p = TestPatcher(600.0, 500.0)
        p._add("in", None, "inlet", 0, 1, [""])
        resets = False
        columns = []    # for every watch: (ids of its chain from the receive down, ids of its reset from the receive down, holder id, ids of checks, result number)
        reads = []      # holder ids in the order they are read
        results = []    # the (box, outlet) of each result
        for k, wanted in enumerate(one["expect"]):
            holders = []
            for w, seen in enumerate(wanted["watches"]):
                rid, hid = f"r{k}_{w}", f"h{k}_{w}"
                p.obj(rid, f"r {seen['receive']}", 0, 1)
                previous = [(rid, 0)]
                for c, element in enumerate(seen["chain"]):
                    text, outlets = element if isinstance(element, tuple) else (element, [0])
                    oid = f"o{k}_{w}_{c}"
                    p.obj(oid, text, *_ports(text))
                    for source in previous:
                        p.line(source, oid)
                    previous = [(oid, o) for o in outlets]
                p.obj(hid, seen["hold"], *_ports(seen["hold"]))
                for source in previous:
                    p.line(source, (hid, 1))
                start = []
                if not seen["keep"]:
                    resets = True
                    start = [f"zr{k}_{w}", f"zv{k}_{w}"]
                    p.obj(start[0], f"r {begin}", 0, 1)
                    p.msg(start[1], seen["hold"].split()[-1])
                    p.line(start[0], start[1])
                    p.line(start[1], (hid, 1))
                columns.append(([rid] + [f"o{k}_{w}_{c}" for c in range(len(seen["chain"]))], start, hid, [], k))
                holders.append(hid)
            reads += holders[::-1]      # the left inlet of a check is hot, so its holder is read last
            last = None
            for c, text in enumerate(wanted["check"]):
                cid = f"c{k}_{c}"
                p.obj(cid, text, *_ports(text))
                if c == 0:
                    for w, hid in enumerate(holders):
                        p.line(hid, (cid, w))
                else:
                    p.line(last, cid)
                last = cid
                columns[-len(holders)][3].append(cid)
            results.append((last or holders[0], 0))

        segments, waits = [[("send", begin, "bang")] if resets else []], []
        for action in one["do"]:
            if action[0] == "send":
                segments[-1].append(action)
            else:
                for _ in range(action[1] if action[0] == "wait" else 1):
                    waits.append(action)
                    segments.append([])
        segments[-1] += [("read", hid) for hid in reads] + [("done",)]
        p._add("done", None, "outlet", 1, 0, [])
        for k, source in enumerate(results):
            p._add(f"out{k}", None, "outlet", 1, 0, [])
            p.line(source, f"out{k}")
        previous = ("in", 0)
        flow = []       # for every segment: (trigger id or None, [ids of each action from the message down], [ids of the wait and its comment])
        for number, items in enumerate(segments):
            if number < len(waits):
                items = items + [("next",)]
            flow.append((*p._segment(number, previous, items), []))
            if number < len(waits):
                action = waits[number]
                wid = f"w{number}"
                if action[0] == "wait":
                    p.obj(wid, "deferlow", 1, 1)
                else:
                    p.obj(wid, f"delay {action[1]}", 2, 1)
                    p.comment(f"{wid}_why", action[2])
                    flow[-1][2].append(f"{wid}_why")
                flow[-1][2].insert(0, wid)
                p.line(p._next, wid)
                previous = (wid, 0)
        p._arrange_step(flow, columns, len(results))
        return p.patcher()

    def _arrange_step(self, flow, columns, count):
        """Positions of the boxes of a step: what it does in a column on the left (in the order of time, the actions of a trigger beside each other),
        what it watches in columns to the right (chain and start value above the holder, check below it), the outlets on one line at the bottom."""
        boxes = {e["box"]["id"]: e["box"] for e in self.boxes}
        width = {i: layout_patcher.box_width(b) for i, b in boxes.items()}
        height = 40.0
        bottom = [0.0]

        def put(ident, x, row):
            box = boxes[ident]
            size = (30.0, 30.0) if box["maxclass"] in ("inlet", "outlet") else (round(width[ident], 1), 20.0 if box["maxclass"] == "comment" else 22.0)
            box["patching_rect"] = [round(x, 1), 30.0 + row * height, *size]
            bottom[0] = max(bottom[0], row)
            return x + size[0]

        longest = max((len(chain) for chain, *_ in columns), default=0)
        put("in", 30.0, 0)
        row, right, holder_row = 1, 130.0, None
        for number, (trigger, actions, waiting) in enumerate(flow):
            last = number == len(flow) - 1
            if last and columns:
                row = max(row, longest, 2)      # room above the holders for their chains
                holder_row = row + 1
            if trigger:
                right = max(right, put(trigger, 30.0, row))
                row += 1
            x, deepest = 150.0, 0
            for ids in actions:
                for depth, ident in enumerate(ids):
                    put(ident, x, row + depth)
                x += max(width[i] for i in ids) + 16.0
                deepest = max(deepest, len(ids))
                right = max(right, x - 16.0)
            row += deepest
            if waiting:
                right = max(right, put(waiting[0], 30.0, row))
                for comment in waiting[1:]:
                    right = max(right, put(comment, 150.0, row))
                row += 1
        x = right + 40.0
        places = {}
        for chain, start, holder, checks, result in columns:
            main = max([width[i] for i in chain] + [width[holder]])
            for depth, ident in enumerate(reversed(chain)):
                put(ident, x, holder_row - 1 - depth)
            for depth, ident in enumerate(reversed(start)):
                put(ident, x + main + 12.0, holder_row - 1 - depth)
            put(holder, x, holder_row)
            for depth, ident in enumerate(checks):
                put(ident, x, holder_row + 1 + depth)
            places.setdefault(result, x)
            taken = main + (12.0 + max(width[i] for i in start) if start else 0.0)
            x += max([taken] + [width[i] for i in checks]) + 24.0
        last_row = int(bottom[0]) + 2
        put("done", 30.0, last_row)
        for k in range(count):
            put(f"out{k}", places[k], last_row)
        far = max(b["patching_rect"][0] + b["patching_rect"][2] for b in boxes.values())
        self.rect = [34.0, 96.0, max(400.0, round(far + 30.0, 1)), 30.0 + last_row * height + 60.0]

    def _segment(self, number, source, items):
        """The actions between two waits, fired in the order of `items` by one trigger (a single bang needs none). The outlet that leads on is left in `_next`.

        Returns (id of the trigger or None, the ids of every send from its message down, in the order of the trigger's outlets from the left)."""
        plain = len(items) == 1 and items[0][0] in ("next", "done", "read")
        trigger = f"t{number}"
        count = len(items)
        tokens = []
        for item in items:
            if item[0] == "send" and not isinstance(item[2], str):
                tokens.append(_number(item[2]))
            else:
                tokens.append("b")
        if not plain:
            self.obj(trigger, "t " + " ".join(tokens[::-1]), 1, count)
            self.line(source, trigger)
        actions = []
        for k, item in enumerate(items):
            outlet = source if plain else (trigger, count - 1 - k)
            if item[0] == "read":
                self.line(outlet, item[1])
            elif item[0] == "done":
                self.line(outlet, "done")
            elif item[0] == "next":
                self._next = outlet
            else:
                _, to, value = item
                sid = f"s{number}_{k}"
                self.obj(sid, f"s {to}", 1, 0)
                if isinstance(value, str) and value != "bang":
                    mid = f"m{number}_{k}"
                    self.msg(mid, value)
                    self.line(outlet, mid)
                    self.line(mid, sid)
                    actions.insert(0, [mid, sid])
                else:
                    self.line(outlet, sid)
                    actions.insert(0, [sid])
        return (None if plain else trigger), actions

    def patcher(self):
        """The patcher dictionary."""
        return {"fileversion": 1, "appversion": {"major": 9, "minor": 2, "revision": 2, "architecture": "x64", "modernui": 1},
                "classnamespace": "box", "rect": list(self.rect), "boxes": self.boxes, "lines": self.lines}

    def save(self, path):
        """Adds the toggles, lays the patcher out and writes the file."""
        data = {"patcher": self.patcher()}
        add_toggles.add_toggles(data["patcher"])
        layout_patcher.layout(data["patcher"])
        with open(path, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=1)
            f.write("\n")
