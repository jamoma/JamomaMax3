# j.cue (old behaviour, read for milestone 4)

Sources: `JamomaMax/source/j.cue/j.cue.cpp` (564 lines), `PeerObject/TTCueManager.cpp`, `TTCue.cpp`; sample text cue files `Jamoma/examples/model features/alias_renaming.cues.txt` and `Jamoma/patchers/models/data/cue_script/cue_script.demoscript.txt`; the help `j.cue.maxhelp`.

## Object (JamomaCore `TTCue.cpp`, `TTCueManager.cpp` and the old reference page `j.cue.maxref.xml`; an earlier reading of the 0.5.7 classes was an older version and has been replaced)
- Outlets: line (0, what a recalled or output cue sends: `<address> <value...>`), dump (1: `names <cue names>`, `read`, `error`, answers of `get`). Argument: one symbol, the name of the shared selection (see `j.namespace`), the same as `@namespace`.
- Attributes: `address` (the parent node the cues store from; recall addresses that are relative are taken from it; default root), `namespace` (the selection), read-only `names`, `current`, `current/position`, `current/description`, `current/ramp`.
- Messages: `new [position] <name>` (stores the **selected** addresses below `address` under the name; an existing cue is cleared and stored again; at a position if one is given), `update <name|n> [address]` (refreshes the value of every line of the cue from its parameter), `append <name|n> <line...>` (adds a line to a cue, making the cue if needed), `recall <name|n> [address]`, `recall/next`, `recall/previous`, `output <name|n> [address]` (sends the lines to the line outlet without applying them), `interpolate`, `mix`, `move`, `delete`, `order`, `rename`, `copy`, `clear`, `optimize <names...>` (removes from each cue the lines that repeat the state the cues before it left), `get <attribute> <cue>`, `set <attribute> <cue> <value...>` (`name`, `description`, `ramp`), `namespace/select`, `namespace/unselect`, `namespace/grab` (select the addresses of an existing cue), `read [file]`, `write [file]`, `read/again`, `write/again`, `edit`, `dblclick`/`edclose` (the text editor), `dump`.
- Text file (read from `alias_renaming.cues.txt` and `cue_script.demoscript.txt`): a line `CUE <name>` starts a cue (a trailing `# (fold)` is a comment), lines below it are `<absolute address> <value...>`, `#` starts a comment, blank lines and `#####` rules are ignored, `# (end)` ends the cue, indentation is free.
- XML file: one `<cue name="...">` element per cue with the content of a preset (`<flag name="description">`, `<command address=".." ramp="..">`, `<script>`), in the same `<jamoma>` root as presets (`TTCueManager::WriteAsXml`, same writer).
- A cue is a script of lines; `Store` flattens it, so a cue holds the plain list of commands.

## Rulings
1. **Built:** every message above except `sequence` (which does not exist in this version) and `optimize`'s exact internal merge, which is reproduced by value: a line is removed when its address and value are those of the state the earlier cues left. `interpolate`, `mix`, `move`, `delete`, `order`, `rename`, `copy`, `clear`, `output`, the text and XML files are those of presets (a cue is a preset with absolute addresses).
2. **Selection comes from `j.namespace`'s shared selection**; a cue without a named selection stores the selection of an own, empty one (it stays empty unless `namespace/select` adds addresses).
3. Recall of a line whose parameter no longer exists is skipped and reported (as presets do).
4. `read`/`write` without an argument open the Max file dialog; with a file name no dialog; files are never written unasked.
5. The text form writes the description as `# description: text` (a comment the old reader ignores; additive).
6. A file or text with no cue changes nothing and is reported.
