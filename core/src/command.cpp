// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file command.cpp
 * @brief Implementation of the command parser (a port of the old positional rules).
 */

#include "jamoma/command.hpp"

#include <cmath>

namespace jamoma {

namespace {

/** True if the atom is the symbol `ramp`. */
bool is_ramp_word(const Atom& atom)
{
    return atom.is_symbol() && atom.as_symbol() == "ramp";
}

/** The ramp time of the atom in whole milliseconds, never negative. */
double ramp_time(const Atom& atom)
{
    const double t = atom.is_number() ? atom.as_double() : 0.0;
    if (!(t > 0.0)) {
        return 0.0;
    }
    return std::trunc(t);
}

} // namespace

Command parse_command(const Value& input, bool parse_unit_and_ramp)
{
    Command command;
    const std::size_t n = input.size();
    bool has_ramp = false;
    bool has_unit = false;
    std::string unit;

    if (!parse_unit_and_ramp || n < 2) {
        command.values = input;
        return command;
    }

    if (n == 2) {
        if (!input[0].is_symbol() && input[1].is_symbol()) {
            has_unit = true;
            unit = input[1].as_symbol();
        }
    } else if (n == 3) {
        if (input[1].is_symbol()) {
            has_ramp = is_ramp_word(input[1]);
        } else if (!input[0].is_symbol() && input[2].is_symbol()) {
            has_unit = true;
            unit = input[2].as_symbol();
        }
    } else {
        if (input[n - 2].is_symbol()) {
            has_ramp = is_ramp_word(input[n - 2]);
        }
        if (!input[0].is_symbol()) {
            if (has_ramp) {
                if (input[n - 3].is_symbol()) {
                    has_unit = true;
                    unit = input[n - 3].as_symbol();
                }
            } else if (input[n - 1].is_symbol()) {
                bool numerical = true;
                for (std::size_t i = 0; i + 1 < n; ++i) {
                    numerical = numerical && !input[i].is_symbol();
                }
                if (numerical) {
                    has_unit = true;
                    unit = input[n - 1].as_symbol();
                }
            }
        }
    }

    std::size_t keep = n;
    if (has_ramp && has_unit) {
        keep = n - 3;
    } else if (has_ramp) {
        keep = n - 2;
    } else if (has_unit) {
        keep = n - 1;
    }
    command.values.assign(input.begin(), input.begin() + static_cast<std::ptrdiff_t>(keep));
    command.unit = unit;
    if (has_ramp) {
        command.ramp_ms = ramp_time(input[n - 1]);
    }
    return command;
}

} // namespace jamoma
