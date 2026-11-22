#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius
#
# Runs a smoke patcher in Max 9 headlessly and checks the result it writes.
#
#   scripts/max-smoke.sh [--odd-path] [--no-loader] <dir with smoke.maxpat and smoke.js> "<expected line>"
#
# It copies package/Jamoma to a staging folder, links it into ~/Documents/Max 9/Packages/Jamoma
# (this touches the Max folder; an existing Jamoma link, such as the one scripts/max-links.sh makes, is moved aside and put back), launches Max with the patcher,
# waits for the result file, and requires Max to quit by itself without a crash report
# (its exit code is not available because it is launched through Launch Services).
#   --odd-path   stage the package under a path with spaces and a non-ASCII character
#   --no-loader  remove j.loader from the staged package (an external used without the loader)
set -u
ODD=0; NOLOADER=0
while [[ "${1:-}" == --* ]]; do
    case "$1" in
        --odd-path) ODD=1;;
        --no-loader) NOLOADER=1;;
        *) echo "unknown option $1" >&2; exit 2;;
    esac
    shift
done
SRC_DIR="${1:?patcher dir}"; EXPECTED="${2:?expected line}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MAX_APP="/Applications/Max 9/Max.app"
PACKAGES="${MAX_PACKAGES_DIR:-$HOME/Documents/Max 9/Packages}"
LINK="$PACKAGES/Jamoma"

if pgrep -f "Max 9/Max.app/Contents/MacOS/Max" >/dev/null; then echo "FAIL: Max 9 is already running; quit it first" >&2; exit 2; fi
# A Jamoma link that is already there (permanent links, scripts/max-links.sh) is taken away for the run and put back afterwards. Anything
# else under that name (a real folder, an installed package) is never touched.
SAVED_TARGET=""
if [[ -L "$LINK" ]]; then
    SAVED_TARGET="$(readlink "$LINK")"
    rm "$LINK"
elif [[ -e "$LINK" ]]; then
    echo "FAIL: $LINK exists and is not a link; not touching it" >&2; exit 2
fi
restore_link() {
    [[ -L "$LINK" ]] && rm "$LINK"
    if [[ -n "$SAVED_TARGET" ]]; then ln -s "$SAVED_TARGET" "$LINK"; fi
}
trap restore_link EXIT

WORK="$(mktemp -d)"
if [[ $ODD == 1 ]]; then STAGE="$HOME/Documents/Jamoma smoke Åpen/Packages-target"; else STAGE="$WORK/stage"; fi
mkdir -p "$STAGE" && ditto "$ROOT/package/Jamoma" "$STAGE/Jamoma" || { echo "FAIL: cannot stage package" >&2; exit 2; }
[[ $NOLOADER == 1 ]] && rm -rf "$STAGE/Jamoma/extensions/j.loader.mxo"

RESULT="$WORK/result.txt"
sed "s|@RESULT@|$RESULT|g" "$SRC_DIR/smoke.js" > "$WORK/smoke.js"
cp "$SRC_DIR/smoke.maxpat" "$WORK/smoke.maxpat"
START="$WORK/start-marker"; touch "$START"

MAXPID=""
cleanup() {
    [[ -n "$MAXPID" ]] && kill "$MAXPID" 2>/dev/null
    restore_link
    if [[ $ODD == 1 ]]; then rm -rf "$HOME/Documents/Jamoma smoke Åpen"; fi
    rm -rf "$WORK"
}
trap cleanup EXIT

ln -s "$STAGE/Jamoma" "$LINK" || { echo "FAIL: cannot link into $PACKAGES" >&2; exit 2; }
# Launch through Launch Services: Max started as a direct child of a non-interactive shell does not run reliably.
open -a "$MAX_APP" "$WORK/smoke.maxpat"
for _ in $(seq 1 20); do MAXPID="$(pgrep -f "Max 9/Max.app/Contents/MacOS/Max" | head -1)"; [[ -n "$MAXPID" ]] && break; sleep 0.5; done

for _ in $(seq 1 120); do [[ -s "$RESULT" ]] && break; sleep 0.5; done
GOT="$(cat "$RESULT" 2>/dev/null | head -1)"
EXITED="no"
for _ in $(seq 1 40); do
    if ! pgrep -f "Max 9/Max.app/Contents/MacOS/Max" >/dev/null; then EXITED="yes"; MAXPID=""; break; fi
    sleep 0.5
done

STATUS=0
sleep 5   # ReportCrash writes its report asynchronously, sometimes seconds after the process died
[[ "$GOT" == "$EXPECTED" ]] || { echo "FAIL: result '$GOT', expected '$EXPECTED'"; STATUS=1; }
[[ "$EXITED" == "yes" ]] || { echo "FAIL: Max did not quit by itself"; STATUS=1; }
CRASHES="$(find "$HOME/Library/Logs/DiagnosticReports" -name 'Max*' -newer "$START" 2>/dev/null | head -3)"
[[ -z "$CRASHES" ]] || { echo "FAIL: new crash report: $CRASHES"; STATUS=1; }
[[ $STATUS == 0 ]] && echo "PASS: '$GOT', Max quit by itself, no crash report"
exit $STATUS
