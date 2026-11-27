// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file ui_header_test.cpp
 * @brief Unit tests for what a click on the header of the panel reaches (the places of the old j.ui).
 */

#include <catch2/catch_test_macros.hpp>

#include "jamoma/ui_header.hpp"

using jamoma::HeaderPart;
using jamoma::header_part;

/** The circle with the triangle at the far left opens the menu of the model and its presets, the address next to it the menu of what is below. */
TEST_CASE("the header of the panel has its menus at the left")
{
    REQUIRE(header_part(0.0, 9.0, 300.0, true, true) == HeaderPart::PresetMenu);
    REQUIRE(header_part(18.0, 9.0, 300.0, true, true) == HeaderPart::PresetMenu);
    REQUIRE(header_part(19.0, 9.0, 300.0, true, true) == HeaderPart::ModelMenu);
    REQUIRE(header_part(99.0, 9.0, 300.0, true, true) == HeaderPart::ModelMenu);
    REQUIRE(header_part(100.0, 9.0, 300.0, true, true) == HeaderPart::Nothing);
    REQUIRE(header_part(295.0, 9.0, 300.0, false, false) == HeaderPart::Nothing);
    REQUIRE(header_part(10.0, 20.0, 300.0, true, true) == HeaderPart::Nothing); // below the header
}

/** The round buttons are at the right end: the active button, and left of it the panel button; they win over the address. */
TEST_CASE("the buttons of the header are at the right")
{
    REQUIRE(header_part(288.0, 9.0, 300.0, true, true) == HeaderPart::Active);
    REQUIRE(header_part(272.0, 9.0, 300.0, true, true) == HeaderPart::Panel);
    REQUIRE(header_part(288.0, 9.0, 300.0, false, true) == HeaderPart::Panel); // without an active button it moves to the end
    REQUIRE(header_part(288.0, 9.0, 300.0, false, false) == HeaderPart::Nothing);
    REQUIRE(header_part(59.0, 9.0, 80.0, true, false) == HeaderPart::ModelMenu);
    REQUIRE(header_part(68.0, 9.0, 80.0, true, false) == HeaderPart::Active);
}
