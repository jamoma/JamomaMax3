// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file data_attributes.hpp
 * @brief The Max attributes of a data object, shared by the single objects (j.parameter and its neighbours) and the arrays.
 */

#pragma once

#include <algorithm>
#include <string>
#include <string_view>
#include <vector>

#include "c74_min.h"

#include "jamoma/data.hpp"
#include "jamoma/dataspace.hpp"
#include "jamoma/function_library.hpp"
#include "max_atoms.hpp"
#include "max_queries.hpp"

namespace jamoma_max {

/**
 * @brief Answers `<name> <value>` on an outlet (the old attribute query).
 * @param outlet The dump outlet. @param name The attribute or parameter name. @param value Its value.
 */
inline void send_attribute(c74::max::t_outlet* outlet, const std::string& name, const jamoma::Value& value)
{
    const c74::min::atoms atoms = to_atoms(value);
    c74::max::outlet_anything(outlet, c74::max::gensym(name.c_str()), static_cast<short>(atoms.size()),
                              atoms.empty() ? nullptr : const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&atoms[0])));
}

/**
 * @brief Adds every attribute of `jamoma::Data` (the table `Data::attribute_names()`) to a Max class.
 *
 * They are lists of atoms of any length, which Min's attribute type cannot hold, so the Max attribute API is used directly.
 * @tparam Derived The external class. It provides `attribute_value(name)`, `set_attribute_value(name, value)` and
 *         `dump_attribute(name)`, which are called for its instances.
 */
template <class Derived>
struct data_attributes {
    /** @param name A name. @return True if it is an attribute of a data object. */
    static bool is_attribute(std::string_view name)
    {
        const auto& names = jamoma::Data::attribute_names();
        return std::find(names.begin(), names.end(), name) != names.end();
    }

    /** @brief Adds the attributes, with a toggle for the true or false ones and a menu for those with a fixed set of values. @param c The class. */
    static void add_to_class(c74::max::t_class* c)
    {
        for (const std::string& name : jamoma::Data::attribute_names()) {
            add(c, name);
            answer_get_messages(c, {name.c_str()}); // `get<name>`, which Max does not answer here by itself
        }
        // What the inspector and attrui show.
        show_toggle(c, "repetitions/filter");
        show_toggle(c, "active");
        show_menu(c, "type", {"none", "generic", "string", "boolean", "integer", "decimal", "array"});
        show_menu(c, "clipmode", {"none", "low", "high", "both"});
        show_menu(c, "ramp/drive", {"max", "system", "none"});
        std::vector<std::string> functions{"none"};
        for (const std::string& function : jamoma::function_names()) {
            functions.push_back(function);
        }
        show_menu(c, "ramp/function", functions);
        std::vector<std::string> dataspaces{"none"};
        for (const std::string& dataspace : jamoma::Dataspace::names()) {
            dataspaces.push_back(dataspace);
        }
        show_menu(c, "dataspace", dataspaces);
    }

private:
    /** @param attr A Max attribute. @return Its name. */
    static std::string name_of(c74::max::t_object* attr)
    {
        auto* name = static_cast<c74::max::t_symbol*>(c74::max::object_method(attr, c74::max::gensym("getname")));
        return name != nullptr ? std::string(name->s_name) : std::string();
    }

    /** The Max getter. @param o The object. @param attr The attribute. @param argc Receives the count. @param argv Receives the atoms. @return A Max error code. */
    static c74::max::t_max_err getter(c74::max::t_object* o, c74::max::t_object* attr, long* argc, c74::max::t_atom** argv)
    {
        const jamoma::Value v = c74::min::wrapper_find_self<Derived>(o)->m_min_object.attribute_value(name_of(attr));
        char allocated = 0;
        c74::max::atom_alloc_array(static_cast<long>(v.size()), argc, argv, &allocated);
        for (std::size_t i = 0; i < v.size(); ++i) {
            if (v[i].is_int()) {
                c74::max::atom_setlong(*argv + i, static_cast<c74::max::t_atom_long>(v[i].as_int()));
            } else if (v[i].is_float()) {
                c74::max::atom_setfloat(*argv + i, v[i].as_double());
            } else {
                c74::max::atom_setsym(*argv + i, c74::max::gensym(v[i].as_symbol().c_str()));
            }
        }
        return c74::max::MAX_ERR_NONE;
    }

    /**
     * The Max setter. With no arguments (a bare attribute-name message) it answers the query on the dump outlet.
     * @param o The object. @param attr The attribute. @param argc The count. @param argv The atoms. @return A Max error code.
     */
    static c74::max::t_max_err setter(c74::max::t_object* o, c74::max::t_object* attr, long argc, c74::max::t_atom* argv)
    {
        Derived& self = c74::min::wrapper_find_self<Derived>(o)->m_min_object;
        if (argc == 0) {
            self.dump_attribute(name_of(attr));
            return c74::max::MAX_ERR_NONE;
        }
        jamoma::Value v;
        for (long i = 0; i < argc; ++i) {
            switch (c74::max::atom_gettype(argv + i)) {
            case c74::max::A_LONG: v.emplace_back(static_cast<std::int64_t>(c74::max::atom_getlong(argv + i))); break;
            case c74::max::A_FLOAT: v.emplace_back(c74::max::atom_getfloat(argv + i)); break;
            case c74::max::A_SYM: v.emplace_back(std::string(c74::max::atom_getsym(argv + i)->s_name)); break;
            default: break;
            }
        }
        self.set_attribute_value(name_of(attr), v);
        return c74::max::MAX_ERR_NONE;
    }

    /** @param name An attribute. @return Its Max type: a number for the true or false ones, a symbol for those with a menu, else atoms. */
    static std::string type_of(const std::string& name)
    {
        if (name == "repetitions/filter" || name == "active") {
            return "long";
        }
        if (name == "type" || name == "clipmode" || name == "ramp/drive" || name == "ramp/function" || name == "dataspace") {
            return "symbol";
        }
        return "atom";
    }

    /** Adds one attribute. @param c The class. @param name Its name. */
    static void add(c74::max::t_class* c, const std::string& name)
    {
        const std::string type = type_of(name);
        const auto get = reinterpret_cast<c74::max::method>(&getter);
        const auto set = reinterpret_cast<c74::max::method>(&setter);
        c74::max::t_object* attr = type == "atom"
            ? c74::max::attr_offset_array_new(name.c_str(), c74::max::gensym(type.c_str()), 256, 0, get, set, 0, 0)
            : c74::max::attr_offset_new(name.c_str(), c74::max::gensym(type.c_str()), 0, get, set, 0);
        c74::max::class_addattr(c, attr);
    }

    /** Shows an attribute as a toggle. @param c The class. @param name The attribute. */
    static void show_toggle(c74::max::t_class* c, const char* name)
    {
        c74::max::class_attr_addattr_parse(c, name, "style", c74::max::gensym("symbol"), 0, "onoff");
    }

    /** Shows an attribute as a menu. @param c The class. @param name The attribute. @param values The lines of the menu. */
    static void show_menu(c74::max::t_class* c, const char* name, const std::vector<std::string>& values)
    {
        std::string text;
        for (const std::string& value : values) {
            text += (text.empty() ? "" : " ") + value;
        }
        c74::max::class_attr_addattr_parse(c, name, "style", c74::max::gensym("symbol"), 0, "enum");
        c74::max::class_attr_addattr_parse(c, name, "enumvals", c74::max::gensym("atom"), 0, text.c_str());
    }
};

} // namespace jamoma_max
