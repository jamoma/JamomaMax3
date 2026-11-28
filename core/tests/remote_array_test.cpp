// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file remote_array_test.cpp
 * @brief Unit tests for the array of remotes (docs/inventory/j.array.md).
 */

#include <catch2/catch_test_macros.hpp>

#include <string>
#include <utility>
#include <vector>

#include "jamoma/data_array.hpp"
#include "jamoma/remote_array.hpp"

using jamoma::Address;
using jamoma::ArrayFormat;
using jamoma::Atom;
using jamoma::DataArray;
using jamoma::RemoteArray;
using jamoma::Service;
using jamoma::Value;

namespace {

/** Names below the root. */
Address at_root(const std::string& name)
{
    return Address::parse(name.starts_with('/') ? name : "/" + name);
}

/** An array of three integer parameters `/a.[3]` and a remote array. */
struct Rig {
    jamoma::Namespace ns;                                  /**< The namespace. */
    std::vector<std::pair<std::size_t, Value>> shown;      /**< What the remote array showed. */
    DataArray data{ns, Service::Parameter};                /**< The nodes. */
    RemoteArray remote{ns, [this](std::size_t i, const Value& v) { shown.emplace_back(i, v); }}; /**< The array under test. */

    /** Makes the nodes. */
    void make_nodes()
    {
        data.set_attribute("type", Value{"integer"});
        data.set_attribute("range", Value{0, 100});
        REQUIRE(data.set_name("a.[3]", Address(), false));
        data.array(Value{1, 2, 3});
    }

    /** Makes the nodes and binds to them, forgetting what binding showed. */
    void bind()
    {
        make_nodes();
        REQUIRE(remote.set_name("a.[3]", at_root));
        shown.clear();
    }
};

using Shown = std::vector<std::pair<std::size_t, Value>>; /**< A list of what was shown. */

} // namespace

/** Every change of a node is shown with the number of its instance. */
TEST_CASE("remote_array_shows_each_instance_with_its_index", "[remote_array]")
{
    Rig r;
    r.make_nodes();
    REQUIRE(r.remote.set_name("a.[3]", at_root));
    CHECK(r.shown == Shown{{1, Value{1}}, {2, Value{2}}, {3, Value{3}}});
    r.shown.clear();
    r.data.select(Atom(2));
    r.data.command(Value{20});
    CHECK(r.shown == Shown{{2, Value{20}}});
}

/** The UI value goes to the selected nodes and their answers come back. */
TEST_CASE("remote_array_from_ui_goes_to_targets", "[remote_array]")
{
    Rig r;
    r.bind();
    REQUIRE(r.remote.select(Atom(3)));
    REQUIRE(r.remote.from_ui(Value{30}));
    CHECK(r.data.collected() == Value{1, 2, 30});
    CHECK(r.shown == Shown{{3, Value{30}}});
    r.remote.select(Atom("*"));
    r.remote.from_ui(Value{5});
    CHECK(r.data.collected() == Value{5, 5, 5});
    CHECK_FALSE(r.remote.select(Atom(4)));
}

/** `set` shows nothing, also with all selected. */
TEST_CASE("remote_array_set_shows_nothing_here", "[remote_array]")
{
    Rig r;
    r.bind();
    REQUIRE(r.remote.set(Value{9}));
    CHECK(r.data.collected() == Value{9, 9, 9});
    CHECK(r.shown.empty());
}

/** A list is cut, silently if set. */
TEST_CASE("remote_array_set_array_splits_silently", "[remote_array]")
{
    Rig r;
    r.bind();
    REQUIRE(r.remote.set_array(Value{7, 8, 9}));
    CHECK(r.data.collected() == Value{7, 8, 9});
    CHECK(r.shown.empty());
    REQUIRE(r.remote.array(Value{4, 5, 6}));
    CHECK(r.shown.size() == 3);
    CHECK_FALSE(r.remote.array(Value{1, 2}));
    CHECK_FALSE(r.remote.set_array(Value{}));
}

/** Array format shows all values. */
TEST_CASE("remote_array_format_array_collects", "[remote_array]")
{
    Rig r;
    r.remote.set_format(ArrayFormat::Array);
    r.make_nodes();
    r.shown.clear();
    REQUIRE(r.remote.set_name("a.[3]", at_root)); // once, when all are bound
    REQUIRE(r.shown.size() == 1);
    CHECK(r.shown[0].second == Value{1, 2, 3});
    r.shown.clear();
    r.data.select(Atom(2));
    r.data.command(Value{20});
    CHECK(r.shown == Shown{{2, Value{1, 20, 3}}});
}

/** Nodes that come later are bound. */
TEST_CASE("remote_array_binds_when_nodes_appear_later", "[remote_array]")
{
    Rig r;
    REQUIRE(r.remote.set_name("a.[3]", at_root));
    CHECK_FALSE(r.shown.size());
    r.make_nodes();
    r.shown.clear();
    r.remote.from_ui(Value{4});
    CHECK(r.data.collected() == Value{4, 4, 4});
    CHECK(r.shown.size() == 3);
}

/** A smaller array lets go of the rest, also from inside its own callback. */
TEST_CASE("remote_array_resize_unbinds_removed", "[remote_array]")
{
    Rig r;
    r.bind();
    REQUIRE(r.remote.resize(1));
    CHECK(r.remote.name() == "a.[1]");
    r.data.array(Value{11, 12, 13});
    CHECK(r.shown == Shown{{1, Value{11}}});
    CHECK_FALSE(r.remote.resize(257));
    REQUIRE(r.remote.resize(3));
    int calls = 0;
    RemoteArray shrinking(r.ns, [&](std::size_t, const Value&) {
        ++calls;
        shrinking.resize(1);
    });
    REQUIRE(shrinking.set_name("a.[3]", at_root));
    CHECK(shrinking.size() == 1);
    calls = 0;
    r.data.array(Value{1, 1, 1});
    CHECK(calls == 1);
}

/** Absolute names, resolved by the caller, and a change of where names lead. */
TEST_CASE("remote_array_absolute_names", "[remote_array]")
{
    Rig r;
    DataArray gains(r.ns, Service::Parameter);
    REQUIRE(gains.set_name("player.[2]/gain", Address(), false));
    REQUIRE(r.remote.set_name("/player.[2]/gain", at_root));
    r.shown.clear();
    r.remote.from_ui(Value{0.5});
    CHECK(gains.collected() == Value{0.5, 0.5});
    std::string where = "/one/";
    RemoteArray moving(r.ns, nullptr);
    const auto resolve = [&where](const std::string& n) { return Address::parse(where + n); };
    REQUIRE(moving.set_name("player.[2]/gain", resolve));
    CHECK(moving.from_ui(Value{0.1}));
    CHECK(gains.collected() == Value{0.5, 0.5});
    where = "/";
    moving.rebind();
    moving.from_ui(Value{0.25});
    CHECK(gains.collected() == Value{0.25, 0.25});
    CHECK_FALSE(r.remote.set_name("gain", at_root));
}
