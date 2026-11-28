# The array objects (old behaviour, read for milestone 5)

Sources read: `JamomaMax/source/j.parameter_array/j.parameter_array.cpp` (PA; builds the message and return arrays with `JMOD_MESSAGE` / `JMOD_RETURN`),
`source/j.remote_array/j.remote_array.cpp` (RA), `source/classwrapper/TTModularClassWrapperMax.cpp` (W), `library/source/JamomaModularForMax.cpp:1808-1870`
(names), `JamomaCore/Modular/library/source/TTViewer.cpp:46-62`, the reference pages of `j.parameter_array` and `j.remote_array`.

## Names (`jamoma_parse_bracket`, `jamoma_edit_numeric_instance`)
- The number inside the bracket is the size; instance i replaces `[N]` by i (from 1). The bracket may be anywhere in the address.
- More than 256 (`MAX_ARRAY_SIZE`, wrapper header) is an error and nothing changes (PA `data_array_build`).
- Data arrays: no symbol first argument is an error; an absolute address is an error (PA new, `data_address`). `j.remote_array` takes absolute ones (RA `remote_array_subscribe`).

## Data arrays
- Creation: nodes are built deferred, then selected `*` (PA 314). New instances get the box attributes; the old code re-applies them to **all** instances on every build.
- Growing builds only the new indices, shrinking removes the highest ones (PA `data_array_build`). New parameters and returns are sent `Init`.
- `address <name>`: ignored if equal; a name of another shape removes all instances first (PA `data_address`). In `array` format the collected list is output once after the change.
- `array/resize n` (n >= 0) rebuilds the name with `[n]` and calls `address` (W `ArrayResize`). `array/select` and the right inlet: an int 1..size or `*`; else an error (W `ArraySelect`). The index is kept in 8 bits, so 256 fails. A float on the right inlet is treated as a value (PA `data_float` does not look at the inlet).
- Values (`bang int float list`, other messages): to the selected instance; with `*` to every instance in the order of a hash table (PA `data_list`). Empty array: error.
- `array list`: length must be size x n; part i goes to instance i (PA `data_array`).
- `+`, `-`: only the instance the cursor points at (PA `data_inc`, `data_dec`).
- Attributes (box and messages) set **every** instance and leave the cursor on the last one (W `attrSet`, which does not restore it); a query answers the cursor's instance.
- Other messages that name a message or attribute of the data object go to every instance (W `anything`).
- `dump` does nothing (W `wrappedModularClass_dump` is empty).
- Output: for each value the index outlet first, then the value outlet; with `format array` the value outlet carries the values of all instances in index order, an instance without a value contributing its default, else 0, or `none` for strings (PA `data_array_return_value`, `data_edit_array`).
- Outlets (left to right): value, index, dump. Inlets: value, index.
- Messages (refpage): `bang anything + - address array array/select array/resize dec dump inc init`; attributes: those of `j.parameter` plus `format` (`single`, `array`).

## `j.remote_array`
- Outlets: `set`, value, index, dump. Inlets: value, index.
- Messages: `bang anything array array/select array/resize dump set setArray` and `address`. Attributes (refpage): `active address description format freeze highlight tags unit`.
- Binding (RA `remote_array_subscribe`, `remote_return_model_address`): absolute names are used as they are; relative ones below the model of the view (or model) patcher, else below the root; retried 100 times.
- Each value: index, then the value outlet at once; then, from a low-priority queue, `set <value>` (`setlist <list>` in `array` format) from the left outlet, every value in order (RA `remote_array_return_value`, `remote_ui_queuefn`).
- `set` / `setArray`: meant to be silent; the flag is cleared by the first answer, so with `*` selected only the first instance's answer is suppressed (RA `remote_set`, `remote_array_return_value`).
- Changing `address` unbinds and removes all instances, then builds anew.

## Rulings
1. The spec's differences 1 to 5 stand (all confirmed in the source).
2. Instances made later get the attributes set so far; existing instances are not touched again (the old code re-applied the box attributes to all).
3. `set` and `setArray` show nothing here for any instance (spec: silent). Goes in `docs/changes.md`.
4. `dump` answers the attributes of the watched instance and `format` (an addition; the old did nothing).
5. A name without a bracket, with two, with a non-number or above 256 is an error and leaves the array as it was.
