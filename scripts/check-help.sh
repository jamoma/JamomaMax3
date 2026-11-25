#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
#
# Opens the help patchers of the package in Max 9 and reports objects Max could not create.
#   scripts/check-help.sh [patchers...]   (default: every .maxhelp of package/Jamoma/help, and the qmetro model, view, module and help patcher)
set -eu
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
if [ "$#" -eq 0 ]; then set -- "$ROOT"/package/Jamoma/help/*.maxhelp "$ROOT"/package/Jamoma/patchers/models/data/qmetro/*.max*; fi
cd "$ROOT/tools/maxtest" && exec python3 open_help.py "$@"
