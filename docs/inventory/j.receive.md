# j.receive

Value or signal observer

## Arguments

- `subscription node address` (symbol, optional): Address of the node that the object will listen to. If no argument is provided, the object will not be subscribing to any node initially.

## Inlets

- 0 INLET_TYPE: Set address of node to listen to

## Outlets

- 0 OUTLET_TYPE: Value output
- 1 OUTLET_TYPE: Address of the associated node
- 2 OUTLET_TYPE: dumpout

## Messages

- `bang` : Ouptut current value for the associated node.
- `dump` : The message dumb will output the current value of all attributes for the associated node.

## Attributes

| Attribute | Type | Size | Default | Description |
|---|---|---|---|---|
| `active` | int | 1 |  | When the j.return object is active, it will output new values whenever the value of the associated node changes. If j.return is not active, values will only be output when requested by a bang. |
| `address` | symbol | 1 |  | This sets the address of the associated node that the object will listen to. The address can be absolute and take the form of an OSC address, or relative, in which case the relative address is appended to the address of the j.model or j.view object in the model or view that this j.return object is part of. |

<!-- HAND-WRITTEN: everything below this line is kept when this page is regenerated -->

## Semantics from JamomaCore/Modular

**Implementation.** `source/j.receive/j.receive.cpp` wrapping `TTReceiver` (`JamomaCore/Modular/library/source/TTReceiver.cpp`). Attributes: `address` (setter), `active` (setter), hidden `objectCache`; messages `get`, `grab` (`TTReceiver.cpp:38-49`). Max methods: `receive_return_address`, `receive_return_value`, `receive_bang`, `receive_address`, `receive_return_model_address`, signal methods `dsp` / `dsp64`. Read.

**Dependencies**: as `j.send` (node tree, enclosing model/view address); `grab` and `get` read the current value of the target.

To characterise for milestone 2: how values returned from the target reach the outlet (`receive_return_value`), and the `active` semantics.
