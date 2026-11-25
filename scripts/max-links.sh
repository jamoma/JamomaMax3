#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
#
# Keeps the three links that let Max 9 find this project's packages, so that tests and help patchers open without errors in a Max that you
# start yourself. The test runners work with these links in place (they leave existing links alone); scripts/max-smoke.sh moves the Jamoma
# link aside while it runs and puts it back.
#
#   scripts/max-links.sh on      create the links that are missing (an existing link to somewhere else, or a real folder, is never replaced)
#   scripts/max-links.sh off     remove only the links that point where this script would point them
#   scripts/max-links.sh status  show each name and what it is
#
# Max reads its packages at launch: quit and reopen Max after "on" or "off".
# MAX_PACKAGES_DIR (default ~/Documents/Max 9/Packages) and MAX_TEST_DIR (default ~/Developer/Jamoma/max-test) change the places.
set -eu
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PACKAGES="${MAX_PACKAGES_DIR:-$HOME/Documents/Max 9/Packages}"
NAMES=(Jamoma max-test JamomaIntegrationTests)
TARGETS=("$ROOT/package/Jamoma" "${MAX_TEST_DIR:-$HOME/Developer/Jamoma/max-test}" "$ROOT/tests/integration/JamomaIntegrationTests")
# The package of the own tests was retired (they are in JamomaIntegrationTests now): a link to the old place is taken away by on and off.
RETIRED_NAME=JamomaMax3Tests; RETIRED_TARGET="$ROOT/tests/max"

mode="${1:-status}"
case "$mode" in on|off|status) ;; *) echo "usage: $0 on|off|status" >&2; exit 2;; esac
[[ -d "$PACKAGES" ]] || { echo "FAIL: $PACKAGES does not exist" >&2; exit 2; }
status=0
for i in "${!NAMES[@]}"; do
    name="${NAMES[$i]}"; target="${TARGETS[$i]}"; link="$PACKAGES/$name"
    if [[ -L "$link" ]]; then
        have="$(readlink "$link")"
        if [[ "$have" == "$target" ]]; then state="ours"; else state="elsewhere"; fi
    elif [[ -e "$link" ]]; then state="folder"
    else state="absent"; fi
    case "$mode" in
    status) if [[ $state == ours || $state == elsewhere ]]; then echo "$name: $state -> $(readlink "$link")"; else echo "$name: $state"; fi;;
    on)
        case "$state" in
        absent) [[ -e "$target" ]] || { echo "SKIP $name: $target does not exist" >&2; status=1; continue; }
                ln -s "$target" "$link"; echo "created $name -> $target";;
        ours) echo "kept $name (already there)";;
        elsewhere) echo "LEFT $name: it points to $(readlink "$link"), not touching it" >&2; status=1;;
        folder) echo "LEFT $name: a real folder is there, not touching it" >&2; status=1;;
        esac;;
    off)
        case "$state" in
        ours) rm "$link"; echo "removed $name";;
        absent) echo "absent $name";;
        *) echo "LEFT $name: not one of ours ($state)" >&2; status=1;;
        esac;;
    esac
done
if [[ "$mode" != status && -L "$PACKAGES/$RETIRED_NAME" && "$(readlink "$PACKAGES/$RETIRED_NAME")" == "$RETIRED_TARGET" ]]; then
    rm "$PACKAGES/$RETIRED_NAME"; echo "removed $RETIRED_NAME (retired: its tests are in JamomaIntegrationTests)"
fi
if pgrep -f "Max 9/Max.app/Contents/MacOS/Max" >/dev/null && [[ "$mode" != status ]]; then
    echo "Note: Max 9 is open; quit and reopen it to see the change."
fi
exit $status
