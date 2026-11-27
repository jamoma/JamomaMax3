// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file max_attributes.hpp
 * @brief Keeping list attributes of Min objects from ever being empty.
 *
 * Max's style system (the colour menus of the toolbar, and its own names such as `knobcolor`) sets a colour attribute to nothing to say "use the
 * inherited colour". Min stores that empty list, and Min's attribute getter aborts Max (an assertion) when an attribute without values is read.
 * Every attribute that is a list therefore has a setter that gives it its values back, and a custom getter never returns an empty list.
 */

#pragma once

#include "c74_min.h"

namespace jamoma_max {

/**
 * @brief The values a list attribute is set to.
 * @param given What it was set to.
 * @param defaults The default values; their number is the number the attribute needs.
 * @return What was given if it has enough values, else the defaults.
 */
inline c74::min::atoms values_or_default(const c74::min::atoms& given, const c74::min::atoms& defaults)
{
    return given.size() >= defaults.size() ? given : defaults;
}

} // namespace jamoma_max
