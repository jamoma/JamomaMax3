# Presets: characterisation for milestone 3

Paths relative to the old checkout (`~/Developer/Jamoma/JamomaMax`). *Read* = read in the source named. Written before any code (milestone 3, Task 1).

## The preset manager (`JamomaCore/Modular/library/source/TTPresetManager.cpp`)

- **State:** an ordered list of names, the presets by name, `current` (a name) and `currentPosition` (1-based, 0 = none); attribute `value` answers the current position plus one followed by the current name (`getValue`, `:99-105`); `address` is the model address (setting it clears everything). *Read.*
- **A preset is a script** (`TTPreset.cpp`, `TTScript.cpp`): lines of three kinds: flags (`- preset "name"`, `- description "text"`), comments (`# ...`), commands (`<relative address> <value...>`, the usual command syntax with optional unit and `ramp <ms>`), and `WAIT <ms>`. The core stores a list of entries; flags other than name and description are kept as text and written back unchanged. *Read.*
- **`new <name>` / `new <position> <name>`** (`:122-170`): a name that already exists is **cleared and stored again** (no duplicate); a new name is appended and becomes current; with a position the preset is then moved there. No name: error. *Read.*
- **`update [<name or 1-based position>]`:** re-stores into an existing preset; unknown: error (`:172-210`). *Read.*
- **`recall <name or position> [<address>]`:** runs the preset's lines in order (`Run`), optionally only the line at an address; sets `current` and `currentPosition`; an unknown name or an out-of-range position is an error and changes nothing (`:213-250`). *Read.*
- **`output <name or position> [<address>]`:** dumps the lines (as messages out of the `names`/line outlet) instead of running them. *Read.*
- **`interpolate <a> <b> <position>`** (names, or two 1-based positions, and a float) and **`mix <a> <f1> <b> <f2> ...`** (pairs of name or position and a float; an odd count is an error). *Read.*
- **`move <name or position> <new position>`** (1..n else error), **`delete <name or position>`** (clears current), **`order <names...>`** (must be all the names), **`rename <name or position> <new>`**, **`copy <name or position> <new> [<position>]`**, **`clear`**. *Read (`:360-600`).*
- **Store** (`TTPreset::Store`, `:75-150`): looks at every `Data` with the `parameter` service below the model address, **sorted by priority, then name, then instance**, and appends `<relative address> <value>` for each (the `value` attribute, with no unit; a parameter whose value is empty is skipped). Recall runs the lines in that order; each line is a normal command (ranges, clipping, ramps apply). *Read.*
- **Interpolate** (`TTScriptInterpolate`, `TTScript.cpp:1764`): lines are paired in order; a line of the second script with another target is found by address, one that is missing is skipped; only the `value` attribute; integer and decimal parameters are interpolated linearly (`v1 (1 - p) + v2 p`), arrays element by element when the sizes are equal, any other type takes the first value at position 0 and the second otherwise; if the parameter has a ramp function other than `none`, the ramp engine slides instead. *Read.*
- **Mix** (`TTScriptMix`, `:1883`): each numeric value is multiplied by its factor, summed and divided by the sum of the factors (nothing happens if the sum is 0); other types take the value of the first line with a positive factor. *Read.*

## Files

- **The model's file is the text format** (`source/j.model/j.model_preset.cpp`): `preset:read [file]` / `preset:write [file]` / `preset:read/again` / `preset:write/again` go through the text handler (`:65-135`); `preset:write` proposes `<class>.<context>.presets.txt` (`:155`). Several presets in one file, each starting at its `- preset "name"` flag. *Read.*
- **At start-up** (`model_preset_default`, `:215-260`): after the model has registered, the manager is registered at `<model address>/preset`; the file `<class>.model.presets.txt` (`.view.presets.txt` for a view) is looked for in the Max search path; if found it is read and then the preset called `default` is recalled if it exists; the `presets` attribute can name another file; a file watcher reloads the file when it changes on disk. *Read.*
- **The XML format** (`TTPresetManager::WriteAsXml`, `TTPreset.cpp:302-340`, `TTScript::WriteAsXml`, `TTScript.cpp:973-1090`): one `<preset name="...">` element per preset, inside it `<flag name="description">text</flag>`, `<command address="..." unit="..." ramp="...">values</command>` and `<script address="...">` for sub-scripts, comments as XML comments. It is written by the cue and application XML files, not by `j.model` (which only does text). *Read.*
- **The sample text file** is `Jamoma/patchers/models/data/qmetro/qmetro.model.presets.txt`: `- preset "default"`, `- description "..."`, comment lines, then `data/active 0`, `randomness 0`, `time 100`. *Read.*

## Rulings

1. **Presets are lists of entries** (address, value) plus name and description; unknown flags are kept as text and written back. Recall sends each entry as a command to the node (relative to the model); a missing node is skipped and reported.
2. **Text format is the model's file format and is built fully (read and write, round trip).** The XML reader and writer are built as the plan says (spec section 9) but are not wired to `j.model` messages: nothing in milestone 3 writes them (milestone 4: `j.cue`).
3. **`new` of an existing name replaces its entries and keeps its position** (as the old object), **positions are 1-based** in messages and **0-based in the C++ API**.
4. **Interpolation and mix follow the old rules above;** the ramp-function branch is not built (a ramp function other than `none` interpolates linearly like the others; recorded for `docs/changes.md`).
5. **File watching and `preset:edit`** (the text editor window): not built in this milestone (recorded as deferred; `preset:read/again` covers reloading by hand). The default file `<class>.model.presets.txt` is found in the Max search path and read once the model has initialised, then `default` is recalled if it exists.
6. **The preset manager lives in the core `Model`** (`Model::presets()`) so that the core `ModelExplorer` can read its names, and has an `observe` for changes; the preset node `<model>/preset` of the old object is not registered (nothing in the pass-bar set uses it).
