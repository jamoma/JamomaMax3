// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file command_test.cpp
 * @brief Unit tests for the command parser. The cases (including the quirks) follow the old TTDataParseCommand.
 */

#include <catch2/catch_test_macros.hpp>

#include "jamoma/command.hpp"

using jamoma::Atom;
using jamoma::Command;
using jamoma::Value;
using jamoma::parse_command;

/** One number is just a value. */
TEST_CASE("plain value")
{
    const Command c = parse_command(Value{Atom(100.0)});
    REQUIRE(c.values == Value{Atom(100.0)});
    REQUIRE(c.unit == "");
    REQUIRE_FALSE(c.ramp_ms.has_value());
}

/** A list of numbers is all value. */
TEST_CASE("list of values")
{
    const Command c = parse_command(Value{Atom(1), Atom(2), Atom(3)});
    REQUIRE(c.values.size() == 3);
    REQUIRE(c.unit == "");
    REQUIRE_FALSE(c.ramp_ms.has_value());
}

/** A number followed by a symbol is a value with a unit. */
TEST_CASE("value with unit")
{
    const Command c = parse_command(Value{Atom(0.5), Atom("linear")});
    REQUIRE(c.values == Value{Atom(0.5)});
    REQUIRE(c.unit == "linear");
}

/** Value, the word ramp and a time. */
TEST_CASE("value with ramp")
{
    const Command c = parse_command(Value{Atom(100.0), Atom("ramp"), Atom(200)});
    REQUIRE(c.values == Value{Atom(100.0)});
    REQUIRE(c.unit == "");
    REQUIRE(c.ramp_ms.has_value());
    REQUIRE(*c.ramp_ms == 200.0);
}

/** Value, unit, the word ramp and a time. */
TEST_CASE("value with unit and ramp")
{
    const Command c = parse_command(Value{Atom(0.5), Atom("linear"), Atom("ramp"), Atom(50)});
    REQUIRE(c.values == Value{Atom(0.5)});
    REQUIRE(c.unit == "linear");
    REQUIRE(*c.ramp_ms == 50.0);
}

/** Two values and a unit. */
TEST_CASE("two values with unit")
{
    const Command c = parse_command(Value{Atom(1), Atom(2), Atom("db")});
    REQUIRE(c.values == Value{Atom(1), Atom(2)});
    REQUIRE(c.unit == "db");
}

/** Two values and a ramp. */
TEST_CASE("two values with ramp")
{
    const Command c = parse_command(Value{Atom(1.0), Atom(2.0), Atom("ramp"), Atom(100)});
    REQUIRE(c.values == Value{Atom(1.0), Atom(2.0)});
    REQUIRE(c.unit == "");
    REQUIRE(*c.ramp_ms == 100.0);
}

/** Three values and a unit. */
TEST_CASE("three values with unit")
{
    const Command c = parse_command(Value{Atom(1), Atom(2), Atom(3), Atom("db")});
    REQUIRE(c.values.size() == 3);
    REQUIRE(c.unit == "db");
}

/** A symbol among the leading atoms stops a trailing symbol from being a unit. */
TEST_CASE("trailing symbol after a symbol is not a unit")
{
    const Command c = parse_command(Value{Atom(1), Atom("a"), Atom(3), Atom("db")});
    REQUIRE(c.unit == "");
    REQUIRE(c.values.size() == 4);
}

/** Old quirk: a number and the word ramp (no time) is a value with the unit "ramp", not a ramp. */
TEST_CASE("ramp without time is read as a unit")
{
    const Command c = parse_command(Value{Atom(100.0), Atom("ramp")});
    REQUIRE(c.values == Value{Atom(100.0)});
    REQUIRE(c.unit == "ramp");
    REQUIRE_FALSE(c.ramp_ms.has_value());
}

/** Old behaviour: the ramp word is recognised by position whatever the first atom is. */
TEST_CASE("ramp word is recognised by position")
{
    const Command c = parse_command(Value{Atom("foo"), Atom("ramp"), Atom(100)});
    REQUIRE(c.values == Value{Atom("foo")});
    REQUIRE(*c.ramp_ms == 100.0);
}

/** The ramp time is truncated to whole milliseconds; a negative or non-numeric time is 0. */
TEST_CASE("ramp time is whole milliseconds and never negative")
{
    REQUIRE(*parse_command(Value{Atom(1.0), Atom("ramp"), Atom(200.9)}).ramp_ms == 200.0);
    REQUIRE(*parse_command(Value{Atom(1.0), Atom("ramp"), Atom(-5)}).ramp_ms == 0.0);
    REQUIRE(*parse_command(Value{Atom(1.0), Atom("ramp"), Atom("x")}).ramp_ms == 0.0);
}

/** An empty input is an empty command. */
TEST_CASE("empty input gives an empty command")
{
    const Command c = parse_command(Value{});
    REQUIRE(c.values.empty());
    REQUIRE(c.unit == "");
    REQUIRE_FALSE(c.ramp_ms.has_value());
}

/** With parsing switched off (types that have no unit or ramp) the whole input is the value. */
TEST_CASE("parsing off keeps the whole input")
{
    const Value in{Atom(100.0), Atom("ramp"), Atom(200)};
    const Command c = parse_command(in, false);
    REQUIRE(c.values == in);
    REQUIRE(c.unit == "");
    REQUIRE_FALSE(c.ramp_ms.has_value());
}
