# Integration tests of the old Jamoma package

`JamomaIntegrationTests/` is the Max package of integration tests from the old JamomaMax repository
(`github.com/jamoma/JamomaMax`, `JamomaIntegrationTests`), copied here with its folder structure unchanged so that the tests
are carried forward with this repository. It holds the 82 `j.parameter` tests (`patchers/tests/Modular/j.parameter`) and the one helper
abstraction they use, `test.list.equals` (`patchers/components`, with its help patcher). The other tests of the old package (audio,
DSP, foundation, graph and the other modular objects) are not copied; add them when the objects they test are built.

The lists of what to run are `conformance/m1-tests.txt` (all 82) and `conformance/m2-tests.txt` (the three that need `j.unit`);
their paths are relative to this folder. Run them with `scripts/run-maxtests.sh <list> <out dir>` (see `docs/conformance/README.md`).
Own tests of this project are in `tests/max`.

## Licence

These patchers are part of the Jamoma project and are under its "New BSD License" (BSD 3-clause), as the rest of this repository.
They were written by the Jamoma authors, not by this project.

## What they need

They run on the Cycling '74 `max-test` package (`github.com/Cycling74/max-test`, MIT), which is not part of this repository. The
version they were last run with is commit `8c5d833d4b1e454238ced7c866c34acedb69cc07`. The runner expects it in
`~/Developer/Jamoma/max-test` (`--max-test` changes that) and links it, this folder's package and the Jamoma package into Max's `Packages`
folder while it runs, removing the links again.

## Refreshing the copy

The copy is ours to change. If the old tests are corrected upstream, copy the changed patchers over and run the lists again.
