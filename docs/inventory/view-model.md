# Views and models: characterisation for milestone 3

*Read* in `source/j.model/j.model.cpp`, `source/j.view/CMakeLists.txt`, `JamomaMax/Shared` helpers as named, and the qmetro patchers.

- **`j.view` is `j.model` compiled with `JCOM_VIEW`** (`source/j.view/CMakeLists.txt`; the `#ifndef JCOM_VIEW` blocks of `j.model.cpp`): same class with the model-only behaviour removed (presets of the model, signal amenities, the init message). *Read.*
- **Context.** Each patcher has a *class* and a *context* taken from its file name: `qmetro.model.maxpat` is class `qmetro`, context `model`; `qmetro.view.maxpat` is class `qmetro`, context `view` (`jamoma_patcher_get_info`, `j.model.cpp:222`). *Read.*
- **The address of a model** is `/` + its argument, else the patcher's class (`qmetro`; the module patcher passes `#1`, the instance name, as the model argument: `qmetro.model #1`); several instances of one class get `.1`, `.2`. A model patcher inside a model patcher is registered below it. *Read (`:222-345`).*
- **How a view learns the address of its model** (`model_address_to_bind`, `:367-460`): if the patcher (or bpatcher) was given an argument, the first symbol is the model address: **absolute** is used as it is, **relative** is taken under the model address of the enclosing view, else from the root; **with no argument** the view looks in the patcher that contains it for a model patcher of the **same class** and takes the address of the model registered there, trying again deferred until the model exists. The result is the view's `model:address` attribute, which observers (j.ui, j.remote with relative addresses) follow. *Read.*
- **`#0` / `#1`** (`jamoma_parse_dieze`): `#0` stands for the unique id of the patcher instance, `#1`.. for the arguments of the abstraction or bpatcher; they are substituted in the object arguments and addresses before use. To characterise exactly (the helper lives in the old shared code, not read): milestone 3 implements `#0` as a per-patcher-instance unique number and `#1`.. as the patcher arguments, and tests it with an own abstraction.
- **Aliases** (`alias`, `alias/remove`): an extra node for the model; **`activity`** is a read-only attribute that reports (a number) when a parameter below the model changes. *Read (reference page).*
- **`amenities`** (`all`, `data`, `audio`, `preset`, `none`): which services the model provides; for data milestone 3 implements `preset` and `data` (the in/out nodes), the audio ones are accepted and stored.

## Rulings

1. **One shared implementation, two registered names** (`model_object.hpp`). The old code does not say where a view registers; the new `j.view` registers under its own address by the same rule as a model (its patcher class, the `view` context, instances numbered) and is bound to a model through the observed `model:address`; `dump` reports the model it is bound to, or that it is waiting.
2. **The model address comes from, in order:** an explicit argument (absolute, or relative to the enclosing model), else the patcher argument, else (views only) the model of the same class in the containing patcher; a model without any argument uses its patcher's class name (the part of the file name before `.model`), falling back to the file name with dots replaced (as milestone 1).
3. **Binding is observed, not retried:** a view binds when a model appears at its address and lets go when it goes (the observation of Task 2), instead of the old deferred retries.
4. **`#0` and `#1`..** as above; unknown `#n` is left as written.
