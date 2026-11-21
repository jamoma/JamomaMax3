// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file command.hpp
 * @brief Parsing of a value message into values, a unit and a ramp time.
 */

#pragma once

#include <optional>
#include <string>

#include "jamoma/atom.hpp"
#include "jamoma/export.hpp"

namespace jamoma {

/** A parsed message to a data object. */
struct Command {
    Value values;                    /**< The values, without unit and ramp. */
    std::string unit;                /**< The unit symbol, or empty. */
    std::optional<double> ramp_ms;   /**< The ramp time in whole milliseconds, or none. */
};

/**
 * @brief Parses a message the way the old Jamoma data object did (TTDataParseCommand).
 *
 * The rules are positional. Two atoms: a number then a symbol is a value with a unit. Three atoms: if the second is a
 * symbol it is the ramp keyword position (a ramp if the symbol is `ramp`, whatever the first atom is), otherwise a number
 * first and a symbol last is a unit. Four or more: if the second-to-last atom is the symbol `ramp` the last atom is the ramp
 * time, and the atom before `ramp` is a unit if it is a symbol; without a ramp, a last symbol is a unit only if every atom before
 * it is a number. Quirk kept on purpose: a number followed by `ramp` and nothing else is read as a value with the unit `ramp`.
 * The ramp time is truncated to whole milliseconds; a negative or non-numeric time is 0.
 * @param input The message.
 * @param parse_unit_and_ramp False for types without unit and ramp (the whole input is then the value).
 * @return The parsed command.
 */
JAMOMA_API Command parse_command(const Value& input, bool parse_unit_and_ramp = true);

} // namespace jamoma
