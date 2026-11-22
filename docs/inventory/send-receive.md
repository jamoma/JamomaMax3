# j.send and j.receive: characterisation for milestone 2

Paths are relative to the old checkout (`~/Developer/Jamoma/JamomaMax`). *Read* = read in the source named. Written before any code (milestone 2, Task 1).

## Receiver (`JamomaCore/Modular/library/source/TTReceiver.cpp`, `source/j.receive/j.receive.cpp`)

- **Attribute.** The address's attribute part names what is observed; none means `value` (`TTReceiver.cpp:237-255`). *Read.*
- **Binding** (`bindAddress`, `:237`): the address is looked up in the directory; **every** matching node (wildcards allowed) is observed through the attribute (`cacheNodeObserver`, `:286`); then the receiver observes **creation and destruction of an address equal to its own** (`addObserverForNotifications(mAddress, ..., 0)`), so a node that appears later is bound, one that goes is dropped (`TTReceiverDirectoryCallback`, `:279`). *Read.*
- **Output on binding** (`cacheNodeObserver`): if the receiver is active and the attribute is not `signal`, the current value is read and, **if it is non-empty**, the node's address is returned first, then the value (`:286-340`). An attribute other than `value` returns the address with `:<attribute>` appended. *Read.*
- **Output on change:** the same pair, address then value, from the attribute observer (`TTReceiverAttributeCallback`). *Read (callback registered in `cacheNodeObserver`).*
- **`:created` / `:destroyed`:** these two attribute names do not bind values; on creation (destruction) of the node the receiver returns only its **address without the attribute** through the address callback (`TTReceiverDirectoryCallback`, `:279-`). No value output. *Read.*
- **`active`** (default yes, `:89`): switches the attribute observers on and off for the nodes already bound (the observer is unregistered when inactive); while inactive nothing is output on a change. *Read.*
- **`bang` / `Get`** (`:145`): for each bound node reads the attribute; a non-empty value is output (address then value); an empty one gives an error. Used by the object's `bang`. *Read.*
- **`grab`:** the value of the first bound node only, no output. *Read.*
- **Max object.** Outlets from the left: 0 value, 1 address, 2 dumpout (`j.receive.cpp:165-171`). The value outlet receives `msg` + atoms and avoids a blank selector when the message is empty (`receive_return_value`, `:326`); the address outlet gets the address as the message selector (`receive_return_address`). `bang` outputs the current value, and on error sends `error` to the dumpout (`receive_bang`). *Read.*

## Sender (`TTSender.cpp`, `source/j.send/j.send.cpp`)

- **Attribute.** None means `value` (`:60-66`). *Read.*
- **`Send`** (`TTSender.cpp:78`), per bound object, by object kind and attribute: a **Data** and `value` → `command`; a **Container** (model) and `value` → the first element must be a symbol (a relative address inside the model) and the rest is sent to that member, otherwise error; an **Input** and `signal` → `Send`; **default**: if the object has the attribute, set it; else if it has the message of that name, call it. *Read.* New rulings below.
- **Guard:** `mIsSending` blocks a send while a send is in progress; the blocked send is dropped. *Read.*
- **Binding** (`bindAddress`, `:160`): looks up the nodes, caches their objects, observes creation/destruction at the address (`TTSenderDirectoryCallback`, `:185`: add the new object, drop the destroyed one). *Read.*
- **Max object** (`j.send.cpp`): one outlet only, the **dumpout**; the absolute target address is sent there as `address <absolute>` after binding (`:232, :305, :345, :465`); an error sends `error`. The message `address <a>` re-targets (`send_address`, `:433`); if the old address was relative and the new one absolute the model-address observer is dropped. A `j.send` **without an address** takes the message selector as the address when it is absolute (`send_list`, `:390`: `/model/param 5` sets the target to `/model/param` and sends `5`; a message with 0, one or several atoms is retyped bang, int, float, symbol or list) and ignores messages that are not absolute addresses. `#0`-style arguments in the address are substituted (`jamoma_parse_dieze`); **not done** here (no abstraction arguments in milestone 2). *Read.*

## Relative addresses (`send_subscribe`, `j.send.cpp:258`; same in `j.receive`)

- A relative address is appended to the **address of the model (or view) the box is in**: the box looks for its context through the patcher chain (`jamoma_patcher_get_info`), subscribes a probe to learn the context address, and takes `<model address>/<address>`. If the model has not registered yet it **tries again, deferred, up to 100 times**, then reports an error; in a **view** patcher it observes `<model>/model:address` instead (milestone 3). Outside any model the address is taken from the root (`contextAddress = root`). *Read.*

## Rulings (cited by later tasks)

1. **Receiver output order and conditions** as above: on binding, if active and non-empty, address then value; on every change likewise; `:created` / `:destroyed` output the node address only; an inactive receiver outputs nothing until banged.
2. **Binding by waiting, not polling:** instead of the old 100 deferred retries, a relative address is resolved after the patcher has loaded and again whenever the model appears (the model observer of Task 4); no error after 100 tries, a receiver or sender with no model simply stays unbound. Cost if wrong: a patcher that relied on the console error loses it.
3. **Sender targets:** `Data` + `value` → `Data::command`; `Data` + another attribute → `Data::set_attribute`; `Model` + `value` → the message is forwarded to the member named by the first symbol (milestone 2 implements only the lookup and the `command` to a `Data` member; anything else returns false); an unknown attribute reaches nothing. The "call a message of that name" branch has no target in milestone 2 (the new `Data` has no message table) and is documented as not done.
4. **`j.send` outputs `address <absolute>` on its only (dump) outlet,** as the old object; the plan's "outlet 0" is that outlet.
5. **Guard:** one atomic flag per sender; a dropped send returns false.
6. **`#0` argument substitution is not done** (abstraction arguments belong with the model patchers of milestone 3).
