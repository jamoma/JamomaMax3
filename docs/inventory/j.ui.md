# j.ui

A GUI widget providing access to some model embedded features

## Arguments

(none)

## Inlets

(none)

## Outlets

(none)

## Messages

- `(mouse)` : Access embedded features provided by the model patcher the view is binding to. model address: clicking the model address the view currently binds to brings a dropdown menu listing all parameters, messages and returns registered under the model address node menu widget: clicking the menu arrow brings a dropdown menu giving access to preset management commands and other utilities: Open Model Reference Page: selecting item sends the model:reference/open message Open Model Help Patch: selecting item sends the model:help/open message Open Model Internal: selecting item sends the model:internal/open message Edit Current State: selecting item sends the preset:edit message Load Presets File: selecting item sends the preset:read message Save Presets File: selecting item sends the preset:write/again message Save Presets File As: selecting item sends the preset:write message Edit Presets File: selecting item sends the preset:edit message Create New Preset: selecting item sends the preset:new message Update Current Preset: selecting item sends the preset:update message Delete Preset: selecting item sends the preset:delete message (preset name): selecting a preset name sends the preset:recall (preset name) message Depending on the type of your model (audio or control), j.ui will automatically display the widgets corresponding to the available internal parameters. Models including a combination of j.in~ and/or j.out~ provide in j.ui (from left to right): audio gain widget: dragging the knob sets the model's internal audio/gain parameter mix widget: dragging the knob sets the model's internal audio/mix (wet/dry) parameter mute widget: clicking the button toggles on or off the model's internal audio/mute parameter (default off) bypass widget: clicking the button toggles on or off the model's internal audio/bypass parameter (default off) Models including a combination of j.in and/or j.out provide in j.ui (from left to right): bypass widget: clicking the button toggles on or off the model's internal data/bypass parameter (default off) active widget: clicking the button toggles on or off the model's internal data/active parameter (default on) j.ui also provides an + button when a secondary panel view is built in your view. plus widget: clicking the button opens panel window

## Attributes

| Attribute | Type | Size | Default | Description |
|---|---|---|---|---|
| `bgcolor` | float | 4 |  | Background color. Note that j.ui is not yet compatible with Max 7 styling features |
| `bordercolor` | float | 4 |  | Border color. Note that j.ui is not yet compatible with Max 7 styling features |
| `headercolor` | float | 4 |  | Header color. Note that j.ui is not yet compatible with Max 7 styling features |
| `textcolor` | float | 4 |  | Text color. Note that j.ui is not yet compatible with Max 7 styling features |

<!-- HAND-WRITTEN: everything below this line is kept when this page is regenerated -->

## Semantics from JamomaCore/Modular

**Implementation.** `source/j.ui/j.ui.cpp` (55 KB), `j.ui.internals.cpp`, `j.ui.presets.cpp`, `TTUiInfo.*`, built on `jbox`. Read.

**Max-level behaviour** (`class_addmethod` list, `j.ui.cpp:68-101`): `notify`, `paint`, `mousedown`, `mousedragdelta`, `mouseup`, `mousemove`, `mouseleave`, `oksize`, `dblclick`, `edclose`, plus callbacks from the observed model: `return_modelParamExploration`, `return_modelMessExploration`, `return_modelRetExploration`, `return_modelClassExploration`, `return_model_address`, `return_model_init`, `return_model_class`, `return_model_content`, `return_mute`, `return_bypass`, `return_mix`, `return_gain`, `return_freeze`, `return_active`, `return_preset_names`. Default `patching_rect` 0 0 300 70; attributes include `bgcolor`, `bordercolor`, `headercolor`, `textcolor`, `highlightcolor`, `fontname`, `fontsize`. Read.

**How it observes a model** (`j.ui.h`): one `TTSubscriber` binding the ui node, and four `TTExplorer` objects observing the model's messages, parameters, returns and all models of the same class; it keeps `modelAddress`, `modelClass` and the patcher context (model or view). Feature flags decide what the panel shows: `has_preset`, `has_model`, `has_panel`, `has_meters`, `has_mute`, `has_bypass`, `has_freeze` and more. The empty state shows "waiting for a model:address". Read.

**Presets** (`j.ui.presets.cpp`, `JamomaCore/Modular/library/source/TTPresetManager.cpp`, `TTPreset.cpp`): the manager has attributes `address`, `names`, `current`, `currentPosition` and messages `clear`, `new`, `update`, `recall`, `output`, `interpolate`, `mix`, `move`, `delete`, `order`, `rename`, `copy`, plus XML and text read/write (`TTPresetManager.cpp:36-75`); one preset has `name`, `description`, `address` and `clear`, `store`, `update`, `recall`, `output` (`TTPreset.cpp:29-49`). `j.ui` loads the abstraction `j.preset_interface.maxpat` for the preset panel (`j.ui.presets.cpp:44`). The text preset format is visible in `Jamoma/patchers/models/data/qmetro/qmetro.model.presets.txt` (the first test patch). Read; the formats are To characterise in milestone 3.

**Text field.** `jbox_get_textfield` is used (`j.ui.cpp:274`, `:433`); the spike showed Min-API does not provide it (see the spec, section 7). To characterise which interactions need it.

**Dependencies**: `TTExplorer`, `TTSubscriber`, `TTPresetManager`/`TTPreset`, `TTTextHandler` (the text editor content), the jgraphics drawing API, the abstraction `j.preset_interface.maxpat`.
