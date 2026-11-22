// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file remote_test.cpp
 * @brief Unit tests for the remote: the link between a node and the UI object that shows it.
 */

#include <catch2/catch_test_macros.hpp>

#include <cmath>
#include <memory>
#include <vector>

#include "jamoma/data.hpp"
#include "jamoma/remote.hpp"
#include "manual_clock.hpp"

using jamoma::Address;
using jamoma::Data;
using jamoma::DataType;
using jamoma::Remote;
using jamoma::Value;

namespace {

/** A node `/m/x`, a remote bound to it and a log of what the UI was shown. */
struct Rig {
    jamoma::Namespace ns;                       /**< The namespace. */
    ManualClock clock;                          /**< The clock of the node. */
    Data node{jamoma::Service::Parameter};      /**< The node. */
    jamoma::Subscription subscription;          /**< Its registration. */
    std::vector<Value> shown;                   /**< What the UI object was told to show. */
    Remote remote{ns, [this](const Value& v) { shown.push_back(v); }}; /**< The remote under test. */

    /** Sets the node up as a decimal parameter at /m/x with a value of 1. */
    Rig()
    {
        node.set_type(DataType::Decimal);
        node.set_clock(&clock);
        node.set_attribute("ramp/drive", {"system"});
        subscription = ns.subscribe(Address::parse("/m/x"), node);
        node.command({1.0});
    }

    /** @return The value of the node as a number. */
    double value() const { return node.value().at(0).as_double(); }
};

} // namespace

/** A value from the UI reaches the node, and the answer of the node is not shown to the UI again. */
TEST_CASE("ui value reaches the node without echo")
{
    Rig r;
    r.remote.set_address(Address::parse("/m/x"));
    r.shown.clear();
    r.remote.from_ui({4.0});
    REQUIRE(r.value() == 4.0);
    REQUIRE(r.shown.empty());
}

/** A change of the node shows in the UI's unit: a linear gain of 0.5 is about -6 dB. */
TEST_CASE("node change reaches the ui in the ui unit")
{
    Rig r;
    r.node.set_attribute("dataspace", {"gain"});
    r.node.set_attribute("unit", {"linear"});
    r.remote.set_unit("db");
    r.remote.set_address(Address::parse("/m/x"));
    r.shown.clear();
    r.node.command({0.5});
    REQUIRE(r.shown.size() == 1);
    REQUIRE(std::fabs(r.shown[0].at(0).as_double() + 6.0206) < 0.001);
    r.remote.from_ui({-20.0});
    REQUIRE(std::fabs(r.value() - 0.1) < 1e-6);
}

/** Every tick of a ramp is shown. */
TEST_CASE("ramp ticks reach the ui")
{
    Rig r;
    r.remote.set_address(Address::parse("/m/x"));
    r.shown.clear();
    r.node.command({101.0, "ramp", 100});
    r.clock.advance(100.0);
    REQUIRE(r.shown.size() >= 3);
    REQUIRE(r.shown.back().at(0).as_double() == 101.0);
}

/** Dragging the UI object while a ramp runs stops the ramp: the dragged value stays. */
TEST_CASE("dragging wins over a running ramp")
{
    Rig r;
    r.remote.set_address(Address::parse("/m/x"));
    r.node.command({101.0, "ramp", 1000});
    r.clock.advance(200.0);
    r.remote.from_ui({7.0});
    r.shown.clear();
    r.clock.advance(2000.0);
    REQUIRE(r.value() == 7.0);
    REQUIRE(r.shown.empty());
}

/** Freeze stops what goes to the UI; the node still follows the UI. */
TEST_CASE("freeze blocks the ui not the node")
{
    Rig r;
    r.remote.set_address(Address::parse("/m/x"));
    r.remote.set_freeze(true);
    r.shown.clear();
    r.node.command({3.0});
    REQUIRE(r.shown.empty());
    r.remote.from_ui({5.0});
    REQUIRE(r.value() == 5.0);
}

/** An inactive remote neither sends nor shows. */
TEST_CASE("inactive remote is silent")
{
    Rig r;
    r.remote.set_address(Address::parse("/m/x"));
    r.remote.set_active(false);
    r.shown.clear();
    r.node.command({3.0});
    r.remote.from_ui({9.0});
    REQUIRE(r.shown.empty());
    REQUIRE(r.value() == 3.0);
}

/** A node that appears after the address was set is bound and shown once. */
TEST_CASE("late node is bound and shown once")
{
    jamoma::Namespace ns;
    std::vector<Value> shown;
    Remote remote(ns, [&shown](const Value& v) { shown.push_back(v); });
    remote.set_address(Address::parse("/m/late"));
    Data node;
    node.set_type(DataType::Decimal);
    auto subscription = ns.subscribe(Address::parse("/m/late"), node);
    node.command({2.0});
    REQUIRE(shown.size() == 1);
    REQUIRE(shown[0].at(0).as_double() == 2.0);
    REQUIRE(remote.current().has_value());
}

/** A node that has gone is not touched: nothing is sent, nothing crashes. */
TEST_CASE("deleted node is not touched")
{
    Rig r;
    r.remote.set_address(Address::parse("/m/x"));
    r.subscription = jamoma::Subscription();
    r.shown.clear();
    r.remote.from_ui({5.0});
    REQUIRE(r.value() == 1.0);
    REQUIRE(r.shown.empty());
}

/** `set` shows a value in the UI and sends nothing. */
TEST_CASE("set shows without sending")
{
    Rig r;
    r.remote.set_address(Address::parse("/m/x"));
    r.shown.clear();
    r.remote.set_without_echo({8.0});
    REQUIRE(r.shown.size() == 1);
    REQUIRE(r.value() == 1.0);
    REQUIRE(r.remote.current()->at(0).as_double() == 8.0);
}
