# j.namespace (old behaviour, read for milestone 4)

Sources: `JamomaMax/source/j.namespace/j.namespace.cpp` (609 lines), `Jamoma.0.5.7/Modules/Modular/library/PeerObject/TTExplorer.cpp` (1031 lines), the old help `j.namespace.maxhelp`, `j.model.maxhelp` and `j.parameter.maxhelp`.

## Object
- Inlet: `bang` and `explore` (explore again), a symbol = a new address (an absolute address, or a relative one only with `@relative 1`, else the error "set relative attribute on before to send relative address"), `select`, `selectall`, `selectnone`, `filterset`, `filterremove`, `filterinfo` and the attributes of the explorer, passed through by the class wrapper.
- Outlets, left to right: data (explore result), size (the number of items, sent after the result), dump (`j.namespace.cpp:12-14`).
- Argument: one symbol, the name of a shared selection namespace (`x->wrappedObject.set(namespace, name)`); the same as `@namespace`.
- Attributes: `address` (default empty), `output` (`descendants` default; `children brothers attributes`), `format` (`none umenu umenu_prefix jit.cellblock coll`; default `none`), `relative` (on/off; with it on the object watches `model:address` of its patcher and explores below that), `update` (bool, default 1: re-explore when the namespace changes), `sort` (`none alphabetic priority`, default `alphabetic`), `depth` (0 = all, default 0), `filterlist`, `namespace`.
- Items (TTExplorer::Explore, returnResultBack): `descendants` = every address below the address, relative to it; `children` = the first name part of each, repeats removed; `brothers` = the instances of nodes with the same name as the address, below its parent (the instance part only; a node without an instance is sent as `0`); `attributes` = the attribute names of the node at the address (written in Max form). The result is sorted by `sort`. A repeated identical result is not sent again (empty result is always sent).
- Formats (`nmspc_return_value`): `none`: the items as one list (an empty one: the message name); `umenu`: `clear`, then `append <item>` per item (for `descendants` below `/` the leading `/` is removed); `umenu_prefix`: also `prefix_mode 0` and `prefix <address><separator>` (separator `/` for children and descendants, `.` for brothers, `:` for attributes); `jit.cellblock`: `clear all`, `rows <n>`, `set 0 <i> <item>`; `coll`: `clear`, then `store <item> 0` per item. The size outlet then gets `int <n>`.
- Selection (each address item has a selected flag in a namespace shared by name): `select <item> [0|1]` toggles or sets one, `select 0 1 1 ...` sets all, `selectall`, `selectnone`; the result is returned as `selection <flags>` (none), `clearchecks` + `checkitem <i> <state>` (umenu), `cell 0 <i> brgb r g b` with 158 0 92 for selected and 0 0 0 otherwise (jit.cellblock), nothing for coll.
- Filters (`filterset <name> <key> <value>...`): named filters on node name, instance, service, tag... applied while exploring (`testNodeUsingFilter`). **Not read in detail.**

## What the in-scope help uses
`j.model.maxhelp`: `j.namespace @address /Amenities @format jit.cellblock`. `j.parameter.maxhelp`: `j.namespace @format umenu @sort priority`. The own help `j.namespace.maxhelp` also uses selection, `@filter/list model`, `@depth` and the shared `@namespace`.

## Rulings
1. **Built:** address, output, format (all five), relative, sort, depth, update, the three result forms, the size outlet. These cover the help patchers of the in-scope objects.
2. **Selection is built** (a core `Selection` shared by name: `select`, `selectall`, `selectnone`, selection output in the three formats), because `j.cue` stores the selected addresses (see `j.cue.md`).
3. **Filters (`filterset`, `filterremove`, `filterinfo`, `@filter/list`) are not built** in this milestone (not read, not needed by the pass-bar set); listed in `docs/changes.md`.
4. Defaults are those of the `TTExplorer` constructor (TTExplorer.cpp:14-22): output `descendants`, update on, sort `alphabetic`, depth 0, namespace `none`.
5. Names are written in Max form (a leading `/`, `:` before an attribute); a name with a space (not possible in an address) is not a case.
