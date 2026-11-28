# Milestone 5 results

**Headline:** the four array objects, `j.oscinstance`, `j.oscroute`, `j.route`, `j.initialized`, the namespace browser (view and window, with the filters of
`j.namespace`) and the models `mapper`, `midiin` and `hi` are built. Every Max test and every unit test passes. What only a person or a device can
check is listed below.

## Run of 28 November 2026

macOS 27.2 arm64, Max 9.

| What | Result |
|---|---|
| Every Max test (`run_maxtests.py --all`), **one test per Max launch** | **181 of 181 pass** (612 assertions) |
| Core unit tests, with the tool checks `test_layout` and `package_references` | 456 of 456 pass |
| The same under AddressSanitizer + UndefinedBehaviorSanitizer and under ThreadSanitizer | all pass, no reports |
| Tool tests (`python3 -m unittest discover` in each folder of `tools`) | 132 pass |
| Reference pages (`tools/refpages/check_refpages.py`) | no differences |
| Help patchers and model patchers (`scripts/check-help.sh`; `j.namespace.maxhelp` left out), the browser window and `j.initialized` | no missing object or load error |
| Doxygen | no warnings |

Console errors in the full run are those the tests provoke on purpose (an unknown function name, files that do not exist, an edited text without presets).
The old tests of `j.oscinstance` and `j.oscroute` (five) are part of the run; there are no old tests for the arrays or the three models.

## Added after that run

`j.route` (asked for by the author, whose own patchers use it), also back in the namespace browser window: its unit tests (461 of 461 pass; its own
also under both sanitizers), its Max test and the browser's two pass, its help patcher and the window open without a missing object. The full Max run
above was made before it. It has not been reviewed.

## Final review

A read-only review of the branch (before the browser window was added) by a fresh Opus reviewer gave no critical, two important and four minor findings.

- **Fixed with a test that failed first:** `j.oscroute` could crash when a pattern was replaced while another thread routed; arrays in `array` format sent their list while a patch loaded; a value still came out for an instance that what followed the index outlet had removed; `j.remote_array` lost an `array/resize` sent before it had bound; string instances without a value counted as 0.
- **Deferred, minor:** `array/resize` with a word instead of a number sets the size to 0 instead of giving an error.
- **Left as before:** a ramp clock could in theory be freed on the scheduler thread after two resizes in quick succession (not reproduced).
- The filters of `j.namespace` and the browser window were built after this review and have **not** been reviewed.

## Not covered

- **The browser window:** that clicking `≣` binds the view and opens the window, choosing in the lists, searching, the arrow, return and escape keys, and where the window appears.
- **By eye:** the new help patchers and the `mapper` views.
- Saving a patch and loading it again with arrays that were resized or renamed.
- `scripts/max-smoke.sh` (quit with live objects) was not run for this milestone.
- **Windows is untested in Max.**

## Found on the way

- `j.remote` drops a `bang` sent to it (the old object passed it to the node); not changed.
- New externals other than the data objects, the arrays and `j.map` may not answer an attribute name sent without a value, as the old objects did.
- The unit test `unit converter is race free` (milestone 1) failed once on a loaded machine and passed 200 times in a row afterwards.

## Checks for the author: hardware

`midiin` (a MIDI device, in `midiin.model.maxhelp`):
- the device appears in the menu of the view and can be chosen;
- notes, program changes, pitch bend, mono and poly aftertouch arrive in their returns;
- controller n arrives in `cc.n` (controller 0 in `cc.128`);
- `normalization` (none, normalize, s-normalize) changes the values as expected; `midiChannel` filters.

`hi` (a human interface device, in `hi.model.maxhelp`):
- the devices appear in the menu and can be chosen;
- moving a control changes the matching `hi.n`;
- `data/active`, `polling_interval` and `defer` work; `info` prints the device information.
