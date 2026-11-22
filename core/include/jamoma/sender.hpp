// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file sender.hpp
 * @brief The sender: delivers a value to the nodes at an address (the core of `j.send`).
 *
 * The rules are those of the old TTSender, written down in docs/inventory/send-receive.md.
 */

#pragma once

#include <atomic>

#include "jamoma/address.hpp"
#include "jamoma/data.hpp"
#include "jamoma/export.hpp"
#include "jamoma/namespace.hpp"

namespace jamoma {

/**
 * @brief Sends values to the nodes that match an address.
 *
 * The attribute of the address (default `value`) decides what a send does for each matching node: for a `Data`, `value` is a command and any
 * other attribute is set by name; for a `Model`, `value` forwards the message to the member named by its first element, which must be a symbol
 * (the rest of the message is the command). Nodes are looked up on every send, so a target that was deleted is never touched and a new one
 * at the address is reached. A send that arrives while this sender is already sending (its own value coming back through a receiver, say) is
 * dropped. Use a sender on the main thread, where nodes are created and removed.
 */
class JAMOMA_API Sender {
public:
    /** @brief Creates a sender without an address. @param ns The namespace to look in (it must outlive the sender). */
    explicit Sender(Namespace& ns);

    /** @brief Sets the target; an empty address means sends go nowhere. @param address The address (wildcards allowed). */
    void set_address(const Address& address);
    /** @return The target address. */
    Address address() const;
    /** @brief Delivers a value. @param value The value (a message for a model target). @return True if at least one node was reached. */
    bool send(const Value& value);

private:
    Namespace& ns_;                   /**< The namespace. */
    Address address_;                 /**< The target. */
    std::atomic<bool> sending_{false}; /**< The re-entrancy guard. */
};

} // namespace jamoma
