# JamomaMax3 Milestone 4 (the rest of the old surface) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `j.namespace`, `j.map`, `j.cue` and `j.textslider` run natively in Max 9; `j.ui` gets the subwindow button and naming of a preset when it is created; `view/freeze` is settled; the old `osc_receive` model and view are in the package; the help patchers of `j.model`, `j.parameter` and `j.return` have no placeholder for these four objects any more.

**Architecture:** As before: a Max-free, unit-tested core (a function library and a `Mapper`, a namespace explorer with output formats, a `CueList` on the existing XML preset code) and thin Min-API externals. One new shared Max helper, a text editor window, serves `j.cue edit`, `preset:edit` and naming a preset. `j.textslider` is a Min UI object that draws its own text.

**Tech Stack:** As milestone 3 (C++20, CMake, Catch2, Min-API, max-test, Python tools, jgraphics, the Max editor and popup APIs).

**Spec:** `docs/superpowers/specs/2026-11-26-milestone-4-old-surface-design.md` (approved 26 November 2026), parent `docs/superpowers/specs/2026-11-21-jamomamax3-modular-design.md`. Earlier plans in this folder; results `docs/conformance/m3-results.md`; differences `docs/changes.md`; new features `CHANGELOG.md`. Old behaviour: `~/Developer/Jamoma/JamomaMax/source/{j.map,j.namespace,j.cue,j.textslider,j.ui}`, the old Foundation function library and `TTMapper.cpp` (`~/Developer/Jamoma/Jamoma.0.5.7/Modules/Modular/library/PeerObject/`), `TTExplorer`, `TTCueManager`, and the patchers under `~/Developer/Jamoma/JamomaMax/Jamoma/` (`help`, `patchers/models/data/osc`).

## Global Constraints

The Global Constraints of the milestone 1 to 3 plans hold (clean-room, Max 9, macOS arm64 + x86_64 from macOS 12, Windows compiling by construction and untested, old names and OSC semantics, core without Max headers, all C++ Doxygen-documented with no warnings, BSD-3-Clause SPDX headers, the Min rules, threading rules with `run_on_main` and `Alive`, a test must be seen failing first, Max used only through the runners and announced before and after, one test per launch for acceptance runs). Added here:

- Branch `milestone-4`; at the end it is merged into `main` and tagged `milestone-4`, the branch deleted first, as for milestone 3 (asking the author before any push).
- Max tests follow `tests/integration/README.md`: `Modular/<external>/<external>_<behaviour>.maxtest.maxpat`, assertions `Jamoma/Modular/<folder>/<behaviour>/<case>`; `test_layout` and `package_references` stay green.
- A new attribute, message or behaviour the old objects did not have goes into `CHANGELOG.md` (Unreleased > New features) in the same commit; every deliberate difference into `docs/changes.md`.
- Nothing finished in milestones 1 to 3 changes behaviour: the 121 Max tests and the 284 unit tests stay green after every task (quick mode between tasks, one test per launch at the end).
- Audio objects stay placeholders in help patchers (`j.in~`, `j.out~`, `j.limiter~`).

## Review Focus

1. **`j.map` with degenerate numbers:** equal input or output limits, NaN and infinity, input outside the range, `inverse` with equal limits, an unknown function name, wrong number of function parameters. No crash, no NaN out of the outlet, a console message. Tasks 2, 3, 8.
2. **`j.cue` with hostile files and moving models:** missing, empty, truncated, wrong version; a cue naming a model or parameter that does not exist or goes away; a cue recalled while models are created or deleted; very many cues. Recall never crashes and reports what it skipped. Tasks 5, 9.
3. **`j.namespace` on a changing namespace:** nodes created or deleted while it outputs, an address that does not exist, relative and absolute addresses, names with spaces in `umenu`/`coll`, a very large namespace. Tasks 4, 7.
4. **`j.textslider` extremes:** range with equal ends or reversed, NaN, value outside the range, very long text, one-pixel size, `defeat`, drag past the edges. Task 10.
5. **Editor windows and a prompt that outlive their object:** `edclose` after the object was freed, a second `edit` while one is open, an empty or duplicate preset name, a name with odd characters. Tasks 6, 9, 11.

---

## File Structure

```
core/include/jamoma/{function_library,mapper,explore,cue}.hpp      new (explore.hpp: output kinds and formats of j.namespace)
core/src/{function_library,mapper,explore,cue}.cpp
core/tests/{function_library,mapper,explore,cue}_test.cpp          (also added to core/CMakeLists.txt)
externals/common/max_editor.hpp                                    text editor window helper
externals/{j.namespace,j.map,j.cue,j.textslider}/                  new externals (added to externals/CMakeLists.txt)
externals/{j.model,j.view,j.ui}/                                   preset:edit, naming, subwindow, view/freeze
tests/integration/JamomaIntegrationTests/patchers/tests/Modular/{j.namespace,j.map,j.cue,j.textslider,osc_receive}/
package/Jamoma/{help,docs/refpages/modular}/                       help patchers and reference pages of the four objects
package/Jamoma/patchers/models/data/osc/                           osc_receive model and view (copied)
docs/inventory/{j.namespace,j.map,j.cue,j.textslider,ui-additions}.md
docs/conformance/m4-results.md, docs/changes.md, CHANGELOG.md
```

---

### Task 1: Characterise and baseline

**Files:**
- Create: `docs/inventory/j.namespace.md`, `j.map.md`, `j.cue.md`, `j.textslider.md`, `ui-additions.md` (the `j.ui` subwindow button, preset naming, `view/freeze`, the dead freeze button), `conformance/m4-tests.txt`

**Interfaces:**
- Produces: five notes, each ending in a **Rulings** list that later tasks cite. Required content:
  - `j.namespace.md`: outlets (data, size, dump), `explore`/`bang` and address symbol, attribute values `output` (`descendants children brothers attributes`), `format` (`none umenu umenu_prefix jit.cellblock coll`), `relative`; the exact output of each combination for a sample namespace (read from `TTExplorer`, `nmspc_return_value`, `nmspc_return_selection`); what `return_model_address` does.
  - `j.map.md`: arguments, attributes (`input output inputmin inputmax outputmin outputmax active inverse function functionlibrary functionparameters functionsamples ramp`), messages (`int float list reset map`), the four `return_*_going_*` paths (how the mapper follows the ranges of the parameters it is bound to), **the complete list of functions of the old library with their parameters and formulas**, behaviour outside the range, with `inverse`, and with equal limits.
  - `j.cue.md`: messages (`get set read write read/again write/again edit dblclick edclose`), outlets, the cue model (cue name, entries with absolute addresses, flags), the cue XML file with a written sample derived from the writer's code, what `get`/`set` return, what an edit window shows.
  - `j.textslider.md`: attributes with defaults (range `0 1`, `textpos 10 4`, `text textslider`, `unit` empty, colours `bgcolor 0.8 0.8 0.8 0.7`, `fgcolor 0.95 0.95 0.95 1`, `bordercolor 0.5 0.5 0.5 1`, `textcolor 0 0 0 1`, `knobcolor 0.7 0.7 0.7 1`, font size 10, default rect 160 x 20), messages, drawing, mouse behaviour (drag, double-click, Ctrl-click to the default value), outlet output rules, the poll interval constants.
  - `ui-additions.md`: the subwindow button (what the old `j.ui` showed, when, and which message it sent), naming a preset (what the old panel did at creation), `view/freeze` (what old `j.view`/`j.model` did with it; the `cue_script.demoscript.txt` and `alias_renaming.cues.txt` uses), and the finding that the freeze button is never shown (`ui_return_model_content`: `freeze = NO`, never set).
- Produces: `conformance/m4-tests.txt`: old tests that use the four objects (`grep` over `JamomaIntegrationTests`; say so if none).

- [ ] **Step 1: Read** the sources named above, the old reference pages and help patchers of the four objects, and `osc_receive.model.maxpat`/`.view.maxpat`; write the notes with file and line for every rule. Anything not read is marked "to characterise", never guessed.
- [ ] **Step 2: Write** `conformance/m4-tests.txt`; baseline (announce Max use): `scripts/run-maxtests.sh --list conformance/m4-tests.txt --out build/maxtests-m4-baseline`. Expected: FAIL with missing objects, or "no tests" noted.
- [ ] **Step 3: Commit** the notes and the list.

---

### Task 2: Function library

**Files:**
- Create: `core/include/jamoma/function_library.hpp`, `core/src/function_library.cpp`, `core/tests/function_library_test.cpp`
- Modify: `core/CMakeLists.txt` (sources, test)

**Interfaces:**
- Consumes: Task 1 `j.map.md` (the list of functions, parameters, formulas).
- Produces:
```cpp
struct FunctionInfo { std::string name; std::size_t parameter_count; std::vector<double> default_parameters; };
JAMOMA_API std::vector<FunctionInfo> function_library();                       // every function, in the old order
JAMOMA_API bool has_function(std::string_view name);
JAMOMA_API double apply_function(std::string_view name, double x, std::span<const double> parameters = {}); // x and result in 0..1; unknown name = linear; wrong parameter count = defaults; NaN in = 0; result clamped to 0..1
```

- [ ] **Step 1: Write failing tests** `function_library_lists_every_old_function` (names and order as in the note), `function_endpoints_are_zero_and_one` (for every function: `f(0) == 0`, `f(1) == 1` within 1e-9, unless the note says a function does not), `function_known_values` (the note's checked values, one per function, from the formula), `function_unknown_name_is_linear`, `function_wrong_parameter_count_uses_defaults`, `function_nan_and_infinity_stay_in_range`.
- [ ] **Step 2: Run:** `cmake --build build --target jamoma_core_tests && ctest --test-dir build --output-on-failure -R function_`. Expected: FAIL (does not compile / no such function).
- [ ] **Step 3: Implement** the three functions; a table of `FunctionInfo` plus one lambda per function; formulas from the note, not from memory.
- [ ] **Step 4: Run** the same command. Expected: PASS. Commit.

---

### Task 3: `Mapper`

**Files:**
- Create: `core/include/jamoma/mapper.hpp`, `core/src/mapper.cpp`, `core/tests/mapper_test.cpp`
- Modify: `core/CMakeLists.txt`

**Interfaces:**
- Consumes: Task 2; `Receiver` and `Sender` (milestone 2/3) for the optional address binding.
- Produces:
```cpp
struct MapperSettings { double input_min = 0, input_max = 1, output_min = 0, output_max = 1; std::string function = "linear";
                        std::vector<double> function_parameters; bool inverse = false; bool active = true; double ramp = 0; };
class JAMOMA_API Mapper {
public:
    explicit Mapper(Namespace& ns);
    void set(const MapperSettings& s);   MapperSettings settings() const;
    double map(double x) const;                                   // the whole law; see below
    std::vector<double> samples(std::size_t count) const;         // the curve, for functionsamples
    void bind_input(const Address& a);  void bind_output(const Address& a);   // follow the range of a parameter (rules of the note)
    void set_output(std::function<void(double)> out);              // called on the main thread with every mapped value
private: /* ... */
};
```
Law (pins from the note, Rulings override): `t = (x - input_min) / (input_max - input_min)`, clipped to 0..1; with `inverse` the function is applied to `1 - t`; `y = output_min + f(t) * (output_max - output_min)`. Equal input limits give `output_min`; NaN gives `output_min`; `active` false passes `x` through.

- [ ] **Step 1: Write failing tests:** `mapper_linear_default_is_identity`, `mapper_scales_between_ranges`, `mapper_clips_outside_the_input_range`, `mapper_inverse_flips_the_curve`, `mapper_reversed_output_range`, `mapper_equal_input_limits_give_output_min`, `mapper_nan_and_infinity_give_finite`, `mapper_inactive_passes_through`, `mapper_samples_match_map`, `mapper_follows_bound_parameter_range` (a parameter with `range` 10..20 bound as input sets `input_min/max`).
- [ ] **Step 2: Run:** `ctest --test-dir build --output-on-failure -R mapper_`. Expected: FAIL.
- [ ] **Step 3: Implement** `Mapper` with a mutex around the settings (read on the scheduler thread, written on main); binding through the observation of the node's range attribute.
- [ ] **Step 4: Run.** Expected: PASS; also under ASan/TSan. Commit.

---

### Task 4: Namespace exploration and formats

**Files:**
- Create: `core/include/jamoma/explore.hpp`, `core/src/explore.cpp`, `core/tests/explore_test.cpp`
- Modify: `core/CMakeLists.txt`

**Interfaces:**
- Consumes: `Namespace::visit_below`, `Namespace::lookup`, `Node`, `Data` attributes; Task 1 `j.namespace.md`.
- Produces:
```cpp
enum class ExploreOutput { Descendants, Children, Brothers, Attributes };
enum class ExploreFormat { None, Umenu, UmenuPrefix, JitCellblock, Coll };
struct ExploreResult { std::vector<std::string> items;            // addresses (relative to the explored one if requested)
                       std::vector<std::vector<std::string>> lines; };  // what is sent out of the data outlet, one entry per message, in the note's form
JAMOMA_API ExploreResult explore(const Namespace& ns, const Address& root, ExploreOutput kind, ExploreFormat format, bool relative);
JAMOMA_API std::size_t count_items(const ExploreResult& r);        // the value of the size outlet
```

- [ ] **Step 1: Write failing tests** on a namespace built in the test: `explore_children_lists_direct_nodes`, `explore_descendants_lists_all_below`, `explore_brothers_lists_siblings_not_self`, `explore_attributes_lists_the_attributes_of_a_node`, `explore_relative_strips_the_root`, `explore_nonexistent_address_is_empty_not_error`, `explore_formats_match_the_note` (one case per format with the note's expected lines, including a name with a space), `explore_is_stable_while_nodes_come_and_go` (a second thread creates and deletes nodes; run under TSan).
- [ ] **Step 2: Run:** `ctest --test-dir build --output-on-failure -R explore_`. Expected: FAIL.
- [ ] **Step 3: Implement** with one `visit_below` pass under the namespace lock; sort order as in the note.
- [ ] **Step 4: Run** (plain, ASan, TSan). Expected: PASS. Commit.

---

### Task 5: `CueList`

**Files:**
- Create: `core/include/jamoma/cue.hpp`, `core/src/cue.cpp`, `core/tests/cue_test.cpp`
- Modify: `core/CMakeLists.txt`

**Interfaces:**
- Consumes: `Preset`/`PresetEntry`, `read_presets_xml`, `write_presets_xml` (existing), `Namespace`, `Data::command`; Task 1 `j.cue.md`.
- Produces:
```cpp
class JAMOMA_API CueList {
public:
    explicit CueList(Namespace& ns);
    const std::vector<Preset>& cues() const;   std::vector<std::string> names() const;
    bool store(std::string_view name, const std::vector<Address>& models);       // the state of the given models, absolute addresses
    RecallReport recall(std::string_view name_or_index);                         // nodes that are gone are listed in `skipped`, never an error
    bool remove(std::string_view name_or_index);   bool rename(std::string_view from, std::string_view to);
    std::vector<std::string> read(std::string_view xml);                          // replaces the cues; returns the problems found, keeps what could be read
    std::string write() const;
    std::string edit_text() const;   std::vector<std::string> apply_edit_text(std::string_view text);  // the text of the edit window and its read-back
    std::shared_ptr<void> observe(std::function<void()> callback);
};
```

- [ ] **Step 1: Write failing tests:** `cue_store_and_recall_round_trip`, `cue_recall_skips_missing_nodes_and_reports_them`, `cue_recall_while_nodes_are_deleted` (second thread; TSan), `cue_write_then_read_is_identical`, `cue_read_truncated_empty_and_wrong_version_keep_what_they_can`, `cue_read_unknown_parameter_is_reported_at_recall_not_read`, `cue_many_cues_ten_thousand_stay_fast`, `cue_edit_text_round_trip`, `cue_edit_text_with_errors_keeps_old_cues_for_bad_entries`, `cue_rename_to_existing_name_fails`.
- [ ] **Step 2: Run:** `ctest --test-dir build --output-on-failure -R cue_`. Expected: FAIL.
- [ ] **Step 3: Implement** on top of the existing preset code; absolute addresses stored as the note says.
- [ ] **Step 4: Run** (plain, ASan, TSan). Expected: PASS. Commit.

---

### Task 6: Text editor window helper; `preset:edit` in `j.model`

**Files:**
- Create: `externals/common/max_editor.hpp`
- Modify: `externals/j.model/j.model.cpp` (message `preset:edit`), `docs/changes.md`
- Test: `tests/integration/.../Modular/j.model/j_model_preset_edit.maxtest.maxpat`

**Interfaces:**
- Produces:
```cpp
namespace jamoma_max {
class TextEditor {                                   // owns one Max editor window (`jed`); main thread only
public:
    TextEditor(c74::max::t_object* owner, std::weak_ptr<Alive> alive);
    void open(std::string title, std::string text, std::function<void(std::string)> on_close);  // brings an open window to the front instead of opening a second
    void close();                                    // from the destructor: the callback never runs after it
};}
```
- Consumes: `Alive`, `run_on_main`; Task 5 `edit_text` has no part here; `j.model` uses `write_presets_text`/`read_presets_text` and `PresetManager::replace_all`.

- [ ] **Step 1: Write failing Max test** `j_model_preset_edit`: send the object an edit-result simulation through the testable entry point `preset:edit:apply <text>` (the same function `edclose` calls) and check that presets are replaced, that a text with a bad line keeps the good ones, and that `preset:edit` twice opens one window (counted through a dump).
- [ ] **Step 2: Run** the test (announce Max use). Expected: FAIL (no such message).
- [ ] **Step 3: Implement** `TextEditor` (open `jed`, `edclose` callback through the object's class method; the object's destructor closes it; a late `edclose` after destruction is ignored through `Alive`); `j.model` message `preset:edit` and the testable `preset:edit:apply`.
- [ ] **Step 4: Run** the test and the `j.model` folder (`--dir j.model`). Expected: PASS. Commit.

---

### Task 7: `j.namespace`

**Files:**
- Create: `externals/j.namespace/j.namespace.cpp`, `externals/j.namespace/CMakeLists.txt`, `package/Jamoma/help/j.namespace.maxhelp`, `package/Jamoma/docs/refpages/modular/j.namespace.maxref.xml`
- Modify: `externals/CMakeLists.txt`
- Test: `Modular/j.namespace/j_namespace_explore.maxtest.maxpat`, `j_namespace_formats.maxtest.maxpat`, `j_namespace_changing.maxtest.maxpat`

**Interfaces:**
- Consumes: Task 4 `explore`/`count_items`; the attribute/outlet list of Task 1 (outlets data, size, dump; messages `bang`, `explore`, address symbol; `output`, `format`, `relative`).
- Produces: Max class `j.namespace` (`message<threadsafe::no>`; every handler runs on the main thread).

- [ ] **Step 1: Write failing Max tests:** `explore` (children and descendants of a model with three parameters, size outlet), `formats` (each `format` value gives the lines of the note), `changing` (a parameter is deleted after the first explore: the second explore has one line fewer; a nonexistent address outputs size 0).
- [ ] **Step 2: Run** (announce Max use). Expected: FAIL (object not found).
- [ ] **Step 3: Implement** the external over `explore`; `dump` outlet through `jamoma_max::dump_outlet`; reference page from the old one, rewritten; the help patcher migrated from the old `j.namespace` help (placeholders for other missing objects only).
- [ ] **Step 4: Run** `--dir j.namespace`, `scripts/check-help.sh` for the new help, `check_refpages.py`. Expected: PASS. Commit with the `CHANGELOG.md`/`docs/changes.md` lines (if any difference).

---

### Task 8: `j.map`

**Files:**
- Create: `externals/j.map/j.map.cpp`, `externals/j.map/CMakeLists.txt`, help, refpage, `package/Jamoma/javascript/` helper only if the old help patcher needs one
- Modify: `externals/CMakeLists.txt`
- Test: `Modular/j.map/j_map_linear.maxtest.maxpat`, `j_map_functions.maxtest.maxpat`, `j_map_degenerate.maxtest.maxpat`, `j_map_follows_parameters.maxtest.maxpat`

**Interfaces:**
- Consumes: Tasks 2 and 3; attribute/message list of Task 1 (`input output inputmin inputmax outputmin outputmax active inverse function functionlibrary functionparameters functionsamples ramp`; `int float list reset`; outlets data, dump).
- Produces: Max class `j.map`; `int`/`float`/`list` map every element; `functionlibrary` and `functionsamples` are read-only attributes; `reset` restores the creation arguments.

- [ ] **Step 1: Write failing Max tests:** `linear` (identity and scaled), `functions` (one value per function of the library against `apply_function`), `degenerate` (equal limits, NaN, `inf`, unknown function: the outlet value is finite and the console gets a message, nothing crashes), `follows_parameters` (`input`/`output` addresses of two `j.parameter`s with ranges: the mapper takes their ranges).
- [ ] **Step 2: Run** (announce Max use). Expected: FAIL.
- [ ] **Step 3: Implement** over `Mapper`; scheduler-thread values go through `run_on_main` where the Mapper requires it; help patcher migrated; `j.map functions` help (`j.map.functions.maxpat` of the old package) ported if the note says it is used.
- [ ] **Step 4: Run** `--dir j.map`, help check, refpage check. Expected: PASS. Commit.

---

### Task 9: `j.cue`

**Files:**
- Create: `externals/j.cue/j.cue.cpp`, `externals/j.cue/CMakeLists.txt`, help, refpage, an example cue file used by the help patcher
- Modify: `externals/CMakeLists.txt`
- Test: `Modular/j.cue/j_cue_store_recall.maxtest.maxpat`, `j_cue_files.maxtest.maxpat`, `j_cue_missing_models.maxtest.maxpat`, `j_cue_edit.maxtest.maxpat`

**Interfaces:**
- Consumes: Tasks 5 and 6 (`TextEditor`, `edit_text`, `apply_edit_text`); messages from Task 1 (`get set read write read/again write/again edit dblclick edclose`; outlets line and dump).
- Produces: Max class `j.cue`. Files are read and written only on `read`/`write` (never silently); `write` with no argument asks for a file name by Max's file dialog on the main thread.

- [ ] **Step 1: Write failing Max tests:** `store_recall` (two models, two cues, recall each, values and order at the line outlet as in the note), `files` (`write` to the scratch folder, `read` back, equal; a damaged file keeps the readable cues and reports the rest), `missing_models` (recall of a cue after one model was deleted outputs the rest and reports the skipped addresses), `edit` (the testable `edclose` entry with a changed text).
- [ ] **Step 2: Run** (announce Max use). Expected: FAIL.
- [ ] **Step 3: Implement** over `CueList`; `dblclick` and `edit` open the editor; destructor closes it.
- [ ] **Step 4: Run** `--dir j.cue`, help check, refpage check. Expected: PASS. Commit.

---

### Task 10: `j.textslider`

**Files:**
- Create: `externals/j.textslider/j.textslider.cpp`, `externals/j.textslider/CMakeLists.txt`, help, refpage
- Modify: `externals/CMakeLists.txt`
- Test: `Modular/j.textslider/j_textslider_value.maxtest.maxpat`, `j_textslider_extremes.maxtest.maxpat`; unit test `core/tests/slider_test.cpp` (added to `core/CMakeLists.txt`) for the mouse maths

**Interfaces:**
- Consumes: Task 1 `j.textslider.md` (the attribute list, defaults and mouse rules above).
- Produces: Max UI class `j.textslider` (Min `ui_operator`); pure functions in `core/include/jamoma/slider.hpp`: `double slider_value_from_drag(double anchor, double delta_pixels, double length_pixels, double low, double high)` (clamped to the range, reversed or equal ranges handled), `std::string slider_text(std::string_view text, double value, std::string_view unit)`.

- [ ] **Step 1: Write failing tests:** unit `slider_drag_moves_proportionally`, `slider_drag_is_clamped_at_both_ends`, `slider_reversed_and_equal_range_do_not_divide_by_zero`, `slider_text_includes_value_and_unit`; Max `value` (`int`, `float`, `set` stay silent, `bang` outputs, range attribute clips, `dump`), `extremes` (NaN, a value far outside, equal range, `defeat 1` ignores input).
- [ ] **Step 2: Run:** `ctest --test-dir build --output-on-failure -R slider_`; Max tests (announce Max use). Expected: FAIL.
- [ ] **Step 3: Implement** the pure functions, then the UI object drawing text with jgraphics (text and value inside the slider, knob, colours, border) and the mouse rules of the note (drag, double-click, Ctrl-click to the default); a snapshot of the look checked by eye by the author (listed in the results record as the check that no test reaches).
- [ ] **Step 4: Run** unit and `--dir j.textslider`, help check, refpage check. Expected: PASS. Commit.

---

### Task 11: `j.ui` additions and `view/freeze`

**Files:**
- Modify: `externals/j.ui/j.ui.cpp` (subwindow button, preset naming), `externals/j.view/*` or the shared `externals/common/model_object.hpp` (`view/freeze`, if the note says it is part of the old surface), `docs/changes.md`, `CHANGELOG.md`
- Test: `Modular/j.ui/j_ui_subwindow.maxtest.maxpat`, `j_ui_preset_name.maxtest.maxpat`, `Modular/j.view/j_view_freeze.maxtest.maxpat` (only if `view/freeze` is built)

**Interfaces:**
- Consumes: Task 6 `TextEditor` (or Max's own prompt, by the Task 1 ruling), `PresetManager::new_preset`/`free_name`; Task 1 `ui-additions.md`.
- Produces: the subwindow button drawn and sending the message the old one sent; "Create New Preset" asks for a name (empty or duplicate gives `free_name`, Cancel creates nothing); message `preset:name <name>` (testable, creates a preset with that name); `view/freeze` as the note says, or an entry in `docs/changes.md` as not part of the old surface.

- [ ] **Step 1: Write failing Max tests:** `subwindow` (the click handler's testable entry sends the note's message), `preset_name` (`preset:name` creates the preset; empty, duplicate and odd names; no name given creates nothing), `view_freeze` (as the note).
- [ ] **Step 2: Run** (announce Max use). Expected: FAIL.
- [ ] **Step 3: Implement.** Drawing of the new button follows the geometry rules in the note; the existing `snap` grid and active button are unchanged.
- [ ] **Step 4: Run** `--dir j.ui --dir j.view`. Expected: PASS; menus and the button by the author's eye. Commit.

---

### Task 12: `osc_receive` model and view

**Files:**
- Create: `package/Jamoma/patchers/models/data/osc/osc_receive.model.maxpat`, `osc_receive.view.maxpat`, `osc_receive.model.maxhelp`, `Modular/osc_receive/osc_receive_basic.maxtest.maxpat`
- Modify: `scripts/check-help.sh` (also this model help), `docs/conformance/README.md`

**Interfaces:**
- Consumes: the old patchers (`~/Developer/Jamoma/JamomaMax/Jamoma/patchers/models/data/osc/`), `j.out`, `j.model`, `j.receive`, `j.send`; text edits that keep Max's own JSON format (`tools/maxtest/layout_patcher.py` rules).

- [ ] **Step 1: Write failing Max test** `osc_receive_basic`: load the model; set `port` to a free test port; send a UDP message with Max's `udpsend` to it; check the model outputs it through its `j.out`; `print` and `port` parameters have their old defaults (`0`, `11111`).
- [ ] **Step 2: Run** (announce Max use). Expected: FAIL (patcher missing).
- [ ] **Step 3: Copy** the three old patchers with fonts and sizes as in the package (Arial 12), fix references; open them with `scripts/check-help.sh`.
- [ ] **Step 4: Run** the test and the help check. Expected: PASS. Commit.

---

### Task 13: Help patchers lose their placeholders

**Files:**
- Modify: `package/Jamoma/help/j.model.maxhelp`, `j.parameter.maxhelp`, `j.return.maxhelp`, `j.message.maxhelp` (where they hold a comment for `j.map`/`j.namespace`/`j.cue`/`j.textslider`), `tools/package/check_references.py` only if a new reference type appears; `docs/inventory/coverage-baseline.md` (regenerated)

- [ ] **Step 1: Run** the baseline tool that wrote `coverage-baseline.md`; Expected: the four objects listed as implemented, `j.in~ j.out~ j.limiter~` missing.
- [ ] **Step 2: Replace** each placeholder by the real object at its position, keeping the author's layout (text edits only); then `scripts/check-help.sh` (announce Max use) and `ctest -R package_references`. Expected: all help patchers open without a missing object except the audio ones.
- [ ] **Step 3: Commit.**

---

### Task 14: Conformance, review, record

**Files:**
- Create: `docs/conformance/m4-results.md`
- Modify: `docs/changes.md`, `CHANGELOG.md`, `README.md` (object list), `conformance/own-tests.txt` if still used

- [ ] **Step 1: Unit and tool tests:** full `ctest` (plain), ASan+UBSan and TSan builds in their own package folders, `python3 -m unittest discover -s tools/maxtest`, `cmake --build build --target docs` (no warnings). Expected: all pass.
- [ ] **Step 2: Max:** `scripts/run-maxtests.sh --all --out build/maxtests-m4` with one test per launch (announce Max use; about 70 minutes plus the new tests), then `scripts/check-help.sh` and `scripts/max-smoke.sh tests/smoke/quit_live_objects "live objects loaded"`. Expected: every test passes; every help patcher opens.
- [ ] **Step 3: Review:** a fresh reviewer of the whole branch (`review-package`), findings sorted as in the executing-plans skill; fixes with a failing test first.
- [ ] **Step 4: Record:** `m4-results.md` (headline, run, what no test reaches: the look of `j.textslider` and of the subwindow button, the editor window, a prompt in a real Max; Windows untested), `docs/changes.md` (dead freeze button, anything different), `CHANGELOG.md` (new features), then ask the author before pushing, merging into `main` and tagging `milestone-4`.
