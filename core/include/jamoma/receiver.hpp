// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file receiver.hpp
 * @brief The receiver: watches the nodes at an address and reports their values (the core of `j.receive`).
 *
 * The rules are those of the old TTReceiver, written down in docs/inventory/send-receive.md.
 */

#pragma once

#include <functional>
#include <memory>
#include <optional>

#include "jamoma/address.hpp"
#include "jamoma/data.hpp"
#include "jamoma/export.hpp"
#include "jamoma/namespace.hpp"

namespace jamoma {

/**
 * @brief Binds to the nodes that match an address and outputs their attribute (by default `value`).
 *
 * On binding, and whenever a bound attribute changes, the receiver reports the address of the node (with `:<attribute>` appended unless the
 * attribute is `value`) and then the value, if the receiver is active and the value is not empty. A node that appears later at the address
 * is bound and reported once; one that goes is dropped without a report. An address whose attribute is `created` or `destroyed` reports only
 * the address of a node when it appears or goes. Callbacks run on the thread that made the change, with no lock held, so a callback may
 * rebind or destroy the receiver. Use bang() and grab() on the main thread only, the thread on which nodes are created and removed.
 * The namespace must outlive every call into the receiver; the receiver itself may outlive the namespace and the data objects.
 */
class JAMOMA_API Receiver {
public:
    /**
     * @brief Creates an unbound receiver.
     * @param ns The namespace to look in.
     * @param on_address Called with the address of the node a value belongs to, before the value.
     * @param on_value Called with the value.
     */
    Receiver(Namespace& ns, std::function<void(const Address&)> on_address, std::function<void(const Value&)> on_value);
    ~Receiver();
    Receiver(const Receiver&) = delete;            /**< A receiver is never copied. */
    Receiver& operator=(const Receiver&) = delete; /**< A receiver is never assigned. */

    /** @brief Binds to an address; an empty address unbinds. Rebinding first drops every old binding. @param address The address (wildcards allowed). */
    void set_address(const Address& address);
    /** @return The address the receiver is bound to. */
    Address address() const;
    /** @brief Sets whether changes are reported (default true). Reactivating reports nothing by itself. @param on True to report. */
    void set_active(bool on);
    /** @return Whether changes are reported. */
    bool active() const;
    /** @brief Reports the current value of the first bound node (address, then value). @return False if there is none or the value is empty. */
    bool bang();
    /** @brief Reads the current value of the first bound node without reporting it. @return The value, or nothing. */
    std::optional<Value> grab() const;

    struct Impl;                    /**< The state, defined in the source file (public only so that its helper functions can name it). */

private:
    std::shared_ptr<Impl> impl_;    /**< The state (callbacks hold it weakly). */
};

} // namespace jamoma
