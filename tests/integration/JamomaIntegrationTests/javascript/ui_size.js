// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
// Test helper: `measure <varname>` outputs the width and height of the box with that scripting name in this patcher.
inlets = 1;
outlets = 1;

function measure(name)
{
    var box = this.patcher.getnamed(name);
    if (!box) {
        outlet(0, "missing");
        return;
    }
    var r = box.rect;
    outlet(0, r[2] - r[0], r[3] - r[1]);
}
