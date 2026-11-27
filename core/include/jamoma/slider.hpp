// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file slider.hpp
 * @brief The arithmetic of `j.textslider`: where the bar ends, what a click and a drag give, and the text that shows the value.
 *
 * The rules are those of the old object (docs/inventory/j.textslider.md). A range whose ends are equal, reversed ends and numbers that are not
 * finite never divide by zero or give anything that is not finite.
 */

#pragma once

#include <string>
#include <string_view>

#include "jamoma/export.hpp"

namespace jamoma {

/**
 * @brief How far along the range a value is.
 * @param value The value. @param low One end of the range. @param high The other end.
 * @return 0 at the low end to 1 at the high end, limited to that; 0.5 if the ends are equal.
 */
JAMOMA_API double slider_normalised(double value, double low, double high);

/**
 * @brief The value a click picks (`clickjump`).
 * @param x The position in the box, in pixels from the left. @param width The width of the box. @param low The low end. @param high The high end.
 * @return The value under the pointer, limited to the range (the low end if the numbers make no sense).
 */
JAMOMA_API double slider_value_at(double x, double width, double low, double high);

/**
 * @brief The value after a drag: the pointer moved, the value moves by a part of the range.
 * @param anchor The value before the move. @param pixels How far the pointer moved (right or up is positive). @param width The width of the box.
 * @param low The low end. @param high The high end. @param fineness How many pixels more than the width it takes to cross the range
 *        (1: normal; 0.8 with Command; 50 with Shift).
 * @return The new value, limited to the range.
 */
JAMOMA_API double slider_drag(double anchor, double pixels, double width, double low, double high, double fineness);

/** @return The text that shows a value: three decimals and, if there is one, the unit. @param value The value. @param unit The unit. */
JAMOMA_API std::string slider_value_text(double value, std::string_view unit);

} // namespace jamoma
