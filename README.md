# JamomaMax3

A clean-room rewrite of the Jamoma modular framework for Max 9 (macOS and Windows),
keeping what patchers can see and replacing everything underneath. See
`docs/superpowers/specs/` for the design and `docs/superpowers/plans/` for the plans.

Licence: BSD 3-clause (see `LICENSE`).

## Build

```
git submodule update --init --recursive
cmake --preset macos            # or: cmake --preset windows
cmake --build --preset macos
ctest --preset macos
cmake --build --preset macos --target docs   # Doxygen; any warning is an error
```

On Windows use the `windows` preset in every command; it needs Visual Studio with C++ (the newest installed one
is used). CI builds and unit-tests the Windows version; it has not yet been run in Max.

## Install the package in Max 9

The Max package folder must be named `Jamoma`. Link the package folder into Max:

```
ln -s "$PWD/package/Jamoma" "$HOME/Documents/Max 9/Packages/Jamoma"
```

## Status: milestone 1 (namespace and data)

Objects: `j.parameter`, `j.message`, `j.return`, `j.model`, `j.init`, `j.savebang`, `j.pass` (plus the start-up
loader `j.loader`). The core (`core/`, namespace `jamoma`) has no Max includes and has its own unit tests; the Max
externals (`externals/`) are thin. See `docs/changes.md` for what differs from the old objects and
`docs/conformance/m1-results.md` for the results of the old integration tests.

Checks (Max 9 must be closed for the ones that start it):

```
ctest --preset macos                                   # core unit tests
scripts/run-maxtests.sh --all --out build/maxtests                # every Max test (tests/integration: one folder for each external)
scripts/run-maxtests.sh --dir j.model --out build/maxtests        # the tests of one external
scripts/check-help.sh                                  # every help patcher opens without missing objects
python3 tools/refpages/check_refpages.py --package package/Jamoma --externals externals
```

Sanitizer builds must not write into the package that Max uses; give them their own folder:
`cmake -S . -B build/tsan -G Ninja -DCMAKE_CXX_FLAGS=-fsanitize=thread -DJAMOMA_PACKAGE_DIR=$PWD/build/tsan/package`.

## Status: milestone 2 (the OSC-addressed bus)

Added: `j.send`, `j.receive`, `j.unit`, and the data `j.in` / `j.out`; the core gained attribute observers, namespace observers, `Receiver` and
`Sender`. Differences from the old objects are in `docs/changes.md`; results in `docs/conformance/m2-results.md`.
The test runner has a quick mode for development, `python3 tools/maxtest/run_maxtests.py --list <list> --out build/x --fast 10` (batches; every test that did not pass is run again alone), and prints a progress bar. Acceptance runs use one test
per Max launch (`scripts/run-maxtests.sh`).

## Status: milestone 5 (arrays and the models that need them)

Added: `j.parameter_array`, `j.message_array`, `j.return_array`, `j.remote_array`, `j.oscinstance`, `j.oscroute`, `j.initialized`, the namespace browser
with the filters of `j.namespace`, and the models `mapper`, `midiin` and `hi`. Differences from the old objects are in `docs/changes.md`, new features in
`CHANGELOG.md`, results in `docs/conformance/m5-results.md`.

## Status: milestone 4 (the old surface)

Added: `j.namespace`, `j.map`, `j.cue`, `j.textslider`, the editor window of `preset:edit`, the second panel and preset names of `j.ui` (whose
colours, like those of `j.textslider`, follow the Max theme), and the model `osc_receive`. Differences from the old objects are in
`docs/changes.md`, new features in `CHANGELOG.md`, results in `docs/conformance/m4-results.md`.

## Status: milestone 3 (views, presets and the panel)

Added: `j.view`, `j.remote`, `j.ui` (a drawn panel), `j.node`, and the presets of `j.model` (`preset`, `preset:new`, `preset:interpolate`, `preset:read`, `preset:write` and the others; the old text file format, and the XML format in the core).
Models that appear later, are replaced or go are now followed by `j.send`, `j.receive`, `j.remote` and the data objects, and models nest.

**The old `qmetro` model is fully working.** It was the first test patch of the whole project (`package/Jamoma/patchers/models/data/qmetro`): the model, the view with its `j.ui` panel and the module load with the old help patcher, `data/active` starts and stops the metro (also from the active button of `j.ui`), the trigger button blinks, the time and randomness follow the `j.remote` objects, and the presets (`default` and the ones made in the panel's menu) recall, create and delete. It is part of conformance: the test `qmetro_module`, the help check and the package check run it every time.

The core gained `PresetManager`, `Remote`, `ModelExplorer` and the preset file readers and writers. Differences from the old objects are in `docs/changes.md`;
results, and what still has to be run on Windows and looked at by eye, are in `docs/conformance/m3-results.md`.
