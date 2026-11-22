#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius
#
# Runs the old Jamoma integration tests (max-test patchers) in Max 9. Thin wrapper around tools/maxtest/run_maxtests.py.
#   scripts/run-maxtests.sh <list file> <out dir> [extra run_maxtests.py options]
# Example: scripts/run-maxtests.sh conformance/m1-tests.txt build/maxtests
# See docs/conformance/README.md for the one-time setup (max-test) and what the runner touches.
set -eu
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LIST="${1:?list file}"; OUT="${2:?out dir}"; shift 2
exec python3 "$ROOT/tools/maxtest/run_maxtests.py" --list "$LIST" --out "$OUT" "$@"
