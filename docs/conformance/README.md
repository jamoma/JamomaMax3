# Conformance tests (old integration tests under max-test)

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
scripts/run-maxtests.sh conformance/m1-tests.txt build/maxtests            # all milestone 1 tests
scripts/run-maxtests.sh conformance/m1-tests.txt build/maxtests --timeout 10 # shorter per-test timeout
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
