# Deliberate differences from the old JamomaMax behaviour

Milestone 1 (namespace and data). Everything not listed here behaves as the old objects did, and the old integration
tests (`tests/integration`, folder `Modular/j.parameter`) are the evidence. Differences are either additions, or things left out for a later
milestone (so a patcher that uses them will not find them yet).

## Changed or added behaviour

- **Initialisation order** of a model follows the old rule (priority, then name, then instance); the plan said creation order and that was wrong. No difference from the old objects.
- `j.model` has a left outlet that is not used yet (preset results come with the presets) and the dumpout on the right, as the old help patchers expect.
- `j.model` accepts `@amenities` and stores it; it has no effect yet (the services it selects, such as audio in/out, come in later milestones).
- **Model lookup is deferred:** a data object finds its model after the patcher has loaded, so for a very short moment after creation it is registered at the top level. Nothing visible changes in a loaded patch.
- `ramp/function` defaults to `none` (behaves as linear); `value` answers nothing until the object is initialised. Both as the old tests expect.

## Left out for now (not in milestone 1)

- Message `dump` on `j.parameter`, `j.message`, `j.return`, `j.model`; attribute `style` is the standard Max one.
- `j.model`: attributes `alias`, `activity`, `presets`, `tags`; messages `preset:*`, `alias/remove`, double-click editing, `model/edit`, `model:help/open`.
- `ramp/drive external`; ramp functions other than `linear` and `none`; dataspaces other than gain, time and position.
- Nested models (a `j.model` inside the patcher of another model) are not given nested addresses; all models are at the top level.
- Objects not yet present: `j.unit` (three of the 82 old tests need it), `j.send`, `j.receive`, `j.remote`, `j.view`, `j.ui`, `j.out`, `j.in`, `j.out~`, `j.in~`, `j.map`, `j.cue`, `j.namespace`, `j.node`. The migrated help patchers show a comment where such an object was.
- Windows is built but untested (no Windows machine yet).


# Milestone 2 (send, receive and their neighbours)

Differences from the old behaviour, on top of the list above. The old test suite has no integration tests for `j.send`, `j.receive`, `j.in` or `j.out`; their behaviour was read from the old source (`docs/inventory/send-receive.md`, `docs/inventory/j.in-j.out.md`) and is tested by own Max tests.

## Changed or added behaviour

- **Binding does not poll.** The old `j.send` / `j.receive` retried up to 100 deferred times to find their model and then reported an error. The new ones resolve the address once the patcher has loaded and follow nodes that appear or go (an observer in the namespace). An object that cannot find its target stays unbound without a console error. A model that is created after the object (by script, long after load) is not followed. *(Closed in milestone 3: see below.)*
- **Wildcards:** a name of `*` in an address matches any name, and any instance unless the address gives one (`/model/*`); an instance of `*` matches any instance. (The old namespace had only the instance form in `find`; the name form is what `j.receive /model/*` needs.)
- **`j.receive` and `j.send` outlets:** `j.receive` outputs the address of the node as a message whose selector is the address; `j.send` reports `address <absolute>` and `error` on its dump outlet, as before. `#0`-style argument substitution in addresses is not done (it belongs to model abstractions with arguments, milestone 3). A `j.send` target that is a model forwards to the member named by the first symbol and only reaches data objects; a target that is another kind of message of the old model is not built.
- **Standalone parameters initialise themselves.** A `j.parameter` with no model sends itself `init` after the patcher has loaded (the old object did; this fixes the old integer-repetition test). `j.message` and `j.return` do not.
- **`dump`** is back on `j.parameter`, `j.message`, `j.return` and `j.model`.
- **Value messages run on the thread that sends them.** Ramp ticks arrive from Max's scheduler thread; the value-carrying messages of the data objects, `j.send`, `j.unit`, `j.in` and `j.out` are handled there directly, as the old objects did (Min would otherwise defer them to the main thread and lose most of a ramp).
- **`j.unit`:** new, with the `temperature` dataspace (Kelvin, Celsius, Fahrenheit; aliases K, C, F) as its default, as the old object. The dataspaces `angle`, `distance`, `color` and the others of the old library are not built (the help patcher shows comments for `color`).
- **`j.in` / `j.out` (data only):** values pass through; `mute` and `freeze` (out) act; `mix`, `gain` and `bypass` are stored and have no effect (the old ones acted on audio only). The nodes `data/in.N` and `data/out.N` hold the last value and are visible to `j.receive`; the attributes `mute`, `freeze` and the others are attributes of the Max object, not of the node, so `j.send` cannot set `data/out.1:mute`. The audio objects (`j.in~`, `j.out~`) are not built.

## Left out for now (not in milestone 2)

- Network OSC (`directory:` addresses beyond parsing, remote applications), `j.remote`, `j.view`, `j.ui`, presets (milestone 3).
- `j.map`, `j.cue` (milestone 3 and 4), `j.namespace`, `j.node` (decided in the milestone 3 plan).
- Messages and attributes removed from the reference pages because they are not built: see the ledger of milestone 2 and `docs/changes.md` above (preset messages of `j.model`; `type` and `dump` of `j.in` / `j.out`).

## Known gaps found in the milestone 2 review

- A `j.send` or `j.receive` binds to the model of its patcher once, after the patcher has loaded. A model that appears later (created by script) or is replaced under another name (`name.1`) is not followed; set the `address` attribute again. (Planned in the first draft of the milestone 2 plan; left out: it needs a model observer.)
- A `j.parameter` still drops a command that arrives while another command (on another thread, for example a ramp tick) is being processed, as the old object did.

# Milestone 3 (views, presets and the panel)

Differences from the old behaviour, on top of the lists above. The old suite has one `j.remote` test and none for `j.view`, `j.ui`, `j.node` or presets; their behaviour was read from the old source (`docs/inventory/presets.md`, `view-model.md`, `j.remote.md`, `j.ui.md`) and is tested by own Max tests and the old `qmetro` model.

## Changed or added behaviour

- **Models that come later, go, or are replaced are followed.** `j.send`, `j.receive`, `j.remote` and the data objects find their model again when it appears, is replaced or is deleted (an observer on the patcher-to-model map). This closes the milestone 2 gap. A `j.model` inside the patcher of another model is registered below it (`/outer/inner`), also when the outer one appears later.
- **A model without a name takes its class from the file name:** `qmetro.model.maxpat` is `/qmetro`, `qmetro.view.maxpat` is the view of class `qmetro`. Other patchers keep the milestone 1 rule (the file name with dots replaced).
- **`#1`, `#0` in abstractions:** Max itself replaces a whole-token `#1` (`qmetro.model #1`), and that is all that works. A `#1` inside a longer word (`m#1`) is **not** replaced: Max leaves it. `jamoma::substitute_arguments` exists in the core, tested, and is not used by any object yet.
- **`j.view`:** binds to the model named by its argument, else by the first argument of its bpatcher (either one absolute, or relative to the model of the containing patcher; since milestone 4 a `j.model` without an argument in a bpatcher likewise takes its name from the bpatcher argument; since milestone 4 `model:address <address>` also sets the address later, as in the old object), else to the model of the same class in the containing patcher (an argument `j.model`, which the old qmetro view writes, means the same). It does not register a node in the namespace (the old one was `j.model` compiled with a flag); what it is bound to is worked out when asked, so it follows models coming and going. A relative address in `j.send`, `j.receive` and `j.remote` inside a view is relative to the model the view is bound to. `dump` answers `model:address <address>` or `model:waiting`. `activity` and `alias` are accepted and have no effect.
- **Presets** live in the core `Model` (`Model::presets()`), not in the `j.model` object. Messages: `preset`, `preset:new [<position>] <name>`, `preset:update`, `preset:delete`, `preset:clear`, `preset:names` (answers `preset:names ...` on the dump outlet), `preset:move`, `preset:copy`, `preset:rename`, `preset:interpolate <a> <b> <0..1>`, `preset:mix <preset> <factor> ...`, `preset:read [file]`, `preset:write [file]` (with `/again`). Positions in messages count from 1. `new` of an existing name stores again in place. Interpolation: numbers and lists of numbers of the same length are interpolated, any other value is taken from the nearer preset (the second at exactly 0.5); the old ramp-function branch is not built. Mix is normalised per entry by the factors of the presets that have it.
- **Preset files:** the text format of the old model file is read and written fully (`- preset "name"`, `- description "..."`, comments, `<address> <value...>`); the model reads `<patcher name>.presets.txt` (for `qmetro.model.maxpat`: `qmetro.model.presets.txt`) from the Max search path after its first initialisation and recalls `default`. The XML format of the old cue and application files is read and written by the core and is **not** connected to `j.model`. A file that is damaged is read as far as possible and reported on the console; a missing file, or one without presets, changes nothing. `WAIT` lines of old preset scripts are reported and skipped.
- **The `data` amenity:** a model has the parameter `data/active` (integer 0 or 1, default 1) unless `amenities` leaves `data` out; presets store and recall it. The audio amenities are accepted and have no effect.
- **`j.remote`** has the outlets of the old object: `set <value>` (left), the value, a reserved outlet (the old object selected a UI object with it), dump. Every change of the node, the answer to the remote's own command included, comes out of both of the first two outlets (the old test reads it); `set <value>`, as before, sends the value to the node without output from this object (until milestone 4 it only showed the value here, which was wrong). A UI object that is dragged while a ramp runs stops the ramp (any command does). `highlight` is accepted and has no effect; the connected UI object is not inspected (both outlets always carry the value).
- **`j.ui`** is a drawn panel (Min has no text field): the address (or `waiting for a model:address`) and its menus (see "Help patcher review" below for their places since then). Create New Preset asks for a name since milestone 4 (see "j.ui additions" below); a preset is renamed with `preset:rename`. Where the file, preset editor and window items go has changed since (see "Help patcher review" below). No preset slider, no audio widgets. The colours changed in milestone 4 (see "j.ui colours" below). `dump` reports the state (`model:address`, `preset:count`, `presets`, `preset:current`). The size snaps to the grid of the old version, whole units of 150 pixels across and 35 pixels down (at least one of each; half a unit rounds down), whenever Max resizes the box; the attribute `snap` (default 1) switches it off. If the model has `data/active` (the `data` amenity), the header shows the old active button (filled while the model is on, a ring when it is off; a click switches it, and it follows the parameter); the message `active [0|1]` does the same from a patch and `dump` reports `active <0|1>`. The audio buttons of the old header (gain, mix, mute, bypass) are not built yet; they come with the audio objects. For the subwindow button and the freeze button see "j.ui additions" below.
- **A bang of a node of type none** (for example a `j.return trigger @type none`) reaches `j.receive` as a bang and `j.remote` as `set bang` out of the left outlet (so that a button blinks, as in the old object) and a bang out of the value outlet. Before, both dropped it as an empty value.
- **`j.receive`, `j.send` and `j.remote` follow their model quietly.** They bind again when a model comes, goes or is replaced, but only after the change has settled (one deferred call for a burst of changes) and only if the address that the written one resolves to is another than the one bound. A model of another patcher that is opened or closed therefore changes nothing and nothing is reported again; before, every receiver reported all its values again, and a relative wildcard such as `*/*` could for a moment resolve against the root and pick up the values of other models. The test `j_receive_other_models` checks it.
- **`j.maxhelpui`** (the title and description header that old help patchers load as a bpatcher) is in the package (`patchers/components/data/maxhelpui`, with its button picture and resize script), so old help files such as `qmetro.model.maxhelp` open without an error. The test `package_references` checks that every bpatcher, `js` file and picture that a package patcher loads is in the package.
- **`j.node`** is a model registered at `<model>/<name>` with a priority: `Model::init` orders it among its siblings and initialises what is below it at its place.
- **`tags`** is accepted by `j.in`, `j.out` and `j.ui` (the old help patchers write `@tags jit_matrix`); no effect.

## Left out for now (not in milestone 3)

- `j.cue`, `j.map`, `j.namespace`, `j.textslider`, the audio objects and their amenities, network OSC, array objects (milestone 4 or later).
- File watching for presets files, `preset:edit` (the text editor window), aliases (`alias`, `alias/remove` are accepted by name only), `model:help/open` and `model/edit`.
- Text entry in the panel, the preset slider panel, the light/dark follow of the panel, embedded `#1` in names.

## Known gaps

- Windows: nothing of milestone 3 has been built or run there (see `docs/conformance/m3-results.md`).
- The look of `j.ui` and its menus had not been checked by eye in milestone 3 (see `docs/conformance/m4-results.md` for milestone 4).
- `tools/maxtest/open_help.py` and `run_maxtests.py` still end Max with `pkill` if it has not quit by itself after 30 seconds (milestone 1 leftover).

## j.namespace (milestone 4)

- Built: `address`, `output`, `format`, `relative`, `update`, `sort`, `depth`, `namespace`, exploring, and the selection (`select`, `select/all`, `select/none`, `selection/refresh`). A selection is shared by name (`namespace`, also used by `j.cue`); without a name it is private and is not output.
- **Filters are not built:** `filter/set`, `filter/remove` and `filter/info` warn in the console and do nothing; `filter/list` is accepted without effect.
- An address that does not exist gives an empty result of size 0. `update` explores again only when the result changes.

## j.map (milestone 4)

- Built: the mapper and all 38 functions of the old function library, the four thresholds, `reset` and `dump`. No `clipmode` and no output clipping by default, as before.
- The parameters of a function (`base`, `power/value`, ...) are set by message, not as arguments at creation.
- Numbers that are not finite never leave the outlet: a limit that is not finite is ignored, an input that is not a number gives the lower output limit. An unknown function or symmetry is refused with a console error; the base of `exponential` and `logarithm` is kept between 0.000001 and 100000.
- `ramp` applies to what is sent to the output parameter, not to the outlet.
- The graphical editor of freehand curves (`j.function_edit`) is not built.

## j.cue (milestone 4)

- Built: the cue manager with its messages (new, update, append, recall, next and previous, output, interpolate, mix, move, delete, order, rename, copy, clear, optimize, get and set, selecting what is stored, text and XML files, the editor).
- The text file keeps the description in a comment line `# description: ...`, which the old object ignores. A file ending in `.xml` is read and written as XML.
- A file or an edited text without any cue changes nothing and reports it. A recall that starts at an address does not change the current cue. Recall reports the lines whose parameter does not exist.
- `sequence` is not built (it was not part of the object of this version).

## Preset editor (milestone 4)

- `preset:edit` opens the presets as text in Max's editor window; closing it replaces the presets. New: `preset:edit/apply <text>` does the same from a patch (`\n` stands for a line break). The same window is used by `j.cue edit`.

## Model arguments and `osc_receive` (milestone 4)

- A `j.model` without an argument of its own takes its name from the first argument its patcher was loaded with, in a bpatcher or as an abstraction (`osc_receive.model osc_rcv` registers as `osc_rcv`), as the old object did; `j.view` finds its model the same way. The text of the box is read for this, as the old code did. So `qmetro.module q1` registers its model as `/q1` (until now it was `/qmetro`). Subpatchers (`p`) take no name from their box, and an argument that starts with `#` or `@` is not a name.
- **`osc_receive`** is ported. One change in the patcher: the old one listened to `:data/active`, which names an attribute and not the parameter, so by the reading of the old address rules the switch had no effect; it now listens to `data/active`.

## j.ui additions (milestone 4)

- **Create New Preset** asks for the name as before. A name that is taken is numbered (`<name> 1`), an empty one becomes `preset <n>` (the old object sent the name on as it was). New: `preset:name <name>` does the same without the dialog.
- **Second panel:** the button with a plus sign is shown when the outlet feeds an inlet of a subpatcher; a click (or the new message `panel`) sends `bang`, titles the subpatcher with the model address and opens it. A cord made while the patcher is edited shows the button at the next redraw, for instance on locking. The outlet also carries the menu messages.
- **Not built:** the freeze button and `view/freeze`. Nothing in the old version created or read `view/freeze`, and the freeze button was never shown. `data/freeze` stays a reserved address.

## j.ui colours (milestone 4)

- The old panel had fixed light colours (light grey panel and header, black text and highlight). A colour attribute at its default is now automatic and follows the patcher and the Max theme (see `CHANGELOG.md`); a patcher that saved colours keeps them as chosen colours. A colour set to exactly the new default value counts as the default. The Inspector shows the default values, not the colours drawn.
- The package's own patchers save no `j.ui` colours, and the import cleaner (`tools/package/clean_patcher.py`) removes them from imported patchers.

## j.textslider (milestone 4)

- **Colours:** the old object had fixed light colours (a grey track, a near-white bar, black text). The new defaults follow the colour theme of Max (see `CHANGELOG.md`); where a theme gives no colour, the defaults are a dark set. A patcher that saved the old colours keeps them as chosen colours. A colour set to exactly the new default value counts as the default and follows the theme.
- The pointer stays visible while dragging and is not put back at the knob on release.

## Help patcher review (27 November 2026)

Corrections after the author went through the help patchers:

- **Priority 0** means none and comes after every other priority, when a model initialises and in sorted lists; a preset is stored level by level (as the old objects).
- **`j.remote set <value>`** sends the value to the node without output from this object (it only showed the value before).
- **`j.unit`** sends `UnitMenu` (not `UnitsMenu`), `units.get` takes a dataspace, and `getdataspace`, `getinput`, `getoutput` answer.
- **Ramps follow the easing functions** of the function library; `ramp/function/parameters` lists the parameters, which are set and read by their names. The drives are `max`, `system` and `none`.
- **Addresses** may name attributes with a slash (`x:ramp/function`).
- **Attributes** that are true or false show as toggles, those with fixed values as menus (the unit of a parameter does not: it depends on the dataspace).
- **`j.model alias` and `alias/remove`** are built: a model and what is below it can also be reached under a second address.
- **`j.init`** follows its model when it moves while the patch loads (models inside models report again), and takes the address of a model as argument. While a patch loads, a model inside a model is initialised by that one, in order of priority, and not on its own first (the old version printed a few more start reports then).
- **`j.ui`** has the two menus of the old header, opened at the top of the panel: the circle with a downward triangle at the far left (the model and its presets) and the
  address beside it (the models of the same class, and the user-defined and generic parameters, messages and returns). Differences: choosing a parameter, message or return sends
  `model:reference/open <address>` out of the outlet instead of opening the inspector window; **Edit Current State** and **Open Preset Interface** are grey (not built);
  the preset file items act on the `j.model` of the model, as before; the reference, help and internal items only send their message out of the outlet; a model of the same class can be chosen only in a view. New: `menu:list` and `menu:choose`.


# Milestone 5: arrays

`j.parameter_array`, `j.message_array`, `j.return_array` (and `j.remote_array`) behave as the old ones, except:

- Values sent to all instances reach them in index order (the old order came from an internal table).
- Setting an attribute leaves the selection as it is (the old code left it pointing at the last instance).
- Instance 256 can be selected (the old code failed there).
- `+` and `-` step every instance when all are selected (the old code stepped only one).
- A float in the right inlet selects an instance, rounded down (the old code treated it as a value).
- Instances made when an array grows get the attributes set so far; the ones that exist are left alone (the old code applied the box attributes to all of them again).
- `dump` answers the attributes of the watched instance and `format` on the dump outlet (the old arrays answered nothing).
