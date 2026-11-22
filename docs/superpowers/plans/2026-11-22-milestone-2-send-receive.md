# JamomaMax3 Milestone 2 (the OSC-addressed bus) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `j.send` and `j.receive` run natively in Max 9 and behave as the old objects did over the namespace of milestone 1, together with the small objects the pass-bar set needs next to them (`j.unit`, and the data `j.in` / `j.out` so that the `qmetro` model loads), and the two leftovers of milestone 1 (the `dump` message, the standalone-initialisation quirk).

**Architecture:** The core gains three things: a table of a `Data`'s attributes by name (so a sender can set any attribute and a receiver can read any), observers (of a `Data`'s attributes, and of nodes appearing and disappearing at an address), and two Max-free classes built on them, `Receiver` and `Sender`, ported from the old `TTReceiver` / `TTSender`. The externals stay thin: they resolve a relative address against the model of their patcher and translate Max messages to `Sender` / `Receiver` calls.

**Tech Stack:** As milestone 1: C++20, CMake, Catch2, Min-API, max-test, Python 3 tools.

**Spec:** `docs/superpowers/specs/2026-11-21-jamomamax3-modular-design.md` (sections 8-12). Milestone 1: `docs/superpowers/plans/2026-11-21-milestone-1-namespace-and-data.md`, its results `docs/conformance/m1-results.md`, differences `docs/changes.md`, decisions `docs/decisions/0001-shared-state.md`. Old behaviour: `~/Developer/Jamoma/JamomaMax` (`JamomaCore/Modular/library/source/TTSender.cpp`, `TTReceiver.cpp`, `TTInput.cpp`, `TTOutput.cpp`; `source/j.send`, `j.receive`, `j.in`, `j.out`, `j.unit`).

## Global Constraints

Everything in the milestone 1 plan's Global Constraints still holds (clean-room, Max 9, macOS arm64 + x86_64 from macOS 12, Windows x64 untested but compiling by construction, old names and OSC semantics, core without Max headers, all C++ Doxygen-documented with no warnings, BSD-3-Clause SPDX headers, the rules of `0001-shared-state.md`). Added by what milestone 1 taught:

- **A Min object's state is declared before its attributes.** Min runs every attribute setter with its default during construction, in declaration order; anything a setter uses must already exist. (`data_object` and `j.model` both crashed Max on this.) Every Min object also starts its constructor with `if (c74::min::dummy()) return;` (Min builds one instance without a Max object while it sets the class up) and unsubscribes in its destructor before any member goes.
- Min's documentation stubs stay off: `const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };` in every Min class.
- Sanitizer builds use their own package folder (`-DJAMOMA_PACKAGE_DIR=$PWD/build/<name>/package`), never `package/Jamoma`.
- **Max is used only through the runners, which the user can see:** announce in a message before anything that launches Max and after it has closed; never run two Max launches at once; the runner's temporary links are removed on every exit path (check `~/Documents/Max 9/Packages` after an aborted run); Max is never force-quit by a script except as the runner's documented last resort.
- Values are compared as old patchers see them (messages and values in order at the outlets); float formatting and exact timing are not part of the bar.
- Deliberate differences go into `docs/changes.md`; every ruling into the ledger.

## Review Focus

Failure modes the spec implies that ordinary task tests would miss, most likely first. Each gets a test in the task named.

1. **A receiver or sender bound to a node that goes away and comes back** (the target `j.parameter` deleted, re-created, renamed with `address`, its model replaced): no output from freed memory, the receiver picks the new node up and outputs its value once. Tasks 4, 5, 6.
2. **Feedback loops:** a `j.receive` wired to the `j.send` that drives the same parameter, and two parameters bound to each other through sender and receiver. The old objects guard with a sending flag; the new ones must neither recurse without end nor drop the first value. Tasks 5, 6, 8.
3. **Wildcard addresses** (`/model/*`, `/model/p.*`, `/*/gain`) that match nothing, then something, then many; and an address whose last segment is an attribute (`/m/p:range`, `/m/p:value`, an unknown attribute). Tasks 4, 5, 6.
4. **Relative addresses:** the same patch loaded twice (two models named alike get `name` and `name.1`), a `j.send` outside any model, a `j.send` inside a subpatcher of a model, and the model arriving after the receiver is created. Tasks 7, 8.
5. **Teardown with live bindings:** patcher closed, Max quit, `address` changed or a model freed while a ramp tick or a notification is in flight, on the main and the scheduler thread. Tasks 4, 5, 6, 12.

---

## File Structure

```
core/include/jamoma/{data,namespace,receiver,sender}.hpp       data.hpp and namespace.hpp gain APIs; receiver/sender are new
core/src/{data,namespace,receiver,sender,dataspace}.cpp
core/tests/{data,namespace,receiver,sender,dataspace}_test.cpp
externals/common/{max_context,max_address}.hpp                 max_address.hpp: resolve relative addresses against the model
externals/j.send/ j.receive/ j.unit/ j.in/ j.out/              one folder each (CMakeLists.txt + one .cpp)
tests/max/patchers/*.maxtest.maxpat                            own tests (listed in conformance/own-tests.txt)
conformance/{m2-tests.txt,own-tests.txt,implemented.txt}
package/Jamoma/{help,docs/refpages}/                           help patchers and reference pages of the new objects
docs/inventory/{send-receive.md,j.in-j.out.md,j.unit.md}       characterisation notes (Task 1)
docs/conformance/m2-results.md, docs/changes.md                results and differences (Task 12)
```

---

### Task 1: Characterise, choose the conformance set, baseline

**Files:**
- Create: `docs/inventory/send-receive.md`, `docs/inventory/j.in-j.out.md`, `docs/inventory/j.unit.md`, `conformance/m2-tests.txt`
- Modify: `conformance/own-tests.txt` (nothing yet), `docs/inventory/coverage-baseline.md` (regenerated in Task 12)

**Interfaces:**
- Produces: the three notes, each ending with a **Rulings** list that later tasks cite by name: the exact semantics of address resolution (relative to model, `.` and `..`, wildcard), attribute addresses and what a sender does for each kind of target (`Data` value: command; `Data` attribute: set; message: call), the receiver's output on binding (value once if active and non-empty, then on every change), what it outputs on its address outlet, `active`, `grab` and `get`, behaviour on node creation/destruction, the sending guard; for `j.out` / `j.in` (data only, no audio): their arguments, attributes (`mute`, `gain`, `mix`, `freeze`, `type`; `bypass`) and the nodes they register in the model; for `j.unit`: arguments, attributes, messages (`dataspaces.get`, `units.get`), outlets, default dataspace and which dataspaces the old library has beyond gain, time and position.
- Produces: `conformance/m2-tests.txt`: the three `j.unit` tests that failed in milestone 1 (`type_array/dataspace/*aed2xyz*`, `*xyz2aed*`, `ramp_dataspace/*ramp_and_dataspace*`) and the `Modular/j.remote`-free tests that use `j.send`/`j.receive`/`j.in`/`j.out` if any exist (list found by `grep -l 'j\.\(send\|receive\|in\|out\) ' ` over `JamomaIntegrationTests`; the old suite has none for `j.send`/`j.receive`, so say so in the note), plus the qmetro model as a load-only check handled in Task 12.

- [ ] **Step 1: Read** `TTSender.cpp`, `TTReceiver.cpp`, `TTInput.cpp`, `TTOutput.cpp`, `source/j.send|j.receive|j.in|j.out|j.unit`, the old reference pages and help patchers of these five objects, and `qmetro.model.maxpat`; write the three notes with file and line for every rule. Anything not read is marked "to characterise", never guessed.
- [ ] **Step 2: Write `conformance/m2-tests.txt`** (format as `m1-tests.txt`).
- [ ] **Step 3: Baseline.** Run `scripts/run-maxtests.sh conformance/m2-tests.txt build/maxtests-m2-baseline` (announce Max use first). Expected: the three `j.unit` tests FAIL with "missing objects: j.unit". Commit the notes and the list.

---

### Task 2: Carry-overs from milestone 1

**Files:**
- Modify: `externals/common/data_object.hpp`, `externals/j.model/j.model.cpp`, `core/src/data.cpp` as the findings require
- Create: `tests/max/patchers/standalone_init.maxtest.maxpat`, `tests/max/patchers/dump.maxtest.maxpat`
- Modify: `conformance/own-tests.txt`, `docs/changes.md`

**Interfaces:**
- Consumes: milestone 1 `Data::init()`, `Model::init()`, the attribute table in `data_object.hpp` (moved in Task 3, so this task adds `dump` against the current table and Task 3 keeps its behaviour).
- Produces: message `dump` on `j.parameter`, `j.message`, `j.return` (the current value of every attribute, each as `<attribute> <value>` on the dumpout, in table order) and on `j.model` (`description`, `priority`, `amenities`).

- [ ] **Step 1: Find the cause of the integer failure.** The old test `type_integer/repetitions/*receive_symbols*` counts three outputs from a standalone `j.parameter` (the test's comment: one from initialisation, two from the test). Read how the old Max wrapper (`source/j.parameter`, `TTClassWrapperMax`) and `TTData` initialise an object with no model; record the rule in the ledger. If the old object initialises itself after creation when there is no model: write the failing test `standalone_init` (a `j.parameter p @type integer` in a patcher with no `j.model` outputs `0` once after load; with a `j.model` it outputs only when the model initialises) and watch it fail.
- [ ] **Step 2: Implement** the rule in `data_object.hpp` (the deferred `join_model()` already runs after load: if no model was found, call `data_.init()`; a model's `init` still initialises its members). Run the old test `type_integer/repetitions/*receive_symbols*` and the 78 old milestone 1 tests: Expected: that test passes and nothing else changes.
- [ ] **Step 3: `dump`.** Write the failing own test (`dump.maxtest.maxpat`: send `dump` to a `j.parameter @type integer @range 0 10`, collect the dumpout lines with `zl group`, assert the `type`, `range` and `value` lines). Implement `message<> dump` in `data_object` and `j_model`. Update the reference pages' removed `dump` entries in Task 11.
- [ ] **Step 4: Run** unit tests, both own tests, the 82 old tests (announce Max use). Commit.

---

### Task 3: The attribute table moves into the core

**Files:**
- Modify: `core/include/jamoma/data.hpp`, `core/src/data.cpp`, `externals/common/data_object.hpp`, `tools/refpages/check_refpages.py` (+ its test)
- Test: `core/tests/data_test.cpp`

**Interfaces:**
- Produces on `jamoma::Data`:
  `static const std::vector<std::string>& attribute_names();` (the 18 names, in the order of the current `ATTRIBUTE_NAMES`)
  `bool has_attribute(std::string_view name) const;`
  `std::optional<Value> get_attribute(std::string_view name) const;` (empty optional: unknown name)
  `bool set_attribute(std::string_view name, const Value& value);` (false: unknown or read-only name; sets through the same setters as the Max attributes, so `value` is a command)
- Consumes: the existing setters/getters of `Data`.

- [ ] **Step 1: Write failing tests** `attribute_table_lists_the_names_in_order`, `get_attribute_returns_each_current_value` (type, range, clipmode, `repetitions/filter`, default, stepsize, active, priority, description, tags, dataspace, unit, `ramp/drive`, `ramp/function`, `ramp/status`, value, service: for a data object set to non-default values; assert each), `set_attribute_applies_and_rejects_read_only` (`ramp/status`, `service`, `ramp/function/parameters` return false and change nothing), `unknown_attribute_is_reported`.
- [ ] **Step 2: Run, expect failure** (`ctest --preset macos -R attribute`).
- [ ] **Step 3: Implement** the four members in `data.cpp` by moving the `get_attr` / `set_attr` switch bodies of `data_object.hpp` (value formats exactly as today: `none` for an empty dataspace/unit, 0/1 for booleans, `value` empty until initialised); `data_object.hpp` then calls them and keeps only the Max-side translation. The checker reads `attribute_names()` from `core/src/data.cpp` instead of `ATTRIBUTE_NAMES`; update `scan_source` and its test.
- [ ] **Step 4: Run** unit tests, the checker and the 78 old tests (announce Max use). Commit.

---

### Task 4: Observers in the core

**Files:**
- Modify: `core/include/jamoma/data.hpp`, `core/include/jamoma/namespace.hpp`, `core/src/data.cpp`, `core/src/namespace.cpp`
- Test: `core/tests/data_test.cpp`, `core/tests/namespace_test.cpp`

**Interfaces:**
- Produces on `Data`: `std::shared_ptr<void> observe(std::string_view attribute, std::function<void(const Value&)> callback);` The callback runs on whichever thread changed the attribute, after the lock is released, with the new value of that attribute; for `value` it runs for every value that is output (so also ramp ticks). Dropping the handle unregisters; a handle that outlives its `Data` is harmless. An unknown attribute returns an empty handle.
- Produces on `Namespace`: `std::shared_ptr<void> observe(const Address& pattern, std::function<void(const Address& address, Object* object, bool created)> callback);` The callback runs on the thread that subscribes or unsubscribes, after the lock is released, once per matching node whose object appears (`created == true`, `object` valid) or goes (`false`, `object` null); `pattern` follows `Namespace::find` (instance `*` matches any); an object attached to an existing node counts as created. Dropping the handle unregisters.
- Consumes: `Namespace::find` rules of milestone 1.

- [ ] **Step 1: Write failing tests:** `data_observer_hears_value_and_ramp_ticks` (ManualClock ramp of 4 ticks: one callback per output, last value exact), `data_observer_hears_other_attributes` (`range`, `unit`, `active`), `observer_handle_unregisters_and_survives_data` (handle destroyed after the `Data`; no crash), `namespace_observer_hears_created_and_destroyed` (subscribe, attach to an existing empty node, unsubscribe), `namespace_observer_wildcard` (`/m/*` sees `/m/a` and `/m/b.1`, not `/n/a`), `observer_may_unsubscribe_itself_in_its_callback`, and under the thread sanitizer `concurrent_observers_are_race_free` (one thread subscribes/unsubscribes, one sets values, one adds and drops observers).
- [ ] **Step 2: Run, expect failure.**
- [ ] **Step 3: Implement.** Observer lists live beside the state they watch; callbacks are called from a copy of the list taken under the lock (the milestone 1 `Model::Impl::notify` pattern); a `Data` notifies after its guard and lock are released so that an observer may send a command.
- [ ] **Step 4: Run** unit tests, ASan/UBSan and TSan builds (own package folders). Commit.

---

### Task 5: `Receiver`

**Files:**
- Create: `core/include/jamoma/receiver.hpp`, `core/src/receiver.cpp`, `core/tests/receiver_test.cpp`
- Modify: `core/CMakeLists.txt`

**Interfaces:**
- Consumes: `Namespace::find`, `Namespace::observe`, `Data::observe`, `Data::get_attribute` (Tasks 3, 4), the rules in `docs/inventory/send-receive.md`.
- Produces:
```cpp
class JAMOMA_API Receiver {
public:
    Receiver(Namespace& ns,
             std::function<void(const Address&)> on_address,
             std::function<void(const Value&)> on_value);
    ~Receiver();
    void set_address(const Address& address);   // rebinds; empty address unbinds
    Address address() const;
    void set_active(bool on);                   // default true
    bool active() const;
    bool bang();                                // outputs the current value of the first bound node; false if none or empty
    std::optional<Value> grab() const;          // current value of the first bound node, no output
};
```
The attribute is the address's attribute part, default `value`. On binding, for every matching node whose object is a `Data` (or has the attribute) and while active: output its address (with `:attribute` unless value) then its value, if non-empty; afterwards on every observed change: address then value. A node that appears later is bound and output once; a node that goes is dropped without output. While `set_address` runs and while a binding is being torn down no output happens. `:created` and `:destroyed` attributes report node life cycle (address, `1` / `0`) instead of values (old `TTReceiver::bindAddress`).

- [ ] **Step 1: Write failing tests:** `binds_existing_node_and_outputs_value_once`, `outputs_address_then_value_on_change`, `inactive_receiver_is_silent_until_banged`, `late_node_is_bound_and_output_once`, `node_deleted_then_recreated_is_followed` (Review Focus 1), `rebinding_address_stops_old_binding`, `wildcard_binds_every_match_and_reports_each_address`, `attribute_address_follows_range`, `created_and_destroyed_attributes`, `empty_value_is_not_output`, `destroying_receiver_inside_its_callback_is_safe`, `receiver_outliving_namespace_is_safe`.
- [ ] **Step 2: Run, expect failure.**
- [ ] **Step 3: Implement** `Receiver` with a `Pimpl` guarded by a mutex held only to change bindings, never while calling out; callbacks hold a weak reference to the state (the `Data` pattern of milestone 1).
- [ ] **Step 4: Run** unit tests and both sanitizer builds. Commit.

---

### Task 6: `Sender`

**Files:**
- Create: `core/include/jamoma/sender.hpp`, `core/src/sender.cpp`, `core/tests/sender_test.cpp`
- Modify: `core/CMakeLists.txt`

**Interfaces:**
- Consumes: `Namespace::find`, `Data::command`, `Data::set_attribute`, `Namespace::observe`.
- Produces:
```cpp
class JAMOMA_API Sender {
public:
    explicit Sender(Namespace& ns);
    void set_address(const Address& address);   // empty address: sends go nowhere
    Address address() const;
    bool send(const Value& value);              // false if nothing was reached
};
```
Per matching node, by the attribute part of the address (default `value`): a `Data` and attribute `value` gets `Data::command(value)`; any other `Data` attribute gets `Data::set_attribute`; a node whose object is a `Model` and attribute `value` forwards a message to the member whose address is the first symbol (old `TTSender::Send`, container case; record in the ledger what Task 1 found); an unknown attribute reaches nothing. A send while this sender is already sending (its own output coming back) is dropped (the old `mIsSending` guard) and does not block other senders.

- [ ] **Step 1: Write failing tests:** `value_reaches_parameter_as_a_command` (a ramp command `100. ramp 200` starts a ramp), `attribute_address_sets_the_attribute` (`/m/p:range`), `wildcard_reaches_every_match`, `unknown_target_returns_false`, `deleted_target_is_not_touched` (Review Focus 1), `recursion_through_receiver_is_dropped_once` (a `Receiver` on `/m/p` whose callback sends to `/m/p` again: terminates, the first value is delivered, Review Focus 2), `two_parameters_bound_through_sender_and_receiver_settle` (A to B and B to A with `repetitions/filter 1`: terminates with equal values).
- [ ] **Step 2: Run, expect failure.**
- [ ] **Step 3: Implement** with the guard as an atomic flag per sender.
- [ ] **Step 4: Run** unit tests and both sanitizer builds. Commit.

---

### Task 7: Relative addresses and `j.receive`

**Files:**
- Create: `externals/common/max_address.hpp`, `externals/j.receive/{CMakeLists.txt,j.receive.cpp}`, `tests/max/patchers/receive_basic.maxtest.maxpat`, `receive_relative.maxtest.maxpat`, `receive_feedback.maxtest.maxpat`
- Modify: `externals/CMakeLists.txt`, `conformance/own-tests.txt`, `conformance/implemented.txt`
- Test: `core/tests/address_test.cpp` for the pure part

**Interfaces:**
- Produces in `core`: `Address resolve_relative(const Address& address, const Address& model_address);` (pure, in `address.hpp`): an absolute address is unchanged; a relative one is appended to the model address; the rules of `docs/inventory/send-receive.md` for `.`, `..` and a leading `/`.
- Produces in `max_address.hpp`: `jamoma::Address resolve_in_patcher(c74::max::t_object* box, const std::string& text);` finds the model by `find_model` and applies `resolve_relative`; with no model the address is taken from the root.
- Produces: object `j.receive` (outlets: 0 value, 1 address of the bound node, 2 dumpout; argument: the address; attributes `address`, `active`; messages `bang`, `dump`, `address <symbol>`; inlet message that sets the address, as the old help patcher).

- [ ] **Step 1: Write failing core tests** `resolve_relative_*` (absolute stays, relative appended, `..` climbs, empty stays empty).
- [ ] **Step 2: Write failing Max tests** (own, Review Focus 2-4): `receive_basic` (`j.model` + `j.parameter a @type integer` + `j.receive a`: after load the value outlet gets `0` once; setting `a` to 5 outputs `5`; the address outlet says `/<model>/a`); `receive_relative` (the same patcher abstraction loaded twice: each receiver follows its own model); `receive_feedback` (a `j.receive` wired to a `j.send` to the same parameter terminates and outputs once per change).
- [ ] **Step 3: Implement** `resolve_relative`; `j.receive` as a Min object (state before attributes, dummy guard, destructor unsubscribes: Global Constraints). It binds in a deferred call after the patcher has loaded (as `data_object::join_model`), re-resolves when its model appears, drops its `Receiver` before the outlets go, and writes its output on the main thread by deferring when the value arrives on another thread (note the rule in the ledger).
- [ ] **Step 4: Run** unit tests, sanitizers, own tests (announce Max use). Commit.

---

### Task 8: `j.send`

**Files:**
- Create: `externals/j.send/{CMakeLists.txt,j.send.cpp}`, `tests/max/patchers/send_basic.maxtest.maxpat`, `send_attribute.maxtest.maxpat`, `send_relative.maxtest.maxpat`
- Modify: `externals/CMakeLists.txt`, `conformance/own-tests.txt`, `conformance/implemented.txt`

**Interfaces:**
- Consumes: `Sender` (Task 6), `resolve_in_patcher` (Task 7).
- Produces: object `j.send` (inlet: anything; outlet 0: the absolute address of the target after it is resolved; argument: the address; attribute `address`; messages `bang`, `int`, `float`, `list`, `anything`, `symbol`, `address <symbol>`, `dump`).

- [ ] **Step 1: Write failing own tests:** `send_basic` (a value sent to `j.send a` reaches `a`, whose output is observed through a `j.receive`), `send_attribute` (`j.send a:range` with `0 10` changes the range, then `20` is clipped to 10), `send_relative` (two copies of one model patcher: a relative send reaches only its own model).
- [ ] **Step 2: Run, expect failure** (announce Max use).
- [ ] **Step 3: Implement** like Task 7: deferred binding, resolved again when the model appears; `symbol` forwards the symbol; messages that Max delivers as `symbol <name>` are unwrapped as in `data_object`.
- [ ] **Step 4: Run** the own tests. Commit.

---

### Task 9: `temperature` dataspace and `j.unit`

**Files:**
- Modify: `core/src/dataspace.cpp`, `core/tests/dataspace_test.cpp`
- Create: `externals/j.unit/{CMakeLists.txt,j.unit.cpp}`, `tests/max/patchers/unit_basic.maxtest.maxpat`
- Modify: `externals/CMakeLists.txt`, `conformance/own-tests.txt`, `conformance/implemented.txt`, `docs/inventory/j.unit.md` (rulings)

**Interfaces:**
- Consumes: `Dataspace::find`, `Dataspace::convert` (milestone 1).
- Produces: dataspace `temperature` (units from the old `TemperatureDataspace`, as Task 1 lists them; formulas read from the old source) and any other dataspace Task 1 found necessary for `j.unit`'s default; object `j.unit` (attributes `dataspace` (default as the old object), `input`, `output`; messages `int`, `float`, `list`, `dataspaces.get`, `units.get`; outlet 0: converted value, outlet 1: dumpout where `DataspacesMenu` / `UnitsMenu` lines go).

- [ ] **Step 1: Write failing tests:** `temperature_celsius_fahrenheit_kelvin` (the cases of the old `TemperatureDataspace.test.cpp`), `j.unit` own test `unit_basic` (`j.unit @dataspace gain @input db @output linear`: `-6.` gives `0.501187`, within 1e-6 as the old tests; `@dataspace position @input aed @output xyz` converts a list).
- [ ] **Step 2: Run, expect failure.**
- [ ] **Step 3: Implement** the dataspace table entry and the object; unknown unit or dataspace: no output and one console error (the old behaviour recorded in Task 1).
- [ ] **Step 4: Run** unit tests and the three old `j.unit` tests of `conformance/m2-tests.txt` (announce Max use). Expected: PASS. Commit.

---

### Task 10: `j.out` and `j.in` (data)

**Files:**
- Create: `externals/j.out/`, `externals/j.in/` (CMakeLists.txt + one .cpp each), `tests/max/patchers/in_out.maxtest.maxpat`
- Modify: `externals/CMakeLists.txt`, `conformance/own-tests.txt`, `conformance/implemented.txt`

**Interfaces:**
- Consumes: the rulings of `docs/inventory/j.in-j.out.md` (Task 1): arguments, the node each registers in the model (name, attributes), the attributes `mute`, `gain`, `mix`, `freeze`, `type` (`j.out`) and `bypass`, `mute`, `type` (`j.in`) that the data variants honour.
- Produces: objects `j.in` and `j.out` that pass data through the model boundary as the old data variants did, and register their node so that `j.send` / `j.receive` and the namespace see it. Audio (`j.in~`, `j.out~`) is not built (milestone 4 with MC).

- [ ] **Step 1: Write the failing own test** `in_out` from the rulings (a model abstraction with `j.in 1` and `j.out 1`: a value into the abstraction comes out, `mute 1` silences it, a `j.receive` on the registered node address sees its attributes).
- [ ] **Step 2: Run, expect failure** (announce Max use).
- [ ] **Step 3: Implement** both objects as Min objects with the Global Constraints rules.
- [ ] **Step 4: Run** the own tests. Commit.

---

### Task 11: Help patchers and reference pages

**Files:**
- Create: `package/Jamoma/help/{j.send,j.receive,j.unit,j.in,j.out}.maxhelp`, `package/Jamoma/docs/refpages/{modular,data}/{...}.maxref.xml`
- Modify: `tools/refpages/{check_refpages.py,migrate_refpages.py,migrate_help.py}` (object list and source map: add the five, `core/src/data.cpp` as a source of the attribute names), `package/Jamoma/docs/refpages/modular/{j.parameter,j.message,j.return,j.model}.maxref.xml` (restore the `dump` entries)

**Interfaces:**
- Consumes: the three scripts of milestone 1; `conformance/implemented.txt` (so help patchers of milestone 1 objects now show `j.send`, `j.receive`, `j.unit` and not comments).

- [ ] **Step 1: Extend** `OBJECT_SOURCES` in `check_refpages.py` and add a failing unit test (`new_objects_are_checked`); run, expect failure; implement.
- [ ] **Step 2: Migrate** the pages and help patchers with the scripts; regenerate the milestone 1 help patchers (their comment boxes for the now implemented objects become the objects).
- [ ] **Step 3: Run** `check_refpages.py` (exit 0) and `scripts/check-help.sh` (every help patcher OK; announce Max use). Commit.

---

### Task 12: Acceptance and record

**Files:**
- Create: `docs/conformance/m2-results.md`
- Modify: `docs/changes.md`, `README.md`, `docs/inventory/coverage-baseline.md` (regenerate), `docs/decisions/0001-shared-state.md` (observers, threading of callbacks)

- [ ] **Step 1: Full runs** (announce Max use; one at a time): the milestone 1 list (`conformance/m1-tests.txt`, expect all but the `j.unit` ones to stay as in `m1-results.md`, those now passing), `conformance/m2-tests.txt`, own tests, `scripts/check-help.sh`, the quit smoke (`scripts/max-smoke.sh tests/smoke/quit_live_objects`, extended with a `j.send` / `j.receive` pair on a running ramp), and the load-only check of `qmetro.model.maxpat` (open it through the help-opening tool; the only missing objects allowed are the milestone 3 ones).
- [ ] **Step 2: Sanitizers:** unit tests under ASan/UBSan and TSan (own package folders), no reports.
- [ ] **Step 3: Windows.** There is no Windows machine yet: list in `m2-results.md` what must be run there (unit tests, `max-smoke.ps1`, the conformance lists) and that conformance on Windows is due after this milestone (spec section 12).
- [ ] **Step 4: Documentation:** Doxygen gate with no warnings, README status, regenerated coverage baseline (which of the remaining objects `j.map`, `j.cue`, `j.namespace`, `j.node` belong to which milestone: `j.cue` needs presets (milestone 3), `j.namespace` and `j.node` serve the UI and are decided in the milestone 3 plan, `j.map` in milestone 4), every difference in `docs/changes.md`.
- [ ] **Step 5: Whole-branch review** by a fresh read-only reviewer on the most capable model, fix the findings, then finish the branch. **Commit.**

---

## Self-review notes

- **Spec coverage (section 12, milestone 2):** `j.send` / `j.receive` (Tasks 5-8), conformance (Tasks 1, 12). The spec's section 8 pulls in what the old versions need from the family: `j.unit` (Task 9) and `j.in` / `j.out` (Task 10) for the help patchers and `qmetro`, the namespace and `Data` observers (Task 4). Windows conformance is named but cannot run without a machine (Task 12).
- **Deliberately not in this milestone:** network OSC (`j.oscroute`, `j.oscinstance`, remote applications and the `directory:` part of addresses beyond parsing), `j.remote`, `j.view`, `j.ui`, presets (milestone 3); `j.map`, `j.cue`, `j.namespace`, `j.node` (milestones 3 and 4, see Task 12); audio objects (`j.in~`, `j.out~`, the `dsp` methods of `j.send` / `j.receive`) and arrays (milestone 4); nested model addresses (milestone 3, with `j.view`).
- **Open for the user, not guessed:** the author's own patchers for `conformance/set.txt` (still a placeholder); a Windows machine for the conformance runs.
- **Risks to watch:** the old suite has no integration tests for `j.send` / `j.receive` / `j.in` / `j.out`, so acceptance leans on the own tests written from the old source and on the help patchers; Task 1 must therefore read the old behaviour carefully and the notes are the only record of it. Observers add callbacks that may arrive on the scheduler thread (ramp ticks): the Max objects must defer output to the main thread. The old help patchers of `j.send` / `j.receive` need `j.view` and `j.remote` (comment boxes until milestone 3).
