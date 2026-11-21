# JamomaMax3: design for the modular framework

Status: draft for approval. Date: 2026-11-21. Nothing in this repository is built yet; this document is the first file in it.

## 1. Intent

Jamoma for Max (JamomaMax, last released around 2016, with the JamomaCore libraries) gave Max patchers a model-view-controller structure: a *model* owns a tree of parameters, messages and return values in an OSC-addressable namespace, and *views* (a generic UI, remotes, `j.send`/`j.receive`) read and drive that tree. The code is ten years old, was never built for Apple Silicon, predates modern C++, and is hard to read and debug.

JamomaMax3 is a clean-room rewrite, written from scratch, as a Max package for **Max 9** on **current macOS (arm64 and x86_64) and Windows (x64)**. It keeps what patchers can see and replaces everything underneath. The author wants it so that existing patchers keep working, and so that patchers written in the future can use newer Max features.

This document covers the first stage only: the **modular framework**. DSP objects, spatial objects (`j.dbap`, `j.vimic~`, and others) and AudioGraph come later and are out of scope here (see non-goals).

## 2. Goals

1. **Drop-in compatibility for patchers.** Existing patchers and abstractions that use the in-scope objects load and behave the same, with no edits. This includes the names, messages, attributes, outlets, OSC address semantics and saved file formats of the in-scope objects.
2. **Native on Max 9.** arm64 and x86_64 macOS, x64 Windows, current compilers. No Rosetta, no legacy SDK.
3. **Readable, debuggable C++.** A small, well-named codebase in modern C++ that one person can hold in their head, with behaviour that can be tested without launching Max.
4. **Max 9 features, additively.** New attributes and messages for the newer JavaScript engine, dictionaries and JSON, and MC (multichannel), and any other newer Max feature that improves behaviour. These never change the meaning of old ones.
5. **Efficiency.** Lock-free or low-contention paths where the namespace is read at high rates; no per-message heap churn where it can be avoided.

## 3. Non-goals

- Not a port: the old class structure (TTBlue, TTNodeDirectory, class wrapper) is not reproduced.
- No DSP, spatial or score objects in this stage. AudioGraph is not rewritten at all: Max's native MC (multichannel patch cords) is expected to make it redundant.
- No **OSSIA** support in stage 1, but it is an **intended later goal** (author's decision): the core's namespace, node and value model must not rule out an OSSIA-compatible protocol backend later. OSSIA support itself is a separate project after this stage.
- No Pure Data support in stage 1. It "might be relevant in the future" (author's words); the Max-free core makes it possible, and nothing more is done for it now.
- No Minuit support.
- No support for Max 8 or earlier, and no 32-bit builds.
- No redesign of the user-facing model of Jamoma.

## 4. Anti-goals (what would make this a failure even if it technically works)

- Old patchers need hand-editing to load.
- Two behaviours exist side by side with no clear rule for which wins.
- The core becomes tangled with the Max API so it can only be tested inside Max.
- The code ends up as hard to read as the old one.

## 5. Constraints

- Written from scratch. The old code is read to learn behaviour; nothing is copied.
- Package folder is named `Jamoma`, because old abstractions locate their resources through it. This means the new package cannot be installed beside the old one (same object names). The old one does not load on Apple Silicon in any case.
- Min-API for the externals (decided below), the Max SDK base from Cycling '74, CMake as the build system, current Xcode and Visual Studio.
- **All C++ is Doxygen-documented** (author's decision): every file has a `@file`/`@brief` block, and every class, function, member and constant has a Doxygen comment. The Doxygen run is part of the build checks and must report no warnings. Max reference pages (`.maxref.xml`) and help patchers are documented separately, as Max requires.

## 6. Approaches considered

- **A. Pure C++ core plus thin Min-API externals (chosen).** A Max-free C++ library holds the namespace tree, nodes, typed values, ramps, the send/receive bus, presets and file readers/writers. Each external is a thin layer translating Max messages into core calls. The core is unit-tested with `ctest` without Max. Trade-off: the core has to be designed carefully before any external works.
- **B. Raw Max C SDK with our own C++ wrapper.** Full control over every Max detail, but we would write and maintain the boilerplate that Min-API already provides.
- **C. Modernise JamomaCore in place.** Not from scratch, and it inherits the structure the author finds hard to read.

The author chose A.

## 7. Evidence from the `j.ui` spike (2026-11-21)

A throwaway Min-API UI object was built (arm64, Xcode 27, Min-API `main`) and loaded in Max 9.2.2. Results:

- Works: `paint`, `oksize`, `mousedown`, `mousedragdelta`, `mouseup`, `mousemove`, `mouseenter`, `mouseleave`, `mousedoubleclick`, attributes (including colours).
- Not available: `jbox_get_textfield` returns NULL, because Min does not set `JBOX_TEXTFIELD`. The old `j.ui` uses a text field. Options: draw text ourselves, or carry a small patch to Min's UI operator.
- Untested: `mousewheel`, `edclose`.
- Min's own CMake script defaults to x86_64 and forces a macOS 10.11 deployment target that current Xcode rejects. The project uses its own CMake against `max-sdk-base`.
- A Min class named `jspike_ui` registers as `jspike.ui`; the bundle file must be named the same (`jspike.ui.mxo`). The real project names classes and files accordingly.

## 8. Scope of the first stage

Objects, in this order of dependency: `j.model`, `j.parameter`, `j.message`, `j.return`, `j.send`, `j.receive`, `j.view`, `j.ui` (with presets). Whatever the old versions of these objects need from the rest of the modular family to behave the same (for example `j.in`/`j.out`, `j.init`, `j.remote`, ramps and dataspaces used by `j.parameter`) is pulled in only as far as required and recorded as a dependency, not built as a goal.

## 9. Compatibility contract

**Preserved:** object names, argument and attribute names and defaults, message names, outlet order and meaning, OSC address semantics, saved file formats (presets, namespace and layout XML where the in-scope objects read or write them), the package folder name.

**Free:** everything inside; the internal data structures; the threading model; any documented bug, provided it is listed in a changes file with the old and new behaviour.

**Additive only:** new attributes and messages for Max 9 features. The old surface is never altered by them.

**Sources of truth for old behaviour, in order of trust:**
1. The Modular library in JamomaCore (`~/Developer/Jamoma/JamomaMax/JamomaCore/Modular`): the logic for `j.parameter`, `j.message`, `j.return`, `j.view`, `j.send`, `j.receive` lives here, and the Max objects are thin wrappers around it.
2. The reference pages `Jamoma/docs/refpages/modular/*.maxref.xml` (messages, attributes, descriptions).
3. The help patchers (`Jamoma/help/*.maxhelp`) and the 783 patchers in `Jamoma/patchers/` (the in-scope objects as used in practice).
4. The existing integration tests in `JamomaIntegrationTests/` (Max test patchers; `j.parameter` and `j.model` already have cases).

**First test patch (author's choice):** the `qmetro` model in `Jamoma/patchers/models/data/qmetro/` (`qmetro.model.maxpat`, `qmetro.view.maxpat`, `qmetro.module.maxpat`, `qmetro.model.presets.txt`, `qmetro.model.maxhelp`), together with the help files of the in-scope objects. It exercises a model, its parameters and messages, a view, and presets end to end, so it is the first target that must load and behave the same.

The conformance suite is these patchers and tests, run against the new package. Behaviour that only the old binaries show (the old package does not run on this Mac's Max 9) is recovered by reading the source, not by running it.

**Pass bar (decided by the author).** The set to pass is not all 783 patchers. It is (a) the help patchers and the integration tests for the eight in-scope objects, and (b) the author's own patchers, which the author names. "Same" means the same messages and values, in the same order, at the outlets. Float formatting and exact timing are not part of the bar. Quirk-for-quirk reproduction beyond this is not a goal.

**Protocol boundary (decided by the author).** The contract is what a patcher sees at the object boundary. The internal messages between `j.model`, `j.view` and `j.ui` (the model-to-view protocol) are free to change. If the author later finds abstractions of their own that rely on those internals, that is a new requirement and comes back to this document.

**File formats.** The new package reads the old formats for the in-scope files and writes the same formats, so files stay readable in both directions. Additions are optional new attributes that the old readers ignore. (Builder-check Q4; my call.)

## 10. Architecture decisions

- **Core library** (`core/`, namespace `jamoma`): C++20, no Max headers, no JUCE. Holds the namespace tree and node registry, typed values with ranges and clip modes, ramps and dataspace conversion, the message bus behind `j.send`/`j.receive`, presets, and the readers/writers. Unit-tested with `ctest`.
- **Externals** (`externals/`): Min-API, one source file per object, no behaviour of their own beyond translating Max messages and attributes to core calls and back. C++17 or 20 depending on what Min-API compiles cleanly with.
- **Build:** CMake, one top-level project, presets for macOS (arm64 + x86_64 universal) and Windows (x64). Minimum macOS 12 and Windows 10 are my calls (Max 9's own minimums apply).
- **Package layout:** `externals/`, `help/`, `patchers/`, `docs/`, `javascript/`, `support/` as in a standard Max package, with the folder name `Jamoma` when installed. Old resources are migrated only if the in-scope objects need them.
- **Documentation:** every object gets a `.maxref.xml` and a help patcher; the reference pages from the old package are the starting point, rewritten where behaviour is described.
- **Licence (decided by the author's question, with my recommendation): BSD 3-clause ("New BSD"), as JamomaMax and JamomaCore are.** MIT, the alternative offered, adds nothing: it differs only by dropping the no-endorsement clause, and BSD-3 keeps continuity with the Jamoma family and is compatible with Min-API (MIT). Every source file carries an SPDX header `BSD-3-Clause`. The copyright line is the new author's; any text carried over from old help files or reference pages stays under the original Jamoma Group notice, which the same licence permits. (An earlier draft of this document wrongly said the old code was LGPL.)
- **Shared state across externals, and the start-up loader.** Every external is a separate binary, but all must see one namespace per Max process, from launch to quit. The old package did this with `j.loader` (in the package's `extensions` folder, which Max loads at launch), whose job was to load the framework once. The new package keeps that shape: an `extensions/` loader external, loaded at launch, owns the process-wide registry; the core lives in a shared library in `support/` that every external links to, so there is exactly one copy of the state. Whether this is the best way on Windows (DLL loading and search paths) is the milestone 0 spike (section 13).
- **Min-API** is pinned as a git submodule at a known commit (not floating), with a local patch only if `j.ui` text editing turns out to need one.

## 11. Max 9 features (additive)

All of these are my calls on how to approach what the author asked for, to be confirmed in the plan:

- **Dictionaries and JSON:** model state, presets and namespace dumps readable and writable as Max dictionaries and JSON, next to (not instead of) the old XML. The old formats keep working.
- **JavaScript (the new engine):** a small API so patcher scripts can query and drive the namespace, and so UI logic that is awkward in patchers can be written in script.
- **MC:** parameters and messages that carry multichannel values map onto MC patch cords where the old arrays (`j.parameter_array` and the like) did, so array-style patchers can move to MC without rewriting the model.
- Other newer features are taken as they improve behaviour; each addition lands in a changes file.

## 12. Milestones (proposal; the plan refines these)

0. **Foundations:** the build (CMake, macOS arm64 + x86_64 and Windows x64, **both from the start**, decided by the author), CI on both, the core library skeleton and test harness, the behaviour inventory of the in-scope objects from sections 9.1–9.2, and a spike, on both platforms, for how externals share state through a start-up loader and a shared library (section 13). Conformance testing runs on macOS first and on Windows once milestone 2 is complete.
1. **Namespace core with `j.model`, `j.parameter`, `j.message`, `j.return`:** the tree, typed values, ranges, clipmodes, ramps, dataspaces, repetition filtering, priorities, the Max objects, their help patchers and conformance tests.
2. **`j.send`/`j.receive`:** the OSC-addressed bus.
3. **`j.view` and `j.ui` with presets:** the generic UI on Min-API (the text field resolved per section 7), preset store, recall and interpolation, file formats.
4. **Max 9 additions:** dictionaries/JSON, JavaScript, MC.

## 13. Open items left to the builder

- **How externals share one namespace.** The starting design is the start-up loader plus a shared library (section 10). The alternative is one binary that registers all classes. The milestone 0 spike on both platforms confirms or replaces it, because it constrains the layout of everything.
- Whether `j.view` is a C++ external or an abstraction in the new package (the old one has no C++ of its own).
- **Array objects** (`j.parameter_array`, `j.message_array`, `j.return_array`) are outside stage 1 and move to milestone 4 together with the MC mapping. Each gets a short note on what happens to patchers that use it. (My call.)
- **Minimum Max version:** 9.0 provisionally; raised only if an API we need requires a later 9.x. The spike ran on 9.2.2. (My call.)
- **`j.ui` text field:** draw the text ourselves first; patch Min's UI operator only if the inventory shows editing is needed. How much of old `j.ui` editing (text editing, mousewheel, `edclose`) is required comes from the milestone 0 inventory. (My call.)
- The threading rules for the namespace: which operations may run on the audio, scheduler and main threads, and what must be lock-free.
- The text-field approach for `j.ui`.
- Test tooling for the core (a framework, or plain `ctest` executables) and for the conformance patchers (the old `maxtest` approach may not exist in Max 9).
- Windows toolchain details and code signing/notarization for release (out of scope for the first stage, but the build must not preclude them).
- The exact set of dependencies pulled in from the wider modular family (section 8).
