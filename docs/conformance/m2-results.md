# Milestone 2 conformance results

macOS arm64, Max 9, one test per Max launch (`scripts/run-maxtests.sh`), after the last code change.

| What | Result |
|---|---|
| The 82 old `j.parameter` integration tests (`conformance/m1-tests.txt`) | **82 of 82 pass** (milestone 1 ended at 78 of 82: the three `j.unit` tests and the integer-repetition test now pass) |
| The three old `j.unit` tests (`conformance/m2-tests.txt`; they are among the 82) | 3 of 3 pass |
| Own Max tests (`conformance/own-tests.txt`, 15: names, attribute order, free while ramping, model init, `j.pass`, standalone init, `dump`, receive basic / relative / feedback, send basic / attribute / relative, `j.unit`, `j.in` / `j.out`) | **15 of 15 pass** |
| Help patchers (`scripts/check-help.sh`) | all 12 open without a missing object |
| Reference pages (`tools/refpages/check_refpages.py`) | match the implemented attributes and messages of all 12 objects |
| Quit with live objects (`scripts/max-smoke.sh tests/smoke/quit_live_objects`: models, parameters, a running ramp, a `j.send` / `j.receive` pair) | Max quits by itself, no crash report |
| The old `qmetro.model.maxpat` opens (`tools/maxtest/open_help.py`) | no missing object, no error line |
| Core unit tests | 218 pass; also under AddressSanitizer + UndefinedBehaviorSanitizer and under ThreadSanitizer (no reports) |
| Doxygen | no warnings |

## After the final review

The review found threading problems introduced when the value messages were made thread safe (Task 9); they were fixed and the whole set was run again in quick mode (`--fast`): 82 of 82 old tests, 15 of 15 own tests, 3 of 3 `j.unit` tests, 12 of 12 help patchers, the quit smoke, and 221 core unit tests under ASan/UBSan and TSan. The table above is the one-test-per-launch run made before the fixes; a one-test-per-launch run of the final tree is still to be done before merging.

## Not covered

- **No old integration tests exist for `j.send`, `j.receive`, `j.in` or `j.out`.** Their behaviour was read from the old source (`docs/inventory/send-receive.md`, `docs/inventory/j.in-j.out.md`) and is checked by the own tests only. The old help patchers of these objects open without a missing object but their behaviour in them was not compared.
- The own test `scheduler_inputs` that was meant to pin the thread fix could not reproduce the loss and was removed; the evidence for the fix is the old `ramp_and_dataspace` test (failed deterministically before, passes after).
- **Windows is untested** (no Windows machine yet). To run there: the unit tests, `scripts/max-smoke.ps1`, the conformance lists, `scripts/check-help` (the Max-driving scripts are macOS only, the equivalent for Windows is still to be written). Spec section 12 puts Windows conformance after this milestone.

## What remains of the objects the pass-bar set uses

Implemented: `j.parameter`, `j.message`, `j.return`, `j.model`, `j.init`, `j.savebang`, `j.pass`, `j.send`, `j.receive`, `j.unit`, `j.in`, `j.out`.
Remaining (`docs/inventory/coverage-baseline.md`): `j.remote`, `j.view`, `j.ui`, `j.textslider` (milestone 3); `j.cue` (needs presets, milestone 3); `j.map` (milestone 4); `j.namespace`, `j.node` (decided in the milestone 3 plan); `j.out~`, `j.in~`, `j.limiter~` (audio, later).
