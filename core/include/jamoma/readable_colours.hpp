// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file readable_colours.hpp
 * @brief Colours that stay readable with any Max theme: those of j.textslider and of the panel j.ui.
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

/** The colours of a model panel (j.ui). */
struct PanelColours {
    Rgba panel;     /**< The background. */
    Rgba header;    /**< The strip with the address. */
    Rgba text;      /**< The title, on the header. */
    Rgba highlight; /**< The lit button, on the header. */
    Rgba border;    /**< The border. */
};

/** Which colours of a panel the user chose; the others are automatic. */
struct PanelChosen {
    bool panel = false;     /**< The background. */
    bool header = false;    /**< The header. */
    bool text = false;      /**< The title. */
    bool highlight = false; /**< The lit button. */
    bool border = false;    /**< The border. */
};

/** What the automatic colours of a panel are derived from. */
struct PanelSurroundings {
    Rgba patcher;   /**< The background of the patcher (opaque). */
    Rgba text;      /**< The text colour of the theme. */
    Rgba highlight; /**< The highlight colour of the theme. */
};

/** The contrast an automatic header keeps with the panel. */
constexpr double kHeaderSeparation = 1.35;

/**
 * @brief The colours a panel is drawn with. A colour the user chose is used as it is.
 *
 * Objects and comments lie on the panel, so an automatic panel is a faint grey tint of whatever the patcher shows, with a grey border. The automatic
 * header is the panel (as seen on the patcher) darkened until it stands out (contrast 1.35), or lightened if black is not far enough. The automatic
 * title is the theme's text colour if it can be read on the header, else black or white; the automatic highlight is the theme's if it can be seen on
 * the header (contrast 3), else the title colour.
 *
 * @param given The colours of the user (only those marked in `chosen` are looked at). @param chosen Which are the user's.
 * @param around The patcher and theme colours. @return The colours to draw with.
 */
JAMOMA_API PanelColours panel_colours(const PanelColours& given, const PanelChosen& chosen, const PanelSurroundings& around);

} // namespace jamoma
