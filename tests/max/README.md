# Own Max tests

The patchers in `patchers/` are this project's own Max tests (the package `JamomaMax3Tests`); the lists that run them are
`conformance/own-tests.txt`. The integration tests copied from the old package are in `tests/integration`.

Patchers are laid out to read from top to bottom: every object sits below the objects that feed it, with its left edge lined up with theirs where the row allows (a chain is a straight vertical line), and the targets of a left outlet are left of
the targets of a right outlet. After writing or changing a patcher, lay it out with

```
python3 tools/maxtest/layout_patcher.py tests/max/patchers/<name>.maxtest.maxpat
```

(running it twice changes nothing).

Every `test.assert` has a toggle directly above it, fed by whatever checks the result and feeding the assert. It does not change the test; when the
check passes the toggle turns on, so a patcher that you open in Max shows at a glance whether its checks pass (the patcher runs itself on opening
when the four package links are in place, see `scripts/max-links.sh`). New patchers get the toggles with

```
python3 tools/maxtest/add_toggles.py tests/max/patchers/<name>.maxtest.maxpat
```

and are then laid out as above (adding toggles twice changes nothing). A test that waits for a model starts from the end outlet of `j.init`, never from a fixed delay.

Patchers that script-create or script-delete objects (`late_model`, `nested_model`, `free_while_ramping`, `ui_state`, `ui_grid`, `view_argument`, `view_late_model`, `dieze`) change
themselves when they run. Never save such a patcher after it has run (close it with "Don't Save"); a saved copy has lost the deleted objects (`free_while_ramping` lost its `j.parameter`).
