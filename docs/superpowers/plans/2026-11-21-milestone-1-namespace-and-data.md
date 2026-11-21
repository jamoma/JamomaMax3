# JamomaMax3 Milestone 1 (Namespace and Data) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `j.parameter`, `j.message`, `j.return`, `j.model`, `j.init` and `j.savebang` run natively in Max 9 and pass the old `j.parameter` and `j.model` integration tests, backed by a Max-free core that holds the namespace tree, typed values, clipping, ramps and dataspaces.

**Architecture:** The shared core library (`jamoma_core`, from milestone 0) gains the namespace tree and the process-wide registry state. The value semantics (types, ranges, clipmodes, repetition filter, ramps, dataspace conversion) are Max-free C++20 in the same library, unit-tested with `ctest`. Thin Min-API externals translate Max messages and attributes to core calls; three of them (`j.parameter`, `j.message`, `j.return`) are one template instantiated three times, as the old ones were one source built three ways. The old integration tests (Max patchers under Cycling '74's `max-test` harness) are the conformance suite.

**Tech Stack:** C++20, CMake, Catch2 v3.8.1, Min-API (pinned submodule), Cycling '74 `max-test` package (MIT) with its Ruby runner, Python 3 (standard library) for tools.

**Spec:** `docs/superpowers/specs/2026-11-21-jamomamax3-modular-design.md`. Milestone 0 plan and results: `docs/superpowers/plans/2026-11-21-milestone-0-foundations.md`, `docs/decisions/0001-shared-state.md` (its "Rules for milestone 1" bind this plan). Old behaviour: `docs/inventory/*.md` and the old checkout at `~/Developer/Jamoma/JamomaMax` (read-only).

## Global Constraints

- Written from scratch; the old code is read to learn behaviour, nothing is copied.
- Max 9 (provisional minimum 9.0); macOS arm64 + x86_64, minimum macOS 12; Windows x64, minimum Windows 10. The Windows branch stays untested until a Windows machine is available; keep it compiling by construction (no platform `#ifdef`s in the core).
- Object names, argument and attribute names (including slash names such as `repetitions/filter`, `ramp/drive`, `ramp/function`), message names, outlet order and OSC address semantics follow the old objects. Package folder is `Jamoma`.
- Compatibility pass bar (spec section 9): same messages and values, in the same order, at the outlets; float formatting and exact timing are not part of the bar.
- Core in `core/`, namespace `jamoma`, C++20, **no Max headers**. Externals in `externals/`, Min-API.
- **All C++ is Doxygen-documented** (every file `@file`/`@brief`; every class, function, member and constant); `cmake --build --preset macos --target docs` reports no warnings.
- Licence BSD-3-Clause; every source file starts with the SPDX header used in milestone 0.
- Rules from `docs/decisions/0001-shared-state.md`: (1) decide the exit/teardown policy before the registry holds state that references externals; (2) no allocation ownership across the core boundary; (3) the ABI entry points (`abi_version`, `check_abi`, `try_attach_loader`) are frozen and every external checks the ABI first in its setup; (4) externals warn about a missing loader only through `Registry::claim_missing_loader_warning()`.
- Threading (decided here): the namespace's structure (create, remove, subscribe) changes only on the main thread and is guarded by a `std::shared_mutex`; lookups take the shared lock. A `Data`'s state is guarded by its own mutex, and commands may arrive on the main or the scheduler thread. No audio-thread access in this milestone.
- Commit steps run only when the user has asked for commits in the session; every commit ends with the Co-Authored-By trailer given in the session.
- The smoke and conformance runners touch `~/Documents/Max 9/Packages` (temporary symlinks, removed afterwards) and refuse to run while a Max 9 process is open; Max is launched through `open`, never as a child of the shell.

## Review Focus

Failure modes the spec implies but ordinary task tests would miss, most likely first. Each has a test in the task named.

1. **A `j.parameter` freed while its node still points at it** (patcher closed, object deleted, Max quit): later lookups or ramp ticks must not touch freed memory. Tasks 3, 7, 8.
2. **Two objects with the same name under one model**, and deletion and re-creation in either order: instances are numbered, the survivor keeps its address, and a removed instance's number is not silently reused for a different object while another holds it. Task 3.
3. **Hostile and odd values:** NaN and infinity, integers beyond 2^53, a symbol sent to a numeric type, lists longer or shorter than an array's size, empty messages, a range with low above high. Never crash; the result is the old behaviour or a defined clamp. Tasks 4, 5.
4. **A ramp that outlives its context:** interrupted by a new value, by `ramp 0`, by a change of range, or by the object being freed while a clock callback is pending. Task 7.
5. **Attribute order and late changes:** `@dataspace` before `@type`, `@range` before `@clipmode`, `@type` changed after a value was set, attributes given at creation versus set later. The object must reach the same state either way. Tasks 5, 8.

---

## File Structure

```
core/include/jamoma/{atom,address,namespace,clip,command,data,dataspace,ramp}.hpp
core/src/{atom,address,namespace,clip,command,data,dataspace,ramp}.cpp
core/tests/{atom,address,namespace,clip,command,data,dataspace,ramp}_test.cpp
externals/common/{max_atoms,max_attributes,max_clock}.hpp       Max <-> core glue (header-only, Min-API)
externals/j.parameter/{CMakeLists.txt,j.parameter.cpp}           the three data objects share externals/common/data_object.hpp
externals/j.message/...  externals/j.return/...
externals/j.model/...  externals/j.init/...  externals/j.savebang/...
package/Jamoma/{help,docs,patchers}/                             migrated help patchers and reference pages
scripts/run-maxtests.sh                                          max-test runner for the conformance set
conformance/set.txt, conformance/implemented.txt                 updated as objects land
docs/inventory/namespace.md                                      characterisation notes written in Tasks 2-3
docs/conformance/m1-results.md                                   final result list (Task 11)
```

---

### Task 1: Conformance harness and failing baseline

**Files:**
- Create: `scripts/run-maxtests.sh`, `docs/conformance/README.md`
- Modify: `conformance/set.txt` (add the milestone 1 test list), `README.md` (how to run)

**Interfaces:**
- Produces: `scripts/run-maxtests.sh <list file> <out dir>` runs every `.maxtest.maxpat` named in the list (paths relative to the old checkout), each in a fresh Max 9 launched through `open`, with the staged package linked in `~/Documents/Max 9/Packages/Jamoma` and the `max-test` package linked beside it; writes `<out dir>/results.tsv` (one line per test: `<path>\tPASS|FAIL|TIMEOUT\t<detail>`) and exits non-zero if any line is not PASS. `conformance/m1-tests.txt` lists the milestone 1 tests: all `.maxtest.maxpat` under `JamomaIntegrationTests/patchers/tests/Modular/j.parameter/` and under `.../j.model/` except `j.model/audio_gain` (needs `j.in~`/`j.out~`, which are not in this milestone).

- [ ] **Step 1: Get `max-test`.** It is Cycling '74's MIT-licensed harness (`github.com/Cycling74/max-test`; the old tests use its `test.assert`, `test.equals`, `test.list.equals`, `test.terminate` objects, and its Ruby runner in `ruby/`). **Ask the user before downloading** (state: the repository, about its size, that it goes into a scratch folder and is linked into `~/Documents/Max 9/Packages/`). Read its README, `help/oscar.maxhelp` and `ruby/` to learn how a test reports its result, and write what you learn (where the result goes, how a test is started and ended, timeouts) into `docs/conformance/README.md`.
- [ ] **Step 2: Prove one old test runs under the harness with a known object.** Hand-copy one test that uses only built-in Max objects plus `test.*` (for example one of `max-test`'s own examples under its `patchers/`) and run it through the new script. Expected: `PASS` in `results.tsv`, and a test that is made to fail (edit a copy) gives `FAIL`.
- [ ] **Step 3: Implement `scripts/run-maxtests.sh`** on the pattern of `scripts/max-smoke.sh` (same refusals, same `open` launch, same cleanup, same crash-report scan with a 5 s wait). Per-test timeout 60 s.
- [ ] **Step 4: Write `conformance/m1-tests.txt` and run the baseline.** Expected: every test is `FAIL` or `TIMEOUT` because `j.parameter` and `j.model` do not exist (`no such object`). Commit the baseline counts into `docs/conformance/README.md` (for example "baseline: 0 of N pass").
- [ ] **Step 5: Commit.**

---

### Task 2: Atoms, values and addresses

**Files:**
- Create: `core/include/jamoma/atom.hpp`, `core/src/atom.cpp`, `core/include/jamoma/address.hpp`, `core/src/address.cpp`, `core/tests/atom_test.cpp`, `core/tests/address_test.cpp`
- Modify: `core/CMakeLists.txt`, top-level `CMakeLists.txt` (Windows: `CMAKE_MSVC_RUNTIME_LIBRARY` becomes `MultiThreaded$<$<CONFIG:Debug>:Debug>DLL`), `docs/decisions/0001-shared-state.md`

**Interfaces:**
- Produces (namespace `jamoma`):
  `class Atom` holds an `int64_t`, a `double` or a `std::string` (a Max symbol): constructors from each; `bool is_int() const`, `is_float()`, `is_symbol()`, `is_number()`; `int64_t as_int() const` (a float is truncated toward zero; a symbol gives 0); `double as_double() const` (a symbol gives 0.0); `const std::string& as_symbol() const` (a number gives its text); `bool operator==(const Atom&) const`; `std::string to_string() const`.
  `using Value = std::vector<Atom>;` `std::string to_string(const Value&)`.
  `struct Segment { std::string name; std::string instance; };` (`instance` empty means none).
  `class Address`: `static Address parse(std::string_view text)` (never throws; a malformed text gives an empty address); `std::string directory() const`; `bool absolute() const`; `const std::vector<Segment>& path() const`; `std::string attribute() const`; `Address parent() const`; `Address append(const Address& relative) const`; `Address with_attribute(std::string_view) const`; `std::string str() const`; `bool operator==`; `bool empty() const`.
  Grammar (from the old `TTAddress`): `directory:/parent/name.instance:attribute`; `name.0` is the same as `name` (instance zero is dropped); the instance is the text after the first `.` of a segment.

- [ ] **Step 1: Write failing tests.** `atom_test.cpp`: `int_atom_reports_int_and_double` (`Atom(3)`: `is_int`, `as_double()==3.0`), `float_truncates_to_int` (`Atom(-2.9).as_int()==-2`), `symbol_is_zero_as_number` (`Atom("foo").as_double()==0.0`), `large_int_survives` (`Atom(int64_t{9007199254740993}).as_int()==9007199254740993`), `nan_stays_nan` (`std::isnan(Atom(NAN).as_double())`), `equality_distinguishes_int_from_float` (`Atom(1) != Atom(1.0)`). `address_test.cpp` (exact expectations): `parse("/a/b.2:range")` has path `[{a,""},{b,"2"}]`, `absolute()`, `attribute()=="range"`, `str()=="/a/b.2:range"`; `parse("app:/m.1/p")` has directory `app`; `parse("/a/b.0").str()=="/a/b"`; `parse("both.4")` is relative with one segment `{both,"4"}`; `parse("/a/b").parent().str()=="/a"`; `parse("/a").append(parse("b/c")).str()=="/a/b/c"`; `parse("").empty()`; `parse("///").str()` is a defined value (state it in the test and in the Doxygen); `parse("/a/b:").attribute()==""`; a 4 KB address round-trips.
- [ ] **Step 2: Run** `ctest --preset macos -R "atom|address"`. Expected: build FAIL (headers missing).
- [ ] **Step 3: Implement** `Atom`, `Value`, `Segment`, `Address` per the Interfaces. Value semantics only; no shared state.
- [ ] **Step 4: Run** `ctest --preset macos` and the `docs` target. Expected: all PASS, docs no warnings.
- [ ] **Step 5: Windows runtime decision.** Because the core API now passes `std::string` and `std::vector` across the library boundary, change the Windows runtime to the dynamic CRT (`/MD`) for core and externals (one shared heap) and rewrite rule 2 in `docs/decisions/0001-shared-state.md` accordingly; macOS needs no change. Not testable here; say so in the record.
- [ ] **Step 6: Commit.**

---

### Task 3: Namespace tree, subscription and the teardown policy

**Files:**
- Create: `core/include/jamoma/namespace.hpp`, `core/src/namespace.cpp`, `core/tests/namespace_test.cpp`, `docs/inventory/namespace.md`
- Modify: `core/include/jamoma/registry.hpp`, `core/src/registry.cpp`, `core/CMakeLists.txt`, `docs/decisions/0001-shared-state.md`

**Interfaces:**
- Consumes: `Address`, `Segment` (Task 2); `Registry` (milestone 0).
- Produces (namespace `jamoma`):
  `class Object { public: virtual ~Object() = default; };` (what a node refers to: a data object, a model).
  `class Node`: `const std::string& name() const`, `const std::string& instance() const`, `Node* parent() const`, `std::vector<Node*> children() const`, `Object* object() const`, `Address address() const`.
  `class Subscription` (movable, not copyable; destroying it unsubscribes): `Node* node() const`, `bool created_instance() const`, `Address address() const`.
  `class Namespace`: `Node* root()`; `Node* lookup(const Address& absolute) const`; `Subscription subscribe(const Address& absolute, Object& object)`; `std::vector<Node*> find(const Address& pattern) const` (a segment instance of `*` matches any instance).
  `Namespace& Registry::names() noexcept`.
- Behaviour (from `TTSubscriber::Subscribe`, read it and `Foundation/library/source/TTNodeDirectory.cpp` `TTNodeCreate`, and write the exact instance-numbering rule into `docs/inventory/namespace.md` **before** the tests): subscribing to an address with no node creates the node; with a node that has no object, attaches; with a node that already has an object, creates another instance of the name. Unsubscribing removes a node that has no children and no other object, otherwise only detaches the object.

- [ ] **Step 1: Characterise.** Read the two old sources, write `docs/inventory/namespace.md`: the numbering rule for repeated names (first `name`, then which suffix), what an explicit `name.4` does when it is free and when it is taken, whether a freed number is reused, and how a context (a model) node is created. Cite file and line for each rule.
- [ ] **Step 2: Write failing tests** in `namespace_test.cpp` from that note, with exact addresses: `subscribe_creates_nodes_along_the_path`, `second_object_under_same_name_gets_an_instance` (use the numbering written in the note), `explicit_instance_is_kept_when_free`, `unsubscribe_removes_childless_node`, `unsubscribe_keeps_node_that_has_children`, `lookup_of_missing_address_is_null`, `find_with_wildcard_instance_returns_all_instances`, `subscription_survives_move` (move-construct, node still registered once), **Review Focus 2:** `removing_one_of_two_instances_keeps_the_other_address` and `recreate_after_removal_does_not_alias_a_live_instance`; **Review Focus 1:** `object_freed_after_unsubscribe_is_never_returned_by_lookup` (an `Object` subclass records its destruction; after its subscription is destroyed `lookup` returns null or a node whose `object()` is null) and `subscription_outliving_namespace_content_is_safe` (destroy the subscription after `names().root()` was reached again; no crash).
- [ ] **Step 2b: Run** `ctest --preset macos -R namespace`. Expected: FAIL (not defined).
- [ ] **Step 3: Implement** `Namespace` with a `std::shared_mutex` (structure changes take the unique lock, lookups the shared lock) and nodes that never hand out raw pointers that survive their removal without the caller holding a `Subscription` (document the rule: a `Node*` is valid while some subscription or the caller's lock keeps it alive).
- [ ] **Step 4: Teardown policy (rule 1).** Make `Registry::instance()` return a deliberately leaked heap object (`static Registry* registry = new Registry;`), so externals that unregister while Max quits always find a live registry; record the decision and the reason (static destruction order versus externals freed at quit) in `docs/decisions/0001-shared-state.md`. Add `registry_outlives_static_destruction`: a function-local static object in the test whose destructor calls `Registry::instance().names().lookup(...)` runs at exit without a crash (run it as its own ctest case and check the exit code).
- [ ] **Step 5: Run** `ctest --preset macos` and the `docs` target. Expected: all PASS.
- [ ] **Step 6: Commit.**

---

### Task 4: Clip modes and command parsing

**Files:**
- Create: `core/include/jamoma/clip.hpp`, `core/src/clip.cpp`, `core/include/jamoma/command.hpp`, `core/src/command.cpp`, `core/tests/clip_test.cpp`, `core/tests/command_test.cpp`

**Interfaces:**
- Produces: `enum class ClipMode { None, Low, High, Both, Wrap, Fold };` `ClipMode clip_mode_from_name(std::string_view)` (unknown gives `None`); `std::string_view clip_mode_name(ClipMode)`; `double clip(double value, double low, double high, ClipMode mode) noexcept`.
  `struct Command { Value values; std::string unit; std::optional<double> ramp_ms; };` `Command parse_command(const Value& input)`: an input such as `100. ramp 200` or `0.5 linear ramp 50` splits into the leading values, an optional unit symbol before `ramp`, and the ramp time after it; `ramp` is a reserved word; a missing or non-numeric ramp time gives no ramp.
- Reference values (from the old tests): for range 3..4 and mode Both: -9.5 → 3, 4.5 → 4, 2.5 → 3, 3.5 → 3.5. For range 0..80 (the old ramp-and-clipmode test, target 100 and the previous step 80): Low: 100 → 100; High: 100 → 80; Both: 100 → 80; Wrap: 80 → 0 and 100 → 20; Fold: 80 → 80 and 100 → 60.

- [ ] **Step 1: Write failing tests.** `clip_test.cpp`: the reference values above (one test per mode: `both_clips_to_range`, `low_clips_only_below`, `high_clips_only_above`, `wrap_re_enters_range`, `fold_reflects_at_bounds`), `none_leaves_value`, `unknown_mode_name_is_none`, and **Review Focus 3:** `nan_in_gives_nan_out_without_crash`, `infinite_value_is_clamped_by_both`, `low_above_high_is_defined` (decide: the bounds are swapped; state it in the Doxygen), `wrap_with_zero_width_range_returns_the_bound`. `command_test.cpp`: `plain_value`, `list_of_values`, `value_with_ramp` (`100. ramp 200` gives values `[100.]`, ramp 200), `value_with_unit_and_ramp`, `ramp_without_time_has_no_ramp`, `ramp_word_in_the_middle_of_a_symbol_list_is_still_reserved` (state the rule), `empty_input_gives_empty_command`.
- [ ] **Step 2: Run** `ctest --preset macos -R "clip|command"`. Expected: build FAIL.
- [ ] **Step 3: Implement.** Wrap and fold are the standard modulo and reflection against `[low, high]` (check against the reference values; the old `TTValue::wrap/fold` in `JamomaCore/Foundation` is the arbiter if a case differs).
- [ ] **Step 4: Run** tests and `docs`. Expected: PASS, no warnings.
- [ ] **Step 5: Commit.**

---

### Task 5: The data object (parameter, message, return)

**Files:**
- Create: `core/include/jamoma/data.hpp`, `core/src/data.cpp`, `core/tests/data_test.cpp`

**Interfaces:**
- Consumes: `Value`, `Atom`, `clip`, `ClipMode`, `parse_command` (Tasks 2, 4).
- Produces (namespace `jamoma`):
  `enum class DataType { None, Generic, String, Boolean, Integer, Decimal, Array };` `enum class Service { Parameter, Message, Return };`
  `class Data : public Object` (an `Object` from Task 3): `explicit Data(Service)`; setters/getters for the attributes of the old object (names exactly as in `docs/inventory/j.parameter.md`): `type`, `range` (two doubles), `clipmode`, `repetitions_filter` (bool), `default_value`, `stepsize`, `active`, `priority`, `description`, `tags`, `array_size` (derived from the default for `Array`); `Value value() const`; `bool initialized() const`; `void init()`; `void set_output(std::function<void(const Value&)>)` (called with the value that leaves the object; never called while the object holds its own lock); `void command(const Value& input)` (the full pipeline: parse, convert to the type, apply range and clipmode, apply the repetition filter, store, output); `void inc(const Value& args)`, `void dec(const Value& args)`; `void bang()` (outputs the current value).
- Behaviour to reproduce (read `JamomaCore/Modular/library/source/TTData.cpp` and `TTDataTypedMethods.cpp`; the old `type_*` integration tests are the oracle; cases below are taken from them): defaults are 0 / range 0..1 for decimal and array, range 0..1 and step 1 for integer; a symbol sent to a numeric type gives 0 (`message/symbol`, `message/symbol:with_args` expect 0.); `bang` outputs the current value; an integer sent to a decimal gives the decimal (`3` → `3.`); `inc 2` on a decimal with step 0.1 gives `0.2` and `dec 2` gives `-0.2` from 0; `+ 0.1` and `- 0.1` (a symbol `+` followed by a number) are accepted by the decimal type (`message/+`, `message/-`); with `repetitions/filter` on, a value equal to the current one is not output again (`msg_float/repetitions_filter/1`), off outputs it every time (`/0`); `init` outputs the default for a parameter and sets `initialized` (the old code special-cases `Service::Parameter` when not yet initialised, `TTDataTypedMethods.cpp:268,301`; characterise what it does and write it in the Doxygen of `init`); a `Service::Return` never initialises its value; an inactive object ignores commands; the re-entrancy guard of the old code (`mIsSending`) is kept: a command issued from inside the output callback of the same object is dropped, not recursed.

- [ ] **Step 1: Characterise before coding.** Read the two old sources and the `default_attr_value` tests of each type (`type_boolean`, `type_decimal`, `type_generic`, `type_integer`, `type_string`, `type_array`) and write, at the top of `core/tests/data_test.cpp` as comments, the table of defaults per type and what `init` does per service. This table is the test's source of truth.
- [ ] **Step 2: Write failing tests** `data_test.cpp`, one test per row of the table plus the behaviours above, with exact values: `decimal_default_is_zero_with_unit_range`, `integer_truncates_float_input`, `symbol_to_decimal_is_zero`, `bang_outputs_current_value`, `inc_dec_use_stepsize`, `plus_minus_symbols_on_decimal`, `repetition_filter_drops_equal_value`, `repetition_filter_off_repeats`, `inactive_ignores_command`, `reentrant_command_from_output_is_dropped`, `return_service_does_not_initialise`, `array_keeps_its_length_from_the_default`, `boolean_maps_nonzero_to_one`, `string_keeps_first_element_only` (the old code keeps only the first element for `String`). **Review Focus 3:** `nan_to_integer_is_zero_not_ub`, `int64_max_survives_integer_type`, `shorter_list_into_array_pads_with_default`, `longer_list_into_array_is_cut`, `empty_command_changes_nothing`, `range_with_low_above_high_does_not_crash`. **Review Focus 5:** `range_then_clipmode_equals_clipmode_then_range` (same final state either order), `type_change_after_value_resets_to_the_new_default` (state the old behaviour from the source).
- [ ] **Step 3: Run** `ctest --preset macos -R data`. Expected: build FAIL.
- [ ] **Step 4: Implement `Data`.** One mutex guards the state; the output callback is invoked after the lock is released with a copy of the value.
- [ ] **Step 5: Run** all tests and `docs`. Expected: PASS.
- [ ] **Step 6: Commit.**

---

### Task 6: Dataspaces (gain, time, position)

**Files:**
- Create: `core/include/jamoma/dataspace.hpp`, `core/src/dataspace.cpp`, `core/tests/dataspace_test.cpp`

**Interfaces:**
- Produces: `class Dataspace { public: static const Dataspace* find(std::string_view name); const std::string& name() const; std::string default_unit() const; bool has_unit(std::string_view) const; std::optional<Value> convert(const Value& in, std::string_view from, std::string_view to) const; };` with the dataspaces and units the pass-bar set uses (each unit has aliases as in the old library):
  - **gain:** `linear`, `midigain`, `dB` / `db`, `db-raw` / `dB-raw`;
  - **time:** `ms` / `millisecond`, `s` / `second`, `sample`, `bpm`, `Hz` / `hz` / `Hertz` / `fps`, `midinote`, `cents`, `mel`, `bark`;
  - **position:** `xyz` / `cart3D`, `xy` / `cart2D`, `aed` / `spherical`, `ad` / `polar`, `daz` / `cylindrical`, `openGL`.
  Unknown dataspace or unit gives `nullopt` from `find` / `convert`. Other dataspaces of the old library (`angle`, `distance`, `speed`, `temperature`, `color`, `orientation`) are **not** in this milestone: add them later when a patcher needs them.
- Oracle: `JamomaCore/Foundation/extensions/DataspaceLib/source/{Gain,Time,Position}Dataspace.cpp` and its `tests/*.test.cpp` (the old library's own numeric tests; port their cases) and the integration tests `type_*/dataspace/*` (for example `linear2midi`: a parameter with `@dataspace gain @unit midigain` that receives `1. linear` outputs 100.; port the exact numbers of `midi2db` and `no_unit` from the test patchers).

- [ ] **Step 1: Write failing tests** `dataspace_test.cpp` porting the numeric cases of the old unit tests and of `linear2midi`, `midi2db`, `no_unit`; plus `unknown_unit_is_nullopt`, `alias_units_are_equal` (`dB` and `db`), `convert_is_invertible_within_tolerance` for every gain and time unit pair (1e-9 relative), and **Review Focus 3:** `convert_of_nan_is_nan`, `db_of_zero_linear_is_a_defined_floor` (state the old floor), `position_aed_to_xyz_at_origin`.
- [ ] **Step 2: Run** `ctest --preset macos -R dataspace`. Expected: build FAIL.
- [ ] **Step 3: Implement** with a table of units per dataspace, each with `to_neutral` and `from_neutral` functions (the old library converts through a neutral unit); no global mutable state.
- [ ] **Step 4: Wire it into `Data`:** `Data::set_dataspace(std::string)`, `Data::set_unit(std::string)`: a command's unit is converted to the object's unit before range, clip and storage (the old tests `ramp_and_dataspace/overriding_unit` and `default_unit`). Add tests `command_unit_overrides_default_unit` and `unknown_unit_in_command_is_ignored_not_fatal` to `data_test.cpp`, watch them fail, then pass.
- [ ] **Step 5: Run** all tests and `docs`. Expected: PASS.
- [ ] **Step 6: Commit.**

---

### Task 7: Ramps

**Files:**
- Create: `core/include/jamoma/ramp.hpp`, `core/src/ramp.cpp`, `core/tests/ramp_test.cpp`
- Modify: `core/include/jamoma/data.hpp`, `core/src/data.cpp`, `core/tests/data_test.cpp`

**Interfaces:**
- Produces: `class Clock { public: virtual ~Clock() = default; virtual void schedule(double delay_ms, std::function<void()> callback) = 0; virtual void cancel() = 0; virtual double now_ms() const = 0; };` (the Max drive implements it in Task 8; a manual clock implements it in the tests).
  `class Ramp`: `Ramp(Clock&, std::function<void(double)> on_value)`; `void start(double from, double to, double duration_ms, std::string_view function)` (function `linear` in this milestone; an unknown name falls back to `linear` and `Ramp::function_ok()` reports false); `void stop()`; `bool running() const`; ticks every `kTickMs` (20 ms, taken from the old tests: a 100 ms ramp from 0 to 100 gives 0, 20, 40, 60, 80, 100; verify against `ramp_correct_value_and_timing.maxtest.maxpat` and write the finding down); the last value is always exactly `to`.
  `Data` gains `ramp/drive` (`none` | `max`; `system` is accepted as an alias for `max`), `ramp/function`, `ramp/status` (read-only), `ramp/function/parameters` (read-only, empty for linear), `void Data::set_clock(Clock*)`; a command with a ramp time starts a ramp from the current value (after unit conversion) to the clipped target, and each tick passes through the same clipmode and the repetition filter as a plain command (old tests `ramp_and_clipmode`: for range 0..80, target 100, fold gives the sequence `0 20 40 60 80 60`, wrap `0 20 40 60 0 20`, high and both stop at 80, low reaches 100).

- [ ] **Step 1: Write failing tests** `ramp_test.cpp` with a manual clock that advances on demand: `linear_ramp_visits_expected_steps` (0→100 in 100 ms gives `0,20,40,60,80,100`), `last_value_is_exactly_the_target`, `zero_duration_jumps_to_target`, `stop_cancels_pending_ticks`, `restart_replaces_the_running_ramp`, `unknown_function_falls_back_to_linear`. In `data_test.cpp`: `ramp_with_fold_clipmode_matches_old_sequence`, `ramp_with_wrap_clipmode_matches_old_sequence`, `ramp_with_high_clipmode_stops_at_upper_bound`, `ramp_with_low_clipmode_reaches_target`, `ramp_in_db_unit_ends_at_converted_value` (the `ramp_and_dataspace` test: `-20., 0. ramp 200` in dB steps `-20 ... 0`; use the tolerance the old test uses). **Review Focus 4:** `new_value_during_ramp_stops_the_ramp`, `ramp_zero_stops_the_ramp_and_sets_value`, `range_change_during_ramp_clips_next_tick`, `data_destroyed_while_tick_is_pending_never_calls_back` (the manual clock keeps the callback; destroy the `Data`; fire the clock; no call, no crash, checked under AddressSanitizer: build this test target in a separate directory with `-fsanitize=address`).
- [ ] **Step 2: Run** `ctest --preset macos -R "ramp|data"`. Expected: build FAIL / FAIL.
- [ ] **Step 3: Implement** `Ramp` and the `Data` integration. A `Data` hands its clock a callback that holds only a weak token, so a destroyed `Data` is never called.
- [ ] **Step 4: Run** all tests, the ASan run and `docs`. Expected: PASS, no sanitizer report.
- [ ] **Step 5: Commit.**

---

### Task 8: Max glue and the three data externals (`j.parameter`, `j.message`, `j.return`)

**Files:**
- Create: `externals/common/max_atoms.hpp`, `externals/common/max_attributes.hpp`, `externals/common/max_clock.hpp`, `externals/common/data_object.hpp`, `externals/j.parameter/{CMakeLists.txt,j.parameter.cpp}`, `externals/j.message/{CMakeLists.txt,j.message.cpp}`, `externals/j.return/{CMakeLists.txt,j.return.cpp}`
- Modify: `externals/CMakeLists.txt`, `conformance/implemented.txt`

**Interfaces:**
- Consumes: `Data`, `Dataspace`, `Ramp`, `Clock`, `Namespace`, `Address`, `Registry` (Tasks 2-7).
- Produces: `externals/common/max_atoms.hpp`: `jamoma::Value to_value(const c74::min::atoms&)`, `c74::min::atoms to_atoms(const jamoma::Value&)`; `max_clock.hpp`: `class MaxClock : public jamoma::Clock` backed by a Max `clock` object (created and freed on the main thread; `cancel()` frees pending callbacks); `data_object.hpp`: `template <jamoma::Service S> class data_object` (the shared body of the three externals); each of the three `.cpp` files is the class declaration plus `MIN_EXTERNAL`.
- Behaviour: the creation arguments are `<name> @attr value ...` (the first argument is the relative address; with no name, an anonymous name is generated as the old object did, characterise it); the attributes of the old object by exact name including `repetitions/filter`, `ramp/drive`, `ramp/function`, `ramp/function/parameters`, `ramp/status`, `unit`, `dataspace`, `range`, `clipmode`, `default`, `stepsize`, `priority`, `active`, `description`, `tags`, `type`, `value`; methods `bang`, `int`, `float`, `list`, `anything`, `inc`, `dec`, `address`; two outlets, data (0) and dump (1) as in the old object; the first thing each external does in its setup is the ABI check (`Registry::try_attach_loader` is the loader's; externals call `Registry::check_abi(jamoma::kAbiVersion)` and, without a loader, warn only if `Registry::claim_missing_loader_warning()` returns true); the object subscribes its address under the enclosing model (Task 9) or the root, and unsubscribes in its destructor before any member is freed.
- First step to settle by reading the pinned Min-API: whether `attribute<>` accepts names with a slash (`ramp/drive`); if not, use the lower-level Max attribute API through `c74::max::` for those attributes and say so in `max_attributes.hpp`.

- [ ] **Step 1: Set the expectation.** Run the baseline of Task 1 for the `j.parameter` tests: all fail (`no such object`). Keep that result.
- [ ] **Step 2: Build `max_atoms.hpp` test-first.** A small Max-free-style unit test is not possible for Min types; instead add `scripts/run-maxtests.sh`-style Max patchers under `docs/conformance/own/` (`atoms_roundtrip.maxtest.maxpat`: a list of `int`, `float`, `symbol` through `j.parameter @type array` and back, with `test.list.equals`) and run them in Step 5. Write the patcher first and watch it fail.
- [ ] **Step 3: Implement the glue and the three externals**; `CMakeLists.txt` per external with `jamoma_add_external(NAME j.parameter SOURCES j.parameter.cpp)` (and `j.message`, `j.return`).
- [ ] **Step 4: Build** (`cmake --build --preset macos`) and run the Doxygen gate. Expected: BUILD SUCCEEDED, no warnings.
- [ ] **Step 5: Run the conformance subset for the data externals:** every test under `Modular/j.parameter/` (they use `j.savebang` in some cases: those wait for Task 9; list them in `docs/conformance/README.md` as "waiting for j.savebang"). Expected: all tests that need only `j.parameter` and the `test.*` objects PASS; fix failures by finding their cause (systematic-debugging), never by loosening a test.
- [ ] **Step 6: Review Focus 1 and 5 in Max.** Add own tests under `docs/conformance/own/`: `free_while_ramping.maxtest.maxpat` (a `j.parameter` ramping 5 s is deleted by a script after 100 ms; the test ends after 1 s without a crash), `attribute_order.maxtest.maxpat` (`@dataspace gain @unit db @type decimal` equals `@type decimal @dataspace gain @unit db`), `duplicate_names.maxtest.maxpat` (two `j.parameter same` in one patcher: both work, addresses differ). Run through the runner; Expected: PASS.
- [ ] **Step 7: Update `conformance/implemented.txt`** (`j.parameter`, `j.message`, `j.return`). **Commit.**

---

### Task 9: `j.model`, `j.init`, `j.savebang`

**Files:**
- Create: `core/include/jamoma/model.hpp`, `core/src/model.cpp`, `core/tests/model_test.cpp`, `externals/j.model/{CMakeLists.txt,j.model.cpp}`, `externals/j.init/{CMakeLists.txt,j.init.cpp}`, `externals/j.savebang/{CMakeLists.txt,j.savebang.cpp}`
- Modify: `externals/common/data_object.hpp` (subscribe under the enclosing model), `externals/CMakeLists.txt`, `conformance/implemented.txt`

**Interfaces:**
- Produces (core): `class Model : public Object`: `Model(Namespace&, Address model_address)`; `void set_description(std::string)`; `void set_priority(int)`; `void set_amenities(std::vector<std::string>)` (the attribute is `amenities`, seen in the old `j.model` usages; characterise its effect, probably which UI panels a model offers, and implement only the storage and getter if nothing else in this milestone reads it); `void init()`: starts the initialisation sequence: notifies "init started" observers, calls `init()` on every `Data` below the model in ascending `priority` order (ties in creation order), then notifies "init finished" observers; `Subscription` of the model node as a context so data objects below subscribe relative to it; `void on_init_started(std::function<void()>)`, `void on_init_finished(std::function<void()>)` (what `j.init` uses; returns a handle that unregisters).
- Max: `j.model` (arguments: optional name; attributes `description`, `priority`, `amenities`; the messages of `docs/inventory/j.model.md` that this milestone needs: `init` and the ones the integration tests send, read `Modular/j.model/audio_gain` neighbours and the `j.model.maxref.xml`), `j.init` (two outlets as in the old `start_out`/`end_out`: a bang when the enclosing model starts initialising and a bang when all defaults have been recalled; binds to the first `j.model` at the same patcher level or above), `j.savebang` (one outlet; a bang when the patcher it lives in is saved, via the patcher's save notification in Min-API / `c74::max::`; if Min-API offers no hook, use the raw Max notification API and say so).
- Context rule (from `TTSubscriber::registerContextList`): a model registers a context node for its patcher; data objects in that patcher or in abstractions below subscribe under it; nested models nest. Characterise the exact patcher-to-address mapping (how the name of an abstraction instance becomes `name.1`), write it into `docs/inventory/namespace.md`, then implement.

- [ ] **Step 1: Characterise** the model's init order and the context mapping; extend `docs/inventory/namespace.md`.
- [ ] **Step 2: Write failing tests** `model_test.cpp`: `init_visits_children_in_priority_order`, `equal_priority_keeps_creation_order`, `init_started_fires_before_first_child_and_finished_after_last`, `model_with_no_children_still_fires_both`, `nested_model_inits_inside_its_parent_slot`, **Review Focus 1:** `data_removed_during_init_is_skipped_not_called`, `model_destroyed_with_children_still_registered_leaves_them_valid`. Run: FAIL (no `Model`).
- [ ] **Step 3: Implement `Model`**, then the three externals. `j.init` and `j.savebang` are small; read the old sources (`source/j.init/j.init.cpp`, `source/j.savebang/j.savebang.cpp`) for the exact outlets and messages.
- [ ] **Step 4: Run** unit tests, docs gate, build. Expected: PASS.
- [ ] **Step 5: Run the conformance set:** all of `Modular/j.parameter/` and `Modular/j.model/` (except `audio_gain`). Expected: PASS; any test that cannot pass because it needs an object outside this milestone is listed by name with the missing object in `docs/conformance/m1-results.md`, not skipped silently.
- [ ] **Step 6: Update `conformance/implemented.txt`.** **Commit.**

---

### Task 10: Help patchers and reference pages

**Files:**
- Create under `package/Jamoma/`: `help/{j.parameter,j.message,j.return,j.model,j.init,j.savebang}.maxhelp`, `docs/refpages/modular/{...}.maxref.xml`, plus any abstraction a help patcher needs that is in scope
- Create: `tools/refpages/check_refpages.py`, `tools/refpages/test_check_refpages.py`

**Interfaces:**
- Produces: `check_refpages.py --package package/Jamoma --inventory docs/inventory` verifies that every attribute and message that an object implements has an entry in its `.maxref.xml` and that no entry names something the object does not have; exit code non-zero on a difference. `parse_implemented(object)` reads the live attribute and message names from a JSON dump the external writes on request (the `dump` message in a debug build is enough; the object-prototype dump of Max, `maxref` generation by Min, is an alternative: use what Min-API already provides and say so).

- [ ] **Step 1: Write failing tests** `test_check_refpages.py` with inline XML and inline JSON fixtures: `missing_entry_is_reported`, `extra_entry_is_reported`, `matching_page_passes`, `malformed_xml_is_a_one_line_error`.
- [ ] **Step 2: Run** `python3 -m unittest discover -s tools/refpages`. Expected: FAIL.
- [ ] **Step 3: Implement** the checker; start each reference page from the old page (same text where the behaviour is unchanged; rewritten where it is not; every change of behaviour recorded in `docs/changes.md`), and migrate the old help patchers, replacing objects that are not in this milestone (`j.remote`, `j.ui`, `j.view`, `j.unit`) with a comment box naming the milestone that brings them.
- [ ] **Step 4: Verify the help patchers open without errors** (extend `run-maxtests.sh` with a mode that opens a `.maxhelp` and writes any `no such object` it can detect through a `js` object that scans the patcher's boxes for error boxes; the in-scope objects must all be found; the replaced ones are comments).
- [ ] **Step 5: Run** the checker for all six objects. Expected: exit 0. **Commit.**

---

### Task 11: Acceptance and record

**Files:**
- Create: `docs/conformance/m1-results.md`
- Modify: `docs/inventory/coverage-baseline.md` (regenerate), `conformance/implemented.txt`, `docs/decisions/0001-shared-state.md` (record the teardown and CRT decisions if not already), `README.md`

- [ ] **Step 1: Full run.** `scripts/run-maxtests.sh conformance/m1-tests.txt <out>`; copy the per-test results into `docs/conformance/m1-results.md` with the totals. Expected: every test PASS except those the document lists with a named cause outside this milestone.
- [ ] **Step 2: Sanitizer and thread run.** Build the core tests with `-fsanitize=address,undefined` and, separately, `-fsanitize=thread` (a test that sets values from two threads while a third creates and removes subscriptions: `concurrent_use_is_race_free` in `namespace_test.cpp`, written first and watched fail against a deliberately unguarded variant if one is easy, otherwise against the sanitizer on the real code). Expected: no reports.
- [ ] **Step 3: Quit-with-live-objects smoke.** A patcher with models, parameters and a running ramp, closed by `;max quit`: through the smoke runner, Expected: Max quits by itself, no crash report.
- [ ] **Step 4: Regenerate the coverage baseline** with the new `implemented.txt`; record which of the 22 objects remain and which milestone each belongs to.
- [ ] **Step 5: Final documentation.** The Doxygen gate, a README update, and a list of every deliberate deviation from the old behaviour in `docs/changes.md` (even if empty, say so). **Commit.**

---

## Self-review notes

- **Spec coverage (milestone 1, section 12):** the namespace tree (Task 3), typed values, ranges, clipmodes (Tasks 4, 5), ramps (Task 7), dataspaces (Task 6), repetition filtering and priorities (Tasks 5, 9), the Max objects (Tasks 8, 9), help patchers (Task 10), conformance tests (Tasks 1, 8, 9, 11). The spec's open items resolved here: `j.view` is deferred to milestone 3 (it shares the `j.model` source in the old code, see `docs/inventory/j.view.md`); the threading rules (Global Constraints); the conformance tooling (`max-test`, Task 1); the teardown rule (Task 3).
- **Deliberately not in this milestone:** `j.send`, `j.receive` (milestone 2); `j.remote`, `j.view`, `j.ui`, presets, file formats (milestone 3); `j.out`, `j.in`, `j.unit`, `j.map`, `j.cue`, `j.namespace`, `j.node` (decide per `docs/inventory/coverage-baseline.md` in the milestone 2 plan); array objects and Max 9 additions (milestone 4); dataspaces other than gain, time, position; ramp functions other than `linear` (the pass-bar set uses only `linear`); audio objects (`j.in~`, `j.out~`) and therefore `Modular/j.model/audio_gain`. The `qmetro` model cannot load completely until milestone 2 (it needs `j.receive` and `j.out`).
- **Open for the user, not guessed:** the author's own patchers for `conformance/set.txt` (still a placeholder); permission to download `max-test` (Task 1 asks); Windows verification waits for a Windows machine.
- **Risks to watch:** Min-API may not accept slash attribute names (Task 8 says what to do); the exact instance-numbering and context-to-address rules are characterised in Tasks 3 and 9 before they are coded; `j.savebang` may need the raw Max API.
