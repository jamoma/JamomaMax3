# Conformance tests (the Max tests under max-test)

The tests are in `tests/integration`, one folder for each external (see its README for the layout and names). They are the 82 old `j.parameter` integration tests and the tests of this project. There are no lists of tests to keep up to date: `--all` and `--dir` find them. The results records `m1-results.md`, `m2-results.md` and `m3-results.md` name the lists and the test names of the time they were written (`conformance/m1-tests.txt`, `own-tests.txt`, assertions called `JamomaMax3/...`); the lists were replaced by the folders when the own tests moved into the tree.

The old Jamoma integration tests are Max patchers (`*.maxtest.maxpat`) that use Cycling '74's
[max-test](https://github.com/Cycling74/max-test) objects (`test.assert`, `test.equals`, `test.terminate`, ...) and the
abstraction `test.list.equals` from the old `JamomaIntegrationTests` package.

## One-time setup (macOS)

1. Build max-test (it must be built for Max 9; it is not part of this repository):

   ```
   git clone --recurse-submodules https://github.com/Cycling74/max-test.git ~/Developer/Jamoma/max-test
   cd ~/Developer/Jamoma/max-test
   cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5
   cmake --build build
   ```

   (Ninja because its pinned max-sdk-base forces a macOS 10.11 target that Xcode rejects; the policy option because its
   CMake files predate CMake 3.5.)
2. The integration tests are in this repository (`tests/integration`, see its README); the old checkout is not needed to run them. It is still read by the inventory and migration tools and by `conformance/set.txt`.

## Running

```
scripts/run-maxtests.sh --all --out build/maxtests                  # every test of tests/integration
scripts/run-maxtests.sh --dir j.parameter --out build/maxtests      # the tests of one folder of Modular/ (repeat --dir for more)
scripts/run-maxtests.sh --all --out build/maxtests --timeout 10     # shorter per-test timeout
scripts/run-maxtests.sh --list some-list.txt --out build/maxtests   # the tests named in a file (paths relative to tests/integration)
```

`results.tsv` in the output folder has one line per test: `<path>	PASS|FAIL|TIMEOUT	<detail>`; the exit code is non-zero
if any test is not PASS. Failures name the failed assertions; objects Max could not create are listed as
`missing objects`.

What the runner does, and touches: it writes a small driver patcher that sends `;test.master run <name>.maxtest`,
launches Max 9 through `open`, waits for Max's log (`~/Library/Application Support/Cycling '74/Max 9/Logs/Max.log`) to say
`integration tests complete`, asks Max to quit through a UDP message (port 7390), and reads max-test's sqlite results
database (`/Applications/Max 9/Macintosh HD--Applications-Max 9--maxtestresults.db3`). It temporarily links the packages
`Jamoma`, `max-test` and `JamomaIntegrationTests` into `~/Documents/Max 9/Packages` (only those not already there; it
removes only its own links) and it refuses to run while a Max 9 process is open.

**Never kill Max during a run.** A killed Max saves a recovery workspace
(`.../Max 9/Crash Recovery/maxworkspace-*.txt`) and restores, and so re-runs, those patchers the next time it starts. The runner
quits Max gracefully and, if it must kill it, deletes those files.

## Baseline (2026-11-21, before any Jamoma object exists)

Sample of 6 of the 82 milestone 1 tests: **0 of 6 pass**, each because `j.parameter` (and, for the tests that use
`test.list.equals`, `j.pass`) does not exist yet. The old `Modular/j.model` folder has no usable test (only `audio_gain`,
which needs `j.in~`/`j.out~`), so the old-test suite for milestone 1 is the 82 `j.parameter` tests; `j.model`, `j.init`,
`j.savebang` and `j.pass` are covered by own tests under `docs/conformance/own/`.


## The qmetro patchers

The qmetro model, view, module and help patcher are the first test patch of the pass-bar set (`conformance/set.txt`). They are checked in three ways: the test `qmetro_module` (`tests/integration/.../Modular/qmetro/`, run by `--all` and `--dir qmetro`: the module loads, the default preset sets the time and stops the metro, and switching the metro on makes the `trigger` return fire); `scripts/check-help.sh` with no arguments, which opens every help patcher and the four qmetro patchers and reports missing objects and load errors (a missing bpatcher too); and the unit test `package_references`, which checks that every bpatcher, `js` file and picture that a package patcher loads is in the package.

The help check can report `doesn't understand "foo"` and `doesn't understand "none"` in a full run, attributed to `j.receive.maxhelp`, which is clean when opened alone. The same errors come now and then in the Max window when a `nodes` object is used; they are not a regression of the qmetro patchers.

## Permanent links for working in Max yourself

The runners link what they need into `~/Documents/Max 9/Packages` while they run and remove only what they created. To open the tests and help
patchers in a Max that you start yourself, keep the three links in place with `scripts/max-links.sh on` (and take them away with `off`;
`status` shows them). Quit and reopen Max after changing them. The runners leave existing links alone, and `scripts/max-smoke.sh` moves the
`Jamoma` link aside while it runs and puts it back.
