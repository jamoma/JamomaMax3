// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file priority.hpp
 * @brief The order of priorities, as the old objects had it (TTNodeDirectory, compareNodePriorityThenNameThenInstance).
 */

#pragma once

namespace jamoma {

/**
 * @brief Whether one priority comes before another. A priority of 0 means none and comes after every other; else the lower one is first.
 * @param a One priority. @param b The other.
 * @return True if `a` comes before `b` (false if they are equal: the name and the instance decide then).
 */
inline bool priority_before(int a, int b) noexcept
{
    if (a == b || a == 0) {
        return false;
    }
    return b == 0 || a < b;
}

} // namespace jamoma
