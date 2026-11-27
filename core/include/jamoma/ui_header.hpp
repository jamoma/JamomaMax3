// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file ui_header.hpp
 * @brief The places in the header of the panel (j.ui), as the old object had them.
 */

#pragma once

namespace jamoma {

inline constexpr double kHeaderHeight = 20.0;   /**< The height of the header, in pixels. */
inline constexpr double kHeaderIconEnd = 18.0;  /**< The circle with the triangle ends here. */
inline constexpr double kHeaderAddressX = 20.0; /**< Where the address is written. */
inline constexpr double kHeaderAddressEnd = 100.0; /**< Clicks on the address up to here open its menu. */
inline constexpr double kHeaderButtonStep = 16.0;  /**< From one round button to the next. */

/** What a click on the header reaches. */
enum class HeaderPart { Nothing, PresetMenu, ModelMenu, Active, Panel };

/** @param width The width of the panel. @return The x position of the middle of the active button (the last one). */
inline double header_active_x(double width) noexcept { return width - 12.0; }

/** @param width The width of the panel. @param has_active Whether there is an active button. @return The x position of the middle of the panel button. */
inline double header_panel_x(double width, bool has_active) noexcept { return header_active_x(width) - (has_active ? kHeaderButtonStep : 0.0); }

/**
 * @brief Tells what a click reaches.
 * @param x The position from the left. @param y The position from the top. @param width The width of the panel.
 * @param has_active Whether the active button is shown. @param has_panel Whether the panel button is shown.
 * @return The part.
 */
inline HeaderPart header_part(double x, double y, double width, bool has_active, bool has_panel) noexcept
{
    if (y < 0.0 || y >= kHeaderHeight || x < 0.0 || x > width) {
        return HeaderPart::Nothing;
    }
    if (x <= kHeaderIconEnd) {
        return HeaderPart::PresetMenu;
    }
    const double half = kHeaderButtonStep / 2.0;
    if (has_active && x >= header_active_x(width) - half && x < header_active_x(width) + half) {
        return HeaderPart::Active;
    }
    if (has_panel && x >= header_panel_x(width, has_active) - half && x < header_panel_x(width, has_active) + half) {
        return HeaderPart::Panel;
    }
    return x < kHeaderAddressEnd ? HeaderPart::ModelMenu : HeaderPart::Nothing;
}

} // namespace jamoma
