// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file max_context.hpp
 * @brief Helpers for the Max layer: finding the patcher of an object and its model, and deferring a call safely.
 */

#pragma once

#include <atomic>
#include <functional>
#include <memory>
#include <optional>
#include <string>

#include "c74_min.h"

#include "jamoma/registry.hpp"

namespace jamoma_max {

/** An outlet that exposes its Max outlet pointer, so it can be registered as the object's dumpout. */
class dump_outlet : public c74::min::outlet<> {
public:
    using c74::min::outlet<>::outlet;
    /** @return The Max outlet (null until Min has created the outlets). */
    c74::max::t_outlet* max_outlet() const { return reinterpret_cast<c74::max::t_outlet*>(m_instance); }
};

/** A token an object holds; deferred calls keep a weak copy and do nothing once the object is gone. */
class Alive {
public:
    /** @return A weak reference to the token. */
    std::weak_ptr<int> weak() const { return token_; }

private:
    std::shared_ptr<int> token_ = std::make_shared<int>(0); /**< The token. */
};

namespace detail {
/** What a deferred call carries. */
struct DeferredCall {
    std::weak_ptr<int> alive;       /**< Whether the caller still exists. */
    std::function<void()> function; /**< What to do. */
};

/** The Max callback of a deferred call. @param argv One atom that holds the DeferredCall. */
inline void run_deferred(c74::max::t_object*, c74::max::t_symbol*, short, c74::max::t_atom* argv)
{
    auto* c = reinterpret_cast<DeferredCall*>(c74::max::atom_getlong(argv));
    if (!c->alive.expired()) {
        c->function();
    }
    delete c;
}
} // namespace detail

/**
 * @brief Runs a function later on the main thread (low priority: after the patcher has finished loading).
 * @param box The box object of the caller (Max wants a valid object to defer on; it is not touched when the call runs).
 * @param alive The token of the object the function belongs to; if it has expired the function is not called.
 * @param function The function.
 */
inline void defer_call(c74::max::t_object* box, std::weak_ptr<int> alive, std::function<void()> function)
{
    auto* call = new detail::DeferredCall{std::move(alive), std::move(function)};
    c74::max::t_atom atom;
    c74::max::atom_setlong(&atom, reinterpret_cast<c74::max::t_atom_long>(call));
    c74::max::defer_low(box, reinterpret_cast<c74::max::method>(&detail::run_deferred), nullptr, 1, &atom);
}

/**
 * @brief Runs a function now if this is the main thread, else later on the main thread (every call is kept, in order; nothing is coalesced).
 *
 * The core's Sender and the Min attribute machinery are for the main thread, but the value messages must be accepted on any thread (ramp
 * ticks arrive on the scheduler thread), so the handlers hand their work over with this.
 * @param box The box object of the caller.
 * @param alive The token of the caller; if it has expired by then the function is not called.
 * @param function The function.
 */
inline void run_on_main(c74::max::t_object* box, std::weak_ptr<int> alive, std::function<void()> function)
{
    if (c74::max::systhread_ismainthread()) {
        function();
    } else {
        defer_call(box, std::move(alive), std::move(function));
    }
}

/** @param box A box object. @return Its patcher (as an opaque key), or null. */
inline const void* patcher_of(c74::max::t_object* box)
{
    c74::max::t_object* patcher = nullptr;
    c74::max::object_obex_lookup(box, c74::max::gensym("#P"), &patcher);
    return patcher;
}

/** @param patcher A patcher. @return The patcher it sits in, or null. */
inline const void* parent_patcher(const void* patcher)
{
    return c74::max::object_attr_getobj(const_cast<c74::max::t_object*>(static_cast<const c74::max::t_object*>(patcher)),
                                        c74::max::gensym("parentpatcher"));
}

/**
 * @brief The class of a patcher, taken from its file name: `qmetro.model.maxpat` and `qmetro.view.maxpat` are of class `qmetro`.
 * @param patcher The patcher (as patcher_of gives it).
 * @return The class, or nothing if the file name has neither the `.model` nor the `.view` context.
 */
inline std::optional<std::string> patcher_class(const void* patcher)
{
    if (patcher == nullptr) {
        return std::nullopt;
    }
    c74::max::t_symbol* s = c74::max::jpatcher_get_name(const_cast<c74::max::t_object*>(static_cast<const c74::max::t_object*>(patcher)));
    if (s == nullptr || s->s_name == nullptr) {
        return std::nullopt;
    }
    const std::string name = s->s_name;
    for (const char* context : {".model", ".view"}) {
        const std::size_t at = name.rfind(context);
        const std::string tail = at == std::string::npos ? std::string() : name.substr(at + std::string(context).size());
        if (at != std::string::npos && at > 0 && (tail.empty() || tail == ".maxpat")) {
            return name.substr(0, at);
        }
    }
    return std::nullopt;
}

/**
 * @brief The first argument of the bpatcher a patcher is loaded in, if it is a name (the old objects took the address of a model or view from it).
 * @param patcher The patcher (as patcher_of gives it).
 * @return The argument, or nothing if the patcher is not in a bpatcher, the bpatcher has no arguments, or the first one is not a symbol or is an attribute.
 */
inline std::optional<std::string> bpatcher_argument(const void* patcher)
{
    if (patcher == nullptr) {
        return std::nullopt;
    }
    auto* box = static_cast<c74::max::t_object*>(c74::max::object_attr_getobj(
        const_cast<c74::max::t_object*>(static_cast<const c74::max::t_object*>(patcher)), c74::max::gensym("box")));
    if (box == nullptr || c74::max::object_classname(box) != c74::max::gensym("bpatcher")) {
        return std::nullopt;
    }
    long count = 0;
    c74::max::t_atom* values = nullptr;
    if (c74::max::object_attr_getvalueof(box, c74::max::gensym("args"), &count, &values) != 0 || values == nullptr) {
        return std::nullopt;
    }
    std::optional<std::string> result;
    if (count > 0 && c74::max::atom_gettype(values) == c74::max::A_SYM) {
        const std::string first = c74::max::atom_getsym(values)->s_name;
        if (!first.empty() && first[0] != '@') {
            result = first;
        }
    }
    c74::max::sysmem_freeptr(values);
    return result;
}

/**
 * @brief The address of the model a view patcher is bound to, if there is one now.
 *
 * With a model argument (that of j.view, else the first argument of the view's bpatcher): an absolute address is used as it is, a relative one is
 * taken below the model of the patcher that contains the view (the root if there is none). Without one, the patcher that contains the view is searched for a model patcher of the same class (`qmetro.view`
 * finds `qmetro.model`). The answer is worked out from what exists now, so it follows models coming and going.
 * @param view_patcher The patcher of the view.
 * @return The address of the model, or nothing while there is none (the view is waiting).
 */
inline std::optional<std::string> view_model_address(const void* view_patcher)
{
    std::optional<std::string> argument = jamoma::Registry::instance().views().find(view_patcher);
    if (!argument) {
        return std::nullopt;
    }
    if (argument->empty()) {
        argument = bpatcher_argument(view_patcher).value_or(std::string());
    }
    const void* container = parent_patcher(view_patcher);
    std::string address;
    if (!argument->empty()) {
        std::string base;
        for (const void* p = container; p != nullptr; p = parent_patcher(p)) {
            if (const jamoma::Model* model = jamoma::Registry::instance().contexts().find(p)) {
                base = model->address().str();
                break;
            }
        }
        address = (*argument)[0] == '/' ? *argument : base + "/" + *argument;
    } else {
        const std::optional<std::string> wanted = patcher_class(view_patcher);
        for (const auto& entry : jamoma::Registry::instance().contexts().all()) {
            if (parent_patcher(entry.first) == container && wanted && patcher_class(entry.first) == wanted) {
                address = entry.second->address().str();
                break;
            }
        }
    }
    if (address.empty()) {
        return std::nullopt;
    }
    jamoma::Node* node = jamoma::Registry::instance().names().lookup(jamoma::Address::parse(address));
    auto* model = node != nullptr ? dynamic_cast<jamoma::Model*>(node->object()) : nullptr;
    if (model == nullptr) {
        return std::nullopt;
    }
    // A model that is being removed is told to the observers while it is still in the namespace: it counts only while a patcher has it.
    for (const auto& entry : jamoma::Registry::instance().contexts().all()) {
        if (entry.second == model) {
            return address;
        }
    }
    return std::nullopt;
}

/**
 * @brief Finds the model that governs a box: the one of its patcher, else of the nearest enclosing patcher.
 * @param box The box object.
 * @return The model, or null.
 */
inline jamoma::Model* find_model(c74::max::t_object* box)
{
    for (const void* p = patcher_of(box); p != nullptr; p = parent_patcher(p)) {
        if (jamoma::Model* model = jamoma::Registry::instance().contexts().find(p)) {
            return model;
        }
    }
    return nullptr;
}

/**
 * @brief Runs a function once, later on the main thread, however often it is asked for before it runs.
 *
 * A burst of changes, such as a model that is removed and made again, gives one call after the burst, when everything has settled. Use one per object.
 */
class Settle {
public:
    /**
     * Asks for the function to run (nothing happens if a call is already waiting).
     * @param box The box object of the caller. @param alive The token of the caller; if it has expired by then the function is not called.
     * @param function What to run.
     */
    void request(c74::max::t_object* box, std::weak_ptr<int> alive, std::function<void()> function)
    {
        if (pending_->exchange(true)) {
            return;
        }
        const std::shared_ptr<std::atomic<bool>> pending = pending_;
        defer_call(box, std::move(alive), [pending, function = std::move(function)] {
            pending->store(false);
            function();
        });
    }

private:
    std::shared_ptr<std::atomic<bool>> pending_ = std::make_shared<std::atomic<bool>>(false); /**< True while a call is waiting. */
};

/**
 * @brief Calls a function whenever a model is registered for a patcher or removed again, or a view is given another model address (anywhere),
 *        so that an object can find its model again when it appears later, is replaced or goes, or the view turns to another one.
 *
 * The function runs on the thread that registers the model or sets the address (the main thread, for Max objects), after the registry's lock is released.
 * It is not called for the object's own start-up: the object binds once itself and then watches.
 */
class ContextWatch {
public:
    /**
     * Starts watching.
     * @param changed What to do on every change (it must be safe to call while the watch exists only).
     */
    void start(std::function<void()> changed)
    {
        views_ = jamoma::Registry::instance().views().observe([changed](const void*) { changed(); });
        handle_ = jamoma::Registry::instance().contexts().observe(
            [changed = std::move(changed)](const void*, jamoma::Model*, bool) { changed(); });
    }

    /** Stops watching (also done by the destructor). */
    void stop()
    {
        handle_.reset();
        views_.reset();
    }

private:
    std::shared_ptr<void> handle_; /**< The observer registration for models. */
    std::shared_ptr<void> views_;  /**< The observer registration for views. */
};

} // namespace jamoma_max
