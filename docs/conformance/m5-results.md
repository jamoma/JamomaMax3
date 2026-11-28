# Milestone 5 results

**Headline:** the four array objects, `j.oscinstance`, `j.oscroute`, `j.route`, `j.initialized`, the namespace browser (view and window, with the filters of
`j.namespace`) and the models `mapper`, `midiin` and `hi` are built. Every Max test and every unit test passes. What only a person or a device can
check is listed below.

## Run of 28 November 2026

macOS 27.2 arm64, Max 9. The final run, on commit `19a96ac`, after `j.route` and the fixes from the author's review.

| What | Result |
|---|---|
| Every Max test (`run_maxtests.py --all`), **one test per Max launch** | **204 of 204 pass** (801 assertions) |
| Core unit tests, with the tool checks `test_layout` and `package_references` | 462 of 462 pass |
| The same under AddressSanitizer + UndefinedBehaviorSanitizer and under ThreadSanitizer | all 462 pass, no reports |
| Tool tests (`python3 -m unittest discover` in each folder of `tools`) | 132 pass |
| Reference pages (`tools/refpages/check_refpages.py`) | no differences |
| Help patchers and model patchers (`scripts/check-help.sh`; `j.namespace.maxhelp` left out), the browser window and `j.initialized` | no missing object or load error |
| Doxygen | no warnings |

Console errors in the full run are those the tests provoke on purpose (an unknown function name, the refused slash form of a parameter, files that do
not exist, an edited text without presets, `array/resize` with a word). The old tests of `j.oscinstance` and `j.oscroute` (five) are part of the run;
there are no old tests for the arrays or the three models. An earlier run, before `j.route` and the review fixes, had 181 of 181.

## Added after the first full run

- `j.route` (asked for by the author, whose own patchers use it), also back in the namespace browser window.
- From the author's review, each with a test that failed first: a `bang` to `j.remote` was lost; `array/resize` with a word emptied the array; many
  objects did not answer attribute queries, and the data objects not `get<name>`; the filters `remote`, `in`, `out`, `in~`, `out~` did not exist and a
  filter change kept the selection; `j.map` accepted a second, slash form of the function parameter names and did not answer a parameter name.

None of these has been reviewed by a second reader.

## Final review

A read-only review of the branch (before the browser window was added) by a fresh Opus reviewer gave no critical, two important and four minor findings.

- **Fixed with a test that failed first:** `j.oscroute` could crash when a pattern was replaced while another thread routed; arrays in `array` format sent their list while a patch loaded; a value still came out for an instance that what followed the index outlet had removed; `j.remote_array` lost an `array/resize` sent before it had bound; string instances without a value counted as 0.
- **Deferred, minor** (fixed after the author's review): `array/resize` with a word instead of a number.
- **Left as before:** a ramp clock could in theory be freed on the scheduler thread after two resizes in quick succession (not reproduced).
- The filters of `j.namespace` and the browser window were built after this review and have **not** been reviewed.

## Not covered

- **The browser window:** that clicking `≣` binds the view and opens the window, choosing in the lists, searching, the arrow, return and escape keys, and where the window appears.
- **By eye:** the new help patchers and the `mapper` views.
- Saving a patch and loading it again with arrays that were resized or renamed.
- `scripts/max-smoke.sh` (quit with live objects) was not run for this milestone.
- **Windows is untested in Max.**

## Found on the way

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
