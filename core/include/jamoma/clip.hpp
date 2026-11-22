// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file clip.hpp
 * @brief Clip modes: what happens to a value outside the range of a parameter.
 */

#pragma once

#include <string_view>

#include "jamoma/export.hpp"

namespace jamoma {

/** How a value outside the range is brought back. */
enum class ClipMode { None, Low, High, Both, Wrap, Fold };

/**
 * @brief The clip mode with a given name.
 * @param name One of none, low, high, both, wrap, fold.
 * @return The mode; None for an unknown name.
 */
JAMOMA_API ClipMode clip_mode_from_name(std::string_view name);

/**
 * @brief The name of a clip mode.
 * @param mode The mode.
 * @return Its name (none, low, high, both, wrap or fold).
 */
JAMOMA_API std::string_view clip_mode_name(ClipMode mode);

/**
 * @brief Applies a clip mode.
 *
 * Ported from the old TTLimits.h. Low and High clip one side; Both clips both. Wrap treats the range as [low, high)
 * and wraps with fmod (a value of exactly high gives low; a value of low minus the width gives high). Fold reflects at
 * the bounds using the IEEE remainder. If low is above high the bounds are swapped. In a zero-width range Wrap and Fold
 * return the bound. NaN gives NaN; an infinite value gives NaN for Wrap and Fold and the bound for the clipping modes.
 * @param value The value.
 * @param low The lower bound.
 * @param high The upper bound.
 * @param mode The mode.
 * @return The value after clipping.
 */
JAMOMA_API double clip(double value, double low, double high, ClipMode mode) noexcept;

} // namespace jamoma
