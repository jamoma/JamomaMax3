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
