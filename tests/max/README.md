# Own Max tests

The patchers in `patchers/` are this project's own Max tests (the package `JamomaMax3Tests`); the lists that run them are
`conformance/own-tests.txt`. The integration tests copied from the old package are in `tests/integration`.

Patchers are laid out to read from top to bottom: every object sits below the objects that feed it, and the targets of a left outlet are left of
the targets of a right outlet. After writing or changing a patcher, lay it out with

```
python3 tools/maxtest/layout_patcher.py tests/max/patchers/<name>.maxtest.maxpat
```

(running it twice changes nothing). A test that waits for a model starts from the end outlet of `j.init`, never from a fixed delay.
