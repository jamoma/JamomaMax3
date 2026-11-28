// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file max_queries.hpp
 * @brief The old attribute query: an attribute name sent without a value is answered as `<name> <value>` on the dump outlet.
 *
 * Min drops an empty value before the object sees it, so the setter of the Max attribute is replaced.
 */

#pragma once

#include <initializer_list>
#include <string>

#include "c74_min.h"

namespace jamoma_max {

/**
 * @brief Answers `<name> <value>` on the dump outlet of an object (nothing if it has none or no such attribute).
 * @param object The object; its dump outlet is the one stored as `dumpout`. @param name The attribute.
 */
inline void reply_to_query(c74::max::t_object* object, c74::max::t_symbol* name)
{
    c74::max::t_object* dumpout = nullptr;
    c74::max::object_obex_lookup(object, c74::max::gensym("dumpout"), &dumpout);
    long count = 0;
    c74::max::t_atom* values = nullptr;
    if (dumpout != nullptr && c74::max::object_attr_getvalueof(object, name, &count, &values) == c74::max::MAX_ERR_NONE) {
        c74::max::outlet_anything(reinterpret_cast<c74::max::t_outlet*>(dumpout), name, static_cast<short>(count), values);
    }
    if (values != nullptr) {
        c74::max::sysmem_freeptr(values);
    }
}

/** @brief The method of the messages `get<name>`. @param object The object. @param message The message. */
inline void get_message(c74::max::t_object* object, c74::max::t_symbol* message, long, c74::max::t_atom*)
{
    const std::string text = message->s_name;
    if (text.size() > 3) {
        reply_to_query(object, c74::max::gensym(text.c_str() + 3));
    }
}

/**
 * @brief Adds the messages `get<name>`, which answer like the bare attribute name (call from `maxclass_setup`).
 * @param c The Max class. @param names The attributes (leave out those whose `get` message the class has already).
 */
inline void answer_get_messages(c74::max::t_class* c, std::initializer_list<const char*> names)
{
    for (const char* name : names) {
        c74::max::class_addmethod(c, reinterpret_cast<c74::max::method>(&get_message), (std::string("get") + name).c_str(), c74::max::A_GIMME, 0);
    }
}

/**
 * @brief The setter that answers queries and passes every other value to Min.
 * @tparam T The external class. @param self The object. @param attr The attribute. @param argc The count. @param argv The atoms. @return A Max error code.
 */
template <class T>
c74::max::t_max_err query_setter(c74::min::minwrap<T>* self, c74::max::t_object* attr, long argc, c74::max::t_atom* argv)
{
    if (argc != 0) {
        return c74::min::min_attr_setter<T>(self, attr, argc, argv);
    }
    auto* name = static_cast<c74::max::t_symbol*>(c74::max::object_method(attr, c74::max::gensym("getname")));
    reply_to_query(self->m_min_object.maxobj(), name);
    return c74::max::MAX_ERR_NONE;
}

/**
 * @brief Lets Min attributes of a class be asked for by their bare names (call from `maxclass_setup`).
 * @tparam T The external class. @param c The Max class. @param names The attributes, all declared as Min attributes.
 */
template <class T>
void answer_queries(c74::max::t_class* c, std::initializer_list<const char*> names)
{
    for (const char* name : names) {
        auto* attr = static_cast<c74::max::t_object*>(c74::max::class_attr_get(c, c74::max::gensym(name)));
        if (attr != nullptr) {
            c74::max::object_method(attr, c74::max::gensym("setmethod"), c74::max::gensym("set"),
                                    reinterpret_cast<c74::max::method>(&query_setter<T>));
        }
    }
}

} // namespace jamoma_max
