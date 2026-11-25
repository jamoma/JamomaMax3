# Deliberate differences from the old JamomaMax behaviour

Milestone 1 (namespace and data). Everything not listed here behaves as the old objects did, and the old integration
tests (`conformance/m1-tests.txt`) are the evidence. Differences are either additions, or things left out for a later
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
- **`#1`, `#0` in abstractions:** Max itself replaces a whole-token `#1` (`qmetro.model #1`), and that is all that works. A `#1` inside a longer word (`m#1`) is **not** replaced: Max leaves it and the SDK has no documented way to read the arguments of an abstraction. `jamoma::substitute_arguments` exists in the core, tested, and is not used by any object yet.
- **`j.view`:** binds to the model named by its argument (absolute, or relative to the model of the containing patcher), else to the model of the same class in the containing patcher (an argument `j.model`, which the old qmetro view writes, means the same). It does not register a node in the namespace (the old one was `j.model` compiled with a flag); what it is bound to is worked out when asked, so it follows models coming and going. A relative address in `j.send`, `j.receive` and `j.remote` inside a view is relative to the model the view is bound to. `dump` answers `model:address <address>` or `model:waiting`. `activity` and `alias` are accepted and have no effect.
- **Presets** live in the core `Model` (`Model::presets()`), not in the `j.model` object. Messages: `preset`, `preset:new [<position>] <name>`, `preset:update`, `preset:delete`, `preset:clear`, `preset:names` (answers `preset:names ...` on the dump outlet), `preset:move`, `preset:copy`, `preset:rename`, `preset:interpolate <a> <b> <0..1>`, `preset:mix <preset> <factor> ...`, `preset:read [file]`, `preset:write [file]` (with `/again`). Positions in messages count from 1. `new` of an existing name stores again in place. Interpolation: numbers and lists of numbers of the same length are interpolated, any other value is taken from the nearer preset (the second at exactly 0.5); the old ramp-function branch is not built. Mix is normalised per entry by the factors of the presets that have it.
- **Preset files:** the text format of the old model file is read and written fully (`- preset "name"`, `- description "..."`, comments, `<address> <value...>`); the model reads `<patcher name>.presets.txt` (for `qmetro.model.maxpat`: `qmetro.model.presets.txt`) from the Max search path after its first initialisation and recalls `default`. The XML format of the old cue and application files is read and written by the core and is **not** connected to `j.model`. A file that is damaged is read as far as possible and reported on the console; a missing file, or one without presets, changes nothing. `WAIT` lines of old preset scripts are reported and skipped.
- **The `data` amenity:** a model has the parameter `data/active` (integer 0 or 1, default 1) unless `amenities` leaves `data` out; presets store and recall it. The audio amenities are accepted and have no effect.
- **`j.remote`** has the outlets of the old object: `set <value>` (left), the value, a reserved outlet (the old object selected a UI object with it), dump. Every change of the node, the answer to the remote's own command included, comes out of both of the first two outlets (the old test reads it); `set <value>` shows a value in the UI without sending it. A UI object that is dragged while a ramp runs stops the ramp (any command does). `highlight` is accepted and has no effect; the connected UI object is not inspected (both outlets always carry the value).
- **`j.ui`** is a drawn panel (Min has no text field): the address (or `waiting for a model:address`), the menu of parameters, messages and returns, the menu arrow with the utilities and the presets. Create New Preset stores `preset <n>`; a preset is renamed with `preset:rename`. File and window items are sent out of the outlet as messages (`preset:read`, `preset:write`, `preset:edit`, `model:reference/open`, ...) for a patch to route; `preset:edit` and the Max reference, help and internal windows are **not** built in `j.model`. No preset slider, no audio widgets. The colours are fixed attribute defaults (a dark panel); following Max's light and dark themes is not done. `dump` reports the state (`model:address`, `preset:count`, `presets`, `preset:current`). The size snaps to the grid of the old version, whole units of 150 pixels across and 35 pixels down (at least one of each; half a unit rounds down), whenever Max resizes the box; the attribute `snap` (default 1) switches it off. If the model has `data/active` (the `data` amenity), the header shows the old active button (filled while the model is on, a ring when it is off; a click switches it, and it follows the parameter); the message `active [0|1]` does the same from a patch and `dump` reports `active <0|1>`. The other buttons of the old header (freeze, audio gain, mix, mute, bypass, and the subwindow button) are not built yet; the audio ones belong to milestone 4.
- **`j.maxhelpui`** (the title and description header that old help patchers load as a bpatcher) is in the package (`patchers/components/data/maxhelpui`, with its button picture and resize script), so old help files such as `qmetro.model.maxhelp` open without an error. The test `package_references` checks that every bpatcher, `js` file and picture that a package patcher loads is in the package.
- **`j.node`** is a model registered at `<model>/<name>` with a priority: `Model::init` orders it among its siblings and initialises what is below it at its place.
- **`tags`** is accepted by `j.in`, `j.out` and `j.ui` (the old help patchers write `@tags jit_matrix`); no effect.

## Left out for now (not in milestone 3)

- `j.cue`, `j.map`, `j.namespace`, `j.textslider`, the audio objects and their amenities, network OSC, array objects (milestone 4 or later).
- File watching for presets files, `preset:edit` (the text editor window), aliases (`alias`, `alias/remove` are accepted by name only), `model:help/open` and `model/edit`.
- Text entry in the panel, the preset slider panel, the light/dark follow of the panel, embedded `#1` in names.

## Known gaps

- Windows: nothing of milestone 3 has been built or run there (see `docs/conformance/m3-results.md`).
- The look of `j.ui` and its menus have not been checked by eye.
- `tools/maxtest/open_help.py` and `run_maxtests.py` still end Max with `pkill` if it has not quit by itself after 30 seconds (milestone 1 leftover).
