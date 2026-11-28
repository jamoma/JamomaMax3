# j.oscinstance and j.oscroute (old behaviour, read for milestone 5)

Sources read: `JamomaMax/source/j.oscinstance/j.oscinstance.cpp` (I), `source/j.oscroute/j.oscroute.{cpp,h}` (R); the five old tests.

## j.oscinstance
Outlets left to right: address without instance, instance, arguments, dump (unmatched input). Bang, int and float leave the dump outlet (I). Anything else is split by its selector:
- One leading `/` is skipped; the first `.` is looked for, then the first `/` after the leading one. No dot, or a slash before the dot: the whole message leaves the dump outlet.
- Instance = the text after the dot up to that slash (or the end). Address = the text before the dot (leading slash kept) plus the slash and what follows.
- Instance is sent as an int when `strtol` consumes all of it (so an empty instance is 0), else as a symbol.
- Order: arguments, instance, address. Arguments: none = bang; one int, float or symbol = that; several = a message whose selector is the first if it is a symbol, else `list`.

| input | address | instance | arguments |
|---|---|---|---|
| `/a.2/b 5` | `/a/b` | 2 | 5 |
| `a.x` | `a` | `x` | bang |
| `a.2/b.3` | `a/b.3` | 2 | bang |
| `/a/b.2` | dump: the message | | |
| `a.` | `a` | 0 | bang |
| `plain` | dump | | |

## j.oscroute
One inlet per argument besides the first (n arguments: 1 + n inlets), outlets n + dump (rightmost). No argument: the pattern `/nil`, one outlet, one extra inlet. Int arguments become their decimal text, floats the `%f` text.
- A symbol or message in inlet i (1..n) replaces pattern i. Bang, int, float leave the dump outlet whatever the inlet; a list leaves it as a list.
- First pass, patterns in order: the selector begins with the pattern and is longer: a match only if the next character is `/`; the output is the message with the selector after that slash. Same length: the arguments only (none = bang; one = int, float, symbol; several = selector from the first symbol, else `list`). The first match ends the pass.
- Second pass (also after a first-pass match, which can give two outputs): patterns containing `*`, in order, the first match ends:
  - `*` last: the selector begins with the text before it. The output selector is the rest from the next `/` (slash kept); without a slash, only the arguments.
  - `*` elsewhere: only the text after the (first) `*` run counts, compared with the end of the selector; the output selector is that end. A selector shorter than it reads before the string (a bug).
- Nothing matched: the message leaves the dump outlet.

| patterns | input | out |
|---|---|---|
| `/fruit` | `/fruit/apple 1` | 0: `apple 1` |
| `/fruit` | `/fruitcake` | dump |
| `/fruit` | `/fruit 3` | 0: `3` |
| `/robot*` | `/robot.1/arm 2` | 0: `/arm 2` |
| `/robot*` | `/robot.1` | 0: bang |
| `*/gain` | `/a/b/gain 4` | 0: `/gain 4` |

## Rulings
1. All of the above is kept, the second output after a first-pass match included.
2. A selector shorter than the suffix of a middle `*` is no match (the old read outside the string).
3. No fixed length limit (the old buffers held 2048 characters).
