# JamomaMax3 Milestone 0 (Foundations) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** A buildable, tested, documented repository on macOS and Windows with a Max-free core library, a start-up loader that proves one shared namespace per Max process, and an inventory and coverage tool for the old objects.

**Architecture:** A C++20 core in a shared library (`jamoma_core`) with a process-wide `Registry`; a Min-API `j.loader` external in the package's `extensions/` folder attaches to it at Max launch, and every other external links to the same library from the package's `support/` folder. Python tools in `tools/` read the old package's reference pages and patchers to produce the behaviour inventory and a coverage baseline.

**Tech Stack:** C++20, CMake 3.25+, Min-API (git submodule, pinned `ad68697e025d85cf63a6006c593fb7bc6b46f530`) over max-sdk-base (pinned `a9321e86fdb08d03da9fe4053f3accec4a775b6b`), Catch2 v3.8.1 (FetchContent), Doxygen, Python 3 (standard library only) for tools, GitHub Actions.

**Spec:** `docs/superpowers/specs/2026-11-21-jamomamax3-modular-design.md`. Read it first; this plan covers its milestone 0 only. Milestones 1-4 get their own plans after this one's inventory and shared-state decision exist.

## Global Constraints

- Written from scratch; the old code is read to learn behaviour, nothing is copied.
- Targets Max 9 (provisional minimum 9.0); macOS arm64 + x86_64 universal, minimum macOS 12; Windows x64, minimum Windows 10. Both platforms from milestone 0.
- Package folder is named `Jamoma` (`package/Jamoma/`); object names, messages, attributes follow the old ones (`j.*`).
- Min-API externals; core in `core/`, namespace `jamoma`, C++20, **no Max headers**. Min-API's own CMake script is not used (it forces x86_64 and macOS 10.11); use `cmake/JamomaExternal.cmake` against `max-sdk-base`.
- A Min class named `foo_bar` registers as `foo.bar`; the bundle/file must be named `foo.bar.mxo` / `foo.bar.mxe64`. Classes and files are named accordingly.
- **All C++ is Doxygen-documented**: every file has `@file`/`@brief`; every class, function, member and constant has a Doxygen comment; the Doxygen run reports **no warnings** and fails the build if it does.
- Licence **BSD-3-Clause**; every source file starts with `// SPDX-License-Identifier: BSD-3-Clause` and an `SPDX-FileCopyrightText` line.
- Pass bar for later milestones: help patchers + integration tests for the eight in-scope objects (`j.model`, `j.view`, `j.parameter`, `j.message`, `j.return`, `j.send`, `j.receive`, `j.ui`) plus the author's named patchers; first test patch is the `qmetro` model in `Jamoma/patchers/models/data/qmetro/`.
- Old-package sources (read-only reference): `~/Developer/Jamoma/JamomaMax` (patchers, help, `docs/refpages/modular/*.maxref.xml`, `JamomaIntegrationTests/`) and `~/Developer/Jamoma/JamomaMax/JamomaCore/Modular` (library logic).
- Commit steps below run only when the user has asked for commits in this session.

## Review Focus

Failure modes the spec implies but a plain task test would miss, most likely first. Each has a test in the task named.

1. **Package installed at a path with spaces and non-ASCII characters** (macOS `Application Support`, Windows user names such as `Åse`): loader and externals must still find the shared library. Task 3 (macOS) and Task 4 (Windows).
2. **External or loader built against a different core ABI than the installed shared library**: must refuse cleanly with a Max console error, not crash or corrupt state. Task 2 (unit) and Task 3 (loader behaviour).
3. **An external created when the loader never ran** (package installed after Max launched): must still work against one registry and warn once, not crash. Task 2 and Task 3.
4. **Max quits with live objects in an open patcher**: no crash report, exit code 0, registry torn down once. Task 3.
5. **Two externals report the same registry**: if each binary carried its own static copy, state would silently split. Task 3 (the core assertion of the whole milestone).

---

## File Structure

```
JamomaMax3/
  CMakeLists.txt  CMakePresets.json  Doxyfile  LICENSE  README.md  .gitignore  .gitmodules
  .github/workflows/ci.yml
  cmake/JamomaExternal.cmake          one function: jamoma_add_external(NAME SOURCES ...)
  core/CMakeLists.txt
  core/include/jamoma/{export,version,registry}.hpp
  core/src/{version,registry}.cpp
  core/tests/{version_test,registry_test}.cpp
  externals/CMakeLists.txt
  externals/j.loader/{CMakeLists.txt,j.loader.cpp}
  spikes/shared-state/{CMakeLists.txt,j.spike.a.cpp,j.spike.b.cpp,smoke.maxpat}   throwaway, removed in Task 4
  scripts/{max-smoke.sh,max-smoke.ps1}
  tools/inventory/{inventory.py,test_inventory.py}
  tools/conformance/{objects_used.py,test_objects_used.py}
  conformance/set.txt                 the pass-bar patcher list
  docs/inventory/<object>.md          generated, committed
  docs/decisions/0001-shared-state.md
  package/Jamoma/{extensions,externals,support,help,patchers,docs}/   build output + hand-written package files
  third_party/min-api/                git submodule
```

---

### Task 1: Repository skeleton, core library, build checks

**Files:**
- Create: `CMakeLists.txt`, `CMakePresets.json`, `Doxyfile`, `LICENSE`, `README.md`, `.gitignore`, `core/CMakeLists.txt`, `core/include/jamoma/export.hpp`, `core/include/jamoma/version.hpp`, `core/src/version.cpp`, `core/tests/version_test.cpp`
- Add submodule: `third_party/min-api` at the pinned commit (`git submodule add` then `git -C third_party/min-api checkout ad68697e025d85cf63a6006c593fb7bc6b46f530 && git submodule update --init --recursive`)

**Interfaces:**
- Produces: CMake target `jamoma_core` (SHARED, alias `jamoma::core`); `jamoma/export.hpp` macro `JAMOMA_API`; `jamoma/version.hpp`:
  `struct jamoma::Version { int major; int minor; int patch; };`
  `JAMOMA_API Version jamoma::version() noexcept;` (returns 0.0.1)
  `JAMOMA_API int jamoma::abi_version() noexcept;` (returns 1)
  CMake presets `macos` (Xcode, `CMAKE_OSX_ARCHITECTURES=arm64;x86_64`, `CMAKE_OSX_DEPLOYMENT_TARGET=12.0`) and `windows` (Visual Studio 17 2022, x64); targets `jamoma_core_tests` (ctest) and `docs` (Doxygen).

- [ ] **Step 1: Write the failing test** in `core/tests/version_test.cpp` (Catch2): `TEST_CASE("version is 0.0.1")` asserting `jamoma::version().major == 0`, `.minor == 0`, `.patch == 1`; `TEST_CASE("abi version is 1")` asserting `jamoma::abi_version() == 1`.
- [ ] **Step 2: Create the top-level `CMakeLists.txt`** (`project(JamomaMax3 LANGUAGES CXX)`, C++20, `enable_testing()`, `add_subdirectory(core)`), `core/CMakeLists.txt` defining `jamoma_core` as SHARED with hidden symbol visibility and `JAMOMA_API` exporting, and `jamoma_core_tests` built with Catch2 v3.8.1 via `FetchContent`, registered with `catch_discover_tests`. Run: `cmake --preset macos && cmake --build --preset macos --target jamoma_core_tests`. Expected: FAIL to compile (`version.hpp` missing).
- [ ] **Step 3: Implement `version.hpp`/`version.cpp` and `export.hpp`** as specified in Interfaces, with Doxygen on every item.
- [ ] **Step 4: Run** `ctest --preset macos`. Expected: 2 tests PASS.
- [ ] **Step 5: Doxygen gate.** `Doxyfile`: `INPUT = core externals`, `WARN_AS_ERROR = YES`, `WARN_NO_PARAMDOC = YES`, `EXTRACT_ALL = NO`, output to `build/doxygen`. Add custom target `docs` running `doxygen Doxyfile`. Run `cmake --build --preset macos --target docs`. Expected: exit 0, no warnings. Then delete the Doxygen comment from `abi_version` locally and re-run to confirm the target fails; restore it.
- [ ] **Step 6: Add `LICENSE` (BSD-3-Clause, copyright holder as in the git user), `README.md` (what this is, build commands, how to install the package by symlinking `package/Jamoma` into `~/Documents/Max 9/Packages/Jamoma`), `.gitignore` (`build/`, `package/Jamoma/externals/`, `package/Jamoma/extensions/`, `package/Jamoma/support/`).**
- [ ] **Step 7: Commit** (`git add -A && git commit -m "Repository skeleton, core library, Doxygen gate"`).

---

### Task 2: Process-wide registry and ABI check in the core

**Files:**
- Create: `core/include/jamoma/registry.hpp`, `core/src/registry.cpp`, `core/tests/registry_test.cpp`
- Modify: `core/CMakeLists.txt` (add sources/tests)

**Interfaces:**
- Consumes: `JAMOMA_API`, `abi_version()` (Task 1).
- Produces (all in namespace `jamoma`):
  `class JAMOMA_API Registry { public: static Registry& instance() noexcept; std::uint64_t instance_id() const noexcept; bool loader_attached() const noexcept; void attach_loader() noexcept; static bool check_abi(int caller_abi) noexcept; };`
  `instance_id()` is non-zero and constant for the life of the library's load in a process (generate once, at first construction, from a monotonic clock and the object's own address); `check_abi(n)` returns `n == abi_version()`.

- [ ] **Step 1: Write failing tests** in `registry_test.cpp`: `instance_is_a_singleton` (`&Registry::instance() == &Registry::instance()`); `instance_id_is_stable_and_nonzero`; `check_abi_accepts_current_and_rejects_other` (`check_abi(abi_version())` true, `check_abi(abi_version()+1)` false, `check_abi(0)` false); `usable_without_loader` (a fresh process state: `loader_attached()` false and `instance_id()` still non-zero, covering Review Focus 3); `attach_loader_is_idempotent` (two calls leave `loader_attached()` true and `instance_id()` unchanged).
- [ ] **Step 2: Run** `ctest --preset macos -R registry`. Expected: FAIL (not defined).
- [ ] **Step 3: Implement `Registry`** as a function-local-static singleton (thread-safe init), `loader_attached` as `std::atomic<bool>`. Doxygen on everything.
- [ ] **Step 4: Run** `ctest --preset macos` and the `docs` target. Expected: all PASS, docs no warnings.
- [ ] **Step 5: Commit.**

---

### Task 3: External build function, `j.loader`, and the shared-state spike on macOS

**Files:**
- Create: `cmake/JamomaExternal.cmake`, `externals/CMakeLists.txt`, `externals/j.loader/CMakeLists.txt`, `externals/j.loader/j.loader.cpp`, `spikes/shared-state/*`, `scripts/max-smoke.sh`
- Modify: top-level `CMakeLists.txt` (add `cmake/` include, `externals`, `spikes/shared-state`)

**Interfaces:**
- Consumes: `jamoma::core`, `Registry` (Task 2); `third_party/min-api` (Task 1).
- Produces: CMake function `jamoma_add_external(NAME <j.xxx> SOURCES <files...> [EXTENSION])` which builds a Min-API external named exactly `<NAME>` (arm64 + x86_64 on macOS, deployment target 12.0, overriding Min's script), links `jamoma::core`, sets rpath to `@loader_path/../../../support` (macOS) so it finds the shared library in `package/Jamoma/support/`, and writes the bundle to `package/Jamoma/externals/` (or `package/Jamoma/extensions/` with `EXTENSION`); `scripts/max-smoke.sh <patcher> <expected-result-file-content>`: installs `package/Jamoma` as a symlink in `~/Documents/Max 9/Packages/` (name `Jamoma`; **this touches the user's Max folder and removes the symlink afterwards**), launches `/Applications/Max 9/Max.app` with the patcher, waits up to 60 s for the result file, quits Max, compares content, exits non-zero on mismatch or on any new file in `~/Library/Logs/DiagnosticReports/` mentioning Max.

- [ ] **Step 1: Write the loader** `j.loader` (class `j_loader`, registers as `j.loader`, built with `EXTENSION`): at load it calls `Registry::check_abi(jamoma::abi_version())`; on failure it logs a Max console error `"Jamoma: core ABI mismatch"` and does not attach; on success it calls `attach_loader()` and logs `"Jamoma 0.0.1 (abi 1) loaded"` once.
- [ ] **Step 2: Write the spike externals** `j.spike.a` and `j.spike.b` (throwaway, in `spikes/shared-state/`): on a `bang` each outputs `Registry::instance().instance_id()` as a long. Write `smoke.maxpat`: on `loadbang`, bang both, compare the two ids with `==`, and via the Max 9 `js` object write `PASS same-registry` or `FAIL split-registry` to `$TMPDIR/jamoma-smoke.txt`, then send `;max quit`.
- [ ] **Step 3: Build** `cmake --build --preset macos` and confirm both architectures: `lipo -archs package/Jamoma/externals/j.spike.a.mxo/Contents/MacOS/j.spike.a` prints `x86_64 arm64`, and `otool -L` on it shows `libjamoma_core.dylib` via `@rpath` (not an absolute path).
- [ ] **Step 4: Run** `scripts/max-smoke.sh spikes/shared-state/smoke.maxpat "PASS same-registry"`. Expected: exit 0 (Review Focus 5). If the result is `FAIL split-registry`, stop: the decision in section 10 of the spec is wrong; record it in `docs/decisions/0001-shared-state.md` and switch to the one-binary alternative before continuing.
- [ ] **Step 5: Review Focus tests.** Add three variants to the smoke runner and run them: (a) install the package through a symlink whose target path is `~/Documents/Jamoma smoke Åpen/Packages-target/Jamoma` (spaces + non-ASCII; Review Focus 1); (b) a patcher that opens with the loader removed from `extensions/` before launch and the spike externals still present, expecting `PASS same-registry` and one `"loader not attached"` warning logged by the spike externals (Review Focus 3); (c) a patcher whose objects are still alive when `;max quit` runs, expecting exit code 0 and no new crash report (Review Focus 4). Add a unit-level check for Review Focus 2: build a copy of the loader with `abi_version` forced to 2 (compile definition `JAMOMA_TEST_ABI=2` in the loader only) and assert the console shows the mismatch error and `loader_attached()` stays false.
- [ ] **Step 6: Doxygen gate** (`docs` target) over `externals/`; **Commit.**

---

### Task 4: Windows build, CI, Windows spike, and the shared-state decision record

**Files:**
- Create: `.github/workflows/ci.yml`, `scripts/max-smoke.ps1`, `docs/decisions/0001-shared-state.md`
- Modify: `cmake/JamomaExternal.cmake` (Windows branch), `CMakePresets.json` (`windows` preset), `externals/CMakeLists.txt`
- Delete (at the end): `spikes/shared-state/` and its entry in the top-level `CMakeLists.txt`

**Interfaces:**
- Consumes: everything from Tasks 1-3.
- Produces: CI jobs `macos` (macos-latest, preset `macos`) and `windows` (windows-latest, preset `windows`) each running configure, build, `ctest`, and the `docs` target; on Windows `jamoma_add_external` outputs `<NAME>.mxe64` into `package/Jamoma/externals/` (or `extensions/`) and copies `jamoma_core.dll` into `package/Jamoma/support/`; the externals find it through the package layout, not through `PATH` (state the mechanism you choose in the decision record, e.g. delay-loading with `SetDllDirectory` from the loader, or placing the DLL beside each external).

- [ ] **Step 1: Write failing CI** by adding `ci.yml` first; push the branch once the user has created a GitHub remote (there is none yet; ask), or validate locally with `act` if available. Expected: the `windows` job fails to configure.
- [ ] **Step 2: Implement the Windows branch** of `jamoma_add_external` and the `windows` preset; make CI green on both jobs, including `ctest` and `docs`.
- [ ] **Step 3: Windows spike (needs a Windows machine with Max 9; ask the user if none is available).** Write `scripts/max-smoke.ps1` as the PowerShell equivalent of the macOS runner. Run the same smoke patcher, plus the path variant using a user profile path with a space and a non-ASCII character (Review Focus 1), and the quit-with-live-objects variant (Review Focus 4). Expected: `PASS same-registry`.
- [ ] **Step 4: Write `docs/decisions/0001-shared-state.md`**: what was tried, the results on macOS and Windows, the DLL-search mechanism chosen on Windows, and the decision (loader + shared library, or the one-binary alternative if Step 4 of Task 3 failed).
- [ ] **Step 5: Remove the spike** (`spikes/shared-state/`), rebuild on both platforms, confirm CI green; keep `j.loader` and the smoke runners.
- [ ] **Step 6: Commit.**

---

### Task 5: Behaviour inventory of the eight in-scope objects

**Files:**
- Create: `tools/inventory/inventory.py`, `tools/inventory/test_inventory.py`, `docs/inventory/{j.model,j.view,j.parameter,j.message,j.return,j.send,j.receive,j.ui}.md`

**Interfaces:**
- Produces: `inventory.py --old ~/Developer/Jamoma/JamomaMax --out docs/inventory` with functions `parse_maxref(path: pathlib.Path) -> ObjectSpec` where `ObjectSpec` has `name: str`, `digest: str`, `attributes: list[Attribute]`, `messages: list[Message]`, `outlets: list[str]`; `render(spec: ObjectSpec) -> str` (Markdown). `Attribute` has `name, type, size, default, description`; `Message` has `name, args, description`.

- [ ] **Step 1: Write failing tests** in `test_inventory.py` (standard `unittest`, fixture strings inline): `test_parse_maxref_reads_attributes` (a minimal `.maxref.xml` string with one `<attribute name="ramp" ...>` yields one `Attribute` with name `ramp`); `test_parse_maxref_reads_messages`; `test_render_lists_every_attribute_and_message`; `test_real_maxrefs_all_parse` (parses the eight real files under `Jamoma/docs/refpages/modular/` and asserts each yields a non-empty name and at least one attribute or message; skipped with a message if `--old` is absent).
- [ ] **Step 2: Run** `python3 -I -m unittest tools/inventory/test_inventory.py`. Expected: FAIL.
- [ ] **Step 3: Implement** with `xml.etree.ElementTree`; no third-party packages.
- [ ] **Step 4: Run tests; then generate** `docs/inventory/*.md` for the eight objects. Expected: eight files, each listing attributes and messages.
- [ ] **Step 5: Add to each generated file a hand-written section "Semantics from JamomaCore/Modular"** summarising, from the library source in `JamomaCore/Modular/library`, what the attributes and messages actually do (types, clip modes, ramp drivers, dataspaces, repetition filter, priority, presets), citing the source file for each claim, and a final list "Dependencies on the wider modular family" naming every other object or library feature (`j.in`/`j.out`, `j.init`, `j.remote`, dataspace, ramp, preset store) that the behaviour needs. This is reading and writing, not code; it is the input to the milestone 1 plan.
- [ ] **Step 6: Commit.**

---

### Task 6: Conformance object-coverage tool and baseline

**Files:**
- Create: `tools/conformance/objects_used.py`, `tools/conformance/test_objects_used.py`, `conformance/set.txt`, `docs/inventory/coverage-baseline.md`

**Interfaces:**
- Produces: `objects_used.py --old <dir> --set conformance/set.txt --implemented <file>`; functions `objects_in_patcher(path: pathlib.Path) -> set[str]` (every `j.*` object class used, from `maxclass` and the first word of `text` of `newobj` boxes, recursing into subpatchers) and `coverage(used: set[str], implemented: set[str]) -> tuple[set[str], set[str]]` returning `(covered, missing)`. `set.txt` lists one patcher path (relative to `--old`) per line.

- [ ] **Step 1: Write failing tests** with inline `.maxpat` JSON fixtures: `test_finds_class_from_newobj_text`; `test_recurses_into_subpatcher`; `test_ignores_non_j_objects`; `test_coverage_splits_covered_and_missing`.
- [ ] **Step 2: Run** `python3 -I -m unittest tools/conformance/test_objects_used.py`. Expected: FAIL.
- [ ] **Step 3: Implement** with `json` and `argparse` only.
- [ ] **Step 4: Fill `conformance/set.txt`** with: the five qmetro files in `Jamoma/patchers/models/data/qmetro/`, the `.maxhelp` file of each of the eight in-scope objects in `Jamoma/help/`, and the `.maxtest.maxpat` files under `JamomaIntegrationTests/patchers/tests/Modular/j.model` and `.../j.parameter`. Leave a marked placeholder line for the author's own named patchers.
- [ ] **Step 5: Run the tool with `--implemented` pointing at a file containing only `j.loader`** and write the output to `docs/inventory/coverage-baseline.md`: the list of `j.*` objects the pass-bar set needs, which will be the roadmap for milestone 1's scope (everything beyond the eight is a dependency to decide on).
- [ ] **Step 6: Commit.**

---

## Self-review notes

- **Spec coverage:** milestone 0 items (CMake both platforms, CI, core skeleton and test harness, behaviour inventory, shared-state spike on both platforms) map to Tasks 1-6; the Doxygen requirement is enforced in Task 1 and re-checked in Tasks 2 and 3; BSD-3 SPDX headers in Task 1; the first test patch (`qmetro`) is the first entry in Task 6's set; the spec's open items (j.view C++ vs abstraction, threading rules, text field, test tooling for conformance patchers) are deliberately not decided here and are inputs to the milestone 1 plan.
- **Known unknowns the executor must flag, not guess:** whether Min-API's `c74_min_unittest.h` mock harness is wanted for externals later (not used in this milestone); whether the author has a Windows machine with Max 9 (Task 4 Step 3).
- **Not covered here on purpose:** `j.model` and the other seven objects, presets, file formats, Max 9 additions (milestones 1-4).
