// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file slider.cpp
 * @brief The arithmetic of j.textslider.
 */

#include "jamoma/slider.hpp"

#include <algorithm>
#include <cmath>
#include <cstdio>
#include <utility>

namespace jamoma {

namespace {

/** @brief Makes a range usable: finite ends (0 and 1 otherwise), low first. @param low The low end. @param high The high end. */
void tidy(double& low, double& high)
{
    if (!std::isfinite(low))
        low = 0.0;
    if (!std::isfinite(high))
        high = 1.0;
    if (high < low)
        std::swap(low, high);
}

/** @param v A number. @param low The low end. @param high The high end. @return The number limited to the range (the low end if it is not a number). */
double limit(double v, double low, double high) { return std::isnan(v) ? low : std::clamp(v, low, high); }

} // namespace

double slider_normalised(double value, double low, double high)
{
    tidy(low, high);
    if (low == high)
        return 0.5;
    return (limit(value, low, high) - low) / (high - low);
}

double slider_value_at(double x, double width, double low, double high)
{
    tidy(low, high);
    if (!std::isfinite(width) || width <= 3.0 || std::isnan(x))
        return low;
    const double pixel = std::clamp(x - 1.0, 0.0, width - 3.0); // the borders, as the old object counted them
    return limit(pixel / (width - 2.0) * (high - low) + low, low, high);
}

double slider_drag(double anchor, double pixels, double width, double low, double high, double fineness)
{
    tidy(low, high);
    const double start = limit(anchor, low, high);
    const double span = (width - 2.0) * fineness;
    if (!std::isfinite(span) || span <= 0.0 || !std::isfinite(pixels) || low == high)
        return start;
    return limit(start + pixels * (high - low) / span, low, high);
}

std::string slider_value_text(double value, std::string_view unit)
{
    char text[64];
    std::snprintf(text, sizeof text, "%.3f", value);
    std::string out = text;
    if (!unit.empty())
        out += " " + std::string(unit);
    return out;
}

} // namespace jamoma
