# Milestone 5: results

(Filled in as the milestone goes; completed in the last task.)

## Checks for the author: hardware

`midiin` (a MIDI device, in `midiin.model.maxhelp`):
- the device appears in the menu of the view and can be chosen;
- notes, program changes, pitch bend, mono and poly aftertouch arrive in their returns;
- controller n arrives in `cc.n` (controller 0 in `cc.128`);
- `normalization` (none, normalize, s-normalize) changes the values as expected; `midiChannel` filters.

`hi` (a human interface device, in `hi.model.maxhelp`):
- the devices appear in the menu and can be chosen;
- moving a control changes the matching `hi.n`;
- `data/active`, `polling_interval` and `defer` work; `info` prints the device information.
