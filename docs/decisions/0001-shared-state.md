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
| Package staged under a path with spaces and a non-ASCII character | `PASS same-registry loader=1` |
| Loader removed (externals used without it) | `PASS same-registry loader=0` |

Both externals see the same registry id, so state is not split between binaries. The first run also covers Max quitting while objects are alive (no crash report). The registry's ABI check is a Max-free unit test (`try_attach_loader rejects an ABI mismatch`); the loader's console message for that case was not exercised in Max.

Rpath: `@loader_path/../../../../support` (four levels up from `<name>.mxo/Contents/MacOS` to the package root).

## Windows: not verified

No Windows machine was available. The Windows branch of `jamoma_add_external`, the `windows` preset, `ci.yml` and `scripts/max-smoke.ps1` are written but have never been built or run.

The mechanism chosen: Windows looks for a DLL next to the module that needs it, not in `../support`, and the loader itself links the DLL implicitly, so it cannot call `SetDllDirectory` first. So `jamoma_core.dll` is copied next to every external and extension (post-build), and the design relies on Windows mapping a DLL name once per process, so all externals share the first copy loaded (the loader's, from `extensions/`). **This is a guess that the smoke test must confirm.** Fallback if the test shows split state: delay-load `jamoma_core` in `j.loader` and call `AddDllDirectory` for `support/` before first use; or link the core statically into one external that registers every class.

The Windows build uses the static C runtime (`/MT`, `MAXAPI_USE_MSCRT`) like the Max SDK. The core API currently passes only plain data across the DLL boundary; revisit when it passes standard-library types.

## Findings that shaped the runner

- Max started as a direct child of a non-interactive shell does not run reliably (it vanished within seconds without a crash report); launched through Launch Services (`open -a`) it runs normally. The smoke runner therefore uses `open`, and cannot read Max's exit code; it checks the result file, that Max quits by itself, and the absence of a new crash report.
- The runner touches `~/Documents/Max 9/Packages` (a temporary symlink, removed afterwards) and refuses to run while a Max 9 process is open.
