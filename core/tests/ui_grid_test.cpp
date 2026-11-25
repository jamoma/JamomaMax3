// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file ui_grid_test.cpp
 * @brief Unit tests for the grid that the size of a user interface object snaps to.
 */

#include <cmath>
#include <limits>

#include <catch2/catch_test_macros.hpp>

#include "jamoma/ui_grid.hpp"

/** The units are 150 pixels wide and 35 pixels high, as in the old version. */
TEST_CASE("the grid units are 150 by 35")
{
    REQUIRE(jamoma::kUiUnitWidth == 150.0);
    REQUIRE(jamoma::kUiUnitHeight == 35.0);
}

/** A size that already is a whole number of units stays as it is. */
TEST_CASE("a multiple of the unit is not changed")
{
    for (int n = 1; n <= 8; ++n) {
        REQUIRE(jamoma::snap_to_unit(n * 150.0, 150.0) == n * 150.0);
        REQUIRE(jamoma::snap_to_unit(n * 35.0, 35.0) == n * 35.0);
    }
}

/** A length snaps to the nearest unit; exactly half a unit snaps down (as the old integer arithmetic did). */
TEST_CASE("a length snaps to the nearest unit and half a unit goes down")
{
    REQUIRE(jamoma::snap_to_unit(224.0, 150.0) == 150.0);
    REQUIRE(jamoma::snap_to_unit(225.0, 150.0) == 150.0);
    REQUIRE(jamoma::snap_to_unit(225.5, 150.0) == 300.0);
    REQUIRE(jamoma::snap_to_unit(320.0, 150.0) == 300.0);
    REQUIRE(jamoma::snap_to_unit(380.0, 150.0) == 450.0);
    REQUIRE(jamoma::snap_to_unit(52.0, 35.0) == 35.0);
    REQUIRE(jamoma::snap_to_unit(52.5, 35.0) == 35.0);
    REQUIRE(jamoma::snap_to_unit(53.0, 35.0) == 70.0);
    REQUIRE(jamoma::snap_to_unit(100.0, 35.0) == 105.0);
}

/** There is always at least one unit, whatever the length. */
TEST_CASE("the smallest size is one unit")
{
    REQUIRE(jamoma::snap_to_unit(0.0, 150.0) == 150.0);
    REQUIRE(jamoma::snap_to_unit(1.0, 150.0) == 150.0);
    REQUIRE(jamoma::snap_to_unit(149.0, 150.0) == 150.0);
    REQUIRE(jamoma::snap_to_unit(-40.0, 35.0) == 35.0);
    REQUIRE(jamoma::snap_to_unit(std::numeric_limits<double>::quiet_NaN(), 35.0) == 35.0);
    REQUIRE(jamoma::snap_to_unit(-std::numeric_limits<double>::infinity(), 35.0) == 35.0);
}

/** Snapping twice gives the same as snapping once, and the result is always a multiple of the unit. */
TEST_CASE("snapping is stable and gives multiples of the unit")
{
    for (double length = 0.0; length < 1000.0; length += 0.5) {
        const double once = jamoma::snap_to_unit(length, 35.0);
        REQUIRE(jamoma::snap_to_unit(once, 35.0) == once);
        REQUIRE(std::fmod(once, 35.0) == 0.0);
        REQUIRE(once >= 35.0);
    }
}
