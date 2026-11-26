# Changelog

New features and notable changes for each release of JamomaMax3. Everything that deliberately differs from the old JamomaMax objects is described in `docs/changes.md`.

## Unreleased

### New features

- **`j.ui` fits the colour theme of Max.** Left at their defaults, its colours are automatic: a faint panel that lets the patcher show through, a header that stands out from it, and a title and active button that stay readable on every theme. A colour you set yourself is used as it is. The help patchers of `j.ui` and `j.textslider` have a new tab, colours, that shows how this works.
- **`j.textslider` follows the colour theme of Max.** A colour that is left at its default takes the theme's colour for that part (track and border, bar, text, line), and these are adjusted where needed so that the text stays readable on every theme. A colour you set yourself is used as it is.
- **`j.ui`: the attribute `snap`** (default 1) decides whether the size of the object snaps to the grid of the interface: whole units of 150 pixels across and 35 pixels down, at least one unit in each direction. This is how the old `j.ui` behaved, always; with `@snap 0` the object can now have any size.
- **`j.ui`: the message `active [0|1]`** switches the model on or off through its parameter `data/active`, as a click on the active button of the header does (no argument: the other way round).
