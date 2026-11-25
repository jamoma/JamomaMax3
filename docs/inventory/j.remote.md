# j.remote: characterisation for milestone 3

*Read* in `source/j.remote/j.remote.cpp` (666 lines), the reference page and the old test `Modular/j.remote/dataspace/j_remote_dataspace_db2linear`.

- **Purpose:** keeps a UI object (a slider, number box, ...) and a node (parameter, message or return) showing the same value. Argument: the node address (relative to the model or view, or absolute); attributes `active`, `address`, `unit`, `freeze`, `highlight`. *Read.*
- **Outlets:** the value outlet (values to send onward, as `remote_return_value`), the **set** outlet (`set <value>` to the connected UI object so it shows the value without sending), the dump outlet. A UI object connected to the set outlet shows the node's value; if nothing is connected to it the value outlet is used (`remote_attach`, `:487-550`). *Read.*
- **From the UI to the node:** `bang`, `int`, `float`, `list`, `anything` are sent to the node as a command (`jamoma_viewer_send`); the node answers as for any command. *Read.*
- **`set <value>`** (`remote_set`, `:411`): sets a flag so that the **next** value that comes back from the node is not output again; used when a UI object sets itself. Echo suppression is therefore one-shot: the value that `set` caused is swallowed, later ones pass. *Read.*
- **From the node to the UI:** every change of the node's value is output on the value outlet and, queued once per main-thread cycle (`qelem`), as `set` on the set outlet (`remote_return_value`, `:353-380`), unless the one-shot flag swallows it. *Read.*
- **Unit:** the `unit` attribute chooses the unit the UI object works in (dataspace conversion in both directions, as for `j.parameter`'s `unit`). *Read (reference page).*
- **Binding:** deferred after creation (`remote_subscribe`, `:218`), retried while the model address is unknown (a view whose `model:address` is not there yet); highlights the connected UI object while the mouse is over it (`highlight`, cosmetic). *Read.*
- **The old test** `j_remote_dataspace_db2linear`: a `j.remote` with `unit db` on a gain parameter: a UI value in dB arrives at the parameter as the linear value. *Read (patcher).*

## Rulings

1. **The core `Remote`** keeps the one-shot suppression of `set` (a set value is not shown back to the UI once) and adds the guard against loops (`from_ui` never echoes the node's answer to that command to the UI object).
2. **`highlight` and the mouse highlighting of the connected UI object are not built** (cosmetic; the attribute is accepted and stored); the set-outlet routing (no UI object connected: use the value outlet) is built as a plain two-outlet design, the connected object is not inspected.
3. **The value outlet carries the node's changes after conversion to the `unit`;** `active 0` stops both outlets; `freeze 1` stops the node-to-UI direction only.
