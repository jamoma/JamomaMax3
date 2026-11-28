// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file osc_tools_test.cpp
 * @brief Unit tests for the string rules of j.oscinstance and j.oscroute (docs/inventory/osc-tools.md).
 */

#include <catch2/catch_test_macros.hpp>

#include <atomic>
#include <string>
#include <thread>
#include <utility>
#include <vector>

#include "jamoma/osc_tools.hpp"

using jamoma::Atom;
using jamoma::route_osc;
using jamoma::split_osc_instance;

namespace {

using Matches = std::vector<std::pair<std::size_t, std::string>>; /**< Outlet and rest. */

/** @param selector The address. @param patterns The patterns. @return The matches as pairs. */
Matches route(const std::string& selector, const std::vector<std::string>& patterns)
{
    Matches result;
    for (const auto& m : route_osc(selector, patterns)) {
        result.emplace_back(m.outlet, m.rest);
    }
    return result;
}

/** Checks one split. @param in The address. @param address The expected address. @param instance The expected instance. */
void splits(const std::string& in, const std::string& address, const Atom& instance)
{
    INFO(in);
    const auto s = split_osc_instance(in);
    REQUIRE(s);
    CHECK(s->address == address);
    CHECK(s->instance == instance);
}

} // namespace

/** The instance of the first part. */
TEST_CASE("osc_instance_is_taken_from_the_first_part", "[osc]")
{
    splits("/a.2/b", "/a/b", Atom(2));
    splits("a.x", "a", Atom("x"));
    splits("a.2/b.3", "a/b.3", Atom(2));
    splits("/a.12", "/a", Atom(12));
}

/** No instance in the first part. */
TEST_CASE("osc_instance_overflows_without_one", "[osc]")
{
    for (const char* text : {"/a/b.2", "plain", "/a/b", "/", ""}) {
        INFO(text);
        CHECK_FALSE(split_osc_instance(text));
    }
}

/** Odd instances. */
TEST_CASE("osc_instance_text_that_is_not_a_number_stays_a_symbol", "[osc]")
{
    splits("a.", "a", Atom(0));
    splits("a.2x", "a", Atom("2x"));
    splits("a.1.5", "a", Atom("1.5"));
    splits("a.-3", "a", Atom(-3));
    splits("a.99999999999999999999", "a", Atom("99999999999999999999"));
}

/** A pattern followed by a slash, or the whole address. */
TEST_CASE("osc_route_plain_patterns", "[osc]")
{
    const std::vector<std::string> p{"/fruit", "/vegetable"};
    CHECK(route("/fruit/apple", p) == Matches{{0, "apple"}});
    CHECK(route("/vegetable", p) == Matches{{1, ""}});
    CHECK(route("/fruitcake", p).empty());
    CHECK(route("/fru", p).empty());
    CHECK(route("potato/x", {"potato", "pot"}) == Matches{{0, "x"}});
    CHECK(route("/a/b/c", {"/a/b"}) == Matches{{0, "c"}});
}

/** A star at the end. */
TEST_CASE("osc_route_trailing_star", "[osc]")
{
    CHECK(route("/robot.1/arm", {"/robot*"}) == Matches{{0, "/arm"}});
    CHECK(route("/robot.1", {"/robot*"}) == Matches{{0, ""}});
    CHECK(route("/other", {"/robot*"}).empty());
    CHECK(route("anything/at/all", {"*"}) == Matches{{0, "/at/all"}});
}

/** A star elsewhere: only what follows it counts. */
TEST_CASE("osc_route_middle_star_compares_the_end", "[osc]")
{
    CHECK(route("/a/b/gain", {"*/gain"}) == Matches{{0, "/gain"}});
    CHECK(route("/x/gain", {"/a*/gain"}) == Matches{{0, "/gain"}});
    CHECK(route("/a/pan", {"*/gain"}).empty());
    CHECK(route("ab", {"*/gain"}).empty()); // shorter than the end (the old read outside the text)
}

/** The old object could send twice. */
TEST_CASE("osc_route_plain_then_star_gives_two", "[osc]")
{
    CHECK(route("/a/b", {"/a", "/a*"}) == Matches{{0, "b"}, {1, "/b"}});
    CHECK(route("/a/b", {"/a*", "*/b"}) == Matches{{0, "/b"}});
}

/** Nothing a message can hold makes trouble. */
TEST_CASE("osc_tools_survive_hostile_strings", "[osc]")
{
    const std::string longest = "/" + std::string(10000, 'a') + ".7/" + std::string(10000, 'b');
    splits(longest, "/" + std::string(10000, 'a') + "/" + std::string(10000, 'b'), Atom(7));
    CHECK(route(longest, {"*"}).size() == 1);
    for (const std::string& text : {std::string(), std::string("."), std::string("/"), std::string("a/"), std::string("*"), std::string("./."), std::string("/.")}) {
        INFO(text);
        split_osc_instance(text);
        route(text, {"", "*", "**", "*a", "a*", "/"});
    }
}

/** A pattern may be replaced while another thread routes (checked by the thread sanitizer). */
TEST_CASE("osc_router_patterns_change_while_routing", "[osc]")
{
    jamoma::OscRouter router({"/a", "/b"});
    CHECK(router.size() == 2);
    std::atomic<bool> stop{false};
    std::thread changer([&] {
        for (int i = 0; !stop; ++i) {
            router.set(0, i % 2 == 0 ? std::string(100, 'x') : std::string("/a"));
        }
    });
    for (int i = 0; i < 2000; ++i) {
        CHECK(router.route("/b/c").size() == 1);
    }
    stop = true;
    changer.join();
    router.set(0, "/z");
    router.set(7, "/never");
    CHECK(router.route("/z/1").front().outlet == 0);
}
