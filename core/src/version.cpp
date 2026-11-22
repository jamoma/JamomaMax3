// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file version.cpp
 * @brief Implementation of the version functions.
 */

#include "jamoma/version.hpp"

namespace jamoma {

Version version() noexcept
{
    return Version{0, 0, 1};
}

int abi_version() noexcept
{
    return kAbiVersion;
}

} // namespace jamoma
