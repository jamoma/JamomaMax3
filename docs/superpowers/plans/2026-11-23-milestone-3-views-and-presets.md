# JamomaMax3 Milestone 3 (views, remotes, the generic UI and presets) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** A model can be seen and driven from outside as in the old package: `j.view`, `j.remote`, `j.ui` and `j.node` run natively in Max 9, models store, recall, interpolate and file presets in the old text and XML formats, and the old `qmetro` model with its view and module loads and works end to end.

**Architecture:** The core gains the things a view needs, all Max-free and unit-tested: the observation of models appearing and going (so objects bind to a model that appears later), a `PresetManager` with interpolation and the two file formats, a `Remote` (a value that is kept equal on a UI object and on a node) and a `ModelExplorer` (what a `j.ui` lists). The externals stay thin. `j.view` is `j.model`'s sibling: one shared base, two registered names, as in the old code. `j.ui` is a Min-API user interface object that draws its own text (spec section 7).

**Tech Stack:** As milestone 2 (C++20, CMake, Catch2, Min-API, max-test, Python tools); the Max drawing API (jgraphics) and the Max popup menu API for `j.ui`.

**Spec:** `docs/superpowers/specs/2026-11-21-jamomamax3-modular-design.md` (sections 7-12). Earlier plans: `docs/superpowers/plans/2026-11-21-milestone-1-namespace-and-data.md`, `docs/superpowers/plans/2026-11-22-milestone-2-send-receive.md`; results `docs/conformance/m2-results.md`; differences `docs/changes.md`; decisions `docs/decisions/0001-shared-state.md`. Old behaviour: `~/Developer/Jamoma/JamomaMax` (`source/j.model` (shared with `j.view`), `source/j.remote`, `source/j.ui`, `JamomaCore/Modular/library/source/TTPresetManager.cpp`, `TTPreset.cpp`, `TTViewer.cpp`, `TTExplorer.cpp`; the `qmetro` model in `Jamoma/patchers/models/data/qmetro`; reference pages and help patchers of these objects).

## Global Constraints

Everything in the milestone 1 and 2 plans' Global Constraints still holds (clean-room, Max 9, macOS arm64 + x86_64 from macOS 12, Windows x64 untested but compiling by construction, old names and OSC semantics, core without Max headers, all C++ Doxygen-documented with no warnings, BSD-3-Clause SPDX headers, the rules of `0001-shared-state.md`, and the Min rules: state before attributes, `if (c74::min::dummy()) return;`, unsubscribe in the destructor, documentation stubs off, sanitizer builds in their own package folder). Added by what milestone 2 taught:

- **Threads.** Value messages are `message<threadsafe::yes>` (Min otherwise defers and loses ramp ticks) and hand any work that touches the namespace, the core `Sender`/`Receiver` (main thread), Min attributes or drawing to the main thread with `jamoma_max::run_on_main`. Core callbacks may arrive on the scheduler thread: Max code guards them with the object's `Alive` token and the core waits for callbacks in flight on teardown. Every new external states in its Doxygen which thread each handler runs on.
- **A test that cannot fail is not a test.** For every fix, show the test failing first. Max tests that wait for a model start from `j.init`'s end outlet, never from a fixed delay. `test.assert` that never receives input is a failure, so "not reached" is checked by comparing a held value (`zl reg`).
- **Max is used only through the runners and announced before and after** (the user watches). The runners have a progress bar and a quick mode (`--fast N`: batches, failures rerun alone); acceptance runs use one test per launch. The old integration tests are in `tests/integration` and run from there; own tests in `tests/max`.
- Files that Max writes or reads (presets) are written and read in the old formats; additions are optional and ignored by the old readers (spec section 9). Nothing is written next to a patcher unless the user asked (`preset:write`).
- Differences from the old behaviour go into `docs/changes.md`, every ruling into the ledger.

## Review Focus

Failure modes the spec implies that ordinary task tests would miss, most likely first. Each gets a test in the task named.

1. **A view whose model is not there yet, goes away, or is replaced** (bpatcher loaded before its model, model closed while views stay open, a second model with the same name becomes `name.1`): no dangling pointer, the view says it is waiting, binds when the model appears and lets go when it goes. Tasks 2, 7, 9, 11.
2. **Hostile preset files:** missing, empty, truncated or malformed XML, text lines without a value, a version the reader does not know, a preset that names a parameter that does not exist or whose type has changed, values outside the range, a very large file, non-ASCII names. Recall never crashes and reports what it skipped. Tasks 3, 5, 6.
3. **Feedback between a UI object, `j.remote` and the parameter,** while a ramp runs and while the user drags: no echo loops, the dragged value wins, the first value is not lost. Tasks 8, 9.
4. **Preset recall order and timing:** priorities, ramps in presets, interpolation between presets with different entries or types, mixing weights that do not add up to one. Tasks 3, 4.
5. **The UI under odd conditions:** a model with hundreds of parameters, names that are long or not ASCII, tiny and huge sizes, light and dark themes, no model yet, the model closing while a menu is open. Tasks 10, 11.

---

## File Structure

```
core/include/jamoma/{model,preset,preset_files,remote,explorer}.hpp   model.hpp gains observation; the rest are new
core/src/{model,preset,preset_files,remote,explorer}.cpp
core/tests/*_test.cpp
externals/common/{max_context,max_ui}.hpp              max_ui.hpp: popup menu and text drawing helpers
externals/j.model/ j.view/ (shared base in externals/common/model_object.hpp) j.remote/ j.ui/ j.node/
tests/max/patchers/*.maxtest.maxpat, tests/integration/...    own and copied tests
conformance/{m3-tests.txt,own-tests.txt,implemented.txt}
package/Jamoma/{help,docs/refpages}/                          help patchers and reference pages
package/Jamoma/patchers/models/data/qmetro/                    the qmetro model, view, module and presets file (copied, Task 14)
docs/inventory/{view-model,presets,j.remote,j.ui}.md           characterisation notes (Task 1)
docs/conformance/m3-results.md, docs/changes.md
```

---

### Task 1: Characterise, choose the conformance set, baseline

**Files:**
- Create: `docs/inventory/view-model.md`, `docs/inventory/presets.md`, `docs/inventory/j.remote.md`, `docs/inventory/j.ui.md` (replaces the milestone 0 page's open items), `conformance/m3-tests.txt`

**Interfaces:**
- Produces: four notes, each ending with a **Rulings** list that later tasks cite by name:
  - `view-model.md`: how a view learns the address of its model (patcher context, `model:address`, the `#1` argument of the module patcher, `share_patcher_info` / `share_patcher_node`), what `j.view` shares with `j.model` and what it switches off (`JCOM_VIEW` blocks), how a nested model gets its address, what `#0` / `#1` substitute in object arguments and addresses (`jamoma_parse_dieze`), the alias attributes, what `amenities` do for data.
  - `presets.md`: the preset model (`name`, `description`, entries address→value, order), every manager message (`new`, `update`, `recall`, `output`, `interpolate`, `mix`, `move`, `delete`, `order`, `rename`, `copy`, `clear`) with what it does to the current preset, recall order, how ramps and units inside a preset are applied, interpolation and mix rules for numbers, lists, symbols, the **text format** (read from `qmetro.model.presets.txt` and `TTPresetManager` / `TTPreset` text reader and writer) and the **XML format** (from `WriteAsXml` / `ReadFromXml`; write a real sample by reading the code, there is no sample file), where the model looks for and writes its presets file, `preset:read/write/again/edit`.
  - `j.remote.md`: arguments, attributes (`active`, `address`, `unit`, `freeze`, `highlight`), messages (`bang`, `int`, `float`, `list`, `anything`, `address`, `set`, `dump`), outlets, how the UI object's value and the node's value are kept equal (the `set` message, echo suppression, ramps, `freeze`), unit conversion, what is sent when the model appears, and the one old test (`Modular/j.remote/dataspace/j_remote_dataspace_db2linear`).
  - `j.ui.md`: what the panel shows and when (`has_*` flags), the menus (model address menu by service, preset menu, utilities) and the messages each item sends, the colour attributes and defaults, sizes, the empty state, and the interactions that need a text field (decides how much editing is built: draw our own text first).
- Produces: `conformance/m3-tests.txt`: the old `j.remote` test (copied into `tests/integration` in this task) and every old test that uses `j.view`, `j.ui` or presets (`grep` over `JamomaIntegrationTests`; say so if none).

- [ ] **Step 1: Read** the sources named above, the old reference pages and help patchers of `j.view`, `j.remote`, `j.ui`, `j.node`, and `qmetro.model.maxpat`, `qmetro.view.maxpat`, `qmetro.module.maxpat`; write the four notes with file and line for every rule. Anything not read is marked "to characterise", never guessed.
- [ ] **Step 2: Copy** the old `j.remote` test into `tests/integration/JamomaIntegrationTests/patchers/tests/Modular/j.remote` (same structure, as the 82) and write `conformance/m3-tests.txt`.
- [ ] **Step 3: Baseline** (announce Max use): `scripts/run-maxtests.sh conformance/m3-tests.txt build/maxtests-m3-baseline`. Expected: FAIL with missing objects. Commit the notes and the list.

---

### Task 2: Models that appear later, nested models, abstraction arguments

**Files:**
- Modify: `core/include/jamoma/model.hpp`, `core/src/model.cpp`, `externals/common/max_context.hpp`, `externals/common/data_object.hpp`, `externals/j.send/j.send.cpp`, `externals/j.receive/j.receive.cpp`, `externals/j.model/j.model.cpp`
- Test: `core/tests/model_test.cpp`, own Max tests `tests/max/patchers/late_model.maxtest.maxpat`, `nested_model.maxtest.maxpat`, `dieze.maxtest.maxpat`

**Interfaces:**
- Produces on `ContextMap`: `std::shared_ptr<void> observe(std::function<void(const void* patcher, Model* model, bool added)> callback);` (called after the lock is released, for every add and remove; handle semantics as `Namespace::observe`).
- Produces: `std::string substitute_arguments(std::string_view text, const std::vector<std::string>& arguments, std::string_view unique_id);` in `address.hpp` (the rules of `docs/inventory/view-model.md`: `#0` the unique id, `#1`.. the arguments).
- Produces: nested model addresses: a `j.model` inside the patcher of another model is registered below it (`/outer/inner`), by the rule recorded in Task 1.
- Consumes: Task 1 rulings; `find_model` of milestone 2.

- [ ] **Step 1: Write failing tests:** core `context_map_observer_hears_add_and_remove`, `substitute_arguments_replaces_dieze_arguments` (`#0`, `#1`, missing argument, no `#`); own Max tests: `late_model` (a `j.receive` and a `j.parameter` in a subpatcher whose `j.model` is created by script after load: they join it, closing the milestone 2 gap), `nested_model` (the inner model's parameters are at `/outer/inner/p`), `dieze` (an abstraction with an argument names its model through `#1`).
- [ ] **Step 2: Run, expect failure** (unit tests; announce Max use for the Max tests).
- [ ] **Step 3: Implement** the observer in `ContextMap`, `substitute_arguments`, and in `data_object`, `j.send` and `j.receive` a binding that is made again when the model of the patcher appears, is replaced or goes; `j.model` registers nested below the model of its parent patcher.
- [ ] **Step 4: Run** unit tests under ASan and TSan (own package folders), own tests and the 82 old tests (quick mode). Commit.

---

### Task 3: `PresetManager`

**Files:**
- Create: `core/include/jamoma/preset.hpp`, `core/src/preset.cpp`, `core/tests/preset_test.cpp`
- Modify: `core/CMakeLists.txt`

**Interfaces:**
- Consumes: `Namespace`, `Model`, `Data` (`command`, `get_attribute`, priority from `Model::init` ordering), Task 1 `presets.md`.
- Produces:
```cpp
struct PresetEntry { Address address; Value value; };            // address relative to the model, as in the files
struct Preset { std::string name; std::string description; std::vector<PresetEntry> entries; };
class JAMOMA_API PresetManager {
public:
    PresetManager(Namespace& ns, Address model);                  // the model whose parameters are stored
    const std::vector<Preset>& presets() const;                   // in order
    std::vector<std::string> names() const;
    std::optional<std::size_t> current() const;                   // index of the preset last stored or recalled
    bool new_preset(std::string_view name, std::optional<std::size_t> position = {});   // stores the current state
    bool update(std::string_view name);                           // stores the current state into an existing preset
    RecallReport recall(std::string_view name_or_index);          // sends the entries in priority order, then name
    RecallReport output(std::string_view name_or_index);          // like recall, but only reports the values (no ramps)
    bool remove(std::string_view name_or_index);
    bool rename(std::string_view from, std::string_view to);
    bool copy(std::string_view from, std::string_view to, std::optional<std::size_t> position = {});
    bool move(std::string_view name_or_index, std::size_t position);
    void clear();
    void replace_all(std::vector<Preset> presets);                // used by the file readers
};
struct RecallReport { bool found; std::size_t applied; std::vector<Address> skipped; };
```
`new_preset` stores every `Data` with the parameter service below the model (value as the old object stores it: with its unit when the parameter has one); `recall` skips (and reports) entries whose node is gone, and applies the rest as commands through the node (so ranges, clipping and ramps behave as for any command); a missing name is `found == false`, nothing changes.

- [ ] **Step 1: Write failing tests:** `new_preset_stores_every_parameter_in_order`, `recall_sets_values_in_priority_order`, `recall_skips_missing_nodes_and_reports_them`, `recall_clips_to_the_current_range` (Review Focus 2), `recall_by_index_and_by_name`, `update_replaces_values_keeps_position`, `rename_copy_move_remove_clear`, `current_follows_recall_and_new`, `preset_may_be_recalled_while_a_ramp_runs`.
- [ ] **Step 2: Run, expect failure.**
- [ ] **Step 3: Implement** with the entries held by value (nothing points into the namespace between calls).
- [ ] **Step 4: Run** unit tests and both sanitizer builds. Commit.

---

### Task 4: Interpolation and mixing

**Files:**
- Modify: `core/include/jamoma/preset.hpp`, `core/src/preset.cpp`, `core/tests/preset_test.cpp`

**Interfaces:**
- Produces on `PresetManager`: `RecallReport interpolate(std::string_view a, std::string_view b, double position);` (position 0..1) and `RecallReport mix(const std::vector<std::pair<std::string, double>>& weighted);` with the numeric rules of `presets.md` (numbers and lists of numbers are interpolated element by element; anything else takes the value of the nearer preset, or of the first with the largest weight; entries present in only one preset keep that preset's value; weights are normalised by their sum; a sum of zero does nothing).

- [ ] **Step 1: Write failing tests:** `interpolate_halfway_between_numbers_and_lists`, `interpolate_takes_the_nearer_symbol`, `entries_in_one_preset_only_are_kept`, `position_outside_zero_to_one_is_clamped`, `mix_normalises_weights`, `mix_of_nothing_does_nothing` (Review Focus 4).
- [ ] **Step 2: Run, expect failure.** **Step 3: Implement.** **Step 4: Run** with both sanitizers. Commit.

---

### Task 5: Preset files, text and XML

**Files:**
- Create: `core/include/jamoma/preset_files.hpp`, `core/src/preset_files.cpp`, `core/tests/preset_files_test.cpp`, `core/tests/data/qmetro.model.presets.txt` (copy of the old file), a sample XML written by Task 1's reading of the old writer
- Modify: `core/CMakeLists.txt`

**Interfaces:**
- Produces:
```cpp
struct ReadResult { std::vector<Preset> presets; std::vector<std::string> problems; };   // never throws; problems are one-line texts
ReadResult read_presets_text(std::string_view text);
std::string write_presets_text(const std::vector<Preset>& presets);
ReadResult read_presets_xml(std::string_view text);
std::string write_presets_xml(const std::vector<Preset>& presets);
```
Both writers produce what the old writers produce (Task 1 notes); both readers accept what the old writers wrote. The XML reader uses a small parser written for this schema (no new dependency).

- [ ] **Step 1: Write failing tests:** `text_reads_the_qmetro_file` (the preset "default", three entries), `text_round_trip`, `xml_round_trip`, `xml_reads_the_sample_written_like_the_old_writer`, and for Review Focus 2: `empty_file`, `truncated_xml`, `line_without_value`, `unknown_version`, `names_with_quotes_and_non_ascii`, `very_large_file_is_read_in_linear_time` (100000 entries within a generous bound), each giving `problems` and never throwing.
- [ ] **Step 2: Run, expect failure.** **Step 3: Implement.** **Step 4: Run** with both sanitizers (the large-file and malformed tests are the ones to watch). Commit.

---

### Task 6: `j.model` presets and the attributes dropped in milestone 1

**Files:**
- Modify: `externals/j.model/j.model.cpp`, `package/Jamoma/docs/refpages/modular/j.model.maxref.xml` (entries come back), `tools/refpages/check_refpages.py` if the source scan needs a new pattern
- Create: `tests/max/patchers/model_presets.maxtest.maxpat`, `preset_files.maxtest.maxpat`

**Interfaces:**
- Consumes: `PresetManager`, the file functions (Tasks 3-5), Task 1 rulings (where the file lives, when it is read).
- Produces on `j.model`: messages `preset:new`, `preset`, `preset:delete`, `preset:clear`, `preset:read`, `preset:write`, `preset:read/again`, `preset:write/again`, `preset:names` (right-most outlet), `preset:move`, `preset:copy`, `preset:rename`, `preset:interpolate`, `preset:mix`, `preset:edit` (a text editor window with the text format, as the old object; see Task 1), `alias/remove`, `model:help/open` and `model/edit` as in the old object; attributes `presets` (read only), `alias`, `activity`, `tags`, and a real `amenities` (data only). The model reads its presets file when it has initialised (rule from Task 1) and reports what it skipped on the console.

- [ ] **Step 1: Write failing own tests:** `model_presets` (a model with two parameters: `preset:new a`, change a value, `preset a` restores it, `preset:names` lists, `preset:interpolate`), `preset_files` (`preset:write` to a file in the test folder then `preset:clear` then `preset:read` brings them back; a missing file and a damaged file give a console error and change nothing).
- [ ] **Step 2: Run, expect failure** (announce Max use). **Step 3: Implement** with all work on the main thread (`run_on_main`); the `PresetManager` lives in the `j.model` object, state before attributes.
- [ ] **Step 4: Run** the own tests, the checker, the 82 old tests (quick mode). Commit.

---

### Task 7: `j.view`

**Files:**
- Create: `externals/common/model_object.hpp` (the part of `j.model` that `j.view` shares, moved out of `j.model.cpp`), `externals/j.view/{CMakeLists.txt,j.view.cpp}`, `tests/max/patchers/view_basic.maxtest.maxpat`, `view_late_model.maxtest.maxpat`
- Modify: `externals/j.model/j.model.cpp`, `externals/CMakeLists.txt`, `conformance/own-tests.txt`, `conformance/implemented.txt`

**Interfaces:**
- Consumes: Task 2 (observation of models), Task 1 `view-model.md`.
- Produces: object `j.view` (outlets: echo of the values sent to the model, dump; attributes `activity` (read only), `alias`, `description`, `tags`; messages `anything` (a parameter name and its value, sent to the model it binds to), `alias/remove`, `dump`), with the model address learned as `view-model.md` says; it registers at `<view address>` in the namespace and says on `dump` which model it is bound to or that it is waiting.

- [ ] **Step 1: Write failing own tests:** `view_basic` (a model and a view patcher side by side: a message `a 5` into `j.view` sets parameter `a` of its model), `view_late_model` (the view exists before the model, then binds; the model goes away and the view reports waiting, Review Focus 1).
- [ ] **Step 2: Run, expect failure** (announce Max use). **Step 3: Implement** by moving the shared part out of `j.model` without changing it (the 82 old tests and the model tests stay green), then the view as the thin variant.
- [ ] **Step 4: Run** all own tests, unit tests under both sanitizers, the old tests (quick mode). Commit.

---

### Task 8: `Remote` in the core

**Files:**
- Create: `core/include/jamoma/remote.hpp`, `core/src/remote.cpp`, `core/tests/remote_test.cpp`
- Modify: `core/CMakeLists.txt`

**Interfaces:**
- Consumes: `Receiver`, `Sender`, `UnitConverter` (milestone 2), Task 1 `j.remote.md`.
- Produces:
```cpp
class JAMOMA_API Remote {
public:
    Remote(Namespace& ns, std::function<void(const Value&)> to_ui);   // what the UI object shows
    void set_address(const Address& address);
    void set_unit(std::string_view unit);                              // the unit the UI object works in ("" = the node's own)
    void set_active(bool on);  void set_freeze(bool on);
    void from_ui(const Value& value);                                  // the user moved the UI object: goes to the node
    void set_without_echo(const Value& value);                         // `set`: the UI object shows it, nothing is sent
    std::optional<Value> current() const;
};
```
`from_ui` converts from the UI unit to the node's, sends it as a command and does not echo the node's answer to the UI (the old suppression, rule in Task 1); a change of the node (a ramp tick, a preset) goes to `to_ui` converted to the UI unit unless `freeze`; the first value after binding goes to the UI.

- [ ] **Step 1: Write failing tests:** `ui_value_reaches_the_node_without_echo`, `node_change_reaches_the_ui_in_the_ui_unit` (db against linear), `ramp_ticks_reach_the_ui`, `dragging_wins_over_a_running_ramp` (Review Focus 3), `freeze_blocks_the_ui_not_the_node`, `inactive_remote_is_silent`, `late_node_is_bound_and_shown_once`, `deleted_node_is_not_touched`.
- [ ] **Step 2: Run, expect failure.** **Step 3: Implement.** **Step 4: Run** with both sanitizers. Commit.

---

### Task 9: `j.remote`

**Files:**
- Create: `externals/j.remote/{CMakeLists.txt,j.remote.cpp}`, `tests/max/patchers/remote_basic.maxtest.maxpat`, `remote_feedback.maxtest.maxpat`
- Modify: `externals/CMakeLists.txt`, `conformance/own-tests.txt`, `conformance/implemented.txt`

**Interfaces:**
- Consumes: `Remote`, `resolve_in_patcher`, Task 2 (a remote binds to a model that appears later).
- Produces: object `j.remote` (argument: the node address, relative to the model or absolute; attributes `active`, `address`, `unit`, `freeze`, `highlight`; messages `bang`, `int`, `float`, `list`, `anything`, `address`, `set`, `dump`; outlets as the old object: the UI object, the dump).

- [ ] **Step 1: Write failing own tests:** `remote_basic` (a number into `j.remote` sets the parameter; a parameter change comes out for the UI object; `set` shows without sending), `remote_feedback` (a `j.remote` whose output feeds a UI object that feeds it back, with a ramp running, terminates and keeps the dragged value), and the copied old test `Modular/j.remote/dataspace/j_remote_dataspace_db2linear`.
- [ ] **Step 2: Run, expect failure** (announce Max use). **Step 3: Implement** with the value messages `threadsafe::yes` and the work on the main thread.
- [ ] **Step 4: Run** the own tests, the old `j.remote` test, the old suite (quick mode). Commit.

---

### Task 10: `ModelExplorer` in the core

**Files:**
- Create: `core/include/jamoma/explorer.hpp`, `core/src/explorer.cpp`, `core/tests/explorer_test.cpp`
- Modify: `core/CMakeLists.txt`

**Interfaces:**
- Consumes: `Namespace::observe`, `Data::service`, `PresetManager` names.
- Produces:
```cpp
struct ModelContents { std::vector<std::string> parameters, messages, returns; std::vector<std::string> presets; };   // relative addresses, sorted by priority then name
class JAMOMA_API ModelExplorer {
public:
    ModelExplorer(Namespace& ns, std::function<void()> on_change);     // on_change runs after the contents changed, on the changing thread
    void set_model(const Address& model);                               // empty = none
    Address model() const;
    ModelContents contents() const;                                     // a snapshot
};
```
What a `j.ui` shows and lists is read from here; the explorer follows nodes appearing and going below the model and the model itself appearing and going.

- [ ] **Step 1: Write failing tests:** `lists_parameters_messages_returns_sorted`, `follows_new_and_removed_nodes`, `follows_the_model_appearing_and_going` (Review Focus 1), `hundreds_of_parameters_are_listed_in_order` (Review Focus 5), `teardown_inside_on_change_is_safe`, and under the thread sanitizer `contents_while_nodes_change_is_race_free`.
- [ ] **Step 2: Run, expect failure.** **Step 3: Implement.** **Step 4: Run** with both sanitizers. Commit.

---

### Task 11: `j.ui`

**Files:**
- Create: `externals/common/max_ui.hpp` (popup menu helper and text drawing helper), `externals/j.ui/{CMakeLists.txt,j.ui.cpp}`, `tests/max/patchers/ui_state.maxtest.maxpat`
- Modify: `externals/CMakeLists.txt`, `conformance/own-tests.txt`, `conformance/implemented.txt`

**Interfaces:**
- Consumes: `ModelExplorer`, `PresetManager` through the model's messages (the UI sends `preset`, `preset:new` and the others to its model; it holds no preset state of its own), Task 1 `j.ui.md`.
- Produces: object `j.ui` (a Min UI object; attributes `bgcolor`, `bordercolor`, `headercolor`, `textcolor`, `highlightcolor` and the ones Task 1 lists; default size 300 x 70). It draws the header with the model address (drawn text, no text field), the preset area and the state "waiting for a model:address"; a click on the address opens the popup menu of parameters, messages and returns (a choice opens the node's reference through the model, as the old one), the menu arrow opens the utilities and presets menu with the messages of `j.ui.md`; `dump` on its dump outlet reports the model it is bound to, the preset names and the current preset (what the own test reads, since drawing is not testable by messages). Anything that needs the text field of the old object is listed in the ledger with the decision of Task 1, not built.

- [ ] **Step 1: Write failing own test** `ui_state`: a `j.ui` beside a model with two presets: after load `dump` reports the model and the two names; `preset:new x` through the model changes the list; closing the model returns "waiting"; the model returning binds again (Review Focus 1 and 5).
- [ ] **Step 2: Run, expect failure** (announce Max use). **Step 3: Implement** with all drawing and menu work on the main thread; the explorer callback asks for a redraw with `redraw()` deferred to the main thread; sizes below the minimum draw nothing but a border (Review Focus 5); dark and light follow the Max colours when the attributes are at their defaults.
- [ ] **Step 4: Run** the own test, then **have the look checked by the user**: open a patcher with a model, a view and a `j.ui` in Max (announce) and ask the user to look at it and say what is wrong; take no screenshot unless the user agrees, never of the whole screen, and delete any that was taken; run unit tests and the old suite (quick mode). Commit.

---

### Task 12: `j.node`

**Files:**
- Create: `externals/j.node/{CMakeLists.txt,j.node.cpp}`, `tests/max/patchers/node_basic.maxtest.maxpat`
- Modify: `externals/CMakeLists.txt`, `conformance/own-tests.txt`, `conformance/implemented.txt`

**Interfaces:**
- Produces: object `j.node` (argument: the node name; attributes `description`, `priority`, `tags`; message `dump`): declares a node without a parameter below the model, so that its priority orders the initialisation of what is below it (the old purpose; rule in `view-model.md`); the node is a core `Model`-like object or a small `Object` that `Model::init` orders by its priority (state this in the code).

- [ ] **Step 1: Write failing own test** `node_basic` (two parameters below a `j.node` with a lower priority than a sibling parameter are initialised in that order). **Step 2: Run, expect failure.** **Step 3: Implement.** **Step 4: Run** own tests and the old suite (quick mode). Commit.

---

### Task 13: Help patchers and reference pages

**Files:**
- Create: `package/Jamoma/help/{j.view,j.remote,j.ui,j.node}.maxhelp`, `package/Jamoma/docs/refpages/modular/{...}.maxref.xml`
- Modify: `tools/refpages/{check_refpages.py,migrate_refpages.py,migrate_help.py}` (the four objects), the pages and help of `j.model`, `j.send`, `j.receive` and the milestone 1 and 2 objects (their comment boxes for `j.view`, `j.remote`, `j.ui`, `j.node` become the objects)

**Interfaces:**
- Consumes: the three scripts of milestones 1 and 2; `conformance/implemented.txt`.

- [ ] **Step 1: Write a failing checker test** `milestone_3_objects_are_checked` (all four are in `OBJECT_SOURCES`; `j.model`'s page again lists the preset messages); run, expect failure; implement.
- [ ] **Step 2: Migrate** the pages and help patchers; remove the entries milestone 1 dropped from `j.model`'s page only where Task 6 built them.
- [ ] **Step 3: Run** `check_refpages.py` (exit 0) and `scripts/check-help.sh` (every help patcher opens without a missing object; announce Max use). Commit.

---

### Task 14: The qmetro model, acceptance and record

**Files:**
- Create: `package/Jamoma/patchers/models/data/qmetro/` (the old `qmetro.model.maxpat`, `qmetro.view.maxpat`, `qmetro.module.maxpat`, `qmetro.model.maxhelp`, `qmetro.model.presets.txt`, copied with their structure: they are the spec's first test patch), `tests/max/patchers/qmetro.maxtest.maxpat`, `docs/conformance/m3-results.md`
- Modify: `docs/changes.md`, `README.md`, `docs/inventory/coverage-baseline.md` (regenerate), `docs/decisions/0001-shared-state.md`, `tests/smoke/quit_live_objects` (add a view, a remote, a `j.ui` and a preset recall on a running ramp)

- [ ] **Step 1: Own test `qmetro`:** the module patcher loads without a missing object, the model's presets file is read (`default`), a `j.remote` in the view changes `time`, `preset default` recalls 100, the trigger fires (Review Focus 1, 3, 4 on a real model).
- [ ] **Step 2: Full runs** (announce Max use; one at a time, one test per launch for the acceptance set): `conformance/m1-tests.txt`, `m2-tests.txt`, `m3-tests.txt`, own tests, `scripts/check-help.sh`, the quit smoke, and the load of the qmetro patchers.
- [ ] **Step 3: Sanitizers:** unit tests under ASan/UBSan and TSan, no reports. Run the preset-file tests with a 10 MB file under ASan.
- [ ] **Step 4: Windows.** There is no Windows machine yet: list in `m3-results.md` what must be run there (unit tests, `max-smoke.ps1`, the conformance lists, the `j.ui` drawing and menus by eye), and that Windows conformance for milestones 1-3 is due.
- [ ] **Step 5: Documentation:** Doxygen gate, README, regenerated coverage baseline (what remains: `j.map`, `j.cue`, `j.namespace`, `j.textslider` and the audio objects, all milestone 4 or later), every difference in `docs/changes.md`.
- [ ] **Step 6: Whole-branch review** by a fresh read-only reviewer on the most capable model, fix the findings in one pass (each with a test that failed first), then finish the branch. **Commit.**

---

## Self-review notes

- **Spec coverage (section 12, milestone 3):** `j.view` (Task 7), `j.ui` with presets (Tasks 3-6, 10, 11), the preset store, recall and interpolation (3, 4), the file formats (5), with `j.remote` (8, 9) and `j.node` (12) pulled in because the old `qmetro` view needs the first and the old `j.parameter` help the second (spec section 8: pulled in only as far as required). The text field of the old `j.ui` is resolved as the spec's section 13 says: draw our own text first (Task 11); what that leaves out is recorded.
- **Deliberately not in this milestone:** `j.cue`, `j.namespace`, `j.map` and `j.textslider` (milestone 4: `j.cue` and `j.namespace` pair with the dictionary/JSON namespace dumps, `j.map` with the Max 9 additions, `j.textslider` is a drawing widget no pass-bar patcher needs besides one help patcher); audio objects and the audio amenities of `j.model` (`j.in~`, `j.out~`, MC); network OSC and `directory:` addresses; array objects.
- **Closed from earlier milestones:** the model that appears later or is replaced (milestone 2 review, Task 2), nested model addresses and `amenities` (milestone 1, Tasks 2 and 6), `#0` argument substitution (milestone 2, Task 2), the preset entries of `j.model`'s page (milestone 1, Tasks 6 and 13).
- **Open for the user, not guessed:** the author's own patchers for `conformance/set.txt` (still a placeholder); a Windows machine for the conformance runs and for judging the drawing of `j.ui` there.
- **Risks to watch:** the old suite has one `j.remote` test and none for `j.view`, `j.ui` or presets, so acceptance leans on own tests written from the old source and on the `qmetro` model; Task 1's notes are therefore the only record of the old behaviour and must be read carefully. The XML preset schema is not documented anywhere, only in the old writer's code. Drawing and menus cannot be asserted by messages; `dump` carries the state for tests and the user's own look at the object is the only check of how it looks (no screenshots without the user's agreement, never of the whole screen). A `j.ui` repaint from the scheduler thread must always be deferred.
