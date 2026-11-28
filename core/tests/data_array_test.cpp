// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file data_array_test.cpp
 * @brief Unit tests for the array of data objects (docs/inventory/j.array.md).
 */

#include <catch2/catch_test_macros.hpp>

#include <atomic>
#include <memory>
#include <string>
#include <thread>
#include <utility>
#include <vector>

#include "jamoma/data_array.hpp"
#include "jamoma/model.hpp"
#include "manual_clock.hpp"

using jamoma::Address;
using jamoma::ArrayFormat;
using jamoma::Atom;
using jamoma::Data;
using jamoma::DataArray;
using jamoma::Service;
using jamoma::Value;

namespace {

/** A clock that is part of a group the test advances together (every instance has its own clock). */
struct Clocks {
    /** One clock that keeps itself in the group while it exists. */
    struct Member : ManualClock {
        explicit Member(std::vector<Member*>& g) : group(g) { group.push_back(this); } /**< @param g The group. */
        ~Member() override { std::erase(group, this); }                               /**< Leaves the group. */
        std::vector<Member*>& group;                                                  /**< The group. */
    };
    std::vector<Member*> all; /**< The clocks that exist. */
    /** @param ms How far to advance every clock. */
    void advance(double ms)
    {
        const std::vector<Member*> now = all;
        for (Member* m : now) {
            if (std::find(all.begin(), all.end(), m) != all.end()) {
                m->advance(ms);
            }
        }
    }
};

/** A namespace, an array in it and a log of what it outputs. */
struct Rig {
    jamoma::Namespace ns;                                  /**< The namespace. */
    Clocks clocks;                                         /**< The clocks. */
    std::vector<std::pair<std::size_t, Value>> log;        /**< The outputs. */
    DataArray array;                                       /**< The array under test. */

    /** @param service The role. */
    explicit Rig(Service service = Service::Parameter) : array(ns, service)
    {
        array.set_clock_maker([this] { return std::make_unique<Clocks::Member>(clocks.all); });
        array.set_output([this](std::size_t i, const Value& v) { log.emplace_back(i, v); });
    }

    /** @param address An address. @return The data object there, or null. */
    Data* at(const std::string& address) const
    {
        const jamoma::Node* node = ns.lookup(Address::parse(address));
        return node != nullptr ? dynamic_cast<Data*>(node->object()) : nullptr;
    }

    /** Builds a decimal array with the range 0 100. @param name The name. */
    void make(const std::string& name)
    {
        REQUIRE(array.set_name(name, Address(), false));
        REQUIRE(array.set_attribute("range", Value{0.0, 100.0}));
        log.clear();
    }

    /** @param address An address. @return Its value as a number. */
    double number(const std::string& address) const { return at(address)->value().at(0).as_double(); }
};

} // namespace

/** One node per index, below the prefix. */
TEST_CASE("data_array_makes_one_node_per_index", "[data_array]")
{
    Rig r;
    REQUIRE(r.array.set_name("track.[3]/gain", Address::parse("/m"), false));
    CHECK(r.array.size() == 3);
    CHECK(r.array.name() == "track.[3]/gain");
    for (int i = 1; i <= 3; ++i) {
        CHECK(r.at("/m/track." + std::to_string(i) + "/gain") != nullptr);
    }
    CHECK(r.at("/m/track.4/gain") == nullptr);
    REQUIRE(r.array.set_name("track.[3]/gain", Address::parse("/other"), false)); // the model was found: they move
    CHECK(r.at("/m/track.1/gain") == nullptr);
    CHECK(r.at("/other/track.1/gain") != nullptr);
}

/** With all selected every instance takes the value, in order. */
TEST_CASE("data_array_command_goes_to_all_in_index_order", "[data_array]")
{
    Rig r;
    r.make("a.[3]");
    REQUIRE(r.array.command(Value{5.0}));
    CHECK(r.log == std::vector<std::pair<std::size_t, Value>>{{1, Value{5.0}}, {2, Value{5.0}}, {3, Value{5.0}}});
}

/** One selected instance. */
TEST_CASE("data_array_command_goes_to_the_selected_one", "[data_array]")
{
    Rig r;
    r.make("a.[3]");
    REQUIRE(r.array.select(Atom(2)));
    r.array.command(Value{5.0});
    CHECK(r.log == std::vector<std::pair<std::size_t, Value>>{{2, Value{5.0}}});
    CHECK(r.number("/a.1") == 0.0);
}

/** A list is cut into parts. */
TEST_CASE("data_array_array_splits_over_instances", "[data_array]")
{
    Rig r;
    r.make("a.[3]");
    REQUIRE(r.array.select(Atom(2))); // `array` goes to all whatever is selected
    REQUIRE(r.array.array(Value{1.0, 2.0, 3.0}));
    CHECK(r.number("/a.1") == 1.0);
    CHECK(r.number("/a.3") == 3.0);
    CHECK(r.array.selected() == 2);
}

/** A wrong length is refused. */
TEST_CASE("data_array_array_wrong_length_changes_nothing", "[data_array]")
{
    Rig r;
    r.make("a.[3]");
    CHECK_FALSE(r.array.array(Value{1.0, 2.0}));
    CHECK(r.log.empty());
    Rig empty;
    CHECK_FALSE(empty.array.array(Value{1.0}));
    CHECK_FALSE(empty.array.command(Value{1.0}));
}

/** The step messages reach all selected instances. */
TEST_CASE("data_array_inc_acts_on_all_selected", "[data_array]")
{
    Rig r;
    r.make("a.[3]");
    r.array.set_attribute("stepsize", Value{2.0});
    REQUIRE(r.array.inc(Value{}));
    CHECK(r.number("/a.1") == 2.0);
    CHECK(r.number("/a.3") == 2.0);
    r.array.select(Atom(3));
    r.array.dec(Value{});
    CHECK(r.number("/a.3") == 0.0);
    CHECK(r.number("/a.1") == 2.0);
}

/** Attributes go to every instance; the selection stays. */
TEST_CASE("data_array_attribute_reaches_every_instance_and_keeps_selection", "[data_array]")
{
    Rig r;
    r.make("a.[3]");
    r.array.select(Atom(2));
    REQUIRE(r.array.set_attribute("description", Value{"gains"}));
    CHECK(r.at("/a.1")->description() == "gains");
    CHECK(r.at("/a.3")->description() == "gains");
    CHECK(r.array.selected() == 2);
    CHECK_FALSE(r.array.set_attribute("no/such", Value{1}));
    CHECK_FALSE(r.array.set_attribute("service", Value{1}));
}

/** The watched instance answers. */
TEST_CASE("data_array_query_reports_the_watched_instance", "[data_array]")
{
    Rig r;
    r.make("a.[3]");
    r.at("/a.1")->set_description("one");
    r.at("/a.3")->set_description("three");
    CHECK(r.array.get_attribute("description") == Value{"one"});
    r.at("/a.3")->command(Value{4.0}); // changed from outside: now watched
    CHECK(r.array.get_attribute("description") == Value{"three"});
    r.array.select(Atom(1));
    CHECK(r.array.get_attribute("description") == Value{"one"});
    CHECK_FALSE(r.array.get_attribute("no/such"));
}

/** Array format carries every value. */
TEST_CASE("data_array_format_array_outputs_all_values", "[data_array]")
{
    Rig r;
    r.array.set_format(ArrayFormat::Array);
    REQUIRE(r.array.set_name("a.[3]", Address(), false));
    r.array.set_attribute("range", Value{0.0, 100.0});
    CHECK(r.array.collected() == Value{0.0, 0.0, 0.0});
    r.log.clear();
    r.array.select(Atom(2));
    r.array.command(Value{7.0});
    CHECK(r.log == std::vector<std::pair<std::size_t, Value>>{{2, Value{0.0, 7.0, 0.0}}});
    r.log.clear();
    REQUIRE(r.array.resize(2, true)); // once, after the change
    CHECK(r.log == std::vector<std::pair<std::size_t, Value>>{{2, Value{0.0, 7.0}}});
    Rig strings;
    strings.array.set_attribute("type", Value{"string"});
    strings.array.set_name("s.[2]", Address(), false);
    CHECK(strings.array.collected() == Value{"none", "none"});
}

/** Values survive a change of size. */
TEST_CASE("data_array_resize_keeps_remaining_values", "[data_array]")
{
    Rig r;
    r.make("a.[3]");
    r.array.array(Value{1.0, 2.0, 3.0});
    REQUIRE(r.array.resize(2, true));
    CHECK(r.at("/a.3") == nullptr);
    CHECK(r.number("/a.2") == 2.0);
    REQUIRE(r.array.resize(4, true));
    CHECK(r.number("/a.2") == 2.0);
    CHECK(r.number("/a.4") == 0.0);
    CHECK_FALSE(r.array.resize(257, true));
    CHECK(r.array.size() == 4);
}

/** New instances look like the others; old ones are left alone. */
TEST_CASE("data_array_new_instances_get_remembered_attributes", "[data_array]")
{
    Rig r;
    REQUIRE(r.array.set_attribute("type", Value{"integer"})); // before there is a name, as box attributes may come
    r.array.set_attribute("range", Value{0, 10});
    r.array.set_attribute("default", Value{3});
    REQUIRE(r.array.set_name("a.[1]", Address(), false));
    r.array.set_attribute("range", Value{0, 20});
    r.array.command(Value{9});
    r.log.clear();
    REQUIRE(r.array.resize(2, true));
    CHECK(r.at("/a.2")->range() == Value{0, 20});
    CHECK(r.at("/a.2")->value() == Value{3});
    CHECK(r.at("/a.1")->value() == Value{9});
    CHECK(r.log == std::vector<std::pair<std::size_t, Value>>{{2, Value{3}}});
}

/** Another shape starts again. */
TEST_CASE("data_array_new_shape_removes_old_nodes", "[data_array]")
{
    Rig r;
    r.make("a.[3]");
    r.array.select(Atom(3));
    REQUIRE(r.array.set_name("b.[2]/x", Address(), false));
    CHECK(r.at("/a.1") == nullptr);
    CHECK(r.at("/b.2/x") != nullptr);
    CHECK(r.array.selected() == 0);
    CHECK_FALSE(r.array.set_name("b", Address(), false));
    CHECK(r.array.name() == "b.[2]/x");
}

/** Nothing and back. */
TEST_CASE("data_array_resize_to_zero_and_back", "[data_array]")
{
    Rig r;
    r.make("a.[2]");
    REQUIRE(r.array.resize(0, true));
    CHECK(r.at("/a.1") == nullptr);
    CHECK_FALSE(r.array.command(Value{1.0}));
    CHECK(r.array.collected().empty());
    REQUIRE(r.array.resize(2, true));
    CHECK(r.at("/a.2") != nullptr);
}

/** Every instance ramps by itself, and a removed one is silent. */
TEST_CASE("data_array_resize_during_ramps_gives_no_stale_output", "[data_array]")
{
    Rig r;
    r.make("a.[3]");
    r.array.command(Value{10.0, "ramp", 100});
    r.clocks.advance(50.0);
    CHECK(r.number("/a.1") > 0.0);
    CHECK(r.number("/a.2") > 0.0); // a shared clock would only ramp the last one
    r.array.resize(1, true);
    r.log.clear();
    r.clocks.advance(100.0);
    for (const auto& [index, value] : r.log) {
        CHECK(index == 1);
    }
    CHECK(r.number("/a.1") == 10.0);
}

/** The output may change the array. */
TEST_CASE("data_array_resize_from_its_own_output", "[data_array]")
{
    Rig r;
    r.make("a.[4]");
    r.array.set_output([&r](std::size_t i, const Value& v) {
        r.log.emplace_back(i, v);
        r.array.resize(1, true);
    });
    r.array.command(Value{1.0});
    CHECK(r.array.size() == 1);
    CHECK(r.log.size() == 1);
    r.array.set_output([&r](std::size_t, const Value&) { r.array.set_name("c.[2]", Address(), false); });
    r.array.command(Value{2.0, "ramp", 20});
    r.clocks.advance(100.0);
    CHECK(r.at("/c.2") != nullptr);
}

/** Two arrays of the same name do not disturb each other. */
TEST_CASE("data_array_same_name_twice_keeps_both_working", "[data_array]")
{
    Rig r;
    r.make("a.[2]");
    Data single;
    const auto kept = r.ns.subscribe(Address::parse("/a.1"), single); // a single object on the same name
    {
        DataArray second(r.ns, Service::Parameter);
        REQUIRE(second.set_name("a.[2]", Address(), false));
        CHECK(second.command(Value{0.5}));
        CHECK(second.collected() == Value{0.5, 0.5});
    }
    r.array.command(Value{3.0});
    CHECK(r.array.collected() == Value{3.0, 3.0});
}

/** Names that cannot be used. */
TEST_CASE("data_array_rejects_absolute_name", "[data_array]")
{
    Rig r;
    CHECK_FALSE(r.array.set_name("/a.[2]", Address(), false));
    CHECK_FALSE(r.array.set_name("x:/a.[2]", Address(), false));
    CHECK_FALSE(r.array.set_name("a", Address(), false));
    CHECK_FALSE(r.array.resize(2, false));
    CHECK(r.array.size() == 0);
}

/** Presets treat instances as ordinary parameters. */
TEST_CASE("data_array_instances_are_stored_in_presets", "[data_array]")
{
    Rig r;
    jamoma::Model model(r.ns, Address::parse("/m"));
    REQUIRE(r.array.set_name("a.[2]", model.address(), false));
    r.array.set_attribute("range", Value{0.0, 100.0});
    r.array.array(Value{1.0, 2.0});
    REQUIRE(model.presets().new_preset("one"));
    r.array.array(Value{8.0, 9.0});
    model.presets().recall("one");
    CHECK(r.array.collected() == Value{1.0, 2.0});
}

/** Values may come from another thread while the array changes (checked by the thread sanitizer). */
TEST_CASE("data_array_commands_from_another_thread_while_resizing", "[data_array]")
{
    jamoma::Namespace ns;
    std::atomic<int> outputs{0};
    DataArray array(ns, Service::Parameter);
    array.set_output([&outputs](std::size_t, const Value&) { ++outputs; });
    REQUIRE(array.set_name("a.[8]", Address(), false));
    std::atomic<bool> stop{false};
    std::thread sender([&] {
        double v = 0.0;
        while (!stop) {
            array.command(Value{v});
            v = v > 0.9 ? 0.0 : v + 0.1;
        }
    });
    for (int i = 0; i < 200; ++i) {
        array.resize(static_cast<std::size_t>(i % 9), true);
        array.set_attribute("description", Value{"x"});
    }
    array.resize(2, true);
    stop = true;
    sender.join();
    CHECK(array.size() == 2);
    CHECK(outputs > 0);
}
