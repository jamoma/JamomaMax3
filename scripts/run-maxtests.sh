#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
#
# Runs the Max tests (tests/integration, max-test patchers) in Max 9. Thin wrapper around tools/maxtest/run_maxtests.py: every argument goes to it.
#   scripts/run-maxtests.sh --all --out <out dir> [options]                      every test of the tree
#   scripts/run-maxtests.sh --dir <folder> [--dir <folder>...] --out <out dir>   the tests in some folders of Modular/ (j.model, j.ui, j.parameter/general, ...)
#   scripts/run-maxtests.sh --list <file> --out <out dir>                        the tests named in a file
# Example: scripts/run-maxtests.sh --all --out build/maxtests --fast 5
# See docs/conformance/README.md for the one-time setup (max-test) and what the runner touches.
set -eu
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
exec python3 "$ROOT/tools/maxtest/run_maxtests.py" "$@"
