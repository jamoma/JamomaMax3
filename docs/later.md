# Noted for later

Ideas that are wanted but belong to no milestone yet. Nothing here is decided in detail or built.

## Unsaved presets (noted 26 November 2026)

When presets were created, renamed or deleted since the patch was opened, the changes are lost without a word if the patch is closed before the presets file is written. Neither the old `j.model` and `j.ui` (as far as their sources were searched) nor the new ones warn about this.

Proposed, as its own small feature, in this order:

1. **Show unsaved changes:** a small mark in the header of `j.ui`, and a report from `j.model` that a patch can react to.
2. **Compare with the file:** "unsaved" means that the presets differ from what was last read or written (so Update Current Preset and reordering count, and undoing a change removes the mark).
3. **Then try a question at closing time:** find out by a short experiment whether Max allows it reliably. If it does, ask once per patch (Save, Don't Save, Cancel), with an attribute that switches it off for installations.

Things to keep in mind: an object learns that it goes away when it is freed and cannot stop the close from there; several models in one patch, quitting Max and scripts that remove a bpatcher must not give a row of dialogs; marking the patcher as changed would offer to save the patch, which does not write the presets file.
