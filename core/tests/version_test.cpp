// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file version_test.cpp
 * @brief Unit tests for the version functions of the core library.
 */

#include <catch2/catch_test_macros.hpp>

#include "jamoma/version.hpp"

/** The core library reports version 0.0.1. */
TEST_CASE("version is 0.0.1")
{
    const jamoma::Version v = jamoma::version();
    REQUIRE(v.major == 0);
    REQUIRE(v.minor == 0);
    REQUIRE(v.patch == 1);
}

/** The binary interface of the core library is version 1. */
TEST_CASE("abi version is 1")
{
    REQUIRE(jamoma::abi_version() == 1);
}

/** The constant that externals compile in equals what the installed library reports. */
TEST_CASE("abi constant matches the library")
{
    REQUIRE(jamoma::kAbiVersion == jamoma::abi_version());
}
