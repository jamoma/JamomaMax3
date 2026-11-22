// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file max_context.hpp
 * @brief Helpers for the Max layer: finding the patcher of an object and its model, and deferring a call safely.
 */

#pragma once

#include <functional>
#include <memory>
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

} // namespace jamoma_max
