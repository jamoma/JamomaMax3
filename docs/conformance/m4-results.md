# Milestone 4 conformance results

**Headline: the old surface is in place.** `j.namespace`, `j.map`, `j.cue`, `j.textslider`, the preset editor, the second panel and preset names of `j.ui`, and the model `osc_receive` are built; `j.ui` and `j.textslider` follow the colour theme of Max. Every Max test and every unit test passes. Parts that only a person can see or use are listed under "Not covered".

## Run of 26 and 27 November 2026

macOS 27.2 arm64, Max 9.

| What | Result |
|---|---|
| Every Max test of `tests/integration` (`run_maxtests.py --all`), **one test per Max launch**, on commit `89f1e35` (before the review fixes) | **148 of 148 pass** (468 assertions) |
| After the review fixes: the tests of `j.map`, `j.cue`, `j.model` and `j.ui`, one test per launch | **30 of 30 pass** |
| After the review fixes: every Max test in quick mode (`--all --fast 10`) | **148 of 148 pass** |
| Core unit tests, with the tool checks `test_layout` and `package_references` | 382 of 382 pass |
| The same under AddressSanitizer + UndefinedBehaviorSanitizer and under ThreadSanitizer | all 382 pass, no reports (under ThreadSanitizer the time limit of `cue_many_cues_stay_fast` is raised) |
| Tool tests (`python3 -m unittest discover` in each folder of `tools`) | 120 pass |
| Help patchers (`scripts/check-help.sh`; `j.namespace.maxhelp` is left out by default, see below) | every help patcher and model patcher opens without a missing object or load error; `j.namespace.maxhelp` was checked in earlier runs of this milestone |
| Quit with live objects (`scripts/max-smoke.sh tests/smoke/quit_live_objects "live objects loaded"`) | passes: Max quits by itself, no crash report (macOS did not let the script replace the permanent `Jamoma` link, so it ran against the package the link points to; the script now does this on purpose) |
| Doxygen (`cmake --build --preset macos --target docs`) | no warnings |

Console errors in the full run are those the tests provoke on purpose (an unknown function name, files that do not exist, an edited text without presets) and Max's own message about its Node process at quit.

There are no old integration tests for the objects of this milestone (`conformance/m4-tests.txt`); their behaviour was read from the old source (`docs/inventory/`) and is checked by own tests.

## Final review

A read-only review of the whole branch by a fresh Opus reviewer gave no critical, five important and nine minor findings.

- **Fixed with a test that failed first:** `j.cue recall <cue> <address>` could hang Max when what it recalled added or removed a node; `j.map` lost limits set by hand when it bound to the parameter; one value that is not finite left the `lowpass` function stuck. Two findings the reviewer called minor were fixed with them: a cue name with `#` was cut short by a text file, and a line `CUE` without a name added its lines to the cue before it.
- **Fixed without a test** (no test reaches them): `j.map` unbinds before it is destroyed; `j.ui`, `j.cue` and `j.model` check that they still exist after a menu, a dialog or the bang of the second panel.
- **Deferred, minor:** a text cue file reads a symbol that looks like a number back as a number; `j.map` gives the low output limit for +infinity without clipping, and drops an attribute sent without a value silently; a recall does nothing, without a message, if the patch deletes the cue in reply; the editor window replaces changes made while it was open; `j.ui` walks every patch cord when it is drawn, and shows the plus button for any abstraction the outlet feeds; `j.namespace` cannot output more than 32767 items; `j.textslider` passes a value that is not a number through.

## Seen by the author in Max (26 November 2026)

`j.textslider` colours when the theme is changed, and its look, hovering, clicking and dragging; the plus button and the preset name dialog of `j.ui`. Reports from looking at the help patchers (colours not redrawn, help tabs, panels not showing their model) were fixed the same day.

## Found on the way

- A link `package/Jamoma/Jamoma` to a temporary folder had been committed with the milestone 3 record: the smoke script created it when it could not replace the permanent package link. It is removed and the script no longer links into an existing link.

## Not covered

- **Editor windows** (`preset:edit`, `j.cue edit`, double click): the window itself and what happens when it is closed are not reached by any test; the tests use `edit/apply`.
- **File dialogs** (`read` and `write` without a file) and the **menus** of `j.ui`.
- **By eye after the last changes:** the colours of `j.ui` and the colours tabs, the help patchers that got their objects back, the `osc_receive` view and help, and the two `model:address` messages in the `j.ui` help.
- `j.namespace.maxhelp` fills its menus when it opens, so Max asks whether to save it when it is closed; the help check skips it unless it is named.
- `osc_receive`: the default of its parameter `print` is not asserted.
- Arguments of `poly~` voices do not name a model (the old objects read them).
- A locked patcher background set in a patcher file was read back as the theme's colour in a probe; the header of `j.ui` may follow the theme there.
- **Windows is untested** (no Windows machine yet), for this milestone as for the earlier ones.
