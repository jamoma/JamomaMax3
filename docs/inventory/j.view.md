# j.view

Declare a patcher as a remote view of a Jamoma model patcher

## Arguments

(none)

## Inlets

- 0 list: Messages to be sent to the view or to the Jamoma model j.view is binding to

## Outlets

- 0 OUTLET_TYPE: Echo values sent to the Jamoma model j.view currently binds to
- 1 OUTLET_TYPE: Dump out outlet

## Messages

- `anything` parameter name:atom: j.parameters' name and value to be sent
- `alias/remove` alias name to remove:symbol: Remove alias name previously set to the view
- `dump` : Dump the view internal state (address, description, tags, j.parameters it binds to) out the right-most outlet

## Attributes

| Attribute | Type | Size | Default | Description |
|---|---|---|---|---|
| `activity` | atom | 1 |  | Read-only attribute to listen to the view activity |
| `alias` | symbol | 1 |  | Set an alias name to the view |
| `description` | symbol | 1 |  | Set a text description to the view |
| `tags` | atom | 1 |  | Some tags associated with this Jamoma model view. This can be useful for browsing purpose for example |

<!-- HAND-WRITTEN: everything below this line is kept when this page is regenerated -->

## Semantics from JamomaCore/Modular

**j.view is not a separate implementation.** `source/j.view/CMakeLists.txt` builds the *same* source files as `j.model` (`../j.model/j.model.cpp`, `j.model_preset.cpp`, `j.model_signal.cpp`, `TTModelInfo.cpp`) with `-DJCOM_VIEW`; the `#ifndef JCOM_VIEW` blocks in `j.model.cpp` (`:29`, `:68`, `:115`) switch model-only behaviour off. Read.

**Consequence for the design:** the spec's open item "whether `j.view` is a C++ external or an abstraction" is answered by the old code: it is a C++ variant of `j.model`. The new package can do the same (one class, two registered names, or a shared base) or keep one implementation with a mode; this is a milestone 3 decision, but the inventory fixes the premise.

See `j.model.md` for the container attributes and messages; this page's generated part lists what `j.view` itself documents (4 attributes, 3 messages).
