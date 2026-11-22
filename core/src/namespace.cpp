// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file namespace.cpp
 * @brief Implementation of the namespace tree and subscriptions.
 */

#include "jamoma/namespace.hpp"

#include <algorithm>
#include <mutex>

namespace jamoma {

/** The tree and the lock that guards it. */
struct NamespaceState {
    /** Creates the root node. */
    NamespaceState() : root(new Node(this, nullptr, std::string(), std::string())) {}
    mutable std::shared_mutex mutex; /**< Unique for changes, shared for reads. */
    std::unique_ptr<Node> root;      /**< The root node. */
};

namespace {

/** Finds the child with this name and instance (no locking: the caller holds the lock). */
Node* find_child(const Node& parent, const std::string& name, const std::string& instance, const std::vector<std::unique_ptr<Node>>& kids)
{
    (void)parent;
    for (const auto& kid : kids) {
        if (kid->name() == name && kid->instance() == instance) {
            return kid.get();
        }
    }
    return nullptr;
}

/** The first instance number from 1 that no child of this name uses. */
std::string first_free_instance(const std::vector<std::unique_ptr<Node>>& kids, const std::string& name)
{
    for (unsigned long number = 1;; ++number) {
        const std::string candidate = std::to_string(number);
        const bool taken = std::any_of(kids.begin(), kids.end(), [&](const std::unique_ptr<Node>& kid) {
            return kid->name() == name && kid->instance() == candidate;
        });
        if (!taken) {
            return candidate;
        }
    }
}

} // namespace

Object::~Object() = default;

Node::Node(NamespaceState* state, Node* parent, std::string name, std::string instance)
    : state_(state), parent_(parent), name_(std::move(name)), instance_(std::move(instance))
{
}

Node::~Node() = default;

std::vector<Node*> Node::children() const
{
    std::shared_lock lock(state_->mutex);
    std::vector<Node*> result;
    for (const auto& kid : kids_) {
        result.push_back(kid.get());
    }
    return result;
}

Object* Node::object() const
{
    std::shared_lock lock(state_->mutex);
    return object_;
}

Address Node::address() const
{
    std::shared_lock lock(state_->mutex);
    std::string text;
    for (const Node* n = this; n->parent_ != nullptr; n = n->parent_) {
        std::string part = "/" + n->name_;
        if (!n->instance_.empty()) {
            part += "." + n->instance_;
        }
        text = part + text;
    }
    return Address::parse(text.empty() ? "/" : text);
}

Subscription::Subscription(std::weak_ptr<NamespaceState> state, Node* node, Object* object, bool created, Address address)
    : state_(std::move(state)), node_(node), object_(object), created_instance_(created), address_(std::move(address))
{
}

Subscription::~Subscription()
{
    release();
}

Subscription::Subscription(Subscription&& other) noexcept
    : state_(std::move(other.state_)), node_(other.node_), object_(other.object_), created_instance_(other.created_instance_),
      address_(std::move(other.address_))
{
    other.node_ = nullptr;
    other.object_ = nullptr;
}

Subscription& Subscription::operator=(Subscription&& other) noexcept
{
    if (this != &other) {
        release();
        state_ = std::move(other.state_);
        node_ = other.node_;
        object_ = other.object_;
        created_instance_ = other.created_instance_;
        address_ = std::move(other.address_);
        other.node_ = nullptr;
        other.object_ = nullptr;
    }
    return *this;
}

void Subscription::release() noexcept
{
    if (node_ == nullptr) {
        return;
    }
    if (auto state = state_.lock()) {
        std::unique_lock lock(state->mutex);
        if (node_->object_ == object_) {
            node_->object_ = nullptr;
            Node* n = node_;
            while (n != state->root.get() && n->kids_.empty() && n->object_ == nullptr) {
                Node* parent = n->parent_;
                auto& siblings = parent->kids_;
                siblings.erase(std::find_if(siblings.begin(), siblings.end(), [n](const std::unique_ptr<Node>& k) { return k.get() == n; }));
                n = parent;
            }
        }
    }
    node_ = nullptr;
    object_ = nullptr;
}

Namespace::Namespace() : state_(std::make_shared<NamespaceState>()) {}

Namespace::~Namespace() = default;

Node* Namespace::root() const noexcept
{
    return state_->root.get();
}

Node* Namespace::lookup(const Address& address) const
{
    if (address.empty()) {
        return nullptr;
    }
    std::shared_lock lock(state_->mutex);
    Node* current = state_->root.get();
    for (const Segment& segment : address.path()) {
        current = find_child(*current, segment.name, segment.instance, current->kids_);
        if (current == nullptr) {
            return nullptr;
        }
    }
    return current;
}

Subscription Namespace::subscribe(const Address& address, Object& object)
{
    std::unique_lock lock(state_->mutex);
    Node* current = state_->root.get();
    const auto& path = address.path();
    if (path.empty()) {
        if (current->object_ != nullptr) {
            return Subscription();
        }
        current->object_ = &object;
        return Subscription(state_, current, &object, false, Address::parse("/"));
    }
    for (std::size_t i = 0; i + 1 < path.size(); ++i) {
        Node* next = find_child(*current, path[i].name, path[i].instance, current->kids_);
        if (next == nullptr) {
            current->kids_.emplace_back(new Node(state_.get(), current, path[i].name, path[i].instance));
            next = current->kids_.back().get();
        }
        current = next;
    }
    const Segment& last = path.back();
    Node* node = find_child(*current, last.name, last.instance, current->kids_);
    bool created_instance = false;
    if (node == nullptr) {
        current->kids_.emplace_back(new Node(state_.get(), current, last.name, last.instance));
        node = current->kids_.back().get();
    } else if (node->object_ != nullptr) {
        current->kids_.emplace_back(new Node(state_.get(), current, last.name, first_free_instance(current->kids_, last.name)));
        node = current->kids_.back().get();
        created_instance = true;
    }
    node->object_ = &object;
    std::string text;
    for (const Node* n = node; n->parent_ != nullptr; n = n->parent_) {
        std::string part = "/" + n->name_;
        if (!n->instance_.empty()) {
            part += "." + n->instance_;
        }
        text = part + text;
    }
    return Subscription(state_, node, &object, created_instance, Address::parse(text));
}

std::vector<Node*> Namespace::find(const Address& pattern) const
{
    std::shared_lock lock(state_->mutex);
    std::vector<Node*> level{state_->root.get()};
    for (const Segment& segment : pattern.path()) {
        std::vector<Node*> next;
        for (Node* parent : level) {
            for (const auto& kid : parent->kids_) {
                if (kid->name() == segment.name && (segment.instance == "*" || kid->instance() == segment.instance)) {
                    next.push_back(kid.get());
                }
            }
        }
        level = std::move(next);
    }
    if (pattern.path().empty()) {
        return {};
    }
    return level;
}

} // namespace jamoma
