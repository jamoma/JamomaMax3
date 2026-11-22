# j.in and j.out (data variants): characterisation for milestone 2

*Read* in `JamomaCore/Modular/library/source/TTOutput.cpp`, `TTInput.cpp`, `source/j.out/j.out.cpp`, `source/j.in/j.in.cpp`, `qmetro.model.maxpat`. Audio (`j.in~`, `j.out~`) is not built.

- **Node.** `j.out` subscribes an Output object at `<model>/data/out.<instance>` (`out_subscribe`, `j.out.cpp:283`: `signalAddress = "data"` for the plain variant; the instance is the argument, a number, default 1; a second one with the same number becomes the next free instance). `j.in` subscribes at `<model>/data/in.<instance>`. *Read.*
- **Link.** The output remembers the address of the input with the same instance in the parent (`inputAddress`, hidden); with an `in` below it, `Send` can be bypassed to it. *Read.*
- **Output attributes** (`TTOutput.cpp:24-47`): `tags`, `mute` (default no), `mix` (100), `gain` (100), `freeze` (no); hidden `inputAddress`, `signal`. For data only `mute` and `freeze` act: `Send` drops the value when muted; when frozen it outputs the last value again instead of the new one (the last value is kept only while not frozen) (`:76-105`). `mix` and `gain` exist but only affect audio; for data they are stored. *Read.*
- **Input attributes** (`TTInput.cpp:26-27`): `mute` (no), `bypass` (no), `tags`. `Send`: muted → nothing; bypassed and an output with the same instance exists → that output's `SendBypassed` (which outputs as `Send`); otherwise the value goes to the input's own return. *Read.*
- **Max objects.** `j.out` has one inlet and one outlet for data (`outlets[0]`), values arriving as bang, int, float, list, anything are forwarded as the output `Send`; `out_return_signal` writes the result to the outlet with the "avoid blank selector" rule. `j.in` takes values from the model's inlet and outputs them. *Read.*
- **qmetro** uses `j.out 1` once (a trigger out of the model). *Read.*

## Rulings

1. **Milestone 2 builds both objects as pass-throughs with nodes:** value in, value out, registered at `<model>/data/out.N` and `<model>/data/in.N` with the attributes above (host-visible through `j.send` / `j.receive` and `dump`). The audio parts of the nodes (`signal`, `mix`, `gain` effects) are not built; `mix` and `gain` are stored only. Cost if wrong: a patcher that relied on gain on a data output loses it (it never had an effect on data).
2. **The `j.in` / `j.out` link** (bypass to the output of the same instance) is implemented for data through the namespace lookup of the sibling node.
3. **No `data/in`/`data/out` special casing in `j.send`** (the old `signal` binding for `in`): not done.
