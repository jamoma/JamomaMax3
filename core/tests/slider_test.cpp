// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file slider_test.cpp
 * @brief Unit tests for the arithmetic of j.textslider (docs/inventory/j.textslider.md).
 */

#include <catch2/catch_approx.hpp>
#include <catch2/catch_test_macros.hpp>

#include <cmath>
#include <limits>

#include "jamoma/slider.hpp"

using Catch::Approx;

TEST_CASE("slider_normalised_places_the_value_in_the_range", "[slider]")
{
    CHECK(jamoma::slider_normalised(0.0, 0.0, 1.0) == Approx(0.0));
    CHECK(jamoma::slider_normalised(5.0, 0.0, 10.0) == Approx(0.5));
    CHECK(jamoma::slider_normalised(-3.0, 0.0, 10.0) == Approx(0.0));
    CHECK(jamoma::slider_normalised(30.0, 0.0, 10.0) == Approx(1.0));
    CHECK(jamoma::slider_normalised(2.5, 10.0, 0.0) == Approx(0.25)); // reversed ends are sorted, as the range attribute does
    CHECK(jamoma::slider_normalised(7.0, 3.0, 3.0) == Approx(0.5));
}

TEST_CASE("slider_click_picks_the_value_under_the_pointer", "[slider]")
{
    CHECK(jamoma::slider_value_at(1.0, 102.0, 0.0, 100.0) == Approx(0.0)); // one pixel of border
    CHECK(jamoma::slider_value_at(51.0, 102.0, 0.0, 100.0) == Approx(50.0));
    CHECK(jamoma::slider_value_at(-20.0, 102.0, 0.0, 100.0) == Approx(0.0));
    CHECK(jamoma::slider_value_at(500.0, 102.0, 0.0, 100.0) == Approx(99.0)); // the old limit: width - 3 pixels of (width - 2)
    CHECK(jamoma::slider_value_at(5.0, 102.0, 4.0, 4.0) == Approx(4.0));
}

TEST_CASE("slider_drag_moves_proportionally_and_is_limited", "[slider]")
{
    CHECK(jamoma::slider_drag(0.0, 50.0, 102.0, 0.0, 100.0, 1.0) == Approx(50.0)); // 50 pixels of 100: half the range
    CHECK(jamoma::slider_drag(50.0, -25.0, 102.0, 0.0, 100.0, 1.0) == Approx(25.0));
    CHECK(jamoma::slider_drag(50.0, 25.0, 102.0, 0.0, 100.0, 50.0) == Approx(50.5)); // fine: fifty times more pixels
    CHECK(jamoma::slider_drag(50.0, 1000.0, 102.0, 0.0, 100.0, 1.0) == Approx(100.0));
    CHECK(jamoma::slider_drag(50.0, -1000.0, 102.0, 0.0, 100.0, 1.0) == Approx(0.0));
}

TEST_CASE("slider_extremes_never_give_anything_that_is_not_finite", "[slider]")
{
    const double nan = std::numeric_limits<double>::quiet_NaN();
    const double inf = std::numeric_limits<double>::infinity();
    for (double a : {nan, inf, -inf, 0.0, 1.0}) {
        for (double w : {nan, 0.0, 1.0, 2.0, 100.0}) {
            CHECK(std::isfinite(jamoma::slider_normalised(a, 0.0, 1.0)));
            CHECK(std::isfinite(jamoma::slider_value_at(a, w, 0.0, 1.0)));
            CHECK(std::isfinite(jamoma::slider_drag(a, a, w, 0.0, 1.0, 1.0)));
        }
    }
    CHECK(std::isfinite(jamoma::slider_normalised(1.0, nan, inf)));
    CHECK(std::isfinite(jamoma::slider_drag(3.0, 5.0, 100.0, 3.0, 3.0, 1.0)));
    CHECK(jamoma::slider_drag(3.0, 5.0, 100.0, 3.0, 3.0, 1.0) == Approx(3.0));
    CHECK(std::isfinite(jamoma::slider_drag(0.0, 5.0, 100.0, 0.0, 1.0, 0.0)));
}

TEST_CASE("slider_value_text_has_three_decimals_and_the_unit", "[slider]")
{
    CHECK(jamoma::slider_value_text(0.5, "") == "0.500");
    CHECK(jamoma::slider_value_text(-12.3456, "dB") == "-12.346 dB");
    CHECK(jamoma::slider_value_text(std::numeric_limits<double>::quiet_NaN(), "ms") == "nan ms");
}
