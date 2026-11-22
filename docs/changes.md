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

- **Binding does not poll.** The old `j.send` / `j.receive` retried up to 100 deferred times to find their model and then reported an error. The new ones resolve the address once the patcher has loaded and follow nodes that appear or go (an observer in the namespace). An object that cannot find its target stays unbound without a console error. A model that is created after the object (by script, long after load) is not followed.
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
