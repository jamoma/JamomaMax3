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

#include "c74_min.h"

namespace jamoma_max {

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
    auto* object = self->m_min_object.maxobj();
    auto* name = static_cast<c74::max::t_symbol*>(c74::max::object_method(attr, c74::max::gensym("getname")));
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
    return c74::max::MAX_ERR_NONE;
}

/**
 * @brief Lets attributes of a class be asked for by their bare names (call from `maxclass_setup`).
 * @tparam T The external class. @param c The Max class. @param names The attributes.
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
