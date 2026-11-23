// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

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

    /** One observer of appearing and disappearing objects. */
    struct Observer {
        unsigned id;                                                                       /**< Identifies the observer for removal. */
        Address pattern;                                                                   /**< The addresses it watches. */
        std::function<void(const Address&, Object*, bool)> callback;                       /**< What to call. */
    };
    std::mutex observer_mutex;       /**< Guards the observers (never held while a callback runs). */
    std::vector<Observer> observers; /**< The observers. */
    unsigned next_observer = 1;      /**< The id of the next observer. */

    /** Tells the matching observers; call with the namespace lock released. @param address The node. @param object The object or null. @param created Appeared or went. */
    void notify(const Address& address, Object* object, bool created);
};

namespace {

/** @return Whether a pattern segment matches a name and instance: a name of `*` matches any name (and any instance unless the pattern gives one), an instance of `*` any instance. */
bool segment_matches(const Segment& pattern, const std::string& name, const std::string& instance)
{
    const bool any_name = pattern.name == "*";
    return (any_name || pattern.name == name) && (pattern.instance == "*" || pattern.instance == instance || (any_name && pattern.instance.empty()));
}

/** @return Whether a concrete address is matched by a pattern (same depth, see segment_matches). */
bool pattern_matches(const Address& pattern, const Address& address)
{
    const auto& p = pattern.path();
    const auto& a = address.path();
    if (p.size() != a.size() || p.empty()) {
        return false;
    }
    for (std::size_t i = 0; i < p.size(); ++i) {
        if (!segment_matches(p[i], a[i].name, a[i].instance)) {
            return false;
        }
    }
    return true;
}

} // namespace

void NamespaceState::notify(const Address& address, Object* object, bool created)
{
    std::vector<std::function<void(const Address&, Object*, bool)>> calls;
    {
        std::lock_guard<std::mutex> lock(observer_mutex);
        for (const Observer& o : observers) {
            if (pattern_matches(o.pattern, address)) {
                calls.push_back(o.callback);
            }
        }
    }
    for (const auto& call : calls) {
        call(address, object, created);
    }
}

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
        bool removed = false;
        {
        std::unique_lock lock(state->mutex);
        if (node_->object_ == object_) {
            removed = true;
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
        if (removed) {
            state->notify(address_, nullptr, false);
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
    Subscription result(state_, node, &object, created_instance, Address::parse(text));
    lock.unlock();
    state_->notify(result.address(), &object, true);
    return result;
}

std::shared_ptr<void> Namespace::observe(const Address& pattern, std::function<void(const Address&, Object*, bool)> callback)
{
    unsigned id;
    {
        std::lock_guard<std::mutex> lock(state_->observer_mutex);
        id = state_->next_observer++;
        state_->observers.push_back({id, pattern, std::move(callback)});
    }
    static int token = 0;
    std::weak_ptr<NamespaceState> weak = state_;
    return std::shared_ptr<void>(&token, [weak, id](void*) {
        if (auto state = weak.lock()) {
            std::lock_guard<std::mutex> lock(state->observer_mutex);
            auto& list = state->observers;
            list.erase(std::remove_if(list.begin(), list.end(), [id](const NamespaceState::Observer& o) { return o.id == id; }), list.end());
        }
    });
}

bool Namespace::read_object(const Address& address, const std::function<void(Object&)>& use) const
{
    if (address.empty()) {
        return false;
    }
    std::shared_lock lock(state_->mutex);
    Node* current = state_->root.get();
    for (const Segment& segment : address.path()) {
        current = find_child(*current, segment.name, segment.instance, current->kids_);
        if (current == nullptr) {
            return false;
        }
    }
    if (current->object_ == nullptr) {
        return false;
    }
    use(*current->object_);
    return true;
}

bool Namespace::visit_below(const Address& root, const std::function<void(const std::string&, const std::string&, const std::string&, Object*)>& visit) const
{
    std::shared_lock lock(state_->mutex);
    Node* current = state_->root.get();
    for (const Segment& segment : root.path()) {
        current = find_child(*current, segment.name, segment.instance, current->kids_);
        if (current == nullptr) {
            return false;
        }
    }
    std::function<void(const std::vector<std::unique_ptr<Node>>&, const std::string&)> walk;
    walk = [&walk, &visit](const std::vector<std::unique_ptr<Node>>& kids, const std::string& prefix) {
        for (const auto& kid : kids) {
            std::string text = prefix.empty() ? kid->name_ : prefix + "/" + kid->name_;
            if (!kid->instance_.empty()) {
                text += "." + kid->instance_;
            }
            visit(text, kid->name_, kid->instance_, kid->object_);
            walk(kid->kids_, text);
        }
    };
    walk(current->kids_, std::string());
    return true;
}

std::vector<Node*> Namespace::find(const Address& pattern) const
{
    std::shared_lock lock(state_->mutex);
    std::vector<Node*> level{state_->root.get()};
    for (const Segment& segment : pattern.path()) {
        std::vector<Node*> next;
        for (Node* parent : level) {
            for (const auto& kid : parent->kids_) {
                if (segment_matches(segment, kid->name(), kid->instance())) {
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
