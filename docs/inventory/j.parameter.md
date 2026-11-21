# j.parameter

Declare a node within a Jamoma model

## Arguments

- `node name` (symbol): j.parameter requires an argument defining a node name in Jamoma namespace. This is obligatory, and each j.parameter, j.message and j.return within a Jamoma model must have a unique name

## Inlets

- 0 INLET_TYPE: Input value

## Outlets

- 0 OUTLET_TYPE: Value output

## Messages

- `bang` : A bang at leftmost inlet outputs its current value
- `int` : An int at leftmost inlet sets and outputs the value. Depending on the @type attribute, the value might get converted into a float value if the @type attribute is decimal or array or into a string if the @type attribute is string
- `float` : A float at leftmost inlet sets and outputs the value. Depending on the @type attribute, the value might get converted into a int value if the @type attribute is integer or into a string if the @type attribute is string
- `list` : A list at the leftmost inlet sets and outputs the value. If the @type is decimal, integer or string, only the first list member will be used to set the value, and the type of this list member might be converted to fit the specified @type of the parameter If the @type attribute is decimal, integer or array and ramping is enabled (as specified by @ramp/funcion and @ramp/drive), the two last list members can be used to request a ramp over time to the new value. If so, the second last list member should be the symbol ramp and the last list member specifies the desired ramp time in milliseconds If the @type is decimal, integer or array and a dataspace is used (as specified by @dataspace and @unit), the new value can be set using alternative units. In this case the unit of new value is provided immediately following the numerical value, as either the last list member or as thre third last list member if a ramp is also being requested. If an alternative unit is requested as well as a ramp, the ramping will happen according to the dataspace unit being used temporarily
- `address` address:symbol: The message address followed by a symbol sets the name of the node. This replaces the name provided initially as an argument to the object and allows to create nodes dynamically
- `+` number of steps:int: The + message increments the current value by the amount defined using the @stepsize attribute. An optional integer argument to the message specifies how many steps to increase the value by (default 1)
- `-` number of steps:int: The - message decrements the current value by the amount defined using the @stepsize attribute. An optional integer argument to the message specifies how many steps to decrease the value by (default 1)
- `dec` number of steps:int: The dec message decrements the current value by the amount defined using the @stepsize attribute. An optional integer argument to the message specifies how many steps to decrease the value by (default 1)
- `dump` : The message dump outputs all attribute settings to rightmost outlet
- `inc` number of steps:int: The inc message increments the current value by the amount defined using the @stepsize attribute. An optional integer argument to the message specifies how many steps to increase the value by (default 1)
- `init` : The message init sent to the leftmost inlet reset the current value to the value defined by the @default attribute
- `anything` input:list: 

## Attributes

| Attribute | Type | Size | Default | Description |
|---|---|---|---|---|
| `active` | int | 1 |  | The @active attribute allows to enable (default: 1) or disable a node |
| `clipmode` | symbol | 1 |  | The @clipmode attribute defines how values exceeding range will be clipped. Available clipmodes are: none: when set tot none (default), exceeding values will be left untouched low: when set to low, values exceeding the lower bound will be clipped. Values exceeding the upper bound will be left untouched high: when set to high, values exceeding the upper bound will be clipped. Values exceeding the lower bound will be left untouched both: when set to both, values exceeding lower or upper bounds will be clipped wrap: when set to wrap, values exceeding lower or upper bound will wrap around the opposite bound fold: when set to fold, values exceeding lower or upper bound will fold back within the defined range |
| `dataspace` | symbol | 1 |  | The @dataspace attribute defines a dataspace used by this node. This enables values to be updated using several alternative units interchangeably, such as degree and radian for the angle dataspace. Available dataspaces are: none (default) angle color distance gain orientation position speed temperature time Note that dataspace and units conversion features are enable when type attribute is set to interger, decimal or array |
| `default` | int | 1 |  | The @default attribute sets the value to output at the leftmost outlet on model initialization. The default value can be overridden by the default model preset |
| `description` | symbol | 1 |  | The @description attribute allows to associate a comment describing what this node controls. The description is used when auto-documenting models. |
| `priority` | int | 1 |  | The @priority attribute controls in what order several values of a state of a Jamoma model will get sent on model initialization or when recalling a preset or cue |
| `ramp/drive` | symbol | 1 |  | The @ramp/drive attribute defines the scheduler driving the ramp. Available options are: none (default): no ramping permitted max: using the Max scheduler system: using the system clock external: value is output with ramp time appended so it can be processed out of j.parameter (ie. using Max's line~) Note that in Max, it is recommended to use max rather than system. |
| `ramp/function` | symbol | 1 |  | The @ramp/function defines an easing function used for ramping. A wide range of easing functions as well as windowing functions are available. Please refer to the help file for further details |
| `ramp/function/parameters` | atom | 1 |  | The @ramp/function/parameters is a read-only attribute listing all configurable parameters for the current ramp function. Certain ramp functions as specified by the @ramp/function attribute have additional configurable parameters that can be changed dynamically to modify the shape of the ramping curve. The message ramp/function/parameters cause j.parameter, j.message and j.return to output a list of all such parameters from the rightmost outlet, prepended by the symbol ramp/function/parameters. Refer to the help file for j.ramp for an overview of what functions have additional configurable parameters |
| `ramp/status` | int | 1 |  | The @ramp/status attribute is a read-only attribute that will be set to 1 when value is currently performing a ramp, and changed to 0 when done |
| `range` | list | 2 |  | The @range attribute defines the expected range of possible values. Depending on the @clipmode attribute, this might be a recommended or definitive range. |
| `repetitions/filter` | boolean | 1 |  | The @repetitions/filter attribute defines whether repetited values will be filtered out or not (default) |
| `stepsize` | int | 1 |  | The @stepsize attribute defines a step value used when incrementing or decrementing the value using one of the messages +, -, inc or dec |
| `tags` | atom | 1 |  | The @tags attribute allows to associate a variable number of tags for this node. This helps documenting the parameter, and is also useful when restricting namespace searches using j.namespace. |
| `type` | symbol | 1 |  | The @type attribute define the type of the value. Possible types are: none (j.message and j.return only) generic boolean decimal integer array string Note that value of type integer, decimal and array enable to use a dataspace and unit as well as ramp features. |
| `unit` | symbol | 1 |  | The @unit attribute defines the dataspace unit used by this node. Values will get output according to this unit |
| `value` | int | 1 |  | Current node value |

<!-- HAND-WRITTEN: everything below this line is kept when this page is regenerated -->

## Semantics from JamomaCore/Modular

Paths are relative to the old checkout (`~/Developer/Jamoma/JamomaMax`). "Read" = I read the code; "To characterise" = seen but not yet understood, input to the milestone 1 plan.

**One implementation, three objects.** `j.parameter`, `j.message` and `j.return` are the same source, `source/j.parameter/j.parameter.cpp`, built with `-DJMOD_MESSAGE` / `-DJMOD_RETURN` (their `CMakeLists.txt`). The source calls `jamoma_data_create(..., kTTSym_parameter | kTTSym_message | kTTSym_return)` (`j.parameter.cpp:221-230`), so they are a `TTData` object whose `service` attribute differs. Read.

**Max surface.** Methods: `bang`, `int`, `float`, `list`, `anything`, `inc`, `dec`, `address`, plus assist and file-usage (`j.parameter.cpp`, `class_addmethod` list). Two outlets: `data_out` (0) and `dump_out` (1) (`#define` at the top of the file). Read.

**Attributes** (`JamomaCore/Modular/library/source/TTData.cpp:65-106`), with constructor defaults (`:38-58`): `valueDefault` (0.0), `valueStepsize`, `type` (generic), `tags` (none), `priority` (0), `description` (none), `repetitionsFilter` (off), `active` (on), `initialized` (read-only), `rangeBounds` (0. 1.), `rangeClipmode` (none), `rampDrive` (none), `rampFunction` (none), `rampFunctionParameters` (read-only), `rampStatus` (read-only, hidden in Max), `dataspace` (none), `dataspaceUnit` (none), `service`, and hidden `dynamicInstances`, `instanceBounds`, `rampDriveDefault`. Read.

**Types** (`JamomaCore/Modular/library/source/TTDataTypedMethods.cpp:19-185`): `none`, `generic`, `string`, `boolean`, `integer`, `decimal`, `array`. The type selects the command and setter methods. `integer`, `decimal` and `array` share one command path and are the only ones that use dataspace and ramping. For `integer` the defaults change: step size 1 (instead of 0.1), range 0..1, value 0. Read.

**Command pipeline** (`TTDataTypedMethods.cpp:189-225`): a command is parsed (`TTDataParseCommand`); for `string` only the first element is kept; for numeric types unit and ramp time are parsed from the message; then the type-specific command runs. Read.

**Clipping** (`TTDataTypedMethods.cpp:233-252`): `rangeClipmode` is one of `none`, `low`, `high`, `both`, `wrap`, `fold`, applied to the value against `rangeBounds` (low clips only below, high only above, wrap and fold re-enter the range). Read.

**Ramps** (`TTData.cpp:560-585`): no ramp for types `none`, `string`, `generic` (the drive is forced to none); a drive of `none` or `external` creates no internal ramper; otherwise a `Ramp` object is created with the chosen drive and function. Read.

**Repetition filter** (`TTDataTypedMethods.cpp:351,433`): with `repetitionsFilter` on and the data initialised, a value equal to the current one is dropped. Read.

**Active and feedback guard** (`TTDataTypedMethods.cpp:295`): a set is ignored when `active` is off or while the data is already sending (`mIsSending`), which prevents feedback loops. Read.

**Initialisation**: the value cannot be read before `initialized` (`TTData.cpp:290-296`); the code special-cases `service == parameter && !initialized` (`TTDataTypedMethods.cpp:268,301`). To characterise (what a parameter does at init versus message/return).

**Other messages**: `inc`, `dec`, and hidden `command`, `rampSet`, `rampTarget`, `rampGo`, `rampSlide`, `writeAsText` (`TTData.cpp:110-127`). To characterise.

**Dependencies on the wider modular family**: the node tree and address registration through `TTSubscriber` (`JamomaCore/Modular/library/source/TTSubscriber.cpp:36-50`: relative, node and context addresses; `subscribe`/`unsubscribe`); the `dataspace` converter library (`TTData::convertUnit`); the `Ramp` object with its drives and functions; `TTTextHandler` for the text export. Whether any of the 783 patchers force the full dataspace and ramp libraries is the first thing the coverage baseline (Task 6) and the milestone 1 plan must answer.
