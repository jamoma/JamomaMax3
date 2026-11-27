# Milestone 4: the rest of the old surface (design)

Status: draft for the author's approval, 26 November 2026. Parent spec: `2026-11-21-jamomamax3-modular-design.md`.

## Intent

Milestones 0 to 3 gave the package the namespace, `j.send`/`j.receive`, `j.view`, `j.ui` and presets, and the old `qmetro` model works. Milestone 4 finishes what the old package let a patcher do with those objects, so that old help files and patchers load without a placeholder comment where an object was. New Max 9 behaviour is **not** part of it (milestone 5).

The author's decisions (26 November 2026): audio and DSP wait for later milestones; the old surface comes first, the Max 9 additions after, as a separate milestone (approach B).

## Goals

1. **`j.namespace`** (old `j.namespace.cpp`, 609 lines): explores the namespace below an address. Outlets: data, size, dump. Messages `bang`/`explore` and an address symbol; attributes `output` (`descendants children brothers attributes`), `format` (`none umenu umenu_prefix jit.cellblock coll`) and `relative`. Built on the existing `ModelExplorer`/`Namespace`.
2. **`j.map`** (257 lines): `y = f(x)` between an input and an output address; outlets data and dump; attributes `input`, `output`, `inputmin/max`, `outputmin/max`, `active`, `inverse`, `function`, `functionlibrary`, `functionparameters`, `functionsamples`, `ramp`; messages `int`, `float`, `list`, `reset`. Needs the function library the old mapper uses (see Calls).
3. **`j.cue`** (564 lines): stores and recalls the state of several models; messages `get`, `set`, `read`, `write`, `read/again`, `write/again`, `edit`, `dblclick`/`edclose`; outlets line and dump. Uses the XML preset reader and writer already in the core, which until now nothing connected.
4. **`j.textslider`** (703 lines): a drawn slider showing text and value; attributes `range`, `textpos`, `text`, `unit`, colours, `defeat`; mouse drag, double-click and Ctrl-click reset to the default value. Plain Max UI box (jbox), text drawn with jgraphics.
5. **`j.ui` and `j.model`:** the **subwindow** button; **naming a preset when it is created** (the author's wish); and the **text editor window** for `preset:edit` (shared with `j.cue edit`).
6. **`osc_receive`** (old `patchers/models/data/osc/`: model and view): ported into the package as the second real model next to `qmetro`. It uses `j.model`, `j.out`, two `j.parameter`, `j.receive`, `j.send`, `j.view`, `j.remote` and Max's own `udpreceive`, so nothing is missing. It is a second real model for the conformance set, with its own help and a Max test; `j.out`'s `freeze` attribute is already built and tested.
7. **No freeze button.** The old `j.ui` never shows one: its code has a freeze button and a `data/freeze` viewer, but the flag that would turn them on is never set (`j.ui.internals.cpp`, `ui_return_model_content`: `freeze = NO` and nothing sets it), and the author confirmed in the old `qmetro.model.maxhelp` that no freeze button appears. So it is not built; `docs/changes.md` records it as dead code of the old version. `data/freeze` stays a reserved address.
8. **`view/freeze`:** old cue scripts and helper patchers send `view/freeze` (freeze the view's display), which is not `data/freeze`. The old `j.view`/`j.ui` source is read to see what it did; it is built if it is part of the old surface, otherwise listed in `docs/changes.md`.
9. **Help and conformance:** the help patchers of the five objects migrated, and `osc_receive` (model, view) in the conformance set; patchers that used a missing object get it back; the `j.model`, `j.parameter` and `j.return` help files lose their `j.map`/`j.namespace`/`j.cue`/`j.textslider` placeholders (the audio objects stay placeholders).

## Non-goals

- Audio and DSP: `j.in~`, `j.out~`, `j.limiter~`, the `j.ui` gain/mix/mute/bypass buttons and meters (later milestones).
- Dictionaries/JSON, JavaScript, MC and the three array objects (milestone 5).
- The data models **`mapper`** and **`midiin`** (and **`hi`**, which needs `j.return_array` as they need the array objects): moved to milestone 5 with the array objects and MC. `mapper` is the real-world test of `j.map`; in milestone 4 `j.map` is tested by its help patcher and own tests. (`hi` is my addition; the author named `mapper` and `midiin`.)
- A Windows run (still due, needs a machine), network OSC, aliases, file watching, the preset slider panel.
- Anti-goal: changing the behaviour of anything finished in milestones 1 to 3. Every existing test stays green.

## Approaches considered

- A, one milestone in two phases (old surface then Max 9); C, interleaved by theme. Rejected: one tag after a very long plan, and old and new behaviour mixed in one change.
- **B (chosen by the author): milestone 4 = old surface; milestone 5 = Max 9 additions with the arrays and MC.**

## Order of work (each step ends green and committed)

1. `j.namespace`: smallest dependency, removes placeholders in three help files.
2. `j.map` with the function library.
3. The text editor window (shared piece), then `j.cue` and `preset:edit`.
4. `j.textslider`.
5. `j.ui`/`j.model`: subwindow, naming a preset, `view/freeze`.
6. Help migration, conformance run, results record `docs/conformance/m4-results.md`, `docs/changes.md`, `CHANGELOG.md`, tag `milestone-4` on `main` (branch `milestone-4`, removed after the merge, as for milestone 3).

## Constraints and rules

Same compatibility contract as the parent spec (section 9): names, attributes, outlet order and file formats preserved; each deliberate difference listed in `docs/changes.md`; anything new in `CHANGELOG.md`. Core stays Max-free with `ctest` unit tests; behaviour in Max is covered by tests in the per-external layout under `tests/integration`; sanitizer runs and the Doxygen build stay clean; the full one-test-per-launch Max run is made on `main` before the tag.

## My calls (to be checked)

- **Function library for `j.map`:** read it from the old Foundation library and build the functions the old mapper offers, as a core library with unit tests. Whether `j.parameter`'s ramp `function` then also accepts them is **not** done in this milestone (today only linear exists); it is noted as a difference and left for the author to decide.
- **Text entry for naming a preset:** first try Max's own text editor window API (also needed for `edit`); if a single-line prompt in the panel turns out not to be possible, keep `preset:rename` and say so.
- **`j.cue` file format:** the old XML cue file, read and written by the existing core code; a file written by the old software is not available, so compatibility is checked against the old writer's source (as for presets).
- **Subwindow button:** sends the same message the old one did (read from the old `j.ui` source) so a patch can route it; no window of its own unless the old behaviour needs one.
- **Max reference/help/internal windows** of the `j.ui` menu stay "sent as a message", unless cheap once the editor window exists.

## What is left to the builder

Message and outlet details of each object (read from the old source and reference pages), exact colours and geometry of `j.textslider`, the shape of the text editor window helper, and test names.
