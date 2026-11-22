#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius
#
# Opens the help patchers of the package in Max 9 and reports objects Max could not create.
#   scripts/check-help.sh [help files...]   (default: every .maxhelp of package/Jamoma/help)
set -eu
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
if [ "$#" -eq 0 ]; then set -- "$ROOT"/package/Jamoma/help/*.maxhelp; fi
cd "$ROOT/tools/maxtest" && exec python3 open_help.py "$@"
