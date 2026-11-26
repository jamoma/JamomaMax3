// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file readable_colours.hpp
 * @brief Keeping the text of a slider readable whatever colours it is given (for colours taken from a Max theme).
 *
 * The contrast of two colours is the ratio of the WCAG guidelines (1 for equal colours, 21 for black on white); 4.5 is the usual minimum for
 * small text and 3 for a graphical mark such as a line. Alpha is not taken into account: the colours are treated as opaque.
 */

#pragma once

#include "jamoma/export.hpp"

namespace jamoma {

/** A colour as red, green, blue and alpha, each 0 to 1. */
struct Rgba {
    double r = 0, g = 0, b = 0, a = 1; /**< The components. */
    /** @param o Another colour. @return True if all four components are equal. */
    bool operator==(const Rgba& o) const { return r == o.r && g == o.g && b == o.b && a == o.a; }
};

/** The colours of a slider. */
struct SliderColours {
    Rgba track;  /**< The background. */
    Rgba bar;    /**< The filled part. */
    Rgba text;   /**< The text, which lies on both. */
    Rgba knob;   /**< The line at the end of the bar. */
    Rgba border; /**< The border. */
};

/** Which colours the rule may change (the others were chosen by the user). */
struct Adjustable {
    bool bar = true;  /**< The bar. */
    bool text = true; /**< The text. */
    bool knob = true; /**< The line. */
};

/** The contrast the text keeps with the track and the bar. */
constexpr double kTextContrast = 4.5;
/** The contrast the line keeps with the track. */
constexpr double kLineContrast = 3.0;

/** @return The contrast of two colours, 1 to 21. @param one A colour. @param other Another. */
JAMOMA_API double contrast_ratio(const Rgba& one, const Rgba& other);

/**
 * @brief Changes as little as needed so that the text can be read on the track and the bar and the line can be seen on the track.
 *
 * Text that is hard to read on the track becomes black or white, whichever is better. A bar that the text is hard to read on moves towards the
 * track if it still stands out there (contrast 1.3 or more), else away from the text (towards black under light text, towards white under dark
 * text) until it stands out again; if neither can, to whichever of the two stands out more. A line that is hard to see on the track takes the
 * colour of the text.
 *
 * @param wanted The colours as given. @param adjustable Which of them may change. @return The colours to draw with.
 */
JAMOMA_API SliderColours readable_colours(const SliderColours& wanted, const Adjustable& adjustable = Adjustable());

} // namespace jamoma
