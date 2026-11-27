// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file readable_colours.cpp
 * @brief The colour rules of j.textslider and j.ui.
 */

#include "jamoma/readable_colours.hpp"

#include <algorithm>
#include <cmath>

namespace jamoma {

namespace {

/** @param v A component. @return The linear value of the sRGB component. */
double linear(double v)
{
    v = std::isfinite(v) ? std::clamp(v, 0.0, 1.0) : 0.0;
    return v <= 0.03928 ? v / 12.92 : std::pow((v + 0.055) / 1.055, 2.4);
}

/** @param c A colour. @return Its relative luminance. */
double luminance(const Rgba& c) { return 0.2126 * linear(c.r) + 0.7152 * linear(c.g) + 0.0722 * linear(c.b); }

const Rgba kBlack{0, 0, 0, 1}; /**< Black. */
const Rgba kWhite{1, 1, 1, 1}; /**< White. */

/** The contrast between bar and track that keeps the bar easy to tell from the track. */
constexpr double kBarSeparation = 1.3;

/**
 * @brief The first colour on the way from one colour to another that the text can be read on and that differs enough from the track.
 * @param from Where to start. @param to Where to go. @param text The text colour. @param track The track.
 * @param separation The least contrast with the track (1: none asked). @param[out] found Whether there is one.
 * @return The colour.
 */
Rgba readable_towards(const Rgba& from, const Rgba& to, const Rgba& text, const Rgba& track, double separation, bool& found)
{
    constexpr int kSteps = 200;
    for (int i = 0; i <= kSteps; ++i) {
        const double t = static_cast<double>(i) / kSteps;
        const Rgba c{from.r + (to.r - from.r) * t, from.g + (to.g - from.g) * t, from.b + (to.b - from.b) * t, from.a};
        if (contrast_ratio(text, c) >= kTextContrast && contrast_ratio(c, track) >= separation) {
            found = true;
            return c;
        }
    }
    found = false;
    return to;
}

/** @return What is seen when a colour is drawn on an opaque one. @param c The colour. @param below What it is drawn on. */
Rgba seen_on(const Rgba& c, const Rgba& below)
{
    const double a = std::isfinite(c.a) ? std::clamp(c.a, 0.0, 1.0) : 1.0;
    return {c.r * a + below.r * (1 - a), c.g * a + below.g * (1 - a), c.b * a + below.b * (1 - a), 1};
}

/** @return The header that belongs to a panel. @param panel The panel as seen (opaque). */
Rgba header_for(const Rgba& panel)
{
    constexpr int kSteps = 200;
    for (const Rgba& end : {kBlack, kWhite}) {
        for (int i = 1; i <= kSteps; ++i) {
            Rgba c = end;
            c.a = static_cast<double>(i) / kSteps;
            c = seen_on(c, panel);
            if (contrast_ratio(c, panel) >= kHeaderSeparation) {
                return c;
            }
        }
    }
    return kWhite; // not reached: black or white is far enough from every colour
}

} // namespace

double contrast_ratio(const Rgba& one, const Rgba& other)
{
    const double a = luminance(one), b = luminance(other);
    return (std::max(a, b) + 0.05) / (std::min(a, b) + 0.05);
}

SliderColours readable_colours(const SliderColours& wanted, const Adjustable& adjustable)
{
    SliderColours out = wanted;
    if (adjustable.text && contrast_ratio(out.text, out.track) < kTextContrast) {
        // black or white: one of the two always has at least 4.58 with any colour
        out.text = contrast_ratio(kBlack, out.track) > contrast_ratio(kWhite, out.track) ? kBlack : kWhite;
    }
    if (adjustable.bar && contrast_ratio(out.text, out.bar) < kTextContrast) {
        const Rgba track{out.track.r, out.track.g, out.track.b, out.bar.a};
        const Rgba end = luminance(out.text) > 0.18 ? Rgba{0, 0, 0, out.bar.a} : Rgba{1, 1, 1, out.bar.a}; // away from the text
        bool to_track = false, distinct = false, away = false;
        const Rgba near = readable_towards(out.bar, track, out.text, track, 1.0, to_track);
        const Rgba apart = readable_towards(out.bar, end, out.text, track, kBarSeparation, distinct);
        const Rgba far = readable_towards(out.bar, end, out.text, track, 1.0, away);
        if (to_track && contrast_ratio(near, track) >= kBarSeparation) {
            out.bar = near; // the smallest change, and the bar still stands out
        } else if (distinct) {
            out.bar = apart;
        } else if (to_track && (!away || contrast_ratio(near, track) >= contrast_ratio(far, track))) {
            out.bar = near;
        } else if (away) {
            out.bar = far;
        } else { // neither reaches it (the track itself was chosen by the user and is hard to read on): the best of black and white
            out.bar = contrast_ratio(kBlack, out.text) > contrast_ratio(kWhite, out.text) ? kBlack : kWhite;
        }
    }
    if (adjustable.knob && contrast_ratio(out.knob, out.track) < kLineContrast) {
        out.knob = out.text;
    }
    return out;
}

PanelColours panel_colours(const PanelColours& given, const PanelChosen& chosen, const PanelSurroundings& around)
{
    PanelColours out;
    out.panel = chosen.panel ? given.panel : Rgba{0.5, 0.5, 0.5, 0.14};
    out.border = chosen.border ? given.border : Rgba{0.5, 0.5, 0.5, 0.6};
    const Rgba panel = seen_on(out.panel, around.patcher);
    out.header = chosen.header ? given.header : header_for(panel);
    const Rgba header = seen_on(out.header, panel);
    if (chosen.text) {
        out.text = given.text;
    } else if (contrast_ratio(seen_on(around.text, header), header) >= kTextContrast) {
        out.text = around.text;
    } else {
        out.text = contrast_ratio(kBlack, header) > contrast_ratio(kWhite, header) ? kBlack : kWhite;
    }
    if (chosen.highlight) {
        out.highlight = given.highlight;
    } else {
        out.highlight = contrast_ratio(seen_on(around.highlight, header), header) >= kLineContrast ? around.highlight : out.text;
    }
    return out;
}

} // namespace jamoma
