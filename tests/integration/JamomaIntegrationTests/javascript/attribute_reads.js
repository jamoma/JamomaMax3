// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
//
// js attribute_reads.js <scripting name>
//
// On a bang: reads every attribute of the named object, then sends each colour and list attribute without values (what Max's format toolbar
// and style system do) and reads it again. Outputs 1 if all of that could be done. An attribute that holds no values makes Max abort when it
// is read, so the test fails by Max going away.

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
    outlet(0, 1);
}
