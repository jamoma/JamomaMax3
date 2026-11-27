// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
//
// js subwindow_state.js <scripting name> <title>
//
// On a bang: outputs 1 if the window of the subpatcher in the box of that name is shown and its title is the one given, else 0.

outlets = 1;

function bang() {
    var box = this.patcher.getnamed(jsarguments[1]);
    var p = box ? box.subpatcher() : null;
    outlet(0, p && p.wind.visible && String(p.wind.title).indexOf(jsarguments[2]) === 0 ? 1 : 0);
}
