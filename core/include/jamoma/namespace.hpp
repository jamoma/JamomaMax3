// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file namespace.hpp
 * @brief The namespace tree: nodes addressed like OSC, the objects they refer to, and subscriptions.
 *
 * The rules (instance numbering, attaching, pruning) are in docs/inventory/namespace.md.
 *
 * Threading: the structure changes (subscribe, unsubscribe) on the main thread; every operation takes the namespace's
 * lock (unique for changes, shared for reads), so lookups may come from any thread. A Node pointer is valid only while the
 * node exists: do not keep one across the unsubscribing of the subscription that keeps the node alive.
 */

#pragma once

#include <memory>
#include <shared_mutex>
#include <string>
#include <vector>

#include "jamoma/address.hpp"
#include "jamoma/export.hpp"

namespace jamoma {

struct NamespaceState;

/** What a node refers to: a data object, a model. Derive from it; the namespace never owns objects. */
class JAMOMA_API Object {
public:
    Object() = default;
    Object(const Object&) = delete;            /**< An object is never copied. */
    Object& operator=(const Object&) = delete; /**< An object is never assigned. */
    /** Out of line so that the virtual table lives in the core library. */
    virtual ~Object();
};

/** One node of the namespace tree. Nodes are created and destroyed only by the Namespace. */
class JAMOMA_API Node {
public:
    ~Node();
    Node(const Node&) = delete;            /**< A node is never copied. */
    Node& operator=(const Node&) = delete; /**< A node is never assigned. */

    /** @return The name of the node (the root's is empty). */
    const std::string& name() const noexcept { return name_; }
    /** @return The instance of the node, or an empty string. */
    const std::string& instance() const noexcept { return instance_; }
    /** @return The parent node, or null for the root. */
    Node* parent() const noexcept { return parent_; }
    /** @return The child nodes (a snapshot taken under the shared lock). */
    std::vector<Node*> children() const;
    /** @return The object the node refers to, or null. */
    Object* object() const;
    /** @return The absolute address of the node. */
    Address address() const;

private:
    friend class Namespace;
    friend class Subscription;
    friend struct NamespaceState;
    /** Creates a node. @param state The owning namespace state. @param parent The parent node. @param name The name. @param instance The instance. */
    Node(NamespaceState* state, Node* parent, std::string name, std::string instance);

    NamespaceState* state_;                    /**< The owning namespace state (provides the lock). */
    Node* parent_;                             /**< The parent, or null for the root. */
    std::string name_;                         /**< The name. */
    std::string instance_;                     /**< The instance. */
    Object* object_ = nullptr;                 /**< The referred object, or null. */
    std::vector<std::unique_ptr<Node>> kids_;  /**< The children. */
};

/**
 * @brief The registration of an object at a node. Destroying it unsubscribes.
 *
 * Safe to destroy after its namespace is gone (it then does nothing).
 */
class JAMOMA_API Subscription {
public:
    /** Creates an empty subscription that owns nothing. */
    Subscription() noexcept = default;
    ~Subscription();
    Subscription(Subscription&& other) noexcept;            /**< Moves the registration. @param other The source, left empty. */
    Subscription& operator=(Subscription&& other) noexcept; /**< Moves the registration. @param other The source, left empty. @return This. */
    Subscription(const Subscription&) = delete;             /**< A subscription is never copied. */
    Subscription& operator=(const Subscription&) = delete;  /**< A subscription is never assigned. */

    /** @return The node, or null if the subscription is empty. */
    Node* node() const noexcept { return node_; }
    /** @return True if subscribing created another instance because the address was taken. */
    bool created_instance() const noexcept { return created_instance_; }
    /** @return The absolute address the object ended up at (with its instance); empty for an empty subscription. */
    const Address& address() const noexcept { return address_; }

private:
    friend class Namespace;
    /** Creates a subscription. @param state The namespace state. @param node The node. @param object The object. @param created Whether an instance was created. @param address The final address. */
    Subscription(std::weak_ptr<NamespaceState> state, Node* node, Object* object, bool created, Address address);
    /** Unsubscribes if non-empty and leaves the subscription empty. */
    void release() noexcept;

    std::weak_ptr<NamespaceState> state_; /**< The namespace state, weakly. */
    Node* node_ = nullptr;                /**< The node. */
    Object* object_ = nullptr;            /**< The registered object. */
    bool created_instance_ = false;       /**< Whether an instance was created. */
    Address address_;                     /**< The final address. */
};

/** The tree of nodes. */
class JAMOMA_API Namespace {
public:
    Namespace();
    ~Namespace();
    Namespace(const Namespace&) = delete;            /**< A namespace is never copied. */
    Namespace& operator=(const Namespace&) = delete; /**< A namespace is never assigned. */

    /** @return The root node (always exists). */
    Node* root() const noexcept;
    /**
     * @brief Finds a node.
     * @param address The address; directory and attribute are ignored; a relative address is taken from the root.
     * @return The node, or null if there is none (also for the empty address).
     */
    Node* lookup(const Address& address) const;
    /**
     * @brief Registers an object at an address.
     *
     * No node there: it is created. A node without an object: the object is attached. A node with an object: another
     * instance is created, numbered with the first free number from 1. Missing ancestors are created without objects.
     * @param address The address (directory and attribute are ignored).
     * @param object The object; it must outlive the returned subscription.
     * @return The subscription; empty only if the address is the root and the root already has an object.
     */
    Subscription subscribe(const Address& address, Object& object);
    /**
     * @brief Finds nodes by a pattern.
     * @param pattern An address whose segment instances may be `*` (any instance, including none).
     * @return The matching nodes.
     */
    std::vector<Node*> find(const Address& pattern) const;

private:
    std::shared_ptr<NamespaceState> state_; /**< The tree and its lock, shared weakly with subscriptions. */
};

} // namespace jamoma
