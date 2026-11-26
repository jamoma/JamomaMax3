// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file readable_colours_test.cpp
 * @brief Unit tests for the colour rules of j.textslider and j.ui.
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

namespace {

/** @param c A colour. @param below An opaque colour. @return What is seen when `c` is drawn on `below`. */
Rgba seen(const Rgba& c, const Rgba& below)
{
    return {c.r * c.a + below.r * (1 - c.a), c.g * c.a + below.g * (1 - c.a), c.b * c.a + below.b * (1 - c.a), 1};
}

/** The theme colours of a dark theme: patcher, text and highlight. */
const jamoma::PanelSurroundings kDark{grey(0.2), grey(0.85), {0.594, 0.721, 0.928, 1}};
/** The theme colours of a light theme. */
const jamoma::PanelSurroundings kLight{grey(0.9), grey(0.2), {0.1, 0.3, 0.7, 1}};

} // namespace

TEST_CASE("panel_automatic_background_and_border_are_translucent_grey", "[colours]")
{
    const auto out = jamoma::panel_colours({}, {}, kDark);
    CHECK(out.panel == Rgba{0.5, 0.5, 0.5, 0.14});
    CHECK(out.border == Rgba{0.5, 0.5, 0.5, 0.6});
}

TEST_CASE("panel_automatic_header_is_darker_than_the_panel_and_stands_out", "[colours]")
{
    for (const auto& around : {kDark, kLight}) {
        const auto out = jamoma::panel_colours({}, {}, around);
        const Rgba panel = seen(out.panel, around.patcher);
        CHECK(out.header.a == 1.0);
        CHECK(out.header.g < panel.g);
        CHECK(jamoma::contrast_ratio(out.header, panel) >= jamoma::kHeaderSeparation);
        CHECK(jamoma::contrast_ratio(out.header, panel) < jamoma::kHeaderSeparation + 0.1); // no darker than needed
    }
}

TEST_CASE("panel_header_on_a_black_patcher_becomes_lighter", "[colours]")
{
    const auto out = jamoma::panel_colours({}, {}, {grey(0.0), grey(0.85), kDark.highlight});
    const Rgba panel = seen(out.panel, grey(0.0));
    CHECK(out.header.g > panel.g);
    CHECK(jamoma::contrast_ratio(out.header, panel) >= jamoma::kHeaderSeparation);
}

TEST_CASE("panel_title_is_the_theme_text_if_readable_else_black_or_white", "[colours]")
{
    CHECK(jamoma::panel_colours({}, {}, kDark).text == kDark.text);
    const auto out = jamoma::panel_colours({}, {}, {grey(0.9), grey(0.7), kLight.highlight});
    CHECK(out.text == grey(0.0));
    CHECK(jamoma::contrast_ratio(out.text, out.header) >= jamoma::kTextContrast);
}

TEST_CASE("panel_highlight_is_the_theme_colour_if_visible_else_the_title_colour", "[colours]")
{
    CHECK(jamoma::panel_colours({}, {}, kDark).highlight == kDark.highlight);
    const auto out = jamoma::panel_colours({}, {}, {grey(0.9), grey(0.1), grey(0.75)});
    CHECK(out.highlight == out.text);
}

TEST_CASE("panel_colours_of_the_user_are_used_as_they_are", "[colours]")
{
    const jamoma::PanelColours given{{1, 0, 0, 1}, {0, 1, 0, 1}, {0, 0.9, 0, 1}, {0, 0.8, 0, 1}, {0, 0, 1, 1}};
    const auto out = jamoma::panel_colours(given, {true, true, true, true, true}, kDark);
    CHECK(out.panel == given.panel);
    CHECK(out.header == given.header);
    CHECK(out.text == given.text);
    CHECK(out.highlight == given.highlight);
    CHECK(out.border == given.border);
}

TEST_CASE("panel_automatic_colours_adapt_to_the_colours_of_the_user", "[colours]")
{
    jamoma::PanelColours given;
    given.header = grey(0.95); // a light header in a dark theme
    jamoma::PanelChosen chosen;
    chosen.header = true;
    const auto light_header = jamoma::panel_colours(given, chosen, kDark);
    CHECK(light_header.text == grey(0.0));
    CHECK(light_header.highlight == light_header.text);

    given.panel = grey(0.95); // a light panel: the automatic header follows it
    chosen = {};
    chosen.panel = true;
    const auto light_panel = jamoma::panel_colours(given, chosen, kDark);
    CHECK(light_panel.header.g > 0.7);
    CHECK(jamoma::contrast_ratio(light_panel.header, given.panel) >= jamoma::kHeaderSeparation);
    CHECK(jamoma::contrast_ratio(light_panel.text, light_panel.header) >= jamoma::kTextContrast);
}

TEST_CASE("panel_a_translucent_header_of_the_user_is_judged_as_seen", "[colours]")
{
    jamoma::PanelColours given;
    given.header = {1, 1, 1, 0.1}; // nearly transparent white on a dark panel: seen dark
    jamoma::PanelChosen chosen;
    chosen.header = true;
    CHECK(jamoma::panel_colours(given, chosen, kDark).text == kDark.text);
}
