// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file osc_tools.hpp
 * @brief The string rules of j.oscinstance and j.oscroute (docs/inventory/osc-tools.md).
 */

#pragma once

#include <cstddef>
#include <optional>
#include <span>
#include <string>
#include <string_view>
#include <vector>

#include "jamoma/atom.hpp"
#include "jamoma/export.hpp"

namespace jamoma {

/** An address with the instance of its first part taken out. */
struct OscInstanceSplit {
    std::string address; /**< The address without the instance. */
    Atom instance;       /**< The instance: an integer if its text is one (also if it is empty: 0), else a symbol. */
};

/**
 * @brief Takes the instance out of the first part of an address.
 * @param selector The address.
 * @return The two pieces, or nothing if the first part has no instance (the message then goes to the dump outlet).
 */
JAMOMA_API std::optional<OscInstanceSplit> split_osc_instance(std::string_view selector);

/** One output of j.oscroute. */
struct OscRouteMatch {
    std::size_t outlet; /**< The number of the pattern, from 0. */
    std::string rest;   /**< What is left of the address, which becomes the message; empty if only the arguments are sent on. */
};

/**
 * @brief Matches an address against the patterns of j.oscroute.
 * @param selector The address. @param patterns The patterns, one per outlet.
 * @return The outputs in order: none (the dump outlet), one, or two (a plain pattern and then one with `*`, as the old object).
 */
JAMOMA_API std::vector<OscRouteMatch> route_osc(std::string_view selector, std::span<const std::string> patterns);

} // namespace jamoma
