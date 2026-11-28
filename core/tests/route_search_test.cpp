// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file route_search_test.cpp
 * @brief Unit tests for the rule of j.route.
 */

#include <catch2/catch_test_macros.hpp>

#include <atomic>
#include <string>
#include <thread>
#include <vector>

#include "jamoma/route_search.hpp"

using jamoma::RouteSearch;

/** The start state. */
TEST_CASE("route_search_looks_for_default_at_position_1", "[route]")
{
    const RouteSearch s;
    CHECK(s.words() == std::vector<std::string>{"default"});
    CHECK(s.positions() == std::vector<std::int64_t>{1});
    CHECK_FALSE(s.partial());
    CHECK(s.matches({"default", "x"}));
    CHECK_FALSE(s.matches({"x", "default"}));
    CHECK_FALSE(s.matches({"defaults"}));
}

/** Any of the positions will do. */
TEST_CASE("route_search_any_position", "[route]")
{
    RouteSearch s;
    s.set_words({"click"});
    s.set_positions({2, 4});
    CHECK(s.matches({"cell", "click"}));
    CHECK(s.matches({"cell", "0", "3", "click"}));
    CHECK_FALSE(s.matches({"click"}));
    CHECK_FALSE(s.matches({"cell", "0", "click"}));
    CHECK_FALSE(s.matches({}));
    s.set_positions({0, -3, 1000000});
    CHECK_FALSE(s.matches({"click", "click"}));
    s.set_positions({});
    CHECK_FALSE(s.matches({"click"}));
}

/** A partial match compares the start. */
TEST_CASE("route_search_partial", "[route]")
{
    RouteSearch s;
    s.set_words({"module"});
    s.set_partial(true);
    CHECK(s.matches({"module.1/gain"}));
    CHECK(s.matches({"module"}));
    CHECK_FALSE(s.matches({"modul"}));
    CHECK_FALSE(s.matches({"a_module"}));
}

/** Several words are one text; none match nothing. */
TEST_CASE("route_search_words", "[route]")
{
    RouteSearch s;
    s.set_words({"two", "words"});
    CHECK(s.matches({"two words"}));
    CHECK_FALSE(s.matches({"two", "words"}));
    s.set_words({});
    CHECK_FALSE(s.matches({""}));
    CHECK_FALSE(s.matches({"default"}));
    s.set_partial(true);
    CHECK_FALSE(s.matches({"anything"}));
}

/** The settings may change while another thread asks (checked by the thread sanitizer). */
TEST_CASE("route_search_changes_while_asked", "[route]")
{
    RouteSearch s;
    std::atomic<bool> stop{false};
    std::thread changer([&] {
        for (int i = 0; !stop; ++i) {
            s.set_words({i % 2 == 0 ? std::string(100, 'x') : std::string("default")});
            s.set_positions(i % 2 == 0 ? std::vector<std::int64_t>{1, 2, 3} : std::vector<std::int64_t>{1});
        }
    });
    for (int i = 0; i < 2000; ++i) {
        s.matches({"default", "b"});
    }
    stop = true;
    changer.join();
    s.set_words({"b"});
    s.set_positions({2});
    CHECK(s.matches({"a", "b"}));
}
