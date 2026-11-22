// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file max_address.hpp
 * @brief Resolves the addresses written in a patcher (j.send, j.receive) against the model of that patcher, and outputs values.
 */

#pragma once

#include <string>

#include "c74_min.h"

#include "jamoma/address.hpp"
#include "jamoma/model.hpp"
#include "max_atoms.hpp"
#include "max_context.hpp"

namespace jamoma_max {

/**
 * @brief The address a box should bind to: what is written, resolved against the model of its patcher (see jamoma::resolve_relative).
 * @param box The box object.
 * @param text The address as written (for example `data/active` or `/model/param`).
 * @return The absolute address; relative ones are taken from the root when the patcher has no model.
 */
inline jamoma::Address resolve_in_patcher(c74::max::t_object* box, const std::string& text)
{
    const jamoma::Model* model = find_model(box);
    return jamoma::resolve_relative(jamoma::Address::parse(text), model != nullptr ? model->address() : jamoma::Address());
}

/**
 * @brief Sends a value out of an outlet as the old objects did: nothing is a bang, one integer or float is a number, a list that starts
 *        with a symbol is a message, anything else is a list.
 * @param outlet The Max outlet.
 * @param value The value.
 */
inline void output_value(c74::max::t_outlet* outlet, const jamoma::Value& value)
{
    if (value.empty()) {
        c74::max::outlet_bang(outlet);
        return;
    }
    if (value.size() == 1 && value[0].is_int()) {
        c74::max::outlet_int(outlet, static_cast<c74::max::t_atom_long>(value[0].as_int()));
        return;
    }
    if (value.size() == 1 && value[0].is_float()) {
        c74::max::outlet_float(outlet, value[0].as_double());
        return;
    }
    const c74::min::atoms atoms = to_atoms(value);
    auto* raw = const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&atoms[0]));
    if (value[0].is_symbol()) {
        c74::max::outlet_anything(outlet, c74::max::gensym(value[0].as_symbol().c_str()), static_cast<short>(atoms.size() - 1), raw + 1);
    } else {
        c74::max::outlet_list(outlet, nullptr, static_cast<short>(atoms.size()), raw);
    }
}

} // namespace jamoma_max
