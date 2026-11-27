// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
//
// js attribute_reads.js <scripting name> [colour attribute names...]
//
// On a bang: reads every attribute of the named object, then sends each colour and list attribute without values (what Max's format toolbar
// and style system do) and reads it again. Outputs 1 if all of that could be done. An attribute that holds no values makes Max abort when it
// is read, so the test fails by Max going away.
// For the colour attributes named after the object: each is set to another colour and then sent without values, which must give back the value
// it had before (its default: the help patchers rely on this); if not, 0 is output.

outlets = 1;

function bang() {
    var o = this.patcher.getnamed(jsarguments[1]);
    if (!o) {
        outlet(0, 0);
        return;
    }
    var names = o.getattrnames();
    for (var i = 0; i < names.length; i++) {
        o.getattr(names[i]);
    }
    for (var j = 0; j < names.length; j++) {
        var name = names[j];
        if (name.indexOf("color") >= 0 || name === "textpos" || name === "range") {
            o.message(name);
            o.getattr(name);
        }
    }
    var restored = 1;
    for (var k = 2; k < jsarguments.length; k++) {
        var colour = jsarguments[k];
        var before = String(o.getattr(colour));
        o.message(colour, 1, 0, 0, 1);
        var changed = String(o.getattr(colour)) !== before;
        o.message(colour);
        if (!changed || String(o.getattr(colour)) !== before) {
            error("attribute_reads: " + colour + " is not given back: " + before + " then " + o.getattr(colour) + "\n");
            restored = 0;
        }
    }
    outlet(0, restored);
}
