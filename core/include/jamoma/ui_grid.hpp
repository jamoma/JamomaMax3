// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file ui_grid.hpp
 * @brief The grid that the size of a user interface object snaps to (the old JAMOMA_UNIT_WIDTH and JAMOMA_UNIT_HEIGHT).
 */

#pragma once

namespace jamoma {

/** The width of one unit of the interface grid, in pixels. */
inline constexpr double kUiUnitWidth = 150.0;
/** The height of one unit of the interface grid, in pixels. */
inline constexpr double kUiUnitHeight = 35.0;

/**
 * @brief Snaps a length to a whole number of units, as the old j.ui did when it was resized.
 *
 * The number of units is the length divided by the unit and cut to a whole number; if what is left over is more than half a unit (exactly half
 * is not), it becomes one more. There is always at least one unit, so a length that is zero, negative or not a number gives one unit.
 * @param length The length in pixels.
 * @param unit The size of one unit in pixels (more than zero).
 * @return The snapped length, a multiple of the unit.
 */
inline double snap_to_unit(double length, double unit) noexcept
{
    if (!(length >= unit)) {
        return unit; // less than one unit, negative or not a number
    }
    if (length >= 1.0e9) {
        return length; // not a size at all: left alone (and kept out of the conversion to an integer)
    }
    long units = static_cast<long>(length / unit);
    if (length - static_cast<double>(units) * unit > unit / 2.0) {
        ++units;
    }
    return static_cast<double>(units) * unit;
}

} // namespace jamoma
