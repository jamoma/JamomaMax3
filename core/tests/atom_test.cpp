// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file atom_test.cpp
 * @brief Unit tests for Atom and Value.
 */

#include <catch2/catch_test_macros.hpp>

#include <cmath>
#include <cstdint>
#include <limits>

#include "jamoma/atom.hpp"

/** An integer atom reports itself as an int and converts to double exactly. */
TEST_CASE("int atom reports int and double")
{
    const jamoma::Atom a(std::int64_t{3});
    REQUIRE(a.is_int());
    REQUIRE_FALSE(a.is_float());
    REQUIRE(a.is_number());
    REQUIRE(a.as_double() == 3.0);
}

/** A float converts to int by truncating toward zero. */
TEST_CASE("float truncates to int")
{
    REQUIRE(jamoma::Atom(-2.9).as_int() == -2);
    REQUIRE(jamoma::Atom(2.9).as_int() == 2);
}

/** A symbol is not a number: it converts to zero. */
TEST_CASE("symbol is zero as number")
{
    const jamoma::Atom a("foo");
    REQUIRE(a.is_symbol());
    REQUIRE_FALSE(a.is_number());
    REQUIRE(a.as_double() == 0.0);
    REQUIRE(a.as_int() == 0);
}

/** Integers beyond 2^53 keep every bit. */
TEST_CASE("large int survives")
{
    const std::int64_t big = 9007199254740993; // 2^53 + 1
    REQUIRE(jamoma::Atom(big).as_int() == big);
}

/** NaN stays NaN as a double and becomes 0 as an integer, without undefined behaviour. */
TEST_CASE("nan stays nan and is zero as int")
{
    const jamoma::Atom a(std::nan(""));
    REQUIRE(std::isnan(a.as_double()));
    REQUIRE(a.as_int() == 0);
}

/** Out-of-range floats saturate when converted to int. */
TEST_CASE("huge float saturates as int")
{
    const jamoma::Atom up(1e30);
    const jamoma::Atom down(-1e30);
    const jamoma::Atom inf(std::numeric_limits<double>::infinity());
    REQUIRE(up.as_int() == std::numeric_limits<std::int64_t>::max());
    REQUIRE(down.as_int() == std::numeric_limits<std::int64_t>::min());
    REQUIRE(inf.as_int() == std::numeric_limits<std::int64_t>::max());
}

/** An int and a float with the same numeric value are different atoms. */
TEST_CASE("equality distinguishes int from float")
{
    REQUIRE(jamoma::Atom(std::int64_t{1}) != jamoma::Atom(1.0));
    REQUIRE(jamoma::Atom(1.5) == jamoma::Atom(1.5));
    REQUIRE(jamoma::Atom("a") == jamoma::Atom("a"));
    REQUIRE(jamoma::Atom("a") != jamoma::Atom("b"));
}

/** Text forms: ints plainly, floats shortest-round-trip with a decimal point, symbols as they are. */
TEST_CASE("to_string formats each kind")
{
    REQUIRE(jamoma::Atom(std::int64_t{3}).to_string() == "3");
    REQUIRE(jamoma::Atom(3.5).to_string() == "3.5");
    REQUIRE(jamoma::Atom(3.0).to_string() == "3.0");
    REQUIRE(jamoma::Atom("hello").to_string() == "hello");
}

/** A value is a list of atoms and prints as space-separated text. */
TEST_CASE("value prints space separated")
{
    const jamoma::Value v{jamoma::Atom(std::int64_t{1}), jamoma::Atom(2.5), jamoma::Atom("x")};
    REQUIRE(jamoma::to_string(v) == "1 2.5 x");
    REQUIRE(jamoma::to_string(jamoma::Value{}) == "");
}
