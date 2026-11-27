// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file remote.hpp
 * @brief The remote: keeps a UI object and a node showing the same value (the core of `j.remote`).
 *
 * Rules (docs/inventory/j.remote.md and the old j.remote test): a value from the UI goes to the node as a command, in the unit the UI works in;
 * every change of the node, the answer to that command included (the old test reads it), is shown to the UI in the UI's unit unless the remote
 * is frozen (the UI object takes it as `set`, which shows a value without sending it, so there is no loop; a UI object that does send
 * is stopped by the sender's own guard against re-entering); an inactive remote does neither; the first value after binding is shown. Any command to the node stops a
 * ramp that is running, so a UI object that is dragged wins over a ramp.
 */

#pragma once

#include <atomic>
#include <functional>
#include <memory>
#include <mutex>
#include <optional>
#include <string>
#include <string_view>
#include <thread>

#include "jamoma/address.hpp"
#include "jamoma/atom.hpp"
#include "jamoma/export.hpp"
#include "jamoma/namespace.hpp"
#include "jamoma/receiver.hpp"
#include "jamoma/sender.hpp"

namespace jamoma {

/** Links one node to one UI object. The node changes may come from any thread; the other calls are for the main thread. */
class JAMOMA_API Remote {
public:
    /**
     * @brief Creates a remote that is not bound.
     * @param ns The namespace (it must outlive the remote).
     * @param to_ui Called with the value the UI object should show (on the thread that changed the node, with no lock held).
     */
    Remote(Namespace& ns, std::function<void(const Value&)> to_ui);
    ~Remote();
    Remote(const Remote&) = delete;            /**< A remote is never copied. */
    Remote& operator=(const Remote&) = delete; /**< A remote is never assigned. */

    /** @brief Binds to the node at an address (an empty address unbinds). @param address The address. */
    void set_address(const Address& address);
    /** @brief Sets the unit the UI object works in; empty means the node's own. @param unit The unit. */
    void set_unit(std::string_view unit);
    /** @brief An inactive remote sends nothing and shows nothing. @param on True for active (the default). */
    void set_active(bool on);
    /** @brief A frozen remote shows nothing to the UI; the UI can still send. @param on True for frozen. */
    void set_freeze(bool on);
    /** @brief The user moved the UI object: sends the value to the node as a command in the UI's unit. @param value The value. */
    void from_ui(const Value& value);
    /**
     * @brief Sends a value to the node like from_ui, but shows nothing of the node's answer here (the `set` message). Other remotes show it.
     * @param value The value.
     */
    void set_without_output(const Value& value);
    /** @return The value last shown to the UI or sent from it, if any. */
    std::optional<Value> current() const;

private:
    /** Shows the node's value to the UI. @param value The value as the node reports it. */
    void node_changed(const Value& value);
    /** @return The value in the UI's unit. @param value The node's value. */
    Value to_ui_unit(const Value& value) const;

    Namespace& ns_;                                  /**< The namespace. */
    std::function<void(const Value&)> to_ui_;        /**< What shows a value in the UI. */
    std::atomic<bool> active_{true};                 /**< Whether anything is passed on. */
    std::atomic<bool> freeze_{false};                /**< Whether the UI direction is stopped. */
    std::atomic<std::thread::id> setting_{};         /**< The thread that is inside set_without_output (none otherwise): what it brings is not shown. */
    mutable std::mutex mutex_;                       /**< Guards the unit, the node address and the current value. */
    std::string unit_;                               /**< The unit of the UI object. */
    Address node_;                                   /**< The address of the last node reported. */
    std::optional<Value> current_;                   /**< The current value. */
    Sender sender_;                                  /**< Sends to the node. */
    std::unique_ptr<Receiver> receiver_;             /**< Watches the node (declared last: it is released first). */
};

} // namespace jamoma
