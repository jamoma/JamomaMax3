// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file readable_colours_test.cpp
 * @brief Unit tests for the contrast rule of j.textslider.
 */

#include <catch2/catch_approx.hpp>
#include <catch2/catch_test_macros.hpp>

#include <random>

#include "jamoma/readable_colours.hpp"

using Catch::Approx;
using jamoma::Rgba;
using jamoma::SliderColours;

namespace {

/** @param v A grey level. @return The grey. */
Rgba grey(double v) { return {v, v, v, 1}; }

/** The colours of the default Max theme: track, bar, text, line, border. */
SliderColours default_theme()
{
    return {grey(0.262), {0.270, 0.409, 0.596, 1}, grey(0.85), {0.594, 0.721, 0.928, 1}, grey(0.262)};
}

} // namespace

TEST_CASE("colours_contrast_ratio_follows_the_guidelines", "[colours]")
{
    CHECK(jamoma::contrast_ratio(grey(0), grey(1)) == Approx(21.0));
    CHECK(jamoma::contrast_ratio(grey(1), grey(0)) == Approx(21.0));
    CHECK(jamoma::contrast_ratio(grey(0.5), grey(0.5)) == Approx(1.0));
}

TEST_CASE("colours_that_are_readable_already_stay_as_they_are", "[colours]")
{
    const SliderColours good{grey(0.172), {0.199, 0.347, 0.529, 1}, grey(0.85), {0.594, 0.721, 0.928, 1}, grey(0.35)};
    const auto out = jamoma::readable_colours(good);
    CHECK(out.track == good.track);
    CHECK(out.bar == good.bar);
    CHECK(out.text == good.text);
    CHECK(out.knob == good.knob);
    CHECK(out.border == good.border);
}

TEST_CASE("colours_of_the_default_theme_get_a_slightly_adjusted_bar", "[colours]")
{
    const auto wanted = default_theme();
    CHECK(jamoma::contrast_ratio(wanted.text, wanted.bar) < jamoma::kTextContrast);
    const auto out = jamoma::readable_colours(wanted);
    CHECK(out.text == wanted.text);
    CHECK(out.track == wanted.track);
    CHECK_FALSE(out.bar == wanted.bar);
    CHECK(jamoma::contrast_ratio(out.text, out.bar) >= jamoma::kTextContrast - 1e-9);
    CHECK(jamoma::contrast_ratio(out.bar, out.track) > 1.15); // still to be told from the track
}

TEST_CASE("colours_bar_stays_distinct_when_the_track_is_barely_readable", "[colours]")
{
    // light text on a mid grey track at just 4.5: moving the bar to the track would make it vanish, moving it away from the text does not
    SliderColours wanted{grey(0.353), grey(0.6), grey(0.845), grey(1.0), grey(0.353)};
    REQUIRE(jamoma::contrast_ratio(wanted.text, wanted.track) >= 4.5);
    REQUIRE(jamoma::contrast_ratio(wanted.text, wanted.track) < 5.2);
    const auto out = jamoma::readable_colours(wanted);
    CHECK(jamoma::contrast_ratio(out.text, out.bar) >= jamoma::kTextContrast - 1e-9);
    CHECK(jamoma::contrast_ratio(out.bar, out.track) > 1.3);
}

TEST_CASE("colours_unreadable_text_becomes_black_or_white", "[colours]")
{
    SliderColours wanted{grey(0.2), grey(0.3), grey(0.25), grey(0.9), grey(0.2)};
    const auto out = jamoma::readable_colours(wanted);
    CHECK(out.text == grey(1.0));
    CHECK(jamoma::contrast_ratio(out.text, out.bar) >= jamoma::kTextContrast - 1e-9);
}

TEST_CASE("colours_a_line_that_cannot_be_seen_takes_the_text_colour", "[colours]")
{
    SliderColours wanted{grey(0.8), grey(0.7), grey(0.0), grey(0.85), grey(0.5)};
    const auto out = jamoma::readable_colours(wanted);
    CHECK(out.knob == out.text);
}

TEST_CASE("colours_chosen_by_the_user_are_not_changed", "[colours]")
{
    const SliderColours bad{grey(0.5), grey(0.55), grey(0.52), grey(0.5), grey(0.5)};
    jamoma::Adjustable none;
    none.bar = none.text = none.knob = false;
    const auto out = jamoma::readable_colours(bad, none);
    CHECK(out.bar == bad.bar);
    CHECK(out.text == bad.text);
    CHECK(out.knob == bad.knob);
}

TEST_CASE("colours_any_theme_gives_readable_text_and_a_visible_line", "[colours]")
{
    std::mt19937 random(1);
    std::uniform_real_distribution<double> level(0.0, 1.0);
    const auto any = [&] { return Rgba{level(random), level(random), level(random), 1}; };
    for (int i = 0; i < 20000; ++i) {
        const SliderColours wanted{any(), any(), any(), any(), any()};
        const auto out = jamoma::readable_colours(wanted);
        REQUIRE(jamoma::contrast_ratio(out.text, out.track) >= jamoma::kTextContrast - 1e-9);
        REQUIRE(jamoma::contrast_ratio(out.text, out.bar) >= jamoma::kTextContrast - 1e-9);
        REQUIRE(jamoma::contrast_ratio(out.knob, out.track) >= jamoma::kLineContrast - 1e-9);
    }
}
