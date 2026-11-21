// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file export.hpp
 * @brief Symbol visibility macro for the shared core library.
 */

#pragma once

#if defined(_WIN32)
#if defined(JAMOMA_CORE_BUILDING)
/** Marks a symbol as part of the core library's public interface (exported when building it, imported when using it). */
#define JAMOMA_API __declspec(dllexport)
#else
/** Marks a symbol as part of the core library's public interface (exported when building it, imported when using it). */
#define JAMOMA_API __declspec(dllimport)
#endif
#else
/** Marks a symbol as part of the core library's public interface (exported when building it, imported when using it). */
#define JAMOMA_API __attribute__((visibility("default")))
#endif
