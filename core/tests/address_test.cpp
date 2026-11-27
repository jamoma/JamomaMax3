// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file address_test.cpp
 * @brief Unit tests for Address parsing and composition.
 */

#include <catch2/catch_test_macros.hpp>

#include <string>

#include "jamoma/address.hpp"

using jamoma::Address;

/** An attribute whose name has a slash, as `ramp/function`, is still the attribute. */
TEST_CASE("an attribute with a slash in its name")
{
    const Address a = Address::parse("my_line:ramp/function");
    REQUIRE(a.attribute() == "ramp/function");
    REQUIRE(a.path().size() == 1);
    REQUIRE(a.str() == "my_line:ramp/function");
    REQUIRE(Address::parse("app:/m/x:repetitions/filter").attribute() == "repetitions/filter");
    REQUIRE(Address::parse("/m").append(a).str() == "/m/my_line:ramp/function");
}

/** The full grammar: directory:/parent/name.instance:attribute. */
TEST_CASE("parse reads path and instance and attribute")
{
    const Address a = Address::parse("/a/b.2:range");
    REQUIRE(a.absolute());
    REQUIRE(a.directory() == "");
    REQUIRE(a.path().size() == 2);
    REQUIRE(a.path()[0].name == "a");
    REQUIRE(a.path()[0].instance == "");
    REQUIRE(a.path()[1].name == "b");
    REQUIRE(a.path()[1].instance == "2");
    REQUIRE(a.attribute() == "range");
    REQUIRE(a.str() == "/a/b.2:range");
}

/** A directory prefix is the text before ':/'. */
TEST_CASE("parse reads a directory")
{
    const Address a = Address::parse("app:/m.1/p");
    REQUIRE(a.directory() == "app");
    REQUIRE(a.absolute());
    REQUIRE(a.path().size() == 2);
    REQUIRE(a.str() == "app:/m.1/p");
}

/** Instance zero is the same as no instance. */
TEST_CASE("instance zero is dropped")
{
    REQUIRE(Address::parse("/a/b.0").str() == "/a/b");
    REQUIRE(Address::parse("/a/b.0").path()[1].instance == "");
}

/** A relative address has no leading slash. */
TEST_CASE("relative address with instance")
{
    const Address a = Address::parse("both.4");
    REQUIRE_FALSE(a.absolute());
    REQUIRE(a.path().size() == 1);
    REQUIRE(a.path()[0].name == "both");
    REQUIRE(a.path()[0].instance == "4");
    REQUIRE(a.str() == "both.4");
}

/** The parent drops the last segment and any attribute. */
TEST_CASE("parent drops the last segment")
{
    REQUIRE(Address::parse("/a/b").parent().str() == "/a");
    REQUIRE(Address::parse("/a/b:range").parent().str() == "/a");
    REQUIRE(Address::parse("/a").parent().str() == "/");
    REQUIRE(Address::parse("/").parent().str() == "/");
    REQUIRE(Address::parse("x").parent().empty());
}

/** Appending a relative address extends the path. */
TEST_CASE("append joins paths")
{
    REQUIRE(Address::parse("/a").append(Address::parse("b/c")).str() == "/a/b/c");
    REQUIRE(Address::parse("/a").append(Address::parse("b:range")).str() == "/a/b:range");
    REQUIRE(Address::parse("app:/a").append(Address::parse("b")).str() == "app:/a/b");
}

/** An attribute can be set on an address. */
TEST_CASE("with_attribute sets and replaces the attribute")
{
    REQUIRE(Address::parse("/a/b").with_attribute("value").str() == "/a/b:value");
    REQUIRE(Address::parse("/a/b:range").with_attribute("value").str() == "/a/b:value");
    REQUIRE(Address::parse("/a/b:range").with_attribute("").str() == "/a/b");
}

/** The empty text is the empty address. */
TEST_CASE("empty text is the empty address")
{
    REQUIRE(Address::parse("").empty());
    REQUIRE(Address::parse("").str() == "");
    REQUIRE_FALSE(Address::parse("/").empty());
}

/** Repeated slashes collapse; '///' is the root. */
TEST_CASE("repeated slashes collapse to the root")
{
    REQUIRE(Address::parse("///").str() == "/");
    REQUIRE(Address::parse("//a///b/").str() == "/a/b");
}

/** A trailing colon means an empty attribute, which is not printed. */
TEST_CASE("trailing colon is an empty attribute")
{
    const Address a = Address::parse("/a/b:");
    REQUIRE(a.attribute() == "");
    REQUIRE(a.str() == "/a/b");
}

/** Addresses compare by content. */
TEST_CASE("equality compares content")
{
    REQUIRE(Address::parse("/a/b.2") == Address::parse("/a/b.2"));
    REQUIRE(Address::parse("/a/b.0") == Address::parse("/a/b"));
    REQUIRE(Address::parse("/a/b.1") != Address::parse("/a/b.2"));
}

/** A very long address survives a round trip. */
TEST_CASE("a 4 KB address round-trips")
{
    std::string text;
    while (text.size() < 4096) {
        text += "/seg";
    }
    REQUIRE(Address::parse(text).str() == text);
}

/** Garbage never throws: it parses to something defined. */
TEST_CASE("odd input does not throw")
{
    REQUIRE_NOTHROW(Address::parse(":::"));
    REQUIRE_NOTHROW(Address::parse(".:./."));
    REQUIRE_NOTHROW(Address::parse(std::string("/a\0b", 4)));
}

/** An absolute address stays; a relative one is appended to the model's address; an empty one stays empty. */
TEST_CASE("resolve relative against a model")
{
    const Address model = Address::parse("/qmetro");
    REQUIRE(jamoma::resolve_relative(Address::parse("/other/p"), model).str() == "/other/p");
    REQUIRE(jamoma::resolve_relative(Address::parse("data/active"), model).str() == "/qmetro/data/active");
    REQUIRE(jamoma::resolve_relative(Address::parse("p:range"), model).str() == "/qmetro/p:range");
    REQUIRE(jamoma::resolve_relative(Address::parse("p"), Address::parse("/m.1")).str() == "/m.1/p");
    REQUIRE(jamoma::resolve_relative(Address(), model).empty());
    REQUIRE(jamoma::resolve_relative(Address::parse("p"), Address()).str() == "/p"); // no model: from the root
}

/** `#0` is the unique id of the instance, `#1`.. the arguments; an argument that is not there is left as written. */
TEST_CASE("substitute arguments replaces dieze arguments")
{
    using jamoma::substitute_arguments;
    REQUIRE(substitute_arguments("/m#0/#1/#2", {"a"}, "7") == "/m7/a/#2");
    REQUIRE(substitute_arguments("no dieze here", {"a"}, "7") == "no dieze here");
    REQUIRE(substitute_arguments("#1#2", {"x", "y"}, "0") == "xy");
    REQUIRE(substitute_arguments("#", {"x"}, "0") == "#");
    REQUIRE(substitute_arguments("#x #", {"x"}, "0") == "#x #");
    REQUIRE(substitute_arguments("#10", {"1", "2", "3", "4", "5", "6", "7", "8", "9", "ten"}, "0") == "ten");
    REQUIRE(substitute_arguments("", {}, "0").empty());
}
