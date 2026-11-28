// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.oscinstance.cpp
 * @brief j.oscinstance: takes the instance out of the first part of an OSC address.
 *
 * For `a.2/b 5` the arguments (5) leave the third outlet, then the instance (2) the second, then the address (`a/b`) the first. Anything without an instance
 * there, numbers and bangs leave the dump outlet. Behaviour: docs/inventory/osc-tools.md.
 */

#include <string>

#include "c74_min.h"

#include "jamoma/osc_tools.hpp"
#include "max_context.hpp"
#include "max_osc.hpp"

using namespace c74::min;

/** The j.oscinstance external. */
class j_oscinstance : public c74::min::object<j_oscinstance> {
public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    inlet<> input{this, "(anything) OSC message"};                                                     /**< The inlet. */
    jamoma_max::dump_outlet address_out{this, "(symbol) the address without the instance"};            /**< Outlet 0: the address. */
    jamoma_max::dump_outlet instance_out{this, "(int or symbol) the instance"};                        /**< Outlet 1: the instance. */
    jamoma_max::dump_outlet arguments_out{this, "(anything) the arguments of the message"};            /**< Outlet 2: the arguments. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump: what has no instance"};                   /**< Outlet 3: the dump outlet. */

    /** A bang leaves the dump outlet. */
    message<threadsafe::yes> bang{this, "bang", MIN_FUNCTION {
        c74::max::outlet_bang(dump_out.max_outlet());
        return {};
    }};

    /** An integer leaves the dump outlet. */
    message<threadsafe::yes> m_int{this, "int", MIN_FUNCTION {
        c74::max::outlet_int(dump_out.max_outlet(), static_cast<c74::max::t_atom_long>(static_cast<long long>(args[0])));
        return {};
    }};

    /** A float leaves the dump outlet. */
    message<threadsafe::yes> m_float{this, "float", MIN_FUNCTION {
        c74::max::outlet_float(dump_out.max_outlet(), static_cast<double>(args[0]));
        return {};
    }};

    /** A list has no address: it leaves the dump outlet. */
    message<threadsafe::yes> m_list{this, "list", MIN_FUNCTION {
        c74::max::outlet_list(dump_out.max_outlet(), nullptr, static_cast<short>(args.size()), jamoma_max::raw_atoms(args));
        return {};
    }};

    /** A message: its selector is the address. */
    message<threadsafe::yes> m_anything{this, "anything", MIN_FUNCTION {
        if (args.empty()) {
            return {};
        }
        const std::string selector = static_cast<symbol>(args[0]).c_str();
        const atoms arguments(args.begin() + 1, args.end());
        const auto split = jamoma::split_osc_instance(selector);
        if (!split) {
            c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym(selector.c_str()), static_cast<short>(arguments.size()),
                                      jamoma_max::raw_atoms(arguments));
            return {};
        }
        jamoma_max::send_arguments(arguments_out.max_outlet(), arguments);
        if (split->instance.is_int()) {
            c74::max::outlet_int(instance_out.max_outlet(), static_cast<c74::max::t_atom_long>(split->instance.as_int()));
        } else {
            c74::max::outlet_anything(instance_out.max_outlet(), c74::max::gensym(split->instance.as_symbol().c_str()), 0, nullptr);
        }
        c74::max::outlet_anything(address_out.max_outlet(), c74::max::gensym(split->address.c_str()), 0, nullptr);
        return {};
    }};

    /** Class setup: nothing to add. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION { return {}; }};
};

MIN_EXTERNAL(j_oscinstance);
