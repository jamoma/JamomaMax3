// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file sender_test.cpp
 * @brief Unit tests for the sender (rules in docs/inventory/send-receive.md).
 */

#include <catch2/catch_test_macros.hpp>

#include <memory>
#include <string>
#include <vector>

#include "jamoma/data.hpp"
#include "jamoma/model.hpp"
#include "jamoma/receiver.hpp"
#include "jamoma/sender.hpp"
#include "manual_clock.hpp"

using jamoma::Address;
using jamoma::Atom;
using jamoma::Data;
using jamoma::DataType;
using jamoma::Model;
using jamoma::Namespace;
using jamoma::Receiver;
using jamoma::Sender;
using jamoma::Subscription;
using jamoma::Value;

namespace {

/** A float atom. @param v The value. @return The atom. */
Atom f(double v) { return Atom(v); }

/** A decimal parameter registered in a namespace. */
struct Param {
    /** @param ns The namespace. @param address Where to register it. */
    Param(Namespace& ns, const std::string& address) : subscription(ns.subscribe(Address::parse(address), data))
    {
        data.set_type(DataType::Decimal);
    }
    Data data;                  /**< The data object. */
    Subscription subscription;  /**< Its registration. */
};

} // namespace

/** A value sent to a parameter is a command: a ramp command starts a ramp. */
TEST_CASE("value reaches parameter as a command")
{
    Namespace ns;
    ManualClock clock;
    Param p(ns, "/m/p");
    p.data.set_ramp_drive("max");
    p.data.set_clock(&clock);
    Sender s(ns);
    s.set_address(Address::parse("/m/p"));
    REQUIRE(s.send(Value{f(100.0), Atom("ramp"), Atom(std::int64_t(200))}));
    REQUIRE(p.data.ramp_running());
    clock.advance(1000.0);
    REQUIRE(p.data.value() == Value{f(100.0)});
}

/** An attribute address sets that attribute. */
TEST_CASE("attribute address sets the attribute")
{
    Namespace ns;
    Param p(ns, "/m/p");
    Sender s(ns);
    s.set_address(Address::parse("/m/p:range"));
    REQUIRE(s.send(Value{f(0.0), f(10.0)}));
    REQUIRE(p.data.range() == Value{f(0.0), f(10.0)});
}

/** A wildcard reaches every match. */
TEST_CASE("wildcard reaches every match")
{
    Namespace ns;
    Param a(ns, "/m/a");
    Param b(ns, "/m/b");
    Param other(ns, "/n/a");
    Sender s(ns);
    s.set_address(Address::parse("/m/*"));
    REQUIRE(s.send(Value{f(0.5)}));
    REQUIRE(a.data.value() == Value{f(0.5)});
    REQUIRE(b.data.value() == Value{f(0.5)});
    REQUIRE(other.data.value() == Value{f(0.0)});
}

/** Nothing reached gives false: no node, no address, an unknown attribute. */
TEST_CASE("unknown target returns false")
{
    Namespace ns;
    Param p(ns, "/m/p");
    Sender s(ns);
    REQUIRE_FALSE(s.send(Value{f(0.5)})); // no address yet
    s.set_address(Address::parse("/m/nothing"));
    REQUIRE_FALSE(s.send(Value{f(0.5)}));
    s.set_address(Address::parse("/m/p:nonsense"));
    REQUIRE_FALSE(s.send(Value{f(0.5)}));
}

/** Review focus 1: a deleted target is not touched; a new one at the same address is reached. */
TEST_CASE("deleted target is not touched")
{
    Namespace ns;
    Sender s(ns);
    s.set_address(Address::parse("/m/p"));
    {
        Param p(ns, "/m/p");
        REQUIRE(s.send(Value{f(0.5)}));
    }
    REQUIRE_FALSE(s.send(Value{f(0.6)}));
    Param again(ns, "/m/p");
    REQUIRE(s.send(Value{f(0.7)}));
    REQUIRE(again.data.value() == Value{f(0.7)});
}

/** A model forwards a message whose first element is a symbol to the member of that name. */
TEST_CASE("model forwards to member")
{
    Namespace ns;
    Model m(ns, Address::parse("/m"));
    Param p(ns, "/m/p");
    Sender s(ns);
    s.set_address(Address::parse("/m"));
    REQUIRE(s.send(Value{Atom("p"), f(0.7)}));
    REQUIRE(p.data.value() == Value{f(0.7)});
    REQUIRE_FALSE(s.send(Value{f(0.7)}));               // no symbol first
    REQUIRE_FALSE(s.send(Value{Atom("nothing"), f(1)})); // no such member
}

/** Review focus 2: a receiver whose callback sends to the same parameter through the same sender is dropped once. */
TEST_CASE("recursion through receiver is dropped once")
{
    Namespace ns;
    Param p(ns, "/m/p");
    Sender s(ns);
    s.set_address(Address::parse("/m/p"));
    int callbacks = 0;
    bool inner_reached = true;
    Receiver r(ns, [](const Address&) {}, [&](const Value&) {
        ++callbacks;
        inner_reached = s.send(Value{f(0.9)}); // the guard of s drops this one: nothing is reached
    });
    r.set_address(Address::parse("/m/p"));
    callbacks = 0; // the report on binding
    REQUIRE(s.send(Value{f(0.5)}));
    REQUIRE(callbacks == 1);
    REQUIRE_FALSE(inner_reached); // only the sender's own guard can make this false: the Data would have accepted a command
    REQUIRE(p.data.value() == Value{f(0.5)});
}

/** Review focus 2: two parameters that drive each other through senders and receivers settle. */
TEST_CASE("two parameters bound through sender and receiver settle")
{
    Namespace ns;
    Param a(ns, "/m/a");
    Param b(ns, "/m/b");
    a.data.set_repetitions_filter(true);
    b.data.set_repetitions_filter(true);
    Sender to_a(ns), to_b(ns), entry(ns);
    to_a.set_address(Address::parse("/m/a"));
    to_b.set_address(Address::parse("/m/b"));
    entry.set_address(Address::parse("/m/a"));
    Value last_a, last_b;
    Receiver ra(ns, [](const Address&) {}, [&](const Value& v) { last_a = v; to_b.send(v); });
    Receiver rb(ns, [](const Address&) {}, [&](const Value& v) { last_b = v; to_a.send(v); });
    (void)last_a;
    (void)last_b;
    ra.set_address(Address::parse("/m/a"));
    rb.set_address(Address::parse("/m/b"));
    REQUIRE(entry.send(Value{f(0.5)}));
    REQUIRE(a.data.value() == Value{f(0.5)});
    REQUIRE(b.data.value() == Value{f(0.5)});
}
