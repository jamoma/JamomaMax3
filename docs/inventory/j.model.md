# j.model

Declare patcher as a model

## Arguments

(none)

## Inlets

(none)

## Outlets

(none)

## Messages

- `preset:new` Name of preset to store:list: The preset:new message stores current state of a model as a preset. First argument to the preset:new message will save state under a particular name. An optionnal second argument will set a position in the list of presets. With no argument, preset:new will override the last recalled state
- `preset` Name of preset to recall:list: The preset message followed by a preset name puts a model in a state previously saved. When the preset message is followed by an integer, it will recall the preset stored at this index
- `preset:delete` Name of preset to remove:list: The preset:remove message followed by a preset name removes the preset from the current model's list of presets
- `preset:edit` Name of preset to edit:list: The preset:edit message followed by a preset name brings up j.model text window to manually edit the preset's content. Without argument, preset:edit will bring up j.model text window with all presets
- `preset:clear` : The preset:clear message clears j.model's current list of presets
- `preset:read` Name of preset file to read:list: The preset:read message followed by a file name in Max searchpath reads list of preset previously saved. With no argument, preset:read brings a popup window to select the file to load
- `preset:write` Name of preset file to write:list: The preset:write message followed by a file name writes j.model's current list of presets in a text file. Without any argument, preset:write brings a popup window to set where to write the file on disk
- `preset:write/again` : The preset:write/again saves j.model's current list of preset in the opened text file
- `preset:names` : The preset:names message sends the current list of presets out of j.model right-most window
- `preset:move` Name of presets to move:list New position of preset:int: The preset:move message followed by a preset name and an index moves that preset to a new index. preset:move can also accepts two integers as argument defining index of the preset to move & new index
- `preset:copy` Name of the preset to copy:symbol New name of the preset:symbol Optional index position:int: The preset:copy message followed by two string copies that preset to a new preset named as second argument. preset:copy can also accepts a third optional argument defining an index
- `preset:rename` Current name:symbol New name:symbol: The preset:rename message followed by two strings renames the preset defined as first argument as the name defined as second argument
- `preset:interpolate` Presets name and interpolation value:list: The preset:interpolate message followed by two integers defining presets indexes and a float value will interpolate between the two prests
- `preset:mix` Preset name and weight value pairs:list: The preset:interpolate message followed by pairs of integer defining a preset index and a float defining an amount does a weighted mix of multiple presets
- `alias/remove` Name of the alias to remove:list: The alias/remove message removes the OSC alias of the model
- `(mouse)` : Double-click object opens a text editor with all current values of all parameters of the model
- `dump` : The dump message outputs all attributes' values out the rightmost outlet
- `init` : The init message initializes this model. This message is implemented as a j.message embedded in the j.model object
- `model/edit` : 
- `model:help/open` : 

## Attributes

| Attribute | Type | Size | Default | Description |
|---|---|---|---|---|
| `alias` | symbol | 1 |  | The alias attribute provides the model with an OSC alias. This can be used for future remote OSC communication to the model |
| `activity` | boolean | 1 |  |  |
| `amenities` | symbol | 1 |  | The amenities attribute selects j.model's provided services to specific needs. The amenities attribute can be set as an argument to its patcher. It will then override amenities defined within the model. |
| `description` | symbol | 1 |  | The description attribute sets a textual description of the model for auto-documentation purposes |
| `presets` | list | 0 |  | The presets attribute displays the list of j.model's current presets |
| `priority` | int | 1 |  | The priority attribute sets the priority of the model. It allows to define the order in which model will be saved/recalled from preset and cue. The priority attribute can be set as an argument to its patcher. It will then override priority defined within the model. |
| `tags` | atom | 1 |  | The tags attribute sets an arbitrary list of tags that can be further used by several services such as j.namespace |

<!-- HAND-WRITTEN: everything below this line is kept when this page is regenerated -->

## Semantics from JamomaCore/Modular

Paths relative to the old checkout. "Read" / "To characterise" as in `j.parameter.md`.

**Implementation.** The Max external is `source/j.model/j.model.cpp` (+ `j.model_preset.cpp`, `j.model_signal.cpp`, `TTModelInfo.*`) wrapping a `TTContainer` (`JamomaCore/Modular/library/source/TTContainer.cpp`). Read.

**Container attributes** (`TTContainer.cpp:41-62`): `priority`, `description`, `service`, `tags`, `initialized` (read-only), `active`, `address` (hidden), `alias`, `monitor` (read-only), `content` (read-only). Messages: `send` (hidden), `init`, `rename` (hidden), `aliasRemove`, `writeAsText` (hidden) (`:65-77`). Read.

**Max-level methods** (from the `class_addmethod` list in `j.model.cpp`): assist, `model_share_patcher_info`, `model_share_patcher_node`, `model_return_address`, `model_return_value`, `model_return_upper_view_model_address`, `model_address`, `model_reference_write`, `model_preset_return_names`, `model_preset_filechanged`, `model_preset_read`, and more (the list is longer; read the file when planning). To characterise.

**Conditional compilation.** `j.model.cpp` contains `#ifndef JCOM_VIEW` blocks (`:29`, `:68`, `:115`) that remove model-only behaviour from `j.view` (see `j.view.md`). To characterise which behaviours.

**Dependencies**: `TTContainer`, `TTSubscriber` (address registration and the node tree), the preset manager (`TTPresetManager`, preset messages and files, see `j.ui.md`), `TTModelInfo` (patcher-level context sharing between model, view and the abstractions inside a patcher).
