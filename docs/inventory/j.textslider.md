# j.textslider (old behaviour, read for milestone 4)

Source: `JamomaMax/source/j.textslider/j.textslider.cpp` (703 lines, read in full); help `j.textslider.maxhelp`.

## Object
- A UI box (`jbox`), one inlet, one outlet (a float). Default rect 160 x 20, `patching_size` minimum 1 x 1, font Jamoma default at size 10; size limits 1..1200 wide, 1..400 high (`oksize`).
- Attributes (name, default): `bgcolor 0.8 0.8 0.8 0.7`, `fgcolor 0.95 0.95 0.95 1`, `bordercolor 0.5 0.5 0.5 1`, `textcolor 0 0 0 1`, `knobcolor 0.7 0.7 0.7 1`; `range 0 1` (two floats; if the second is smaller than the first they are swapped); `textpos 10 4` (horizontal, vertical offset of the text); `text textslider`; `unit` (empty); `tracking horizontal` (`horizontal vertical both`); `clickjump 1`; `showvalue 1`; `defaultvalue 0`.
- Messages: `bang` outputs the value last given (unclipped); `int`/`float` store the unclipped value, output it, and draw the value clipped to the range; `set <float>` stores without output.
- Drawing: background rectangle, a 2 px border, a filled bar from the left to the value position (`(width - 3) * normalised + 1`), a 2 px knob line at its end (both only if the value is above the range minimum). Equal range ends draw at 0.5. The text (a Max textfield, read-only, ellipsis) shows `text`, and while the mouse is over the box with `showvalue` on, the value with three decimals and the unit (`%.3f unit`).
- Mouse: down jumps to the position when `clickjump` (Command rounds to an integer), then drag by delta: horizontal, vertical (`-y`) or the larger of both; precision factor `width - 2` over the range delta, times 0.8 with Command and 50 with Shift (fine); Command makes steps integers. Up puts the pointer at the knob. **Ctrl + double-click** resets to `defaultvalue`.

## Rulings
1. **Built as read**, including the attributes `tracking`, `clickjump`, `showvalue`, `defaultvalue` (the plan's list missed them) and the swap rule of `range`.
2. The output is the unclipped value (as the old); `defeat`, listed in the plan from an old field, is **not** an attribute of the class (it is only a struct field): not built.
3. The mouse maths is a pure function in the core (`slider.hpp`) so it is tested without Max; the look is checked by the author's eye.
4. Text is drawn with jgraphics (spec section 7), not with a Max textfield; the textfield's clipping is replaced by clipping to the box.
