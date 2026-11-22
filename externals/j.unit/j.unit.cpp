// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file j.unit.cpp
 * @brief j.unit: converts numbers between the units of a dataspace (jamoma::Dataspace).
 *
 * Attributes: `dataspace` (default temperature), `input` and `output` (the units, which start at the dataspace's neutral unit). A number is
 * output as a float, a list as a list of floats. `dataspaces.get` and `units.get` send the menu contents to the dump outlet.
 */

#include <string>
#include <vector>

#include "c74_min.h"

#include "jamoma/dataspace.hpp"
#include "max_atoms.hpp"
#include "max_context.hpp"

using namespace c74::min;

/** The j.unit external. */
class j_unit : public c74::min::object<j_unit> {
    // State comes before the attributes: Min runs every attribute setter with its default while constructing them.
    jamoma::UnitConverter converter_;       /**< The dataspace and the units; thread safe (numbers arrive on any thread). */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object. @param args Unused (the attributes are applied by Max). */
    explicit j_unit(const atoms& args = {}) { (void)args; }

    inlet<> x_in{this, "(number or list) x"};                       /**< The inlet. */
    jamoma_max::dump_outlet y_out{this, "(number or list) y = f(x)"}; /**< Outlet 0: the converted value. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dumpout"};   /**< Outlet 1: the dump outlet. */

    /** The dataspace; the input and output units are reset to its neutral unit. */
    attribute<symbol> dataspace{this, "dataspace", "temperature", setter{MIN_FUNCTION {
        const std::string name = static_cast<symbol>(args[0]).c_str();
        if (!converter_.set_dataspace(name)) {
            c74::max::error("j.unit: unknown dataspace %s", name.c_str());
        }
        return args;
    }}};

    /** The unit of the incoming numbers. */
    attribute<symbol> input{this, "input", "", setter{MIN_FUNCTION {
        set_unit(true, static_cast<symbol>(args[0]).c_str());
        return args;
    }}};

    /** The unit of the outgoing numbers. */
    attribute<symbol> output{this, "output", "", setter{MIN_FUNCTION {
        set_unit(false, static_cast<symbol>(args[0]).c_str());
        return args;
    }}};

    /** After construction: registers the dump outlet. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        return {};
    }};

    /** A number is converted. */
    message<threadsafe::yes> m_int{this, "int", MIN_FUNCTION {
        convert(args);
        return {};
    }};

    /** A number is converted. */
    message<threadsafe::yes> m_float{this, "float", MIN_FUNCTION {
        convert(args);
        return {};
    }};

    /** Every element of a list is converted. */
    message<threadsafe::yes> m_list{this, "list", MIN_FUNCTION {
        convert(args);
        return {};
    }};

    /** Sends the names of the dataspaces to the dump outlet as the lines of a menu. */
    message<> dataspaces_get{this, "dataspaces.get", MIN_FUNCTION {
        menu("DataspacesMenu", jamoma::Dataspace::names());
        return {};
    }};

    /** Sends the names of the units of the current dataspace to the dump outlet as the lines of a menu. */
    message<> units_get{this, "units.get", MIN_FUNCTION {
        if (const jamoma::Dataspace* d = jamoma::Dataspace::find(converter_.dataspace())) {
            menu("UnitsMenu", d->unit_names());
        }
        return {};
    }};

    /** Class setup: nothing to add. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION { return {}; }};

private:
    /** Sets a unit if the dataspace has it. @param input True for the input unit, false for the output unit. @param name The unit name. */
    void set_unit(bool input, const std::string& name)
    {
        if (name.empty()) {
            return;
        }
        if (!(input ? converter_.set_input(name) : converter_.set_output(name))) {
            c74::max::error("j.unit: %s is not a unit of the %s dataspace", name.c_str(), converter_.dataspace().c_str());
        }
    }

    /** Converts a number or list and outputs the result as floats. @param args The incoming atoms. */
    void convert(const atoms& args)
    {
        jamoma::Value in;
        for (std::size_t i = 0; i < args.size(); ++i) {
            in.push_back(jamoma::Atom(static_cast<double>(args[i])));
        }
        const auto out = converter_.convert(in);
        if (!out || out->empty()) {
            return;
        }
        if (out->size() == 1) {
            c74::max::outlet_float(y_out.max_outlet(), (*out)[0].as_double());
            return;
        }
        atoms list;
        for (const jamoma::Atom& a : *out) {
            list.push_back(a.as_double());
        }
        c74::max::outlet_list(y_out.max_outlet(), nullptr, static_cast<short>(list.size()),
                              const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&list[0])));
    }

    /** Sends `<name> clear` and then `<name> append <entry>` for every entry to the dump outlet. @param name The menu. @param entries Its lines. */
    void menu(const char* name, const std::vector<std::string>& entries)
    {
        c74::max::t_atom a[2];
        c74::max::atom_setsym(&a[0], c74::max::gensym("clear"));
        c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym(name), 1, a);
        for (const std::string& entry : entries) {
            c74::max::atom_setsym(&a[0], c74::max::gensym("append"));
            c74::max::atom_setsym(&a[1], c74::max::gensym(entry.c_str()));
            c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym(name), 2, a);
        }
    }
};

MIN_EXTERNAL(j_unit);
