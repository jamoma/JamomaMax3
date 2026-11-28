# JamomaMax3 Milestone 5 (arrays and the models that need them) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `j.parameter_array`, `j.message_array`, `j.return_array`, `j.remote_array`, `j.oscinstance` and `j.oscroute` run natively in Max 9, and the models `mapper`, `midiin` and `hi` with what their patchers need are in the package.

**Architecture:** All array behaviour (bracket names, selection, distribution, collected output) is in the Max-free core: `DataArray` owns N `Data` nodes, `RemoteArray` owns N `Remote`s. The Max externals are thin; the attribute handling now inside `data_object.hpp` moves to a header used by both single and array objects. The OSC objects are two pure functions with thin externals.

**Tech Stack:** As before (C++20, CMake presets, Catch2, Min-API, max-test, the Python tools).

**Spec:** `docs/superpowers/specs/2026-11-28-milestone-5-arrays-design.md` (approved 28 November 2026), parent `docs/superpowers/specs/2026-11-21-jamomamax3-modular-design.md`. Old behaviour only from `~/Developer/Jamoma/JamomaMax`: `source/j.parameter_array`, `source/j.remote_array`, `source/classwrapper/TTModularClassWrapperMax.cpp`, `library/source/JamomaModularForMax.cpp` (`jamoma_parse_bracket`), `source/j.oscinstance`, `source/j.oscroute`, `Jamoma/patchers/components/data/initialized`, `Jamoma/patchers/components/namespace/namespacebrowser`, `Jamoma/patchers/models/data/{mapper,midiin,hi}`, their help patchers and reference pages.

## Global Constraints

The constraints of the earlier plans hold (clean-room: no C++ is copied; Max 9; macOS arm64 + x86_64 from macOS 12; Windows compiles by construction and is untested in Max; old names, outlets, OSC semantics and file formats; core without Max headers; all C++ Doxygen-documented with no warnings; BSD-3-Clause SPDX headers; `run_on_main` and `Alive` for threading; every test seen failing first; Max only through the runners, announced before and after). Added here:

- Branch `milestone-5` (exists). At the end it is merged into `main` and tagged `milestone-5`, the branch deleted; ask the author before merging and before any push.
- At most 256 instances in an array (`kMaxArraySize`).
- The behaviour of `j.parameter`, `j.message`, `j.return` and `j.remote` does not change: the 393 unit tests and 155 Max tests stay green after every task (quick mode between tasks, one test per launch at the end).
- Max tests follow `tests/integration/README.md` and are built with `tools/maxtest/make_test.py`: `Modular/<external>/<external>_<behaviour>.maxtest.maxpat`, assertions `Jamoma/Modular/<folder>/<behaviour>/<case>`. Never run a generator over a patcher the author has arranged.
- Imported patchers go through `tools/package/clean_patcher.py` once, at import; `package_references` stays green.
- Every deliberate difference goes in `docs/changes.md`, every new feature in `CHANGELOG.md` (Unreleased), in the same commit.
- After adding files: `cmake --preset macos`. Build: `cmake --build --preset macos`. Unit tests: `ctest --test-dir build/macos -C Debug -j8`.

## Review Focus

1. **Resizing while busy:** `array/resize` or `address` while ramps run, from inside the array's own output, or to 0 and back. No crash, no callback from a removed instance, selection falls back to all. Tasks 3, 5.
2. **Bad names and sizes:** no bracket, two brackets, `[abc]`, `[-1]`, `[257]`, a bracket on an absolute address of a data array. A console error, no nodes. Task 2.
3. **Two arrays or an array and a single object with the same names** in one model: both keep working, freeing one leaves the other. Task 3.
4. **A remote array bound before its model or its parameters exist,** or whose model is replaced: it binds when they appear. Tasks 6, 10.
5. **OSC strings that are empty, very long (over 2048 characters), start with a dot or end in a slash:** no crash (the old code used fixed buffers). Task 7.

---

## File Structure

```
core/include/jamoma/{array_name,data_array,remote_array,osc_tools}.hpp   new
core/src/{array_name,data_array,remote_array,osc_tools}.cpp              new
core/tests/{array_name,data_array,remote_array,osc_tools}_test.cpp       (add all to core/CMakeLists.txt)
core/src/receiver.cpp                                                    <model>:initialized
externals/common/data_attributes.hpp                                     moved out of data_object.hpp
externals/common/array_object.hpp                                        shared body of the three data arrays
externals/{j.parameter_array,j.message_array,j.return_array,j.remote_array,j.oscinstance,j.oscroute}/
package/Jamoma/patchers/components/                                      j.initialized, j.namespacebrowser.view
package/Jamoma/patchers/models/data/{mapper,midiin,hi}/
package/Jamoma/{help,docs/refpages}/
tests/integration/JamomaIntegrationTests/patchers/tests/Modular/<external or model>/
docs/inventory/{j.array,osc-tools,array-models}.md, docs/conformance/{m5-tests.txt,m5-results.md}
```

---

### Task 1: Characterise and baseline

**Files:** Create `docs/inventory/{j.array.md,osc-tools.md,array-models.md}`, `conformance/m5-tests.txt`.

**Interfaces:** Produces three notes, every rule with file and line, ending in a **Rulings** list later tasks cite; anything not read is marked "to characterise".
- `j.array.md`: all of the spec's "Behaviour of the array objects", checked against the source, plus: which attributes and messages `j.remote_array` has, what each message answers on the dump outlet, when `format array` outputs, what happens to attributes of the box when the array grows.
- `osc-tools.md`: every matching branch of `oscroute_symbol` (exact, prefix, trailing `*`, `*` in the middle, argument change through inlets 2..n, no argument = `/nil`), the output forms by argument count, `oscinstance_symbol`; a table of input and output taken from the five old tests and the help patchers.
- `array-models.md`: for each model its files, parameters, presets file, bpatchers, scripts, abstractions, and which are not in the package.

- [ ] **Step 1: Read** the sources, reference pages and help patchers named in the header; write the notes.
- [ ] **Step 2: List** the five old tests (`Modular/j.oscinstance/*`, `Modular/j.oscroute/*`) and the old tests that use any other object of this milestone in `conformance/m5-tests.txt`.
- [ ] **Step 3: Run** (announce Max use): `scripts/run-maxtests.sh --list conformance/m5-tests.txt --out build/maxtests-m5-baseline`. Expected: FAIL, missing objects.
- [ ] **Step 4: Commit.**

---

### Task 2: Array names, selection, splitting

**Files:** Create `core/include/jamoma/array_name.hpp`, `core/src/array_name.cpp`, `core/tests/array_name_test.cpp`; modify `core/CMakeLists.txt`.

**Interfaces (produces):**
```cpp
inline constexpr std::size_t kMaxArraySize = 256;
struct ArrayName {
    std::string before, after;                       // text around the bracket
    std::size_t size = 0;                            // 0..kMaxArraySize
    std::string instance(std::size_t index) const;   // "cc.[128]" -> instance(3) == "cc.3"
    std::string with_size(std::size_t n) const;      // "cc.[n]"
    bool same_shape(const ArrayName& other) const;   // before and after equal
};
JAMOMA_API std::optional<ArrayName> parse_array_name(std::string_view text);   // exactly one [digits] with digits <= 256, else nothing
class JAMOMA_API ArraySelection {                    // 0 = all (the start state)
public:
    bool select(const Atom& which, std::size_t size);          // int or float (rounded down) 1..size, or the symbol *; else false, unchanged
    void resized(std::size_t size);                            // an index above size falls back to all
    std::size_t index() const noexcept;
    std::vector<std::size_t> targets(std::size_t size) const;  // ascending, from 1
};
JAMOMA_API std::optional<std::vector<Value>> split_array(const Value& list, std::size_t size);  // size equal parts; nothing if size 0, list empty or not a multiple
```

- [ ] **Step 1: Write failing tests:** `array_name_parses_a_bracket_anywhere` (`cc.[128]` → `cc.1`; `track.[4]/gain` → `track.2/gain`; `output/going.up/action.[3]` → `output/going.up/action.3`), `array_name_rejects_bad_text` (`gain`, `a.[2]/b.[3]`, `a.[x]`, `a.[-1]`, `a.[]`, `a.[257]`, empty), `array_name_accepts_0_and_256`, `array_selection_starts_with_all`, `array_selection_accepts_256`, `array_selection_rejects_out_of_range_and_symbols`, `array_selection_floor_of_float`, `array_selection_falls_back_after_shrinking`, `array_split_equal_parts` (6 atoms over 3 = pairs), `array_split_refuses_other_lengths`.
- [ ] **Step 2: Run** `cmake --preset macos && cmake --build --preset macos --target jamoma_core_tests`. Expected: FAIL to compile.
- [ ] **Step 3: Implement.**
- [ ] **Step 4: Run** build, then `ctest --test-dir build/macos -C Debug -R array_`. Expected: PASS. Commit.

---

### Task 3: `DataArray`

**Files:** Create `core/include/jamoma/data_array.hpp`, `core/src/data_array.cpp`, `core/tests/data_array_test.cpp`; modify `core/CMakeLists.txt`.

**Interfaces:** Consumes Task 2, `Data`, `Namespace::subscribe`. Produces:
```cpp
enum class ArrayFormat { Single, Array };
class JAMOMA_API DataArray {
public:
    DataArray(Namespace& ns, Service service);
    void set_clock(Clock* clock);                                    // as Data::set_clock, for every instance
    void set_output(std::function<void(std::size_t index, const Value& value)> output);  // index from 1; the instance's value, or all values in Array format
    bool set_name(const std::string& name, const Address& prefix, bool init_new);  // false (nothing changes) for a bad or absolute name
    bool resize(std::size_t size, bool init_new);                    // false above kMaxArraySize or without a name
    std::size_t size() const;
    std::string name() const;                                        // with the current size in the bracket
    bool select(const Atom& which);
    std::size_t selected() const;
    bool command(const Value& input);                                // to the targets; false if empty
    bool inc(const Value& args);   bool dec(const Value& args);      // to the targets
    bool array(const Value& list);                                   // split over all instances; false for a wrong length or empty array
    bool set_attribute(std::string_view name, const Value& value);   // every instance; remembered for instances made later
    std::optional<Value> get_attribute(std::string_view name) const; // of the watched instance (the remembered value if empty)
    bool has_function_parameter(std::string_view name) const;
    Value function_parameter(std::string_view name) const;
    bool set_function_parameter(std::string_view name, const Value& value);  // every instance, remembered
    void set_format(ArrayFormat format);   ArrayFormat format() const;
    Value collected() const;                                         // value, else default, else 0 (strings: none), in index order
    void init();                                                     // every instance
};
```
Rules: the watched instance is the selected one; with all selected, the one that output last, at the start 1. Growing creates only the new instances (remembered attributes applied, then `init` if `init_new` and the service is not Message) and leaves the others untouched. A name of another shape removes all instances first. In Array format `set_name` and `resize` after the first build call the output once with the watched index and `collected()`. Instances may output on the scheduler thread; the output callback is called without a lock, and never for an instance that has been removed (hold the state weakly, as `Data` does for ramp ticks).

- [ ] **Step 1: Write failing tests** (a namespace, a `ManualClock` where ramps are needed): `data_array_makes_one_node_per_index`, `data_array_command_goes_to_all_in_index_order`, `data_array_command_goes_to_the_selected_one`, `data_array_array_splits_over_instances`, `data_array_array_wrong_length_changes_nothing`, `data_array_inc_acts_on_all_selected`, `data_array_attribute_reaches_every_instance_and_keeps_selection`, `data_array_query_reports_the_watched_instance`, `data_array_format_array_outputs_all_values`, `data_array_resize_keeps_remaining_values`, `data_array_new_instances_get_remembered_attributes`, `data_array_new_shape_removes_old_nodes`, `data_array_resize_to_zero_and_back`, `data_array_resize_during_ramps_gives_no_stale_output`, `data_array_resize_from_its_own_output`, `data_array_same_name_twice_keeps_both_working`, `data_array_rejects_absolute_name`, `data_array_instances_are_stored_in_presets` (a `Model` with an array under it: store, change, recall restores each value).
- [ ] **Step 2: Run** the build. Expected: FAIL to compile.
- [ ] **Step 3: Implement.**
- [ ] **Step 4: Run** `ctest --test-dir build/macos -C Debug -R data_array_`. Expected: PASS; also with ASan and TSan builds as in milestone 4. Commit.

---

### Task 4: Shared attribute header

**Files:** Create `externals/common/data_attributes.hpp`; modify `externals/common/data_object.hpp`.

**Interfaces:** Produces `template <class Derived> struct jamoma_max::data_attributes` with `static void add_to_class(c74::max::t_class*)` (the 18 attributes of `Data::attribute_names()`, their types, toggles and menus) and `static bool is_attribute(std::string_view)`. It requires of `Derived`: `jamoma::Value attribute_value(const std::string& name) const`, `void set_attribute_value(const std::string& name, const jamoma::Value&)`, `void dump_attribute(const std::string& name)`. The `Attr` enum goes; `data_object` implements the three members.

- [ ] **Step 1: Run** the existing tests of the four affected objects first (announce Max use): `scripts/run-maxtests.sh --dir j.parameter/general --dir j.model --dir j.unit --out build/maxtests-m5-t4-before --fast 10`. Expected: all pass (the reference).
- [ ] **Step 2: Move** the code; no behaviour change.
- [ ] **Step 3: Run** build, unit tests, and `scripts/run-maxtests.sh --all --out build/maxtests-m5-t4 --fast 10`. Expected: 155 of 155. Commit.

---

### Task 5: `j.parameter_array`, `j.message_array`, `j.return_array`

**Files:** Create `externals/common/array_object.hpp`, `externals/j.{parameter,message,return}_array/{CMakeLists.txt,*.cpp}`, tests `Modular/j.parameter_array/j_parameter_array_{basic,format,attributes,resize}.maxtest.maxpat`, `Modular/j.message_array/j_message_array_basic.maxtest.maxpat`, `Modular/j.return_array/j_return_array_basic.maxtest.maxpat`; modify `externals/CMakeLists.txt`.

**Interfaces:** Consumes Tasks 3, 4. Produces `template <class Derived, jamoma::Service S> class array_object`: inlets (values; index), outlets (value, index, dump), the index sent before the value; messages `bang int float list anything array array/select array/resize address inc dec dump init` and `+`/`-`; attributes of Task 4 plus `format` (`single array`, enum). The name goes to `DataArray::set_name` in the constructor under the root; joining and following the model is as in `data_object::join_model` (with `init_new` true once the object has joined). Errors on the console: no name, bad name, size above 256, bad index, wrong `array` length, message to an empty array.

- [ ] **Step 1: Write failing Max tests:** `basic` (nodes `cc.1`..`cc.4` exist; value to all; right inlet 2 then value; `*`; `bang`; index before value; `array`), `format` (`@format array` gives the whole list; changes through `j.send`), `attributes` (`range`/`clipmode` reach every instance with one selected, and the selection stays; a query), `resize` (`array/resize`, `address`, values kept, `j.namespace` shows the nodes); message and return `basic` (a message array of type none passes bangs per index; a return array reaches a `j.receive`).
- [ ] **Step 2: Run** `scripts/run-maxtests.sh --dir j.parameter_array --dir j.message_array --dir j.return_array --out build/maxtests-m5-t5`. Expected: FAIL, no such object.
- [ ] **Step 3: Implement.**
- [ ] **Step 4: Build and rerun.** Expected: PASS. Add differences 1 to 5 of the spec to `docs/changes.md`. Commit.

---

### Task 6: `RemoteArray` and `j.remote_array`

**Files:** Create `core/include/jamoma/remote_array.hpp`, `core/src/remote_array.cpp`, `core/tests/remote_array_test.cpp`, `externals/j.remote_array/`, tests `Modular/j.remote_array/j_remote_array_{basic,format,late_model}.maxtest.maxpat`; modify both `CMakeLists.txt`.

**Interfaces:** Consumes Task 2, `Remote`. Produces:
```cpp
class JAMOMA_API RemoteArray {
public:
    using Resolve = std::function<Address(const std::string& instance_name)>;   // the external resolves against its patcher
    RemoteArray(Namespace& ns, std::function<void(std::size_t index, const Value& value)> to_ui);  // value: instance, or all in Array format
    bool set_name(const std::string& name, Resolve resolve);  bool resize(std::size_t size);  void rebind();
    std::size_t size() const;
    bool select(const Atom& which);  std::size_t selected() const;
    bool from_ui(const Value& value);       // to the targets
    bool set(const Value& value);           // the same, nothing shown here
    bool array(const Value& list);          bool set_array(const Value& list);
    void set_unit(std::string_view unit);  void set_active(bool on);  void set_freeze(bool on);
    void set_format(ArrayFormat format);   ArrayFormat format() const;
};
```
The external: outlets (set, value, index, dump). For each value: index, then value at once, then `set <value>` (`setlist <list>` in array format) from the left outlet through a queue on the low-priority thread, every value kept in order. Binding as in `j.remote` (`defer_call`, `ContextWatch`, `Settle`).

- [ ] **Step 1: Write failing unit tests:** `remote_array_shows_each_instance_with_its_index`, `remote_array_from_ui_goes_to_targets`, `remote_array_set_shows_nothing_here`, `remote_array_set_array_splits_silently`, `remote_array_format_array_collects`, `remote_array_binds_when_nodes_appear_later`, `remote_array_resize_unbinds_removed`, `remote_array_absolute_names` (`/player.[3]/gain`).
- [ ] **Step 2: Run** the build. Expected: FAIL to compile.
- [ ] **Step 3: Implement** the core class on N `Remote`s. **Step 4:** unit tests PASS; commit.
- [ ] **Step 5: Write failing Max tests** (`basic`: outlet order index, value, set; `set` and `setArray` silent; selection; `format`: `setlist`; `late_model`: the array in a view whose model comes later).
- [ ] **Step 6: Implement** the external; run `--dir j.remote_array`. Expected: PASS. Commit.

---

### Task 7: `j.oscinstance` and `j.oscroute`

**Files:** Create `core/include/jamoma/osc_tools.hpp`, `core/src/osc_tools.cpp`, `core/tests/osc_tools_test.cpp`, `externals/j.oscinstance/`, `externals/j.oscroute/`; copy the five old tests into `Modular/j.oscinstance/` and `Modular/j.oscroute/`; modify both `CMakeLists.txt`.

**Interfaces:** Consumes Task 1 `osc-tools.md`. Produces:
```cpp
struct OscInstanceSplit { std::string address; Atom instance; };       // instance is an int when its text is one
JAMOMA_API std::optional<OscInstanceSplit> split_osc_instance(std::string_view selector);  // nothing = overflow
struct OscRouteMatch { std::size_t outlet; std::string rest; };        // rest empty = the whole selector matched
JAMOMA_API std::optional<OscRouteMatch> route_osc(std::string_view selector, std::span<const std::string> patterns);
```
Pinned cases: `/a.2/b` → `/a/b`, 2; `a.x` → `a`, `x`; `/a/b.2` → nothing; route `/fruit` on `/fruit/apple` → rest `apple`; on `/fruitcake` → no match; pattern `/robot*` on `/robot.1/arm` → rest `/arm`. Externals: `j.oscinstance` outlets (address, instance, arguments, dump/overflow), sent right to left; `j.oscroute` one outlet and one extra inlet per argument plus overflow, numbers as arguments turned into text as the note says.

- [ ] **Step 1: Write failing unit tests** `osc_instance_*` and `osc_route_*`: the pinned cases and every row of the note's table, plus `osc_tools_survive_hostile_strings` (empty, `.`, `/`, `a.`, 10000 characters, `*` alone).
- [ ] **Step 2: Run** the build. Expected: FAIL to compile. **Step 3: Implement** the functions. **Step 4:** `ctest ... -R osc_` PASS; commit.
- [ ] **Step 5: Implement** the externals (pure message passing, no defer: they work on the calling thread).
- [ ] **Step 6: Run** `--dir j.oscinstance --dir j.oscroute`. Expected: PASS (five old tests). Commit.

---

### Task 8: `<model>:initialized` and `j.initialized`

**Files:** Modify `core/src/receiver.cpp`, `core/tests/receiver_test.cpp`; import `package/Jamoma/patchers/components/data/initialized/j.initialized.{maxpat,maxhelp}`; test `Modular/j.initialized/j_initialized_basic.maxtest.maxpat`.

**Interfaces:** Consumes `Model::on_init_changed`, `Receiver`. Produces: a receiver on an address whose node is a `Model`, with attribute `initialized`, reports 0 when init starts, 1 when it finishes, and 1 at once if already initialised.

- [ ] **Step 1: Write failing tests** `receiver_model_initialized_reports_start_and_end`, `receiver_model_initialized_bound_after_init_reports_1`, `receiver_model_initialized_survives_model_removal`.
- [ ] **Step 2: Run** `-R receiver_`. Expected: FAIL (nothing received). **Step 3: Implement. Step 4:** PASS; commit.
- [ ] **Step 5: Import** the patcher and help, write the Max test (one bang after the model initialises, one when the object is loaded after it); run `--dir j.initialized`. Expected: PASS. Record the new `:initialized` address in `docs/changes.md`. Commit.

---

### Task 9: `j.namespacebrowser.view`

**Files:** Import `package/Jamoma/patchers/components/namespace/namespacebrowser/` (patcher), its help patcher, `package/Jamoma/javascript/j.get_onscreen_position.js` (**only if the author agreed**, see Task 1 `array-models.md`); test `Modular/j.namespacebrowser/j_namespacebrowser_basic.maxtest.maxpat`.

The patcher calls `js j.get_onscreen_position.js`, which the package lacks. The spec says to stop and ask: ask whether to import the old script (it keeps its old copyright notice) or replace the call.

- [ ] **Step 1: Write the failing test:** the view in a bpatcher next to a model lists the model's parameters when asked, and outputs the chosen address.
- [ ] **Step 2: Run** `--dir j.namespacebrowser`. Expected: FAIL, patcher not found.
- [ ] **Step 3: Import**, run `clean_patcher.py`, adapt only what does not work.
- [ ] **Step 4: Run** the test and `ctest -R package_references`. Expected: PASS. Commit.

---

### Task 10: `mapper`

**Files:** Import `package/Jamoma/patchers/models/data/mapper/{mapper.model,mapper.module,mapper.view,mapper.view.large}.maxpat`, `mapper.model.presets.txt`, `mapper.model.maxhelp` (and what `array-models.md` shows is loaded); tests `Modular/mapper/mapper_{load,maps}.maxtest.maxpat`.

**Interfaces:** Consumes Tasks 5, 6, 8, 9, `j.map`.

- [ ] **Step 1: Write failing tests:** `load` (the model loads in a patcher; the five arrays' nodes exist; the default preset recalls without console errors), `maps` (two parameters as `input` and `output`; changing the input gives the mapped output with default ranges, changed ranges, `inverse`, a function with a parameter through `function/parameters`, and each `going.up`/`going.down` action list).
- [ ] **Step 2: Run** `--dir mapper`. Expected: FAIL.
- [ ] **Step 3: Import** and clean; fix what is wrong **in the externals or core** with a unit or Max test first, and change a model patcher only where the old one depends on something not built (record it). Leave audio and `mouse` parts out of the help patcher.
- [ ] **Step 4: Run** the tests, check both views by screenshot, `scripts/check-help.sh`. Expected: PASS, no missing-object boxes. Commit.

---

### Task 11: `midiin` and `hi`

**Files:** Import `package/Jamoma/patchers/models/data/{midiin,hi}/` (model, module, view, presets, help; not `midiin.model_old.maxpat`, not `.html`); tests `Modular/midiin/midiin_load.maxtest.maxpat`, `Modular/hi/hi_load.maxtest.maxpat`.

- [ ] **Step 1: Write failing tests:** namespace has `cc.1`..`cc.128` and `hi.1`..`hi.256`; the `device` and `normalization` parameters of `midiin` change the return types and ranges as the model's patch says; every path that can be driven without hardware (messages into the subpatchers' inlets, not through `midiin`/`hi` objects).
- [ ] **Step 2: Run** `--dir midiin --dir hi`. Expected: FAIL. **Step 3: Import** and clean as in Task 10.
- [ ] **Step 4: Run** tests and `scripts/check-help.sh`. Expected: PASS. Write the author's hardware checklist (what to try with a MIDI device and an HID device) into `docs/conformance/m5-results.md`. Commit.

---

### Task 12: Help patchers and reference pages

**Files:** `package/Jamoma/help/{j.parameter_array,j.message_array,j.return_array,j.remote_array,j.oscinstance,j.oscroute,j.namespacebrowser.view}.maxhelp`, `package/Jamoma/docs/refpages/**`, `tools/refpages/check_refpages.py` (`OBJECT_SOURCES`), help patchers of other objects that hold a placeholder for one of these.

The old file is `j.remote_Array.maxhelp`; the new one is named `j.remote_array.maxhelp` so Max finds it.

- [ ] **Step 1: Add** the six externals to `OBJECT_SOURCES`; run `ctest -R refpages`. Expected: FAIL, pages missing.
- [ ] **Step 2: Migrate** the reference pages (`migrate_refpages.py`), write the entries it leaves as TODO; import the help patchers (`migrate_help.py`, `clean_patcher.py`); replace placeholders.
- [ ] **Step 3: Run** `ctest -R "refpages|package"` and `scripts/check-help.sh` (announce Max use). Expected: PASS. Commit.

---

### Task 13: Conformance, review, record

**Files:** `docs/conformance/m5-results.md`, `docs/changes.md`, `CHANGELOG.md`, `README.md` (status).

- [ ] **Step 1: Run** the unit tests (also the ASan and TSan builds), tool tests (`python3 -B -m unittest discover -s tools/<dir>` for each), `cmake --build --preset macos --target docs`. Expected: all pass, no Doxygen warnings.
- [ ] **Step 2: Run** (announce) `scripts/run-maxtests.sh --all --out build/maxtests-m5-final`. Expected: every test passes, one per launch.
- [ ] **Step 3: Whole-branch review** (superpowers:requesting-code-review, with the Review Focus above); fix with a failing test first.
- [ ] **Step 4: Record** results, differences, new features; add the author's manual checklist (help patchers, `mapper` views by eye, hardware). Commit.
- [ ] **Step 5: Ask** the author before merging, tagging `milestone-5` and pushing.
