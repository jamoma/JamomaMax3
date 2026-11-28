# Changelog

New features and notable changes for each release of JamomaMax3. Everything that deliberately differs from the old JamomaMax objects is described in `docs/changes.md`.

## Unreleased

### New features

- **The `color` dataspace** (`cmy`, `hsl`, `hsv`, `rgb`, `rgb8`) **and the `angle` dataspace** (`radian`, `degree`).
- **`j.namespace` filters** (`filter/set`, `filter/remove`, `filter/info`, `@filter/list`).
- **`dump` on the array objects** answers the attributes of the watched instance and `format`.
- **Easing functions for ramps:** `ramp/function` takes the functions of the library, with their parameters.
- **Model aliases:** `alias <address>` and `alias/remove` on `j.model`.
- **Toggles and menus in the inspector** and in `attrui` for attributes that are true or false or have fixed values.
- **`j.namespace`** lists what is below an address, for a menu, a table or a `coll`, and keeps a selection of the items.
- **`j.map`** maps numbers, or the values of one parameter onto another, with the 38 functions of the old function library.
- **`j.cue`** stores the state of chosen parameters of several models under names and recalls it, with text and XML files and an editor.
- **`j.textslider`** is a slider that shows a text and, while the mouse is over it, its value.
- **`preset:edit`** opens the presets of a model in an editor window.
- **`j.view`: `model:address <address>`** turns a view to another model while the patch runs.
- **The model `osc_receive`** (with its view and help patcher) receives OSC messages over UDP and sends them to the addresses they name.
- **Models are named by their argument** without `#1` in the patcher: `osc_receive.model osc_rcv`, or a model in a bpatcher with an argument, registers under that name, as in the old version.
- **`j.ui`: the messages `preset:name <name>` and `panel`** create a preset of that name, and open the second panel of a view (the subpatcher the outlet feeds), as the menu and the plus button of the header do.
- **`j.ui` fits the colour theme of Max.** Left at their defaults, its colours are automatic: a faint panel that lets the patcher show through, a header that stands out from it, and a title and active button that stay readable on every theme. The title takes the text colour of the patcher and the lit button the highlight of the theme, or a readable colour where those would be hard to see; automatic colours also adapt to colours you set. A colour you set yourself is used as it is, and the name of the attribute sent without values gives the automatic colour back. A change shows at once. The Inspector shows the default values, not the colours drawn. The help patchers of `j.ui` and `j.textslider` have a new tab, colours, that shows how this works.
- **`j.textslider` follows the colour theme of Max.** A colour that is left at its default takes the theme's colour for that part (track and border, bar, text, line), and these are adjusted where needed so that the text stays readable on every theme. A colour you set yourself is used as it is, and the name of the attribute sent without values gives the automatic colour back. A change of colour, text, unit or text position shows at once.
- **`j.ui`: the attribute `snap`** (default 1) decides whether the size of the object snaps to the grid of the interface: whole units of 150 pixels across and 35 pixels down, at least one unit in each direction. This is how the old `j.ui` behaved, always; with `@snap 0` the object can now have any size.
- **`j.ui`: the message `active [0|1]`** switches the model on or off through its parameter `data/active`, as a click on the active button of the header does (no argument: the other way round).
