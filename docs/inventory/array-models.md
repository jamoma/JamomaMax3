# The models and components of milestone 5: files and dependencies

Read from the patchers under `JamomaMax/Jamoma/patchers` (a walk over every box).

| Folder (under `patchers/`) | Files to import | Uses that the package lacks |
|---|---|---|
| `components/data/initialized` | `j.initialized.{maxpat,maxhelp}` | `<name>:initialized` on a model |
| `components/namespace/namespacebrowser` | `j.namespacebrowser.view.maxpat` (`j.namespacebrowser.maxpat`: check whether anything loads it) | script `javascript/j.get_onscreen_position.js` (**ask the author**) |
| `models/data/mapper` | `mapper.{model,module,view,view.large}.maxpat`, `mapper.model.presets.txt`, `mapper.model.maxhelp`; `function_options/` only if loaded (no box refers to it) | the two array objects, the browser; help: `j.initialized`, `j.maxhelpui`, `degrade~` and `mouse` (audio and mouse parts are left out) |
| `models/data/midiin` | model, module, view, presets, help (not `midiin.model_old.maxpat`) | `j.return_array cc.[128]`; help: `j.oscinstance`, `j.oscroute`, `j.maxhelpui` |
| `models/data/hi` | model, module, view, presets, help | `j.return_array hi.[256]`, Max's `hi`; help: `j.oscinstance`, `j.maxhelpui` |

`j.maxhelpui` and `helpname.js` are handled as for earlier imported help patchers (`tools/refpages/migrate_help.py`; check what it does with them).

## Risk for Task 10 (mapper and j.map)
`mapper.model`: on a change of `function` it asks `j.map` for `function/parameters`; `p function/parameters.dispatch` turns the answer into
`array/resize <number of names>` (`bang` = 0) for `j.parameter_array function/parameters.[1]`, whose values (stored in presets as
`<name> <values>`, e.g. `base 1.`, `curveList ...`) are sent into `j.map` as messages. The new `j.map` answers `function/parameters` with the
names and accepts `<name> <values>`, but answers `none` (length 1) for a function without parameters. Check this with a test, and
`mapper.view.large`, which also uses `function/samples` and the old parameter names.
