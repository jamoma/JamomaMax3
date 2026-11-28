// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file max_osc.hpp
 * @brief What j.oscinstance and j.oscroute share: sending the arguments of a message on by themselves.
 */

#pragma once

#include "c74_min.h"

namespace jamoma_max {

/** @param a Max atoms. @return A pointer to them as the Max API takes it (null if there are none). */
inline c74::max::t_atom* raw_atoms(const c74::min::atoms& a)
{
    return a.empty() ? nullptr : const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&a[0]));
}

/**
 * @brief Sends the arguments of a message without its address: none is a bang; one number or symbol is that; of several the first is the
 *        message if it is a symbol, else they are a list.
 * @param outlet The outlet. @param arguments The arguments.
 */
inline void send_arguments(c74::max::t_outlet* outlet, const c74::min::atoms& arguments)
{
    c74::max::t_atom* raw = raw_atoms(arguments);
    const auto count = static_cast<short>(arguments.size());
    if (count == 0) {
        c74::max::outlet_bang(outlet);
        return;
    }
    const long type = c74::max::atom_gettype(raw);
    if (count == 1) {
        if (type == c74::max::A_LONG) {
            c74::max::outlet_int(outlet, c74::max::atom_getlong(raw));
        } else if (type == c74::max::A_FLOAT) {
            c74::max::outlet_float(outlet, c74::max::atom_getfloat(raw));
        } else if (type == c74::max::A_SYM) {
            c74::max::outlet_anything(outlet, c74::max::atom_getsym(raw), 0, nullptr);
        } else {
            c74::max::outlet_anything(outlet, c74::max::gensym("list"), 1, raw);
        }
    } else if (type == c74::max::A_SYM) {
        c74::max::outlet_anything(outlet, c74::max::atom_getsym(raw), static_cast<short>(count - 1), raw + 1);
    } else {
        c74::max::outlet_anything(outlet, c74::max::gensym("list"), count, raw);
    }
}

} // namespace jamoma_max
