# Max tests

`JamomaIntegrationTests/` is the one Max package of tests of this repository. It started as the package of integration tests of the old
JamomaMax repository (`github.com/jamoma/JamomaMax`, `JamomaIntegrationTests`), copied with its folder structure; the tests of this project are
in the same tree, one folder for each Jamoma external, so everything that tests an object is in one place.

## Layout and names

```
JamomaIntegrationTests/patchers/tests/Modular/<external>/[<group>/]<external>_<behaviour>.maxtest.maxpat
```

- The folder is the external the test is about (`j.model`, `j.ui`, ...). A test of a patch of several objects goes in the folder of the object it is about, or in the folder of the
  patch (`qmetro`). Helper patchers of a test (abstractions, small models and views the test creates, a patcher to look at by hand such as `ui_look`) sit next to it, and JavaScript helpers
  are in `JamomaIntegrationTests/javascript`.
- The file name starts with the external with its dot as an underscore (`j_model_...`, `j_ui_...`, `qmetro_...`) and ends in `.maxtest.maxpat`. File names are unique in the whole tree, because max-test finds a test by its name.
- Every `test.assert` is named `Jamoma/Modular/<folder>/[<group>/]<behaviour>/<case>`, the folder being the one the file is in.
- The test `tools/maxtest/check_test_layout.py` (also run by `ctest` as `test_layout`) checks that every test is in such a folder, that names are unique and that every assertion starts with its folder.

What came from the old package: the 82 tests of `Modular/j.parameter` (in the subfolders `type_*`, written by the Jamoma authors) and the helper abstraction `test.list.equals`
(`patchers/components`, with its help patcher), and the one test of `Modular/j.remote/dataspace`. The other tests of the old package (audio, DSP, foundation, graph and the other modular objects) are not copied; add
them when the objects they test are built. Everything else is new: `Modular/j.parameter/general` and the other folders hold the tests of this project.

## Running

Every test of the tree, or the tests of some folders, with `scripts/run-maxtests.sh` (see `docs/conformance/README.md`):

```
scripts/run-maxtests.sh --all --out build/maxtests            # every test
scripts/run-maxtests.sh --dir j.model --dir j.ui --out build/maxtests
```

A new test is run by these commands as soon as it is in its folder; there are no lists to keep up to date.

## Building and laying out a test patcher

A test patcher is built so that it reads at a glance. It has one of two shapes.

**Blocks**, for a test in which nothing has to wait (`j.map/j_map_functions` is the model):

1. `loadbang` (or `j.init`, if the test has to wait for a model) feeds one `t b b b ...` at the top left. Its outlets run one **block** for each assertion, from right to left; the leftmost outlet, which fires last, goes to `test.terminate`.
2. Inside a block a trigger fixes the order, with constants where useful (`t b 0.5 b`: first the setting message, then the value, last the read of the result).
3. `s name` and `r name` replace long cords: every block sends to one receive that sits beside the object under test.
4. A block reads from top to bottom: trigger, message, send, holder, check, toggle, `test.assert`.
5. The blocks stand side by side in the order of the trigger's outlets, every stage on the same line, with all `test.assert` boxes on one line and no overlaps.

**A chain of steps**, for every other test: something has to wait, or a block would hold much logic (`j.view/j_view_late_model` is the model):

1. One column from top to bottom: a comment that says what the test is about, `loadbang` or `j.init`, one subpatcher `p <step>` for each step, `test.terminate`.
2. The left outlet of a step starts the next step when the step is done. Every other outlet is the result of one assertion, with its toggle and `test.assert` below it.
3. The objects under test stand to the right, each with an `r` above it and an `s` below it, so that no cord goes to a step from them.
4. Inside a step, what it **does** is a column on the left (triggers, messages, `deferlow`), and what it **watches** is one column for each value to the right:
   `r`, the objects that pick the value out, a holder, the check, the outlet. At the start of the step every holder is given a value that fails the check
   (`r <test>_<step>_begin`), so an assertion is always made, and fails if what it waits for never happens. A value that arrives before the step keeps its holder.
5. An assertion that something does **not** happen passes also when the step watches the wrong thing: check by hand that the watched path is right.

Use no timed `delay` to order steps. Work that Max or an object has put off (binding at load, the reaction to a new or deleted object) is waited for with
`deferlow`, one for each time the work is put off in a row. A `delay` is only for what takes real time (a ramp, the network, handing a message to the
scheduler thread), and has a comment beside it that says why.

A `preset <name>` message loses its name on the way through `send` and `receive`; send the name alone and put `prepend preset` beside the model.

`tools/maxtest/make_test.py` builds patchers in both shapes (`blocks` and `receive`; `chain` with `step`, `send`, `wait`, `delay`, `watch`, `expect` and `dut`). To lay out a patcher, run

```
python3 tools/maxtest/layout_patcher.py <path>/<name>.maxtest.maxpat
```

(running it twice changes nothing). A patcher in one of the two shapes is arranged accordingly (the inside of a step is left as `make_test.py` arranged it); any other patcher is laid out so that every object sits below the objects that feed it, with its left edge lined up with theirs where the row allows (a chain is a straight vertical line), and the targets of a left outlet left of the targets of a right outlet. **Do not run it over a patcher that has been arranged by hand.**

Every `test.assert` has a toggle directly above it, fed by whatever checks the result and feeding the assert. It does not change the test; when the
check passes the toggle turns on, so a patcher that you open in Max shows at a glance whether its checks pass (the patcher runs itself on opening
when the three package links are in place, see `scripts/max-links.sh`). New patchers get the toggles with

```
python3 tools/maxtest/add_toggles.py <path>/<name>.maxtest.maxpat
```

and are then laid out as above (adding toggles twice changes nothing).

## Tests that change themselves

Patchers that script-create or script-delete objects (`j_model_late`, `j_model_nested`, `j_parameter_free_while_ramping`, `j_ui_state`, `j_ui_grid`, `j_view_argument`, `j_view_late_model`, `j_receive_dieze`, `j_receive_other_models`, `j_namespace_changing`, `j_cue_missing_models`) change
themselves when they run. Never save such a patcher after it has run (close it with "Don't Save"); a saved copy has lost the deleted objects (`j_parameter_free_while_ramping` lost its `j.parameter`).

## Licence

The patchers that came from the old package are part of the Jamoma project and are under its "New BSD License" (BSD 3-clause), as the rest of this repository.
They were written by the Jamoma authors, not by this project.

## What they need

They run on the Cycling '74 `max-test` package (`github.com/Cycling74/max-test`, MIT), which is not part of this repository. The
version they were last run with is commit `8c5d833d4b1e454238ced7c866c34acedb69cc07`. The runner expects it in
`~/Developer/Jamoma/max-test` (`--max-test` changes that) and links it, this folder's package and the Jamoma package into Max's `Packages`
folder while it runs, removing the links again.

## Refreshing the copy

The copy is ours to change. If the old tests are corrected upstream, copy the changed patchers over (they are the ones in `Modular/j.parameter/type_*` and `test.list.equals`; the old files named `j.parameter_...` have been renamed `j_parameter_...`, so rename the new copies the same way) and run the tests again.
