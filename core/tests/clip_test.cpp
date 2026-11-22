// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file clip_test.cpp
 * @brief Unit tests for clip modes. Reference values come from the old integration tests (range 3..4 and 0..80).
 */

#include <catch2/catch_test_macros.hpp>

#include <cmath>
#include <limits>

#include "jamoma/clip.hpp"

using jamoma::ClipMode;
using jamoma::clip;

/** Both clips to the range (old test: range 3..4). */
TEST_CASE("both clips to range")
{
    REQUIRE(clip(-9.5, 3.0, 4.0, ClipMode::Both) == 3.0);
    REQUIRE(clip(4.5, 3.0, 4.0, ClipMode::Both) == 4.0);
    REQUIRE(clip(2.5, 3.0, 4.0, ClipMode::Both) == 3.0);
    REQUIRE(clip(3.5, 3.0, 4.0, ClipMode::Both) == 3.5);
}

/** Low clips only values below the range. */
TEST_CASE("low clips only below")
{
    REQUIRE(clip(-5.0, 0.0, 80.0, ClipMode::Low) == 0.0);
    REQUIRE(clip(100.0, 0.0, 80.0, ClipMode::Low) == 100.0);
}

/** High clips only values above the range. */
TEST_CASE("high clips only above")
{
    REQUIRE(clip(100.0, 0.0, 80.0, ClipMode::High) == 80.0);
    REQUIRE(clip(-5.0, 0.0, 80.0, ClipMode::High) == -5.0);
}

/** Wrap re-enters the range from the other side (old ramp test: range 0..80). */
TEST_CASE("wrap re-enters range")
{
    REQUIRE(clip(60.0, 0.0, 80.0, ClipMode::Wrap) == 60.0);
    REQUIRE(clip(80.0, 0.0, 80.0, ClipMode::Wrap) == 0.0);
    REQUIRE(clip(100.0, 0.0, 80.0, ClipMode::Wrap) == 20.0);
    REQUIRE(clip(160.0, 0.0, 80.0, ClipMode::Wrap) == 0.0);
    REQUIRE(clip(-10.0, 0.0, 80.0, ClipMode::Wrap) == 70.0);
}

/** Fold reflects at the bounds (old ramp test: range 0..80). */
TEST_CASE("fold reflects at bounds")
{
    REQUIRE(clip(60.0, 0.0, 80.0, ClipMode::Fold) == 60.0);
    REQUIRE(clip(80.0, 0.0, 80.0, ClipMode::Fold) == 80.0);
    REQUIRE(clip(100.0, 0.0, 80.0, ClipMode::Fold) == 60.0);
    REQUIRE(clip(150.0, 0.0, 80.0, ClipMode::Fold) == 10.0);
    REQUIRE(clip(200.0, 0.0, 80.0, ClipMode::Fold) == 40.0);
    REQUIRE(clip(-10.0, 0.0, 80.0, ClipMode::Fold) == 10.0);
}

/** None leaves every value alone. */
TEST_CASE("none leaves value")
{
    REQUIRE(clip(1e9, 0.0, 1.0, ClipMode::None) == 1e9);
    REQUIRE(clip(-1e9, 0.0, 1.0, ClipMode::None) == -1e9);
}

/** Mode names map both ways; an unknown name is None. */
TEST_CASE("mode names round trip and unknown is none")
{
    for (ClipMode m : {ClipMode::None, ClipMode::Low, ClipMode::High, ClipMode::Both, ClipMode::Wrap, ClipMode::Fold}) {
        REQUIRE(jamoma::clip_mode_from_name(jamoma::clip_mode_name(m)) == m);
    }
    REQUIRE(jamoma::clip_mode_from_name("both") == ClipMode::Both);
    REQUIRE(jamoma::clip_mode_from_name("nonsense") == ClipMode::None);
    REQUIRE(jamoma::clip_mode_from_name("") == ClipMode::None);
}

/** Review Focus 3: NaN in gives NaN out for every mode, without crashing. */
TEST_CASE("nan in gives nan out without crash")
{
    for (ClipMode m : {ClipMode::None, ClipMode::Low, ClipMode::High, ClipMode::Both, ClipMode::Wrap, ClipMode::Fold}) {
        REQUIRE(std::isnan(clip(std::nan(""), 0.0, 1.0, m)));
    }
}

/** Review Focus 3: infinity is clamped by both, low and high. */
TEST_CASE("infinite value is clamped")
{
    const double inf = std::numeric_limits<double>::infinity();
    REQUIRE(clip(inf, 0.0, 1.0, ClipMode::Both) == 1.0);
    REQUIRE(clip(-inf, 0.0, 1.0, ClipMode::Both) == 0.0);
    REQUIRE(clip(-inf, 0.0, 1.0, ClipMode::Low) == 0.0);
    REQUIRE(clip(inf, 0.0, 1.0, ClipMode::High) == 1.0);
    REQUIRE(std::isnan(clip(inf, 0.0, 1.0, ClipMode::Wrap)));
}

/** Review Focus 3: a range with low above high has its bounds swapped. */
TEST_CASE("low above high swaps the bounds")
{
    REQUIRE(clip(5.0, 10.0, 0.0, ClipMode::Both) == 5.0);
    REQUIRE(clip(15.0, 10.0, 0.0, ClipMode::Both) == 10.0);
    REQUIRE(clip(-1.0, 10.0, 0.0, ClipMode::Both) == 0.0);
}

/** Review Focus 3: wrap and fold in a zero-width range return the bound, not NaN. */
TEST_CASE("zero width range returns the bound")
{
    REQUIRE(clip(7.0, 2.0, 2.0, ClipMode::Wrap) == 2.0);
    REQUIRE(clip(7.0, 2.0, 2.0, ClipMode::Fold) == 2.0);
    REQUIRE(clip(7.0, 2.0, 2.0, ClipMode::Both) == 2.0);
}
