# j.send

Send value to node

## Arguments

- `target node address` (symbol, optional): Address of the target node (ie. j.parameter) that j.send will forward messages to.

## Inlets

- 0 INLET_TYPE: Value to send

## Outlets

- 0 OUTLET_TYPE: Absolute address of the target node

## Messages

- `bang` : A bang is forwarded to the associated node, and the node will respond in the same way as if it received a bang directy.
- `int` number:int: An integer is forwarded to the associated node, and the node will respond in the same way as if it received an int directy.
- `float` number:float: A decimal nunber is forwarded to the associated node, and the node will respond in the same way as if it received a float directy.
- `list` list:list: A list is forwarded to the associated node, and the node will respond in the same way as if it received the list directy.
- `anything` list:list: The message is forwarded to the associated node, and the node will respond in the same way as if it received the message directy.
- `address` ARG_NAME_0:symbol: The message address followed by an absolute or relative address set the target address.
- `dump` : Dump object attributes value.
- `symbol` ARG_NAME_0:symbol: The symbol is forwarded to the associated node, and the node will respond in the same way as if it received the symbol directy.

## Attributes

| Attribute | Type | Size | Default | Description |
|---|---|---|---|---|
| `address` | symbol | 1 |  | This sets the address of the associated node that the object will bind to and forward values to. The address can be absolute and take the form of an OSC address, or relative, in which case the relative address is appended to the address of the j.model or j.view object in the model or view that this j.send object is part of. |

<!-- HAND-WRITTEN: everything below this line is kept when this page is regenerated -->

## Semantics from JamomaCore/Modular

**Implementation.** `source/j.send/j.send.cpp` wrapping `TTSender` (`JamomaCore/Modular/library/source/TTSender.cpp`). Attribute: `address` (with a setter); hidden `objectCache`; message `send` (`TTSender.cpp:31-38`). Max methods: `bang`, `int`, `float`, `list`, `anything` (`WrappedSenderClass_anything`), `address`, `send_return_model_address`, and signal methods `dsp` / `dsp64` (a signal path exists). Read.

**Address.** Per the reference page, the address may be absolute (an OSC address) or relative, in which case it is appended to the address of the `j.model` or `j.view` the object lives in. Read (`j.send.md`, argument and attribute text).

**Dependencies**: the node tree (it resolves its target through the directory populated by `TTSubscriber`), and the model/view address of the enclosing patcher via `send_return_model_address`. The signal (`dsp`) behaviour is a dependency to decide on in milestone 2: whether `j.send` needs audio-rate sends in the first release.
