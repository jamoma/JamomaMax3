# Milestone 5: arrays and the models that need them (design)

Status: draft for the author's approval, 28 November 2026. Parent spec: `2026-11-21-jamomamax3-modular-design.md`.

## Intent

Milestones 0 to 4 rebuilt the old surface except the array objects. Milestone 5 builds them, and the three data models that
could not be ported without them (`mapper`, `midiin`, `hi`), so that old patchers using arrays load and behave the same.
`mapper` is also the real-world test of `j.map`.

The author's decisions (28 November 2026):

- Milestone 5 is the arrays. The Max 9 additions (dictionaries and JSON, JavaScript, MC) move to a later milestone 6.
- The array objects are a separate layer of externals that uses the same core nodes (approach 2 below).

## Goals

1. **Four externals:** `j.parameter_array`, `j.message_array`, `j.return_array`, `j.remote_array`.
2. **Three models** in `package/Jamoma/patchers/models/data/`, each with its views, presets and help patcher: `mapper`,
   `midiin`, `hi`.
3. **What the models and their help patchers need and the package lacks:** `j.oscinstance` and `j.oscroute` (externals),
   `j.initialized` (a patcher) with `<model>:initialized` answered by `j.model`, and `j.namespacebrowser.view`.
4. Help patchers, reference pages, tests and the conformance run for all of it.

## Non-goals

- Dictionaries and JSON, JavaScript, MC (milestone 6).
- Arrays are **not** mapped onto MC patch cords. The parent spec proposed it; MC cords carry audio signals and these arrays
  carry control values. MC belongs with the audio objects.
- Audio objects and audio models, also those that use arrays (equalizer, DBAP, VBAP, meters, `10harmonics~`, `vst~`).
- The unbuilt `j.ui` menu items, unsaved presets (`docs/later.md`), the Windows run in Max.

**Anti-goal:** the behaviour of `j.parameter`, `j.message`, `j.return` or `j.remote` changes. All existing tests stay green.

## Constraints

The compatibility contract of the parent spec (section 9) applies: names, arguments, attributes, messages, outlet order and
meaning, OSC addresses and file formats are preserved; every deliberate difference goes in `docs/changes.md`, every new
feature in `CHANGELOG.md`. Old behaviour is read from `~/Developer/Jamoma/JamomaMax` only; nothing is copied. The core stays
Max-free; all code has Doxygen comments and the run reports no warnings. Imported patchers follow the project's import rules
(default colours except in `j.` objects, Arial, size 13 becomes 12).

## Approaches

1. **Generalise the single objects:** each holds a list of nodes, a single object being a list of one. Least duplicated code,
   but it changes the insides of finished objects.
2. **A separate array layer (chosen by the author):** new externals own a list of the same core objects; the Max attribute
   handling moves into a header that both layers use. Some parallel code; the single objects keep their own path.
3. **Patchers that script single objects:** no new node code, but slow with 256 nodes and hard to make old patchers load the
   same.

## Behaviour of the array objects

Read from `source/j.parameter_array/j.parameter_array.cpp` (which also builds the message and return arrays),
`source/j.remote_array/j.remote_array.cpp` and `source/classwrapper/TTModularClassWrapperMax.cpp`. The builder reads these in
full and records an inventory in `docs/inventory/j.array.md`; where it disagrees with this summary, the source wins.

### Names and size

- The first argument is an address with one bracketed number, anywhere in it: `cc.[128]`, `track.[4]/gain`. It creates one
  node per index from 1, the bracket replaced by the number (`cc.1` to `cc.128`).
- The data arrays need a relative address (an absolute one is an error). `j.remote_array` also takes absolute addresses,
  for example `/player.[3]/gain`.
- At most 256 instances (error above that). A data array without an argument is an error.
- All four: `address <name>` changes the array, including its size. `array/resize <n>` keeps the name and sets the size
  (`mapper` uses it). With the same name, growing and shrinking keep the instances that remain. In `array` format a data
  array outputs the whole list once after an address change.

### Inlets and outlets

| Object | Outlets, left to right |
|---|---|
| `j.parameter_array`, `j.message_array`, `j.return_array` | value, index, dump |
| `j.remote_array` | `set` (to a UI object), value, index, dump |

- Right inlet, also the message `array/select`: an index from 1, or `*` for all. The start state is all.
- Left inlet: a value goes to the selected instance, or to every instance when all are selected. `bang` likewise.
- `array <list>`: the list length must be a multiple of the size; it is cut into equal parts, one per instance in index
  order. Another length is an error.
- Every output sends the index first, then the value.
- Attributes, as box arguments or messages, apply to **every** instance, whatever is selected. A query reports the selected
  instance; with all selected that is the one whose value changed last (at the start, the first).
- The instances are ordinary nodes: presets, priorities, `j.send`, `j.receive` and `j.namespace` treat them like any other.
- `j.remote_array`: `set` and `setArray` are the silent forms of a value and of `array` (nothing comes back out of this
  object). The `set` outlet is deferred to the low-priority queue; the value outlet is not.

### `@format`

- `single` (default): the value outlet carries the value of the instance that changed.
- `array`: it carries one list with the values of all instances in index order (an instance without a value contributes its
  default, else 0, or `none` for strings). `j.remote_array` then sends `setlist <list>` from the `set` outlet instead of
  `set`.

### Binding

As the single objects do since milestone 3: the array finds its model after load, and follows it when it appears, moves or is
replaced. The old retry loop and its "tries to bind too many times" error are not built.

## The other objects

- **`j.oscinstance`** (old `source/j.oscinstance`): splits the instance out of an OSC address. Outlets: message without the
  instance, instance, arguments, dump (unmatched input leaves here). The old tests in the integration test package apply.
- **`j.oscroute`** (old `source/j.oscroute`): routes OSC messages. Behaviour from the source and its two old tests,
  including changing its arguments while running.
- Both parse in the core, with unit tests.
- **`j.initialized`**: the old patcher, imported. It listens to `<name>:initialized` (1 once the model has initialised),
  which `j.model` does not answer yet (it only knows internally); that is added.
- **`j.namespacebrowser.view`**: imported with its help patcher. Its `j.` objects are `j.view` and `j.remote`. If it turns
  out to need something else the package lacks, the builder stops and asks.

## The three models

- **`mapper`:** model, module, two views, presets, help. Uses five `j.parameter_array` and one `j.remote_array`, and `j.map`.
  The `function_options` patchers are ported only if something loads them (no reference by name was found in the
  model's patchers).
- **`midiin`:** model, module, view, presets, help. Uses `j.return_array cc.[128]`. `midiin.model_old.maxpat` is not ported.
- **`hi`:** model, module, view, presets, help. Uses `j.return_array hi.[256]` and Max's `hi`.
- Help patcher parts that show audio or the `mouse` model are left out, and `docs/changes.md` says so.
- The `.html` pages beside the old models are not ported.

## Deliberate differences (each goes in `docs/changes.md`)

1. Instances are served in index order. The old order came from an internal table.
2. Setting an attribute leaves the selection alone. The old code left it pointing at the last instance.
3. Index 256 can be selected. The old code held the index in 8 bits, so 256 failed.
4. `+` and `-` act on all instances when all are selected. The old code changed only one of them.
5. The right inlet also accepts a float as an index (rounded down). The old code treated it as a value.

## Testing

- Core unit tests: bracket parsing and instance names, selection, cutting an `array` list, collecting the array output,
  resizing, presets with array instances, and the OSC parsing.
- Max tests built with `tools/maxtest/make_test.py`, following `tests/integration/README.md`, for each new object and for
  `mapper` from input parameter to output parameter. The old `j.oscinstance` and `j.oscroute` tests join the conformance run.
- `midiin` and `hi` are tested for load, namespace and the paths that can be driven without hardware. With a real MIDI
  device and a real human interface device they are checked by the author.
- Sanitizers, Doxygen, `scripts/check-help.sh` and the full Max run (one test per launch) on `main` before the tag.

## Order of work (each step ends green and committed)

1. Core: array rules, with tests; inventory document.
2. The shared attribute header (existing tests must pass unchanged), then the three data arrays.
3. `j.remote_array`.
4. `j.oscinstance`, `j.oscroute`, `<model>:initialized` and `j.initialized`.
5. `j.namespacebrowser.view`, then `mapper`.
6. `midiin` and `hi`.
7. Help and reference pages, `docs/conformance/m5-results.md`, `docs/changes.md`, `CHANGELOG.md`, tag `milestone-5` on
   `main` (branch `milestone-5`, removed after the merge).

## My calls (to be checked)

- The extra items in goal 3 are all included, rather than cut from the help patchers.
- Dropping the MC mapping of arrays (see non-goals).
- The five differences above. Differences 4 and 5 are the ones a patcher could notice if it relied on the old behaviour.
- A selection that no longer exists after shrinking falls back to all.

## What is left to the builder

Class names and the shape of the shared header, error message texts, test names, and the details of each object that the
summary above does not mention (read from the old source and reference pages).
