// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file receiver.cpp
 * @brief The receiver (see receiver.hpp).
 */

#include "jamoma/receiver.hpp"

#include "jamoma/model.hpp"

#include <algorithm>
#include <atomic>
#include <condition_variable>
#include <mutex>
#include <string>
#include <vector>

namespace jamoma {

/** The state of a receiver. */
struct Receiver::Impl : std::enable_shared_from_this<Receiver::Impl> {
    /** One bound node. */
    struct Binding {
        Address node;                    /**< The address of the node (no attribute). */
        Data* data;                      /**< The data object (valid while the namespace observer has not reported it gone), or null. */
        Model* model;                    /**< The model, for its attribute `initialized`, or null. */
        std::shared_ptr<void> observer;  /**< Keeps the attribute observer registered. */
    };

    /** @param n The namespace. @param a The address callback. @param v The value callback. */
    Impl(Namespace& n, std::function<void(const Address&)> a, std::function<void(const Value&)> v)
        : ns(n), on_address(std::move(a)), on_value(std::move(v))
    {
    }

    Namespace& ns;                                   /**< The namespace. */
    const std::function<void(const Address&)> on_address; /**< Reports an address. */
    const std::function<void(const Value&)> on_value;    /**< Reports a value. */
    mutable std::mutex mutex;                        /**< Guards everything below (never held while calling out). */
    Address address;                                 /**< The bound address. */
    std::string attribute = "value";                 /**< The attribute that is followed. */
    std::atomic<bool> active{true};                  /**< Whether changes are reported. */
    unsigned generation = 0;                         /**< Counts rebinds so that late callbacks of an old binding are ignored. */
    std::vector<Binding> bindings;                   /**< The bound nodes in binding order. */
    std::shared_ptr<void> ns_observer;               /**< Keeps the namespace observer registered. */
    std::atomic<int> in_flight{0};                   /**< How many callbacks (of the observers) are running now, on any thread. */
    std::mutex idle_mutex;                           /**< Guards the wait for in_flight to reach zero. */
    std::condition_variable idle;                    /**< Signalled when in_flight drops to zero. */

    /** @param node A node address. @param attr The followed attribute. @return What is reported as its address: with `:<attribute>` unless the attribute is `value`. */
    Address report_address(const Address& node, const std::string& attr) const
    {
        return attr == "value" ? node : node.with_attribute(attr);
    }

    /** Reports an address and a value. @param node The node. @param attr The attribute. @param v The value. */
    void emit(const Address& node, const std::string& attr, const Value& v) const
    {
        if (on_address) {
            on_address(report_address(node, attr));
        }
        if (on_value) {
            on_value(v);
        }
    }
};

namespace {

thread_local const void* t_inside = nullptr; /**< The receiver whose callback this thread is running, or null. */

/** Marks a callback as in flight for its lifetime; the receiver's destructor and set_address wait for these (see wait_idle). */
struct Flight {
    /** @param i The receiver state; it must stay alive for the lifetime of this object (hold a shared pointer). */
    explicit Flight(Receiver::Impl* i) : impl(i), previous(t_inside)
    {
        ++impl->in_flight;
        t_inside = impl;
    }
    ~Flight()
    {
        t_inside = previous;
        if (--impl->in_flight == 0) {
            std::lock_guard<std::mutex> lock(impl->idle_mutex);
            impl->idle.notify_all();
        }
    }
    Flight(const Flight&) = delete;            /**< A flight is never copied. */
    Flight& operator=(const Flight&) = delete; /**< A flight is never assigned. */
    Receiver::Impl* impl;                      /**< The receiver state. */
    const void* previous;                      /**< What this thread was inside before. */
};

/**
 * Waits until no callback of this receiver is running on another thread; callbacks running on the calling thread (a receiver rebound or
 * destroyed from inside its own callback) are not waited for.
 * @param impl The receiver state.
 */
void wait_idle(Receiver::Impl& impl)
{
    const int mine = (t_inside == &impl) ? 1 : 0;
    std::unique_lock<std::mutex> lock(impl.idle_mutex);
    impl.idle.wait(lock, [&impl, mine] { return impl.in_flight.load() <= mine; });
}

/** @param model A model. @return Its attribute `initialized` as a value. */
Value initialized_value(const Model& model)
{
    return Value{Atom(model.initialized() ? 1 : 0)};
}

/**
 * Binds a model whose attribute `initialized` is followed: 0 when it starts to initialise, 1 when it is done, and 1 at once if it is.
 * @param impl The receiver state. @param node The model's address. @param model The model. @param gen The generation this binding belongs to.
 */
void bind_model(const std::shared_ptr<Receiver::Impl>& impl, const Address& node, Model& model, unsigned gen)
{
    {
        std::lock_guard<std::mutex> lock(impl->mutex);
        const auto same = [&node](const Receiver::Impl::Binding& b) { return b.node == node; };
        if (gen != impl->generation || impl->attribute != "initialized"
            || std::any_of(impl->bindings.begin(), impl->bindings.end(), same)) {
            return;
        }
        impl->bindings.push_back({node, nullptr, &model, nullptr}); // before observing: the model may report at once
    }
    std::weak_ptr<Receiver::Impl> weak = impl;
    std::shared_ptr<void> observer = model.on_init_changed([weak, node, gen](bool done) {
        const auto keep = weak.lock();
        if (!keep) {
            return;
        }
        const Flight flight(keep.get());
        if (!keep->active.load()) {
            return;
        }
        {
            std::lock_guard<std::mutex> lock(keep->mutex);
            if (gen != keep->generation) {
                return;
            }
        }
        keep->emit(node, "initialized", Value{Atom(done ? 1 : 0)});
    });
    std::lock_guard<std::mutex> lock(impl->mutex);
    for (Receiver::Impl::Binding& b : impl->bindings) {
        if (gen == impl->generation && b.node == node) {
            b.observer = observer;
        }
    }
}

/**
 * Binds one node: observes the attribute and, if asked, reports the current value once.
 * @param impl The receiver state. @param node The node's address. @param object Its object. @param gen The generation this binding belongs to.
 * @param report_now Whether to report the current value when active.
 */
void bind_node(const std::shared_ptr<Receiver::Impl>& impl, const Address& node, Object* object, unsigned gen, bool report_now)
{
    if (Model* model = dynamic_cast<Model*>(object)) {
        bind_model(impl, node, *model, gen);
        return;
    }
    Data* data = dynamic_cast<Data*>(object);
    if (data == nullptr) {
        return;
    }
    std::string attr;
    {
        std::lock_guard<std::mutex> lock(impl->mutex);
        if (gen != impl->generation) {
            return;
        }
        attr = impl->attribute;
    }
    std::weak_ptr<Receiver::Impl> weak = impl;
    std::shared_ptr<void> observer = data->observe(attr, [weak, node, attr, gen](const Value& v) {
        const auto keep = weak.lock();
        if (!keep) {
            return;
        }
        const Flight flight(keep.get()); // counted before the generation check, so a destructor that bumps it waits for us
        // An empty value of the attribute `value` is a bang (only a node of type none outputs one): it is a change like any other.
        if (!keep->active.load() || (v.empty() && attr != "value")) {
            return;
        }
        {
            std::lock_guard<std::mutex> lock(keep->mutex);
            if (gen != keep->generation) {
                return;
            }
        }
        keep->emit(node, attr, v);
    });
    if (!observer) {
        return; // the object has no such attribute
    }
    {
        std::lock_guard<std::mutex> lock(impl->mutex);
        if (gen != impl->generation) {
            return;
        }
        const auto same = [&node](const Receiver::Impl::Binding& b) { return b.node == node; };
        if (std::any_of(impl->bindings.begin(), impl->bindings.end(), same)) {
            return; // already bound (the namespace observer and the first lookup can both find it)
        }
        impl->bindings.push_back({node, data, nullptr, observer});
    }
    if (report_now && impl->active.load()) {
        const std::optional<Value> v = data->get_attribute(attr);
        if (v && !v->empty()) {
            impl->emit(node, attr, *v);
        }
    }
}

/** Reacts to an object appearing or going at the address. */
void on_node_event(const std::shared_ptr<Receiver::Impl>& impl, unsigned gen, const Address& node, Object* object, bool created)
{
    const Flight flight(impl.get());
    std::string attr;
    {
        std::lock_guard<std::mutex> lock(impl->mutex);
        if (gen != impl->generation) {
            return;
        }
        attr = impl->attribute;
    }
    if (attr == "created" || attr == "destroyed") {
        if ((attr == "created") == created && impl->on_address) {
            impl->on_address(node);
        }
        return;
    }
    if (created) {
        bind_node(impl, node, object, gen, true);
        return;
    }
    std::shared_ptr<void> dropped; // destroyed after the lock is released
    {
        std::lock_guard<std::mutex> lock(impl->mutex);
        auto& list = impl->bindings;
        const auto it = std::find_if(list.begin(), list.end(), [&node](const Receiver::Impl::Binding& b) { return b.node == node; });
        if (it != list.end()) {
            dropped = std::move(it->observer);
            list.erase(it);
        }
    }
}

} // namespace

Receiver::Receiver(Namespace& ns, std::function<void(const Address&)> on_address, std::function<void(const Value&)> on_value)
    : impl_(std::make_shared<Impl>(ns, std::move(on_address), std::move(on_value)))
{
}

Receiver::~Receiver()
{
    set_address(Address());
}

void Receiver::set_address(const Address& address)
{
    std::vector<Impl::Binding> old_bindings; // destroyed after the lock is released
    std::shared_ptr<void> old_observer;
    unsigned gen;
    {
        std::lock_guard<std::mutex> lock(impl_->mutex);
        gen = ++impl_->generation;
        old_bindings = std::move(impl_->bindings);
        impl_->bindings.clear();
        old_observer = std::move(impl_->ns_observer);
        impl_->address = address;
        impl_->attribute = address.attribute().empty() ? "value" : address.attribute();
    }
    old_bindings.clear();
    old_observer.reset();
    wait_idle(*impl_); // callbacks of the old binding that are running on other threads finish before we go on
    if (address.empty()) {
        return;
    }
    const std::shared_ptr<Impl> impl = impl_;
    std::weak_ptr<Impl> weak = impl_;
    std::shared_ptr<void> observer = impl_->ns.observe(address, [weak, gen](const Address& node, Object* object, bool created) {
        if (const auto keep = weak.lock()) {
            on_node_event(keep, gen, node, object, created);
        }
    });
    {
        std::lock_guard<std::mutex> lock(impl_->mutex);
        if (gen == impl_->generation) {
            impl_->ns_observer = observer;
        }
    }
    if (impl_->attribute == "created" || impl_->attribute == "destroyed") {
        return;
    }
    for (Node* node : impl_->ns.find(address)) {
        if (Object* object = node->object()) {
            bind_node(impl, node->address(), object, gen, true);
        }
    }
}

Address Receiver::address() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->address;
}

void Receiver::set_active(bool on) { impl_->active.store(on); }

bool Receiver::active() const { return impl_->active.load(); }

bool Receiver::bang()
{
    const Flight flight(impl_.get());
    Address node;
    Data* data = nullptr;
    Model* model = nullptr;
    std::string attr;
    {
        std::lock_guard<std::mutex> lock(impl_->mutex);
        if (impl_->bindings.empty()) {
            return false;
        }
        node = impl_->bindings.front().node;
        data = impl_->bindings.front().data;
        model = impl_->bindings.front().model;
        attr = impl_->attribute;
    }
    const std::optional<Value> v = model != nullptr ? std::optional<Value>(initialized_value(*model)) : data->get_attribute(attr);
    if (!v || v->empty()) {
        return false;
    }
    impl_->emit(node, attr, *v);
    return true;
}

std::optional<Value> Receiver::grab() const
{
    Data* data = nullptr;
    Model* model = nullptr;
    std::string attr;
    {
        std::lock_guard<std::mutex> lock(impl_->mutex);
        if (impl_->bindings.empty()) {
            return std::nullopt;
        }
        data = impl_->bindings.front().data;
        model = impl_->bindings.front().model;
        attr = impl_->attribute;
    }
    return model != nullptr ? std::optional<Value>(initialized_value(*model)) : data->get_attribute(attr);
}

} // namespace jamoma
