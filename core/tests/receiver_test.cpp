// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file receiver_test.cpp
 * @brief Unit tests for the receiver (rules in docs/inventory/send-receive.md).
 */

#include <catch2/catch_test_macros.hpp>

#include <atomic>
#include <chrono>
#include <memory>
#include <string>
#include <thread>
#include <vector>

#include "jamoma/data.hpp"
#include "jamoma/receiver.hpp"

using jamoma::Address;
using jamoma::Atom;
using jamoma::Data;
using jamoma::DataType;
using jamoma::Namespace;
using jamoma::Receiver;
using jamoma::Subscription;
using jamoma::Value;

namespace {

/** A float atom. @param v The value. @return The atom. */
Atom f(double v) { return Atom(v); }

/** A namespace with a receiver that logs what it outputs. */
struct World {
    Namespace ns;                                   /**< The namespace. */
    std::vector<std::string> addresses;             /**< Addresses output, in order. */
    std::vector<Value> values;                      /**< Values output, in order. */
    std::vector<std::string> log;                   /**< Both, in one list: `address` entries and `value` entries in order. */
    std::unique_ptr<Receiver> receiver;             /**< The receiver under test. */
    std::vector<std::unique_ptr<Data>> data;        /**< The data objects. */
    std::vector<Subscription> subscriptions;        /**< Their registrations. */

    World()
        : receiver(std::make_unique<Receiver>(
              ns,
              [this](const Address& a) {
                  addresses.push_back(a.str());
                  log.push_back("address " + a.str());
              },
              [this](const Value& v) {
                  values.push_back(v);
                  log.push_back("value " + jamoma::to_string(v));
              }))
    {
    }

    /** Adds a decimal parameter at an address. @param address Where. @return The data object (also kept in `data`). */
    Data& add(const std::string& address)
    {
        data.push_back(std::make_unique<Data>());
        data.back()->set_type(DataType::Decimal);
        subscriptions.push_back(ns.subscribe(Address::parse(address), *data.back()));
        return *data.back();
    }
};

} // namespace

/** Binding to an existing initialised node outputs its address and value once. */
TEST_CASE("binds existing node and outputs value once")
{
    World w;
    Data& a = w.add("/m/a");
    a.command(Value{f(0.5)});
    w.receiver->set_address(Address::parse("/m/a"));
    REQUIRE(w.log == std::vector<std::string>{"address /m/a", "value 0.5"});
}

/** A change outputs address then value. */
TEST_CASE("outputs address then value on change")
{
    World w;
    Data& a = w.add("/m/a");
    w.receiver->set_address(Address::parse("/m/a"));
    w.log.clear();
    a.command(Value{f(0.25)});
    REQUIRE(w.log == std::vector<std::string>{"address /m/a", "value 0.25"});
}

/** An inactive receiver is silent until banged. */
TEST_CASE("inactive receiver is silent until banged")
{
    World w;
    Data& a = w.add("/m/a");
    a.command(Value{f(0.5)});
    w.receiver->set_active(false);
    w.receiver->set_address(Address::parse("/m/a"));
    a.command(Value{f(0.75)});
    REQUIRE(w.log.empty());
    REQUIRE(w.receiver->bang());
    REQUIRE(w.log == std::vector<std::string>{"address /m/a", "value 0.75"});
}

/** A node that appears later is bound and output once. */
TEST_CASE("late node is bound and output once")
{
    World w;
    w.receiver->set_address(Address::parse("/m/a"));
    REQUIRE(w.log.empty());
    Data& a = w.add("/m/a");
    a.init();
    REQUIRE(w.log == std::vector<std::string>{"address /m/a", "value 0.0"});
    a.command(Value{f(0.5)});
    REQUIRE(w.log.size() == 4);
}

/** Review focus 1: a node deleted and created again is followed; nothing is output from the deleted one. */
TEST_CASE("node deleted then recreated is followed")
{
    World w;
    w.add("/m/a").command(Value{f(0.5)});
    w.receiver->set_address(Address::parse("/m/a"));
    w.log.clear();
    w.subscriptions.clear();
    w.data.clear();
    REQUIRE(w.log.empty());
    Data& again = w.add("/m/a");
    again.command(Value{f(0.9)});
    REQUIRE(w.log == std::vector<std::string>{"address /m/a", "value 0.9"});
}

/** Rebinding stops the old binding. */
TEST_CASE("rebinding address stops old binding")
{
    World w;
    Data& a = w.add("/m/a");
    Data& b = w.add("/m/b");
    w.receiver->set_address(Address::parse("/m/a"));
    w.receiver->set_address(Address::parse("/m/b"));
    w.log.clear();
    a.command(Value{f(0.1)});
    REQUIRE(w.log.empty());
    b.command(Value{f(0.2)});
    REQUIRE(w.log == std::vector<std::string>{"address /m/b", "value 0.2"});
    w.receiver->set_address(Address());
    b.command(Value{f(0.3)});
    REQUIRE(w.log.size() == 2);
}

/** A wildcard binds every match and reports each one's address. */
TEST_CASE("wildcard binds every match and reports each address")
{
    World w;
    Data& a = w.add("/m/a");
    Data& b = w.add("/m/b");
    a.command(Value{f(0.1)});
    b.command(Value{f(0.2)});
    w.receiver->set_address(Address::parse("/m/*"));
    REQUIRE(w.addresses == std::vector<std::string>{"/m/a", "/m/b"});
    w.log.clear();
    b.command(Value{f(0.3)});
    REQUIRE(w.log == std::vector<std::string>{"address /m/b", "value 0.3"});
}

/** An attribute address follows that attribute and says so in the address. */
TEST_CASE("attribute address follows range")
{
    World w;
    Data& a = w.add("/m/a");
    w.receiver->set_address(Address::parse("/m/a:range"));
    REQUIRE(w.log == std::vector<std::string>{"address /m/a:range", "value 0.0 1.0"});
    w.log.clear();
    a.set_attribute("range", Value{f(0.0), f(5.0)});
    REQUIRE(w.log == std::vector<std::string>{"address /m/a:range", "value 0.0 5.0"});
}

/** `:created` and `:destroyed` report the node's address only. */
TEST_CASE("created and destroyed attributes")
{
    World w;
    w.receiver->set_address(Address::parse("/m/a:created"));
    w.add("/m/a");
    REQUIRE(w.log == std::vector<std::string>{"address /m/a"});
    World x;
    Data& b = x.add("/m/b");
    (void)b;
    x.receiver->set_address(Address::parse("/m/b:destroyed"));
    x.subscriptions.clear();
    REQUIRE(x.log == std::vector<std::string>{"address /m/b"});
}

/** An empty value is not output. */
TEST_CASE("empty value is not output")
{
    World w;
    w.add("/m/a"); // not initialised: its value attribute is empty
    w.receiver->set_address(Address::parse("/m/a"));
    REQUIRE(w.log.empty());
    REQUIRE_FALSE(w.receiver->bang());
}

/** grab returns the value without output. */
TEST_CASE("grab returns the first value")
{
    World w;
    Data& a = w.add("/m/a");
    a.command(Value{f(0.5)});
    w.receiver->set_address(Address::parse("/m/a"));
    w.log.clear();
    REQUIRE(w.receiver->grab() == Value{f(0.5)});
    REQUIRE(w.log.empty());
}

/** The receiver may be destroyed inside its own callback. */
TEST_CASE("destroying receiver inside its callback is safe")
{
    Namespace ns;
    Data a;
    a.set_type(DataType::Decimal);
    Subscription s = ns.subscribe(Address::parse("/m/a"), a);
    std::unique_ptr<Receiver> r;
    int calls = 0;
    r = std::make_unique<Receiver>(ns, [](const Address&) {}, [&](const Value&) {
        ++calls;
        r.reset();
    });
    r->set_address(Address::parse("/m/a"));
    a.command(Value{f(0.5)});
    a.command(Value{f(0.6)});
    REQUIRE(calls == 1);
    REQUIRE(r == nullptr);
}

/** A receiver may outlive the namespace and the data. */
TEST_CASE("receiver outliving namespace is safe")
{
    std::unique_ptr<Receiver> r;
    {
        Namespace ns;
        Data a;
        a.set_type(DataType::Decimal);
        Subscription s = ns.subscribe(Address::parse("/m/a"), a);
        r = std::make_unique<Receiver>(ns, [](const Address&) {}, [](const Value&) {});
        r->set_address(Address::parse("/m/a"));
    }
    REQUIRE_NOTHROW(r.reset());
}

/** Review: a receiver destroyed while a callback runs on another thread waits for it; the callback never runs after the destructor returned. */
TEST_CASE("destroying receiver waits for a callback running on another thread")
{
    Namespace ns;
    Data a;
    a.set_type(DataType::Decimal);
    Subscription s = ns.subscribe(Address::parse("/m/a"), a);
    std::atomic<bool> started{false};
    std::atomic<bool> destroyed{false};
    std::atomic<bool> violation{false};
    auto receiver = std::make_unique<Receiver>(ns, [](const Address&) {}, [&](const Value&) {
        started = true;
        std::this_thread::sleep_for(std::chrono::milliseconds(40)); // the window in which the destructor runs
        if (destroyed.load()) {
            violation = true;
        }
    });
    receiver->set_address(Address::parse("/m/a"));
    started = false;
    std::thread driver([&a] { a.command(Value{f(0.5)}); });
    while (!started.load()) {
        std::this_thread::yield();
    }
    receiver.reset(); // must wait for the running callback
    destroyed = true;
    driver.join();
    REQUIRE_FALSE(violation.load());
}
