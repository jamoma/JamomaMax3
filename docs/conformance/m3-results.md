# Milestone 3 conformance results

macOS arm64, Max 9, after the last code change that touched an object. **Deviation from the plan:** the acceptance set was run in batches of five tests per Max launch with every test that did not pass run again alone (`--fast 5`), not one test per launch: a one-test-per-launch run took about two minutes per test (an estimated three hours for 110 tests), and was stopped after three. Nothing failed in the batched run, so no isolation was needed. A one-test-per-launch run is still to be made before a release.

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
- **The look of `j.ui` and its menus have not been seen by anyone.** Task 11 asks for the user to open `ui_look.maxpat` (now in `tests/integration/.../Modular/j.ui/`) in Max and say what is wrong; that is **still to be done**. No screenshot was taken.
- **Windows is untested** (no Windows machine yet). To run there: the unit tests, `scripts/max-smoke.ps1`, the conformance lists (`m1`, `m2`, `m3`, own tests), the help check (the Max-driving scripts are macOS only), and the drawing and menus of `j.ui` by eye. Windows conformance for milestones 1 to 3 is due.
- The preset text editor window (`preset:edit`), file watching, aliases, text entry in the panel and the preset slider panel are not built (`docs/changes.md`).

## What remains of the objects the pass-bar set uses

Implemented: `j.parameter`, `j.message`, `j.return`, `j.model`, `j.init`, `j.savebang`, `j.pass`, `j.send`, `j.receive`, `j.unit`, `j.in`, `j.out`, `j.view`, `j.remote`, `j.ui`, `j.node`.
Remaining (`docs/inventory/coverage-baseline.md`): `j.map`, `j.cue`, `j.namespace`, `j.textslider` (milestone 4 or later); `j.out~`, `j.in~`, `j.limiter~` (audio, later).
