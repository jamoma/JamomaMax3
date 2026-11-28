// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file remote_array.cpp
 * @brief The array of remotes.
 */

#include "jamoma/remote_array.hpp"

#include <atomic>
#include <mutex>
#include <optional>
#include <utility>
#include <vector>

namespace jamoma {

namespace {

/** One instance. */
struct Link {
    std::unique_ptr<Remote> remote;    /**< The remote. */
    std::string bound;                 /**< The address it was bound to last (main thread). */
    std::atomic<bool> alive{true};     /**< False once the instance has been removed. */
};

using Links = std::vector<std::shared_ptr<Link>>; /**< Instances in index order. */

} // namespace

/** The state of a remote array. */
struct RemoteArray::Impl {
    /** @param n The namespace. @param t The callback. */
    Impl(Namespace& n, ToUi t) : ns(n), to_ui(std::move(t)) {}

    Namespace& ns;                             /**< The namespace. */
    mutable std::mutex mutex;                  /**< Guards what follows; never held while a remote or the callback is called. */
    ToUi to_ui;                                /**< What shows a value. */
    std::optional<ArrayName> name;             /**< The name; its size is the size wanted. */
    Resolve resolve;                           /**< Resolves instance names. */
    Links items;                               /**< The instances. */
    Links retired;                             /**< Removed instances that may still be on the call stack. */
    ArraySelection selection;                  /**< Where values go. */
    ArrayFormat format = ArrayFormat::Single;  /**< What is shown. */
    std::string unit;                          /**< The unit of the UI object. */
    bool active = true;                        /**< Whether anything is passed on. */
    bool freeze = false;                       /**< Whether the UI direction is stopped. */
    std::size_t pending = 0;                   /**< The last instance that reported during a change, in Array format. */
    std::atomic<int> outputting{0};            /**< How many callbacks are running. */
    std::atomic<int> restructuring{0};         /**< How many structure changes are running. */

    /** @return A copy of the list of instances. */
    Links snapshot() const
    {
        std::lock_guard<std::mutex> lock(mutex);
        return items;
    }

    /** @return The selected instances, in order. */
    Links targets() const
    {
        std::lock_guard<std::mutex> lock(mutex);
        Links result;
        for (std::size_t i : selection.targets(items.size())) {
            result.push_back(items[i - 1]);
        }
        return result;
    }

    /** Calls the callback. @param index The instance. @param value Its value (replaced by all values in Array format). */
    void emit(std::size_t index, Value value)
    {
        ToUi call;
        bool all = false;
        {
            std::lock_guard<std::mutex> lock(mutex);
            call = to_ui;
            all = format == ArrayFormat::Array;
        }
        if (!call) {
            return;
        }
        if (all) {
            value.clear();
            for (const auto& item : snapshot()) {
                const Value v = item->remote->current().value_or(Value{Atom(0)});
                value.insert(value.end(), v.begin(), v.end());
            }
        }
        struct Count {
            std::atomic<int>& n;                                /**< The counter. */
            explicit Count(std::atomic<int>& c) : n(c) { ++n; } /**< @param c The counter. */
            ~Count() { --n; }                                   /**< Counts down. */
        } count(outputting);
        call(index, value);
    }

    /** Cuts an instance off. @param item The instance. */
    void retire(const std::shared_ptr<Link>& item)
    {
        item->alive = false;
        item->remote->set_active(false);
        std::lock_guard<std::mutex> lock(mutex);
        retired.push_back(item);
    }

    /** Destroys the removed instances, unless a callback is running (one of them could be making it). */
    void purge()
    {
        Links gone;
        if (outputting == 0) {
            std::lock_guard<std::mutex> lock(mutex);
            gone.swap(retired);
        }
    }

    /** Binds an instance, if its address has changed. @param item The instance. @param index Its number. */
    void bind(Link& item, std::size_t index)
    {
        Resolve r;
        std::string instance;
        {
            std::lock_guard<std::mutex> lock(mutex);
            if (!name || !resolve) {
                return;
            }
            r = resolve;
            instance = name->instance(index);
        }
        const Address address = r(instance);
        if (address.str() == item.bound) {
            return;
        }
        item.bound = address.str();
        item.remote->set_address(address);
    }

    /** Builds one instance, not yet bound. @param self This state. @param index Its number. @return The instance. */
    std::shared_ptr<Link> make(const std::shared_ptr<Impl>& self, std::size_t index)
    {
        auto item = std::make_shared<Link>();
        item->remote = std::make_unique<Remote>(ns, [weak = std::weak_ptr<Impl>(self), of = std::weak_ptr<Link>(item), index](const Value& v) {
            const auto state = weak.lock();
            const auto from = of.lock();
            if (!state || !from || !from->alive) {
                return;
            }
            {
                std::lock_guard<std::mutex> lock(state->mutex);
                if (state->format == ArrayFormat::Array && state->restructuring != 0) {
                    state->pending = index; // the whole list is shown once, when the change is done
                    return;
                }
            }
            state->emit(index, v);
        });
        std::lock_guard<std::mutex> lock(mutex);
        item->remote->set_unit(unit);
        item->remote->set_active(active);
        item->remote->set_freeze(freeze);
        return item;
    }

    /** Brings the number of instances to the size in the name (which a callback may change meanwhile). @param self This state. */
    void fit(const std::shared_ptr<Impl>& self)
    {
        for (;;) {
            std::shared_ptr<Link> surplus;
            std::size_t index = 0;
            {
                std::lock_guard<std::mutex> lock(mutex);
                if (items.size() > name->size) {
                    surplus = items.back();
                    items.pop_back();
                } else if (items.size() < name->size) {
                    index = items.size() + 1;
                } else {
                    selection.resized(items.size());
                    return;
                }
            }
            if (surplus) {
                retire(surplus);
                continue;
            }
            auto item = make(self, index);
            {
                std::lock_guard<std::mutex> lock(mutex);
                items.push_back(item);
            }
            bind(*item, index);
        }
    }

    /** Ends a structure change: shows the whole list if something reported during it. */
    void finish()
    {
        std::size_t index = 0;
        if (--restructuring == 0) {
            std::lock_guard<std::mutex> lock(mutex);
            index = pending <= items.size() ? pending : items.size();
            pending = 0;
        }
        if (index != 0) {
            emit(index, Value{});
        }
    }

    /** Sends values to instances. @param to The instances. @param value The value. @param silent Whether nothing is shown here. @return False if there are none. */
    static bool send(const Links& to, const Value& value, bool silent)
    {
        for (const auto& item : to) {
            if (!item->alive) {
                continue;
            }
            if (silent) {
                item->remote->set_without_output(value);
            } else if (value.empty()) {
                item->remote->bang();
            } else {
                item->remote->from_ui(value);
            }
        }
        return !to.empty();
    }

    /** Sends equal parts of a list. @param list The list. @param silent As for send. @return False for a wrong length or an empty array. */
    bool split(const Value& list, bool silent)
    {
        const Links all = snapshot();
        const auto parts = split_array(list, all.size());
        if (!parts) {
            return false;
        }
        for (std::size_t i = 0; i < all.size(); ++i) {
            send({all[i]}, (*parts)[i], silent);
        }
        return true;
    }
};

RemoteArray::RemoteArray(Namespace& ns, ToUi to_ui) : impl_(std::make_shared<Impl>(ns, std::move(to_ui))) {}

RemoteArray::~RemoteArray()
{
    {
        std::lock_guard<std::mutex> lock(impl_->mutex);
        impl_->to_ui = nullptr;
    }
    for (const auto& item : impl_->snapshot()) {
        impl_->retire(item);
    }
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->items.clear();
}

bool RemoteArray::set_name(const std::string& name, Resolve resolve)
{
    const std::optional<ArrayName> parsed = parse_array_name(name);
    if (!parsed) {
        return false;
    }
    const std::shared_ptr<Impl> self = impl_; // the callback may destroy the array
    self->purge();
    ++self->restructuring;
    Links old;
    {
        std::lock_guard<std::mutex> lock(self->mutex);
        if (self->name && !self->name->same_shape(*parsed)) {
            old.swap(self->items);
            self->selection = ArraySelection();
        }
        self->name = *parsed;
        self->resolve = std::move(resolve);
    }
    for (const auto& item : old) {
        self->retire(item);
    }
    rebind();
    self->fit(self);
    self->finish();
    return true;
}

bool RemoteArray::resize(std::size_t size)
{
    const std::shared_ptr<Impl> self = impl_;
    {
        std::lock_guard<std::mutex> lock(self->mutex);
        if (!self->name || size > kMaxArraySize) {
            return false;
        }
        self->name->size = size;
    }
    self->purge();
    ++self->restructuring;
    self->fit(self);
    {
        std::lock_guard<std::mutex> lock(self->mutex);
        if (self->format == ArrayFormat::Array) {
            self->pending = self->items.size();
        }
    }
    self->finish();
    return true;
}

void RemoteArray::rebind()
{
    const std::shared_ptr<Impl> self = impl_;
    ++self->restructuring;
    const Links items = self->snapshot();
    for (std::size_t i = 0; i < items.size(); ++i) {
        if (items[i]->alive) {
            self->bind(*items[i], i + 1);
        }
    }
    self->finish();
}

std::size_t RemoteArray::size() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->items.size();
}

std::string RemoteArray::name() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->name ? impl_->name->with_size(impl_->items.size()) : std::string();
}

bool RemoteArray::select(const Atom& which)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->selection.select(which, impl_->items.size());
}

std::size_t RemoteArray::selected() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->selection.index();
}

bool RemoteArray::from_ui(const Value& value)
{
    const std::shared_ptr<Impl> self = impl_;
    return Impl::send(self->targets(), value, false);
}

bool RemoteArray::set(const Value& value)
{
    const std::shared_ptr<Impl> self = impl_;
    return Impl::send(self->targets(), value, true);
}

bool RemoteArray::array(const Value& list)
{
    const std::shared_ptr<Impl> self = impl_;
    return self->split(list, false);
}

bool RemoteArray::set_array(const Value& list)
{
    const std::shared_ptr<Impl> self = impl_;
    return self->split(list, true);
}

void RemoteArray::set_unit(std::string_view unit)
{
    {
        std::lock_guard<std::mutex> lock(impl_->mutex);
        impl_->unit = std::string(unit);
    }
    for (const auto& item : impl_->snapshot()) {
        item->remote->set_unit(unit);
    }
}

void RemoteArray::set_active(bool on)
{
    {
        std::lock_guard<std::mutex> lock(impl_->mutex);
        impl_->active = on;
    }
    for (const auto& item : impl_->snapshot()) {
        item->remote->set_active(on);
    }
}

void RemoteArray::set_freeze(bool on)
{
    {
        std::lock_guard<std::mutex> lock(impl_->mutex);
        impl_->freeze = on;
    }
    for (const auto& item : impl_->snapshot()) {
        item->remote->set_freeze(on);
    }
}

void RemoteArray::set_format(ArrayFormat format)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->format = format;
}

ArrayFormat RemoteArray::format() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->format;
}

} // namespace jamoma
