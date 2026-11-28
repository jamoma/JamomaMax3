// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file array_name_test.cpp
 * @brief Unit tests for array names, selection and list splitting (docs/inventory/j.array.md).
 */

#include <catch2/catch_test_macros.hpp>

#include "jamoma/array_name.hpp"

using jamoma::Atom;
using jamoma::parse_array_name;
using jamoma::Value;

/** The bracket may be anywhere. */
TEST_CASE("array_name_parses_a_bracket_anywhere", "[array]")
{
    const auto cc = parse_array_name("cc.[128]");
    REQUIRE(cc);
    CHECK(cc->size == 128);
    CHECK(cc->instance(1) == "cc.1");
    CHECK(cc->with_size(4) == "cc.[4]");
    const auto track = parse_array_name("track.[4]/gain");
    REQUIRE(track);
    CHECK(track->instance(2) == "track.2/gain");
    const auto action = parse_array_name("output/going.up/action.[3]");
    REQUIRE(action);
    CHECK(action->instance(3) == "output/going.up/action.3");
    CHECK(cc->same_shape(*parse_array_name("cc.[2]")));
    CHECK_FALSE(cc->same_shape(*track));
}

/** Everything that is not one bracket with a number is refused. */
TEST_CASE("array_name_rejects_bad_text", "[array]")
{
    for (const char* text : {"gain", "a.[2]/b.[3]", "a.[x]", "a.[-1]", "a.[]", "a.[257]", "", "a.[2", "a.2]", "a.][2", "a.[ 2]",
                             "a.[999999999999999999999999]"}) {
        INFO(text);
        CHECK_FALSE(parse_array_name(text));
    }
}

/** The ends of the size range. */
TEST_CASE("array_name_accepts_0_and_256", "[array]")
{
    REQUIRE(parse_array_name("a.[0]"));
    CHECK(parse_array_name("a.[0]")->size == 0);
    REQUIRE(parse_array_name("a.[256]"));
    CHECK(parse_array_name("a.[256]")->size == 256);
}

/** All at the start. */
TEST_CASE("array_selection_starts_with_all", "[array]")
{
    const jamoma::ArraySelection s;
    CHECK(s.index() == 0);
    CHECK(s.targets(3) == std::vector<std::size_t>{1, 2, 3});
    CHECK(s.targets(0).empty());
}

/** The old 8 bit index failed here. */
TEST_CASE("array_selection_accepts_256", "[array]")
{
    jamoma::ArraySelection s;
    CHECK(s.select(Atom(256), 256));
    CHECK(s.targets(256) == std::vector<std::size_t>{256});
    CHECK(s.select(Atom("*"), 256));
    CHECK(s.index() == 0);
}

/** A refused selection changes nothing. */
TEST_CASE("array_selection_rejects_out_of_range_and_symbols", "[array]")
{
    jamoma::ArraySelection s;
    REQUIRE(s.select(Atom(2), 4));
    for (const Atom& bad : {Atom(0), Atom(5), Atom(-1), Atom("two"), Atom(0.5), Atom(1e300)}) {
        CHECK_FALSE(s.select(bad, 4));
    }
    CHECK(s.index() == 2);
    CHECK_FALSE(s.select(Atom(1), 0));
}

/** A float is rounded down. */
TEST_CASE("array_selection_floor_of_float", "[array]")
{
    jamoma::ArraySelection s;
    CHECK(s.select(Atom(3.9), 4));
    CHECK(s.index() == 3);
}

/** Shrinking below the selection selects all. */
TEST_CASE("array_selection_falls_back_after_shrinking", "[array]")
{
    jamoma::ArraySelection s;
    REQUIRE(s.select(Atom(3), 4));
    s.resized(3);
    CHECK(s.index() == 3);
    s.resized(2);
    CHECK(s.index() == 0);
}

/** Equal parts. */
TEST_CASE("array_split_equal_parts", "[array]")
{
    const auto parts = jamoma::split_array(Value{1, 2, 3, 4, 5, 6}, 3);
    REQUIRE(parts);
    CHECK(*parts == std::vector<Value>{Value{1, 2}, Value{3, 4}, Value{5, 6}});
}

/** Other lengths are refused. */
TEST_CASE("array_split_refuses_other_lengths", "[array]")
{
    CHECK_FALSE(jamoma::split_array(Value{1, 2, 3}, 2));
    CHECK_FALSE(jamoma::split_array(Value{}, 2));
    CHECK_FALSE(jamoma::split_array(Value{1}, 0));
    CHECK_FALSE(jamoma::split_array(Value{1}, 2));
}
