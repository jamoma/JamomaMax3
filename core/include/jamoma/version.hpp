// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file version.hpp
 * @brief Version and binary-interface (ABI) version of the core library.
 */

#pragma once

#include "jamoma/export.hpp"

namespace jamoma {

/** A semantic version number. */
struct Version {
    int major; /**< Incremented for incompatible changes. */
    int minor; /**< Incremented for compatible additions. */
    int patch; /**< Incremented for compatible fixes. */
};

/**
 * @brief The version of the core library.
 * @return The library's semantic version.
 */
JAMOMA_API Version version() noexcept;

/**
 * @brief The binary-interface version of the core library.
 *
 * Externals compare their own value with the one of the installed library
 * and refuse to run when they differ.
 * @return The ABI version.
 */
JAMOMA_API int abi_version() noexcept;

} // namespace jamoma
