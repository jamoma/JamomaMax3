// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file clip.cpp
 * @brief Implementation of the clip modes (ported from the old TTLimits.h).
 */

#include "jamoma/clip.hpp"

#include <cmath>
#include <limits>
#include <utility>

namespace jamoma {

namespace {

/** The old TTInfWrap: wraps into [low, high) as often as needed. */
double wrap(double value, double low, double high)
{
    const double width = std::fabs(low - high);
    if (width == 0.0) {
        return low;
    }
    if (value >= low && value < high) {
        return value;
    }
    if (!std::isfinite(value)) {
        return std::numeric_limits<double>::quiet_NaN();
    }
    if (value - low >= 0.0) {
        return std::fmod(value - low, width) + low;
    }
    return -1.0 * std::fmod(-1.0 * (value - low), width) + high;
}

/** The old TTFold: reflects at the bounds. */
double fold(double value, double low, double high)
{
    const double width = std::fabs(low - high);
    if (width == 0.0) {
        return low;
    }
    if (value >= low && value <= high) {
        return value;
    }
    if (!std::isfinite(value)) {
        return std::numeric_limits<double>::quiet_NaN();
    }
    return std::fabs(std::remainder(value - low, 2.0 * width)) + low;
}

} // namespace

ClipMode clip_mode_from_name(std::string_view name)
{
    if (name == "low") return ClipMode::Low;
    if (name == "high") return ClipMode::High;
    if (name == "both") return ClipMode::Both;
    if (name == "wrap") return ClipMode::Wrap;
    if (name == "fold") return ClipMode::Fold;
    return ClipMode::None;
}

std::string_view clip_mode_name(ClipMode mode)
{
    switch (mode) {
    case ClipMode::Low: return "low";
    case ClipMode::High: return "high";
    case ClipMode::Both: return "both";
    case ClipMode::Wrap: return "wrap";
    case ClipMode::Fold: return "fold";
    case ClipMode::None: break;
    }
    return "none";
}

double clip(double value, double low, double high, ClipMode mode) noexcept
{
    if (low > high) {
        std::swap(low, high);
    }
    switch (mode) {
    case ClipMode::Low: return value < low ? low : value;
    case ClipMode::High: return value > high ? high : value;
    case ClipMode::Both: return value < low ? low : (value > high ? high : value);
    case ClipMode::Wrap: return wrap(value, low, high);
    case ClipMode::Fold: return fold(value, low, high);
    case ClipMode::None: break;
    }
    return value;
}

} // namespace jamoma
