# JamomaMax3

A clean-room rewrite of the Jamoma modular framework for Max 9 (macOS and Windows),
keeping what patchers can see and replacing everything underneath. See
`docs/superpowers/specs/` for the design and `docs/superpowers/plans/` for the plans.

Licence: BSD 3-clause (see `LICENSE`).

## Build

```
git submodule update --init --recursive
cmake --preset macos            # or: cmake --preset windows
cmake --build --preset macos
ctest --preset macos
cmake --build --preset macos --target docs   # Doxygen; any warning is an error
```

## Install the package in Max 9

The Max package folder must be named `Jamoma`. Link the package folder into Max:

```
ln -s "$PWD/package/Jamoma" "$HOME/Documents/Max 9/Packages/Jamoma"
```
