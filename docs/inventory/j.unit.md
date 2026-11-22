# j.unit: characterisation for milestone 2

*Read* in `source/j.unit/j.unit.cpp` (261 lines), the old reference page and the three old integration tests that use it.

- **Object.** A wrapper around the Foundation `dataspace` object: attributes `dataspace` (symbol), `input` (symbol, the active unit), `output` (symbol, the native unit); creation default: if no dataspace is given it is `temperature` (`dataspace_new`, `:101-120`). *Read.*
- **Messages.** `int`, `float` (convert one number; output as float), `list` (converts every element as float; the output list may be longer than the input, e.g. for position units: output size is the converted vector's size) (`dataspace_list`, `:162`); `dataspaces.get` and `units.get` send `DataspacesMenu` / `UnitsMenu` lines (`clear`, then one `append <name>` each) to the **dumpout**. *Read.*
- **Outlets.** 0 converted value, 1 dumpout (`dataspace_assist`). *Read.*
- **Dataspaces needed.** gain, time and position exist (milestone 1). The old default `temperature` does not; the three old tests need position only. `temperature` is added (celsius, fahrenheit, kelvin; formulas from the old `TemperatureDataspace`, to be read in Task 9). Other old dataspaces (angle, distance, speed, ...) are not in milestone 2.

## Rulings

1. **`j.unit` implemented with the attributes and messages above;** `dataspace` defaults to `temperature`, which is added with `celsius`, `fahrenheit`, `kelvin`; any other dataspace name gives one console error and no output.
2. **Output type:** a single number is output as a float, a list as a float list (as the old object).
