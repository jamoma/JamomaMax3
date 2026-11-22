// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file max_atoms.hpp
 * @brief Conversion between Min atoms and the core's Value.
 */

#pragma once

#include <cstdint>
#include <string>

#include "c74_min.h"

#include "jamoma/atom.hpp"

namespace jamoma_max {

/**
 * @brief Converts Max atoms to a core value. Atoms that are neither numbers nor symbols are dropped.
 * @param in The Max atoms.
 * @return The value.
 */
inline jamoma::Value to_value(const c74::min::atoms& in)
{
    jamoma::Value out;
    out.reserve(in.size());
    for (const c74::min::atom& a : in) {
        switch (a.type()) {
        case c74::min::message_type::int_argument:
            out.emplace_back(static_cast<std::int64_t>(static_cast<long long>(a)));
            break;
        case c74::min::message_type::float_argument:
            out.emplace_back(static_cast<double>(a));
            break;
        case c74::min::message_type::symbol_argument:
            out.emplace_back(std::string(static_cast<c74::min::symbol>(a).c_str()));
            break;
        default:
            break;
        }
    }
    return out;
}

/**
 * @brief Converts a core value to Max atoms.
 * @param in The value.
 * @return The Max atoms.
 */
inline c74::min::atoms to_atoms(const jamoma::Value& in)
{
    c74::min::atoms out;
    out.reserve(in.size());
    for (const jamoma::Atom& a : in) {
        if (a.is_int()) {
            out.push_back(c74::min::atom(static_cast<c74::max::t_atom_long>(a.as_int())));
        } else if (a.is_float()) {
            out.push_back(c74::min::atom(a.as_double()));
        } else {
            out.push_back(c74::min::atom(c74::min::symbol(a.as_symbol().c_str())));
        }
    }
    return out;
}

} // namespace jamoma_max
