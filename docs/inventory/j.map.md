# j.map (old behaviour, read for milestone 4)

Sources read: `JamomaMax/source/j.map/j.map.cpp` (257 lines), `Jamoma.0.5.7/Modules/Modular/library/PeerObject/TTMapper.cpp`, the function classes in `Jamoma.0.5.7/Core/DSP/extensions/FunctionLib/source/`.

## Object
- One inlet, outlets: data (0), dump (1) (`j.map.cpp:20-21`). Argument: none needed; attribute arguments as everywhere. `int`, `float`, `list` map every element; `reset` re-applies the creation arguments (`map_reset`); `return_*` are internal.
- The wrapped `TTMapper` publishes (TTMapper.cpp:49-75): `input`, `output` (addresses), `inputMin`, `inputMax`, `outputMin`, `outputMax` (float, setters), `active` (bool), `inverse` (bool), `function` (symbol, setter), `functionLibrary` (read-only list of the function names), `functionParameters` (read-only list of the attribute names of the current function), `functionSamples` (read-only, 100 samples), `ramp` (uint). Max attribute names are the lowercase forms the old reference page lists. The attributes of the current function (for example `base`) are also exposed as attributes of the mapper.
- `input` binds a receiver to `<input>:value`; each value that arrives is mapped and sent to the sender on `<output>:value` (if any), to the data outlet, and with `ramp > 0` the command carries `ramp <ms>` (`TTMapperReceiveValueCallback`, TTMapper.cpp:~700).
- If the input (output) address is a data node already, `inputMin/Max` (`outputMin/Max`) are taken from its `rangeBounds` and followed while no explicit value was set (`mObserveInputRange`); setting a limit by hand stops following. If the node appears later the same happens at creation (`TTMapperInputCreationCallback`: an explicit value is kept unless it is still the default 0 / 1).
- The `return_input_going_down/up`, `return_output_going_down/up` callbacks send `input/going/down` etc. out of the dump outlet; nothing in the old package could trigger them in 0.6 (no ramp events are wired). Not built (Ruling 6).

## The law (TTMapper.cpp `processMapping`, `scaleInput`, `scaleOutput`)
1. Clip the input to `[inputMin, inputMax]` (`TTValue::clip`).
2. `a = 1/(inputMax - inputMin)` (1 if equal), `t = a*x - a*inputMin`.
3. Apply the function `f` to `t` (none loaded = identity).
4. `y = (outputMax - outputMin) * f + outputMin`; with `inverse`: `y = (outputMax - outputMin) * (outputMax - f) + outputMin`.
5. Clip the result to `[outputMin, outputMax]`.
The inverse formula of step 4 equals `1 - f` only when `outputMax == 1`; otherwise it is wrong (Ruling 2).

## The function library (class names are the values of `function`)
`linear` y = x. `cosine` y = 0.5 - 0.5 cos(pi x). `crossFadeIn` y = sin(x pi/2). `crossFadeOut` y = 1 - sin((1-x) pi/2). `exponential` (`base`, default e, range epsilon .. 100000, clipped low; base 1 = identity) y = (exp(k x) - 1)/(base - 1), k = ln base. `logarithm` (`base`, default e, same range; base 1 = identity) y = ln(x (base-1) + 1) / ln base. `power` (`powerValue` default 1, `symmetry` none|point|axis, default none; K = 2^powerValue) none: y = x^K; axis: y = |2x - 1|^K; point: y = 0.5 (sign(2x-1) |2x-1|^K + 1). `smoothPolynomial` y = x^3 (x (6x - 15) + 10). `tanh` (`offset` default 0, `width` default 0.5; a = ln 7 / width (ln 7 if width <= 0), b = (offset + 1)/2, f0 = tanh(-a b), f1 = tanh(a (1 - b)), alpha = 1/(f1 - f0), beta = f0) y = alpha (tanh(a (x - b)) - beta). `lowpass` (`coefficient` default 0.75) a one-pole filter on the sequence of calls (stateful: y = y_prev c + x (1 - c)). `freehand` (`curveList`: a point `x y`, then for each further point a function name with at most one `attribute value` pair and the point; the first point carries an implicit `exponential base 1` in the list the getter returns) evaluates in segments: x below the first point's x gives its y; for x between two points the segment's function is applied to `(x - x0)/(x1 - x0)` and scaled `y = (y1 - y0) f + y0`; x beyond the last point gives the last y; an empty list leaves y untouched; a missing function name means `linear` (FreeHand.cpp `setCurveList`, `calculateValue`, lines 80-250). All are in 0..1 -> 0..1.
`functionLibrary` returns these names in registration order. Source lines: Cosine/CrossFade*/Exp/Linear/Log/Power/SmoothPolynomial/Tanh/Lowpass/FreeHand `*.cpp` `calculateValue`.

## Rulings
1. **All eleven functions are built**, `lowpass` (stateful) and `freehand` included; names and attribute names as above.
2. **`inverse` is `outputMin + (outputMax - outputMin) * (1 - f)`**: the old line is wrong for `outputMax != 1` (`(outputMax - f)` where `1 - f` is meant). Same as the old for the default output range; listed in `docs/changes.md`.
3. **Function parameters are named** (`base`, `powerValue`, `symmetry`, `offset`, `width`, `coefficient`, `curveList`), not a list of numbers: the core takes a name/value map. (This changes the proposed `Mapper` signature of the plan.)
4. NaN and infinity in: NaN gives `outputMin`; infinities are clipped like any out-of-range value; the function result is clipped to the output range (as the old step 5), never NaN. An unknown function name is reported on the console and the previous function stays.
5. Equal input limits give `t = a*x + b` with `a = 1`: the old arithmetic is kept (Max users saw this).
6. The four `return_*_going_*` dump messages are not built (never produced in 0.6). Listed in `docs/changes.md`.
7. `functionsamples` keeps the old 100 samples over `[inputMin, inputMax)`.
