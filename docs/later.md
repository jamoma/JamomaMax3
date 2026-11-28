# Noted for later

Ideas that are wanted but belong to no milestone yet. Nothing here is decided in detail or built.

## Unsaved presets (noted 26 November 2026)

When presets were created, renamed or deleted since the patch was opened, the changes are lost without a word if the patch is closed before the presets file is written. Neither the old `j.model` and `j.ui` (as far as their sources were searched) nor the new ones warn about this.

Proposed, as its own small feature, in this order:

1. **Show unsaved changes:** a small mark in the header of `j.ui`, and a report from `j.model` that a patch can react to.
2. **Compare with the file:** "unsaved" means that the presets differ from what was last read or written (so Update Current Preset and reordering count, and undoing a change removes the mark).
3. **Then try a question at closing time:** find out by a short experiment whether Max allows it reliably. If it does, ask once per patch (Save, Don't Save, Cancel), with an attribute that switches it off for installations.

Things to keep in mind: an object learns that it goes away when it is freed and cannot stop the close from there; several models in one patch, quitting Max and scripts that remove a bpatcher must not give a row of dialogs; marking the patcher as changed would offer to save the patch, which does not write the presets file.

## Menu items of `j.ui` that are not built (noted 28 November 2026)

The two menus of the panel are in their old places, but some items do nothing yet. No milestone includes them.

| Menu item | Today | In the old version |
|---|---|---|
| Open Model Reference Page, Open Model Help Patch, Open Model Internal | The message (`model:reference/open`, `model:help/open`, `model:internal/open`) only leaves the outlet of `j.ui`; `j.model` does not answer it | `j.model` opened the window |
| Choosing a parameter, message or return (menu on the address) | `model:reference/open <address>` leaves the outlet | An inspector window showed all attributes (`Jamoma/patchers/components/data/reference_interface/j.reference_interface.maxpat`) |
| Edit Current State | Grey | A text editor with the current state of the model |
| Open Preset Interface | Grey | A window to handle the presets (`Jamoma/patchers/components/data/preset_interface/j.preset_interface.maxpat`) |

The two old patchers use `j.receive`, `j.send`, `j.map`, `j.unit` and the script `Jamoma/javascript/j.interfaceArguments.js`, which now exist or can be imported (see the rules
for imported patchers). The window of Edit Current State can build on the preset editor.

## `j.route` (noted 28 November 2026)

Not built. The only patcher of the package that used it (the namespace browser window) uses Max objects instead. Old patchers that use it show a missing object.
