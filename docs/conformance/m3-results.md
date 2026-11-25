# Milestone 3 conformance results

## Run of 25 November 2026 (after the later changes and the move of the own tests into `tests/integration`)

macOS arm64, Max 9, after the last code change. The changes since the first record: `j.model` outputs the changes of its parameters and forwards `<name> <value>` to them, `j.ui` snaps to the grid and has the active button, a bang of a node of type none reaches `j.receive` and `j.remote`, `j.maxhelpui` is in the package, and the own tests live in the folders of the externals (no lists any more).

| What | Result |
|---|---|
| Every Max test of `tests/integration` (`run_maxtests.py --all`), **one test per Max launch** | **120 of 120 pass** (87 in `j.parameter`: the 82 old ones and 5 own; the others in `j.model` 11, `j.ui` 3, `j.view` 3, `j.receive` 4, `j.send` 3, `j.remote` 4, and one each in `j.in_out`, `j.node`, `j.pass`, `j.unit` and `qmetro`; the run took about 70 minutes) |
| The same set in quick mode (`--all --fast 5`) | 120 of 120 pass |
| Core unit tests (284, with the tool checks `test_layout` and `package_references`) | all pass; also under AddressSanitizer + UndefinedBehaviorSanitizer (284 of 284) and under ThreadSanitizer (284 of 284, no reports) |
| Tool tests (`python3 -m unittest discover -s tools/maxtest`) | 52 pass |
| Help patchers (`scripts/check-help.sh`, now also the four qmetro patchers) | all open without a missing object or load error; in a **full run** `j.receive.maxhelp` is reported with `doesn't understand "foo"` and `doesn't understand "none"`, see below |
| Quit with live objects (`scripts/max-smoke.sh tests/smoke/quit_live_objects "live objects loaded"`) | passes: Max quits by itself, no crash report (the script could not replace the permanent `Jamoma` link, `Operation not permitted`, so it ran against the package the link points to) |
| Doxygen | no warnings |

The error lines of the help check: they are attributed to `j.receive.maxhelp` because that is the file that is being opened when they are written, but they come from the help patchers opened before it, after a delay. Opened with `j.parameter.maxhelp` first, `"none"` appears; with `j.model.maxhelp` first, `"foo"` (the default values of the string parameters there). `j.receive.maxhelp` alone, and with `j.message.maxhelp` first, is clean. A string parameter wired straight into a message box does not give the error (tried in a throwaway patcher), so the source is not yet found. The Max window also shows errors of Max's own Node process when Max quits. Not a failure of an object, but to be looked at.

**What this record does not cover yet:** Windows, and the look of the `j.ui` menus (see below).

---

## First record, at the completion of the milestone (23 November 2026; the lists and test names are those of then)

macOS arm64, Max 9, after the last code change that touched an object. **Deviation from the plan:** the acceptance set was run in batches of five tests per Max launch with every test that did not pass run again alone (`--fast 5`), not one test per launch: a one-test-per-launch run took about two minutes per test (an estimated three hours for 110 tests), and was stopped after three. Nothing failed in the batched run, so no isolation was needed. A one-test-per-launch run was made on 25 November (above).

| What | Result |
|---|---|
| The 82 old `j.parameter` integration tests and the old `j.remote` test (`conformance/m1-tests.txt`, `m2-tests.txt`, `m3-tests.txt`) | **83 of 83 pass** (the `j.remote` dataspace test `j_remote_dataspace_db2linear` timed out before the milestone) |
| Own Max tests (`conformance/own-tests.txt`, 28: the 15 of milestone 2 and `late_model`, `nested_model`, `dieze`, `model_presets`, `preset_files`, `view_basic`, `view_late_model`, `remote_basic`, `remote_feedback`, `ui_state`, `node_basic`, `qmetro`, `view_argument`) | **28 of 28 pass** |
| Whole acceptance set together (`build/accept.txt`: own, old, m3) | **111 of 111 pass** (run again after the review fixes) |
| Help patchers (`scripts/check-help.sh`) | all 16 open without a missing object (the four new ones included) |
| Reference pages (`tools/refpages/check_refpages.py`, and its own tests) | match the implemented attributes and messages of all 16 objects |
| Quit with live objects (`scripts/max-smoke.sh tests/smoke/quit_live_objects`: models, parameters, a running ramp, a `j.send` / `j.receive` pair, now also a view, a remote, a node, a `j.ui` and a preset recall on the running ramp) | Max quits by itself, no crash report (the script could not replace the permanent `Jamoma` link in the Packages folder this time, `Operation not permitted`, so it ran against the package the link points to) |
| The old `qmetro` model, view and module (`package/Jamoma/patchers/models/data/qmetro`) | the own test `qmetro` loads the module without a missing object, reads `qmetro.model.presets.txt`, recalls `default` (time 100, `data/active` 0) |
| Core unit tests | 274 pass; also under AddressSanitizer + UndefinedBehaviorSanitizer and under ThreadSanitizer (no reports); includes a text preset file of 10 MB read whole under ASan |
| Doxygen | no warnings |

## After the final review

An Opus read-only review gave 19 findings; the important ones were fixed (the panel's "Create New Preset" overwrote preset 1, a raw model pointer kept across the modal menu, file items sent a model address as a path, Max-style paths, `j.remote` reading nodes off the main thread without the lock, a view with a model argument never returning to waiting, a nested model losing its default preset) and the rest is listed as deferred in the ledger of the run. The menu, path and nested-default fixes are in code that no automated test reaches.

## Findings on the way (each found by a test or by opening a migrated help patcher)

- Reading nodes from another thread while nodes were removed was a use-after-free (`ModelExplorer`, found by the race test under ASan); `Namespace::visit_below` reads under the lock.
- A model created its preset manager after subscribing, so an observer called during construction found none.
- `j.remote` had its outlets in the wrong order and suppressed the node's answer to its own command; the old test and the old help patchers needed the old order and the echo.
- `j.out`, `j.in` and `j.ui` needed a `tags` attribute for the old help patchers to load; the model needed the `data/active` parameter of its `data` amenity for `qmetro`.

## Not covered

- **No old integration tests exist for `j.view`, `j.ui`, `j.node` or presets.** Their behaviour was read from the old source (`docs/inventory/presets.md`, `view-model.md`, `j.remote.md`, `j.ui.md`) and is checked by own tests and the `qmetro` model. The XML preset format is tested for round trips and against a sample written like the old writer, not against a file written by the old software.
- **The look of `j.ui` and its menus** were checked by the user in Max on 25 November 2026 (screenshots of both menus and of the Max console). Nothing is wrong: the address menu lists Parameters, Messages (Returns when there are any) under greyed headings; the utilities menu has the seven items, then Create New Preset, Update and Delete (both greyed while no preset is current) and the preset names with a check on the current one. Every choice that sends a message arrived at a `print` as designed (`model:reference/open <address>`, `model:help/open`, `model:internal/open`, `preset:edit`, `preset:read`, `preset:write/again`, `preset:write`; the nodes menu sends `model:reference/open <address>/<name>`). Choosing a preset, creating one and deleting it work from the menu: they act on the model directly, so they send nothing, and the check mark follows. `preset:edit` and the windows behind the reference, help and internal items are not built (known). Not tried: a model deleted while a menu is open, which a keystroke cannot do (the menu has the keyboard) and only something automated could, such as a delayed `script delete`; the code reads the model again after the menu closes and no test reaches it.
- **Windows is untested** (no Windows machine yet). To run there: the unit tests, `scripts/max-smoke.ps1`, the conformance lists (`m1`, `m2`, `m3`, own tests), the help check (the Max-driving scripts are macOS only), and the drawing and menus of `j.ui` by eye. Windows conformance for milestones 1 to 3 is due.
- The preset text editor window (`preset:edit`), file watching, aliases, text entry in the panel and the preset slider panel are not built (`docs/changes.md`). **Wish from the user (25 November 2026):** name a preset when it is created in the menu (today it is stored as `preset <n>` and renamed with `preset:rename`); it needs text entry, which Min does not give, so it is a later task.

## What remains of the objects the pass-bar set uses

Implemented: `j.parameter`, `j.message`, `j.return`, `j.model`, `j.init`, `j.savebang`, `j.pass`, `j.send`, `j.receive`, `j.unit`, `j.in`, `j.out`, `j.view`, `j.remote`, `j.ui`, `j.node`.
Remaining (`docs/inventory/coverage-baseline.md`): `j.map`, `j.cue`, `j.namespace`, `j.textslider` (milestone 4 or later); `j.out~`, `j.in~`, `j.limiter~` (audio, later).
