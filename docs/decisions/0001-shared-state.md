# 0001: How externals share one namespace

Date: 2026-11-21. Status: **decided for macOS (verified); Windows mechanism untested.**

## Question

Every external is a separate binary, but all of them must see the same namespace for the life of the Max process. How?

## Decision

A start-up loader external plus one shared library:

- `jamoma_core` is a shared library (`libjamoma_core.dylib` / `jamoma_core.dll`) holding the process-wide `jamoma::Registry`.
- `j.loader` lives in the package's `extensions/` folder, which Max loads at launch (as the old `j.loader` did). It attaches to the registry through `Registry::try_attach_loader(kAbiVersion)`, which refuses a loader built against another ABI and attaches nothing.
- Every other external links to the same library. An external works without the loader (`loader_attached()` is false; it still sees the one registry).

## Evidence (macOS, Max 9.2.2, arm64 host; universal arm64 + x86_64 build)

The spike (two throwaway externals, `j.spike.a` and `j.spike.b`, each reporting `Registry::instance().instance_id()`; source in git history at commit `6e1a8fd`, folder `spikes/shared-state/`) ran through `scripts/max-smoke.sh`:

| Run | Result |
|---|---|
| Package installed normally | `PASS same-registry loader=1`, Max quit by itself, no crash report |
| Package staged under a path with spaces and a non-ASCII character | `PASS same-registry loader=1`. **Spaces verified; non-ASCII not proven:** Max reaches the package through a symlink in `~/Documents/Max 9/Packages`, and Max may resolve it, so the external may never have seen the "Å" in its own path. Proving it needs the smoke external to report the path it was loaded from (`dladdr` / `GetModuleFileNameW`). |
| Loader removed (externals used without it) | `PASS same-registry loader=0` |

Both externals see the same registry id, so state is not split between binaries. The first run also covers Max quitting while objects are alive (no crash report). That proves only that nothing crashes today: `Registry` has a trivial destructor, so "torn down once" has nothing to tear down yet (see the rules below). The registry's ABI check is a Max-free unit test (`try_attach_loader rejects an ABI mismatch`); the loader's console message for that case was not exercised in Max.

Rpath: `@loader_path/../../../../support` (four levels up from `<name>.mxo/Contents/MacOS` to the package root).

## Windows: not verified

No Windows machine was available. The Windows branch of `jamoma_add_external`, the `windows` preset, `ci.yml` and `scripts/max-smoke.ps1` are written but have never been built or run.

The mechanism chosen: Windows looks for a DLL next to the module that needs it, not in `../support`, and the loader itself links the DLL implicitly, so it cannot call `SetDllDirectory` first. So `jamoma_core.dll` is copied next to every external and extension (post-build), and the design relies on Windows mapping a DLL name once per process, so all externals share the first copy loaded (the loader's, from `extensions/`). **This rests on an unverified premise.** Whether a dependency DLL is found next to the external depends on the flags Max passes to `LoadLibraryEx` (with a plain `LoadLibrary(fullpath)` the external's own folder is not searched), and Max's package conventions describe `support/` as the place for such DLLs, so the copies may be unnecessary. **The first Windows step is to test the single-copy layout (DLL only in `support/`); keep the copies only if that fails.** If the copies stay, they drift: each is refreshed only when an external relinks, a core-only change may leave the copy beside the loader (the one loaded first) stale, and copies from removed targets linger; the ABI number cannot catch a same-ABI stale build. Then make each copy depend on the core target. Fallback if the test shows split state: delay-load `jamoma_core` in `j.loader` and call `AddDllDirectory` for `support/` before first use; or link the core statically into one external that registers every class.

The Windows build now uses the dynamic C runtime (`/MD`) for the core and every external (see rule 2 below; the original text said `/MT`). **Untested on Windows.**

## Findings that shaped the runner

- Max started as a direct child of a non-interactive shell does not run reliably (it vanished within seconds without a crash report); launched through Launch Services (`open -a`) it runs normally. The smoke runner therefore uses `open`, and cannot read Max's exit code; it checks the result file, that Max quits by itself, and the absence of a new crash report.
- The runner touches `~/Documents/Max 9/Packages` (a temporary symlink, removed afterwards) and refuses to run while a Max 9 process is open.

## The loader runs from the class setup

`j.loader` attaches from Min's `maxclass_setup` message (called from the external's main function), not from a static initialiser: on Windows a static initialiser runs inside `DllMain` under the loader lock, where calling into Max can deadlock. Verified on macOS with the smoke test (`loader=1`) after the change.

## Rules for milestone 1 (from the whole-branch review)

1. **Exit and teardown (decided in milestone 1, task 3: leaked registry).** `Registry::instance()` returns a deliberately leaked heap object, so externals that unsubscribe while Max quits always find the registry and its namespace intact; the test `registry_outlives_static_destruction` aborts with an ordinary function-local static registry and passes with the leak. Original rule, kept for history: `Registry` has a trivial destructor today. Before it holds anything that references Max or externals, decide the exit policy: either a deliberately leaked singleton (`static Registry* = new Registry`) or an explicit shutdown from a quit task installed in `maxclass_setup` (`c74::max::quittask_install`). Static destruction at `exit()` / `DLL_PROCESS_DETACH` that calls into externals or Max will crash.
2. **Standard-library types across the core API (superseded in milestone 1, task 2).** The Windows build now links the dynamic C runtime (`/MD`) for the core and every external, so they share one heap and `std::string`, `std::vector` and the like may cross the boundary (`Atom`, `Value`, `Address`). Core and externals must always be built together with the same compiler and standard library, which the frozen ABI check and one release per package already imply. **Untested on Windows.** (The original rule, plain data only under `/MT`, is kept here for history.)
3. **ABI entry points are frozen.** `jamoma::abi_version()`, `Registry::check_abi()` and `Registry::try_attach_loader()` are never removed or changed; every external calls the check first in its setup. A symbol the installed library lacks is rejected by the dynamic loader before any Jamoma code runs (a generic dyld or Windows error 127, not the Jamoma ABI message), so the clean refusal only covers "same symbols, different layout or semantics". Giving `jamoma_core` a compatibility version equal to the ABI so older libraries are rejected too is open.
4. **Warn once per process.** An external that starts without the loader logs the warning only if `Registry::claim_missing_loader_warning()` returns true.
5. **Duplicate installs.** Two copies of the package in one Max process (for example the Packages folder plus a search path) could load two libraries and split state silently. Optional hardening: publish the registry's address through a process-wide anchor on first `instance()` and report an error if a second copy finds one set.

## Milestone 1 addendum

- The patcher-to-model map (`ContextMap`) lives in the registry with the namespace, so `j.model` and the data objects, which are separate binaries, share it.
- Sanitizer builds of the core must set `JAMOMA_PACKAGE_DIR` to their own folder: the core library is written to `package/Jamoma/support`, and a ThreadSanitizer build there breaks every external Max loads (found when it did).
- The quit-with-live-objects check relies on the leaked registry above.

## Milestone 2 addendum

- **Observers** (`Data::observe`, `Namespace::observe`) call back on the thread that made the change, after every lock is released. A callback may drop its own handle, set attributes and subscribe. A callback may run once more after its handle is dropped if the change was already in flight on another thread: the Max externals therefore guard every callback with an "alive" token and defer output to the main thread when they are called from another one.
- **Threads and Min:** the value-carrying messages of the externals are declared `message<threadsafe::yes>`; Min's default defers a call from a non-main thread and loses most of a ramp. Outlets are written with the Max API, which is safe from the scheduler thread.
- `Receiver::bang`/`grab` and `Sender::send` are for the main thread (nodes are created and removed there); everything else in them is safe from any thread.

## Added in milestone 3

- The patcher-to-model map (`ContextMap`) now has observers and a listing; a second map (`ViewMap`) records the views. Externals watch the map with `ContextWatch` (`externals/common/max_context.hpp`) and bind again when a model appears, is replaced or goes. Both maps live in the one registry and obey the rules above (a leaked singleton, nothing torn down at exit).
- Anything that reads the namespace from a thread other than the main one must use `Namespace::visit_below` (read lock held, objects alive during the call); `Node` pointers from `lookup` and `find` are for the main thread, which creates and removes nodes.
