// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
// Writes one line to the result file once the patcher has loaded (@RESULT@ is replaced by scripts/max-smoke.sh).
function bang() {
    var f = new File("@RESULT@", "write", "TEXT");
    if (f.isopen) {
        f.writeline("live objects loaded");
        f.close();
    }
}
