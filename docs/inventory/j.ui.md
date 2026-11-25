# j.ui: characterisation for milestone 3

(The milestone 0 page of the same name, `docs/inventory/j.ui.md`, is replaced by this one; its generated attribute and message lists are in the old reference page.) *Read* in `source/j.ui/j.ui.cpp` (1652 lines), `j.ui.presets.cpp`, `j.ui.internals.cpp`, the reference page.

- **Panel:** a header with the model address and a menu arrow; below it widgets that depend on the model (presets; audio gain, mute, bypass, meters for audio models: milestone 4), flags `has_preset`, `has_model`, `has_panel`, `has_meters`, `has_mute`, `has_bypass`, `has_freeze`; with no model it shows `waiting for a model:address`. Default size 300 x 70. *Read.*
- **Menus** (drawn with `jpopupmenu_*`, `j.ui.cpp:1140-1200`): clicking the **model address** lists the parameters, messages and returns below the model (a choice sends the reference request); the **menu arrow** gives: Open Model Reference Page (`model:reference/open`), Open Model Help Patch (`model:help/open`), Open Model Internal (`model:internal/open`), Edit Current State (`preset:edit`), Load Presets File (`preset:read`), Save Presets File (`preset:write/again`), Save Presets File As (`preset:write`), Edit Presets File (`preset:edit`), Create New Preset (`preset:new`), Update Current Preset (`preset:update`), Delete Preset (`preset:delete`), and the preset names (a choice sends `preset <name>`). *Read (reference page).*
- **Preset panel:** loaded from the abstraction `j.preset_interface.maxpat` (`j.ui.presets.cpp:44`): previous/next, a name field, a slider for interpolation. *Read.*
- **Attributes:** `bgcolor`, `bordercolor`, `headercolor`, `textcolor`, `highlightcolor`, `fontname`, `fontsize`... (the generated page lists four; the source adds more: to be listed from `class_addattr` when building). *Read.*
- **Text field:** `jbox_get_textfield` is used (`:274`, `:433`) for the name field of presets and the address text; Min does not provide it (spec section 7).

## Rulings

1. **Text is drawn, not edited:** the model address and preset names are drawn with `jgraphics` text; the name of a new preset is asked for with a Max dialog (`jpopupmenu` has none, so a **small text-entry popup is not built**): `Create New Preset` stores the preset as `preset <n>` (the next free number) and the user renames it with the `preset:rename` message or the preset file; recorded for `docs/changes.md`. Cost if wrong: renaming from the panel is missing.
2. **Milestone 3 builds:** the header with the address and the waiting state, the menu of nodes, the utilities menu (items that send the messages above to the model; `reference/open`, `help/open`, `internal/open` and `preset:edit` send the message and the model may ignore it), and the preset list menu. The preset slider panel, the audio widgets and meters are not built.
3. **Everything the panel shows is read from the model through the core `ModelExplorer`** (which also gives the preset names); `dump` reports the state for tests.
