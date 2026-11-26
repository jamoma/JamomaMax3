# j.ui additions of milestone 4 (old behaviour)

Sources: `JamomaMax/source/j.ui/j.ui.cpp` (menu, mouse), `j.ui.internals.cpp` (`ui_view_panel_attach`, `ui_return_model_content`), `TTUiInfo.cpp` (`Panel`).

## Preset name
Old "Create New Preset" (j.ui.cpp, `ui_menu_qfn`): `jdialog_showtext("Provide a name for this Preset", "Château de Preset", 0, &text)`, a Max modal text dialog; Cancel (result != 1) does nothing; otherwise `preset:new <name>` is sent to the model. So no editor window is needed: use `jdialog_showtext`.

## Subwindow (panel) button
- The old `j.ui` has one outlet, `panel_out` (`j.ui.h:32`). A deferred `ui_view_panel_attach` looks through the objects connected to that outlet and, if one is an inlet of a subpatcher (`jpatcher`), keeps it and sets `has_panel`; the button is then drawn at the right end of the header (13 px wide, `rect_panel`).
- A click sends `Panel` (`TTUiInfo::Panel`): the outlet sends a `bang` (so the patch can prepare), the subpatcher's `title` is set to the view's address, and the subpatcher is shown (`vis`).

## Edit Current State
The old menu item "Edit Current State" and a double-click on the box open the Max text editor on the model's state (`ui_edit_state`); the new menu sends `preset:edit` (known not built until Task 6) and this item stays as it is.

## `view/freeze` and the freeze button
- `view/freeze` exists in the old package only as a symbol (`JamomaMax/library/includes/JamomaSymbols.h` and `source/JamomaSymbols.cpp`: `jps_ui_slash_freeze`; nothing else outside the `quarantine` models uses the address); nothing in the 0.6 source creates or reads such an address. Cue scripts and helper patchers of the 0.5 days still send it (`cue_script.demoscript.txt`, `alias_renaming.cues.txt`, `j.presetParameters.helper.maxpat`); such lines address nothing and are skipped.
- The freeze button of the old `j.ui` is never shown: `ui_return_model_content` declares `freeze = NO` and never sets it (`j.ui.internals.cpp:514`, `612-618`), confirmed in the old `qmetro.model.maxhelp` (no freeze button).

## Rulings
1. **Naming a preset uses `jdialog_showtext`** with the old prompt text and default name; Cancel creates nothing; an empty or duplicate name gets a free name (`PresetManager::free_name`). A testable message `preset:name <name>` creates a preset directly.
2. **Subwindow button:** built as the old, with the one difference that our `j.ui` outlet also carries the menu messages (`preset:edit`, `model:reference/open`...): drawn when the outlet feeds an inlet of a subpatcher; a click sends `bang` and shows the subpatcher with its title set to the view address. Menu messages still go out of the same outlet as designed in milestone 3 (listed in `docs/changes.md`).
3. **Not built:** the freeze button and `view/freeze` (dead in the old version). `data/freeze` stays a reserved address.
4. `Edit Current State` is not part of this milestone's goals; `preset:edit` (Task 6) is the preset-file editor and uses `TextEditor`.
