// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file preset_test.cpp
 * @brief Unit tests for the preset manager: storing the parameters of a model, recalling them, and the list operations.
 */

#include <catch2/catch_test_macros.hpp>

#include <cmath>
#include <memory>
#include <string>
#include <vector>

#include "jamoma/data.hpp"
#include "jamoma/model.hpp"
#include "jamoma/preset.hpp"
#include "manual_clock.hpp"

using jamoma::Address;
using jamoma::Data;
using jamoma::DataType;
using jamoma::PresetManager;
using jamoma::Service;
using jamoma::Value;

namespace {

/** A namespace with the parameters of a model `/m`, and a log of the order in which they output. */
struct Rig {
    jamoma::Namespace ns;                               /**< The namespace. */
    ManualClock clock;                                  /**< The clock of the data objects. */
    std::vector<std::string> log;                       /**< Names, in the order the data objects output. */
    std::vector<std::unique_ptr<Data>> data;            /**< The data objects. */
    std::vector<jamoma::Subscription> subscriptions;    /**< Their registrations. */
    PresetManager presets{ns, Address::parse("/m")};    /**< The manager under test. */

    /**
     * Adds a decimal parameter below the model.
     * @param name The relative address. @param value Its starting value. @param priority Its priority. @param service Its service.
     * @return The object.
     */
    Data& add(const std::string& name, double value, int priority = 0, Service service = Service::Parameter)
    {
        data.push_back(std::make_unique<Data>(service));
        Data& d = *data.back();
        d.set_type(DataType::Decimal);
        d.set_priority(priority);
        d.set_clock(&clock);
        d.set_output([this, name](const Value&) { log.push_back(name); });
        subscriptions.push_back(ns.subscribe(Address::parse("/m/" + name), d));
        d.command({value});
        return d;
    }

    /** @param name The relative address. @return The value of the data object there as a number. */
    double number(const std::string& name) const
    {
        auto* d = dynamic_cast<Data*>(ns.lookup(Address::parse("/m/" + name))->object());
        return d->value().at(0).as_double();
    }
};

} // namespace

/** A new preset stores every parameter (not messages), sorted by priority, then name, nested ones included. */
TEST_CASE("new preset stores every parameter in order")
{
    Rig r;
    r.add("b", 2.0);
    r.add("a", 1.0);
    r.add("c", 3.0, -1);
    r.add("sub/x", 4.0);
    r.add("go", 0.0, 0, Service::Message);
    REQUIRE(r.presets.new_preset("one"));
    const auto& entries = r.presets.presets().at(0).entries;
    REQUIRE(entries.size() == 4);
    REQUIRE(entries[0].address.str() == "c");
    REQUIRE(entries[1].address.str() == "a");
    REQUIRE(entries[2].address.str() == "b");
    REQUIRE(entries[3].address.str() == "sub/x");
    REQUIRE(entries[1].value.at(0).as_double() == 1.0);
}

/** The "Priority" pane of the j.parameter help patcher: priorities order each level of nodes, and 0 comes last. */
TEST_CASE("a preset is stored level by level in order of priority")
{
    Rig r;
    jamoma::Model starter(r.ns, Address::parse("/m/starter"));
    starter.set_priority(11);
    jamoma::Model main_course(r.ns, Address::parse("/m/main_course"));
    main_course.set_priority(12);
    jamoma::Model dessert(r.ns, Address::parse("/m/dessert"));
    r.add("zzz", 0.0, 0);
    r.add("ccc_b", 0.0, 3);
    r.add("ccc_a", 0.0, 3);
    r.add("aaa", 0.0, 1);
    r.add("bbb", 0.0, 2);
    r.add("dessert/ice_cream", 0.0, 2);
    r.add("dessert/cake", 0.0, 1);
    r.add("main_course/vegetarian", 0.0, 2);
    r.add("main_course/fish", 0.0, 1);
    r.add("starter/salad", 0.0, 2);
    r.add("starter/soup", 0.0, 1);
    REQUIRE(r.presets.new_preset("default"));
    std::vector<std::string> order;
    for (const auto& entry : r.presets.presets().at(0).entries) {
        order.push_back(entry.address.str());
    }
    REQUIRE(order == std::vector<std::string>{"aaa", "bbb", "ccc_a", "ccc_b", "starter/soup", "starter/salad", "main_course/fish",
                                              "main_course/vegetarian", "dessert/cake", "dessert/ice_cream", "zzz"});
}

/** Recall sends the stored values in the stored order. */
TEST_CASE("recall sets values in priority order")
{
    Rig r;
    r.add("b", 2.0);
    r.add("a", 1.0);
    r.add("c", 3.0, -1);
    r.presets.new_preset("one");
    r.data[0]->command({20.0});
    r.data[1]->command({10.0});
    r.data[2]->command({30.0});
    r.log.clear();
    const auto report = r.presets.recall("one");
    REQUIRE(report.found);
    REQUIRE(report.applied == 3);
    REQUIRE(r.log == std::vector<std::string>{"c", "a", "b"});
    REQUIRE(r.number("a") == 1.0);
    REQUIRE(r.number("b") == 2.0);
    REQUIRE(r.number("c") == 3.0);
}

/** An entry whose node has gone is skipped and reported; the others are applied. */
TEST_CASE("recall skips missing nodes and reports them")
{
    Rig r;
    r.add("a", 1.0);
    r.add("b", 2.0);
    r.presets.new_preset("one");
    r.subscriptions[1] = jamoma::Subscription();
    r.data[0]->command({9.0});
    const auto report = r.presets.recall("one");
    REQUIRE(report.found);
    REQUIRE(report.applied == 1);
    REQUIRE(report.skipped.size() == 1);
    REQUIRE(report.skipped[0].str() == "b");
    REQUIRE(r.number("a") == 1.0);
}

/** A stored value goes through the node's command, so a range narrowed since then clips it. */
TEST_CASE("recall clips to the current range")
{
    Rig r;
    Data& d = r.add("a", 0.8);
    r.presets.new_preset("one");
    d.set_attribute("range", {0.0, 0.5});
    d.set_attribute("clipmode", {"both"});
    r.presets.recall("one");
    REQUIRE(r.number("a") == 0.5);
}

/** A name or a 1-based position selects the preset; an unknown one changes nothing. */
TEST_CASE("recall by index and by name")
{
    Rig r;
    Data& d = r.add("a", 1.0);
    r.presets.new_preset("p1");
    d.command({2.0});
    r.presets.new_preset("p2");
    REQUIRE(r.presets.recall("1").found);
    REQUIRE(r.number("a") == 1.0);
    REQUIRE(r.presets.recall("p2").found);
    REQUIRE(r.number("a") == 2.0);
    REQUIRE_FALSE(r.presets.recall("nothing").found);
    REQUIRE_FALSE(r.presets.recall("3").found);
    REQUIRE(r.number("a") == 2.0);
}

/** Update stores the present values into an existing preset without moving it. */
TEST_CASE("update replaces values keeps position")
{
    Rig r;
    Data& d = r.add("a", 1.0);
    r.presets.new_preset("p1");
    r.presets.new_preset("p2");
    d.command({5.0});
    REQUIRE(r.presets.update("p1"));
    REQUIRE(r.presets.names() == std::vector<std::string>{"p1", "p2"});
    REQUIRE(r.presets.presets()[0].entries[0].value.at(0).as_double() == 5.0);
    REQUIRE_FALSE(r.presets.update("missing"));
    REQUIRE(r.presets.new_preset("p1")); // an existing name is replaced in place
    REQUIRE(r.presets.names().size() == 2);
}

/** The list operations. */
TEST_CASE("rename copy move remove clear")
{
    Rig r;
    r.add("a", 1.0);
    r.presets.new_preset("p1");
    r.presets.new_preset("p2");
    r.presets.new_preset("p3");
    REQUIRE(r.presets.rename("p1", "first"));
    REQUIRE_FALSE(r.presets.rename("first", "p2")); // taken
    REQUIRE_FALSE(r.presets.rename("nothing", "x"));
    REQUIRE(r.presets.copy("p2", "p2b", 0));
    REQUIRE(r.presets.names() == std::vector<std::string>{"p2b", "first", "p2", "p3"});
    REQUIRE_FALSE(r.presets.copy("p2", "p3"));
    REQUIRE(r.presets.move("p3", 0));
    REQUIRE(r.presets.names() == std::vector<std::string>{"p3", "p2b", "first", "p2"});
    REQUIRE_FALSE(r.presets.move("p3", 9));
    REQUIRE(r.presets.remove("2")); // 1-based position: p2b
    REQUIRE(r.presets.names() == std::vector<std::string>{"p3", "first", "p2"});
    REQUIRE_FALSE(r.presets.remove("p2b"));
    r.presets.clear();
    REQUIRE(r.presets.names().empty());
    REQUIRE_FALSE(r.presets.current().has_value());
}

/** The current preset is the one last stored or recalled, and follows list changes. */
TEST_CASE("current follows recall and new")
{
    Rig r;
    r.add("a", 1.0);
    REQUIRE_FALSE(r.presets.current().has_value());
    r.presets.new_preset("p1");
    r.presets.new_preset("p2");
    REQUIRE(*r.presets.current() == 1);
    r.presets.recall("p1");
    REQUIRE(*r.presets.current() == 0);
    r.presets.move("p1", 1);
    REQUIRE(*r.presets.current() == 1);
    r.presets.remove("p2");
    REQUIRE(*r.presets.current() == 0);
    r.presets.remove("p1");
    REQUIRE_FALSE(r.presets.current().has_value());
}

/** Recalling a preset while a ramp runs stops it and sets the stored value. */
TEST_CASE("preset may be recalled while a ramp runs")
{
    Rig r;
    Data& d = r.add("a", 0.0);
    d.set_attribute("ramp/drive", {"system"});
    r.presets.new_preset("zero");
    d.command({"100", "ramp", "1000"});
    r.clock.advance(100.0);
    REQUIRE(r.presets.recall("zero").applied == 1);
    r.clock.advance(2000.0);
    REQUIRE(r.number("a") == 0.0);
}

/** Output reports the values and changes nothing. */
TEST_CASE("output reports without applying")
{
    Rig r;
    Data& d = r.add("a", 1.0);
    r.presets.new_preset("one");
    d.command({7.0});
    const auto report = r.presets.output("one");
    REQUIRE(report.found);
    REQUIRE(report.entries.size() == 1);
    REQUIRE(r.number("a") == 7.0);
}

/** Halfway between two presets, numbers and lists of numbers are averaged element by element. */
TEST_CASE("interpolate halfway between numbers and lists")
{
    Rig r;
    Data& a = r.add("a", 0.0);
    Data& list = r.add("v", 0.0);
    list.set_type(DataType::Array);
    list.command({0.0, 10.0});
    r.presets.new_preset("lo");
    a.command({10.0});
    list.command({4.0, 20.0});
    r.presets.new_preset("hi");
    const auto report = r.presets.interpolate("lo", "hi", 0.5);
    REQUIRE(report.found);
    REQUIRE(report.applied == 2);
    REQUIRE(r.number("a") == 5.0);
    auto* d = dynamic_cast<Data*>(r.ns.lookup(Address::parse("/m/v"))->object());
    REQUIRE(d->value().at(0).as_double() == 2.0);
    REQUIRE(d->value().at(1).as_double() == 15.0);
}

/** A value that is not a number is taken from the nearer preset. */
TEST_CASE("interpolate takes the nearer symbol")
{
    Rig r;
    Data& s = r.add("s", 0.0);
    s.set_type(DataType::String);
    s.command({"left"});
    r.presets.new_preset("one");
    s.command({"right"});
    r.presets.new_preset("two");
    r.presets.interpolate("one", "two", 0.25);
    auto* d = dynamic_cast<Data*>(r.ns.lookup(Address::parse("/m/s"))->object());
    REQUIRE(d->value().at(0).to_string() == "left");
    r.presets.interpolate("one", "two", 0.75);
    REQUIRE(d->value().at(0).to_string() == "right");
}

/** An entry that only one of the presets has keeps that preset's value. */
TEST_CASE("entries in one preset only are kept")
{
    Rig r;
    Data& a = r.add("a", 1.0);
    r.presets.new_preset("one");
    r.add("b", 8.0);
    a.command({3.0});
    r.presets.new_preset("two");
    r.add("c", 0.0);
    r.data[1]->command({0.0});
    r.data[2]->command({0.0});
    r.presets.interpolate("one", "two", 0.5);
    REQUIRE(r.number("a") == 2.0);
    REQUIRE(r.number("b") == 8.0);
}

/** A position outside 0..1 is clamped, not extrapolated. */
TEST_CASE("position outside zero to one is clamped")
{
    Rig r;
    Data& a = r.add("a", 0.0);
    r.presets.new_preset("lo");
    a.command({10.0});
    r.presets.new_preset("hi");
    r.presets.interpolate("lo", "hi", 2.0);
    REQUIRE(r.number("a") == 10.0);
    r.presets.interpolate("lo", "hi", -1.0);
    REQUIRE(r.number("a") == 0.0);
    REQUIRE_FALSE(r.presets.interpolate("lo", "missing", 0.5).found);
}

/** The factors are normalised by their sum. */
TEST_CASE("mix normalises weights")
{
    Rig r;
    Data& a = r.add("a", 0.0);
    r.presets.new_preset("lo");
    a.command({10.0});
    r.presets.new_preset("hi");
    r.presets.mix({{"lo", 3.0}, {"hi", 1.0}});
    REQUIRE(r.number("a") == 2.5);
    r.presets.mix({{"lo", 30.0}, {"hi", 10.0}});
    REQUIRE(r.number("a") == 2.5);
}

/** A sum of zero, or no preset, does nothing. */
TEST_CASE("mix of nothing does nothing")
{
    Rig r;
    Data& a = r.add("a", 4.0);
    r.presets.new_preset("one");
    a.command({9.0});
    REQUIRE(r.presets.mix({}).applied == 0);
    REQUIRE(r.presets.mix({{"one", 0.0}}).applied == 0);
    REQUIRE_FALSE(r.presets.mix({{"nothing", 1.0}}).found);
    REQUIRE(r.number("a") == 9.0);
}

/** An observer hears every change of the list or of the current preset. */
TEST_CASE("observer is told of changes")
{
    Rig r;
    r.add("a", 1.0);
    int calls = 0;
    auto handle = r.presets.observe([&calls] { ++calls; });
    r.presets.new_preset("one");
    REQUIRE(calls == 1);
    r.presets.recall("one");
    REQUIRE(calls == 2);
    r.presets.rename("one", "two");
    r.presets.clear();
    REQUIRE(calls == 4);
    REQUIRE_FALSE(r.presets.remove("nothing"));
    REQUIRE(calls == 4);
    handle.reset();
    r.presets.new_preset("three");
    REQUIRE(calls == 4);
}

/** A new preset name for "Create New Preset" never collides with an existing one (review finding: the panel overwrote preset 1). */
TEST_CASE("free name skips taken names")
{
    Rig r;
    r.add("a", 1.0);
    REQUIRE(r.presets.free_name("preset") == "preset 1");
    r.presets.new_preset("preset 1");
    r.presets.new_preset("preset 2");
    REQUIRE(r.presets.free_name("preset") == "preset 3");
}

/** A position that is not a number is not applied (review finding: NaN went to every parameter). */
TEST_CASE("interpolate with a nan position does nothing")
{
    Rig r;
    Data& a = r.add("a", 0.0);
    r.presets.new_preset("lo");
    a.command({10.0});
    r.presets.new_preset("hi");
    const auto report = r.presets.interpolate("lo", "hi", std::nan(""));
    REQUIRE_FALSE(report.found);
    REQUIRE(r.number("a") == 10.0);
}

/** The name a new preset gets from a wish: the wish if no preset has it, else numbered; `preset <n>` for an empty one. */
TEST_CASE("a new preset name is the wanted one or a free numbered one", "[preset]")
{
    jamoma::Namespace names;
    jamoma::PresetManager presets(names, jamoma::Address::parse("/m"));
    CHECK(presets.unused_name("Alpha") == "Alpha");
    CHECK(presets.unused_name("  My Preset ") == "My Preset");
    CHECK(presets.unused_name("") == "preset 1");
    CHECK(presets.unused_name("   ") == "preset 1");
    REQUIRE(presets.new_preset("Alpha"));
    CHECK(presets.unused_name("Alpha") == "Alpha 1");
    REQUIRE(presets.new_preset("Alpha 1"));
    CHECK(presets.unused_name("Alpha") == "Alpha 2");
    REQUIRE(presets.new_preset("preset 1"));
    CHECK(presets.unused_name("") == "preset 2");
}
