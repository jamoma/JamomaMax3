// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file model_test.cpp
 * @brief Unit tests for the model (initialisation order and observers) and the patcher-to-model map.
 *
 * The rules come from the old TTContainer::initNode: children are initialised in order of priority then name then instance;
 * only data with the parameter service are initialised; a nested model runs its own init; a child removed meanwhile is skipped.
 */

#include <catch2/catch_test_macros.hpp>

#include <memory>
#include <string>
#include <vector>

#include "jamoma/data.hpp"
#include "jamoma/model.hpp"

using jamoma::Address;
using jamoma::Atom;
using jamoma::Data;
using jamoma::DataType;
using jamoma::Model;
using jamoma::Namespace;
using jamoma::Service;
using jamoma::Subscription;
using jamoma::Value;

namespace {

/** A namespace with a model and a log of what happened, in order. */
struct World {
    Namespace ns;                                       /**< The namespace. */
    std::vector<std::string> log;                       /**< Events in order. */
    std::vector<std::unique_ptr<Data>> data;            /**< The data objects. */
    std::vector<Subscription> subscriptions;            /**< Their registrations. */

    /**
     * Adds a data object that logs its name when it outputs (which init makes it do).
     * @param address Where to subscribe it. @param priority Its priority. @param service Its service.
     * @return The object.
     */
    Data& add(const std::string& address, int priority = 0, Service service = Service::Parameter)
    {
        data.push_back(std::make_unique<Data>(service));
        Data& d = *data.back();
        d.set_type(DataType::Decimal);
        d.set_priority(priority);
        d.set_output([this, address](const Value&) { log.push_back(address); });
        subscriptions.push_back(ns.subscribe(Address::parse(address), d));
        return d;
    }
};

} // namespace

/** Parameters are initialised in order of priority, lowest first. */
TEST_CASE("init visits parameters in priority order")
{
    World w;
    Model m(w.ns, Address::parse("/m"));
    w.add("/m/a", 2);
    w.add("/m/b", 0);
    w.add("/m/c", 1);
    m.init();
    REQUIRE(w.log == std::vector<std::string>{"/m/b", "/m/c", "/m/a"});
}

/** Equal priorities are ordered by name, then instance. */
TEST_CASE("equal priority orders by name then instance")
{
    World w;
    Model m(w.ns, Address::parse("/m"));
    w.add("/m/zebra");
    w.add("/m/apple");
    w.add("/m/apple");
    w.add("/m/apple.5");
    m.init();
    REQUIRE(w.log == std::vector<std::string>{"/m/apple", "/m/apple", "/m/apple.5", "/m/zebra"});
}

/** Messages and returns are not initialised. */
TEST_CASE("messages and returns are not initialised")
{
    World w;
    Model m(w.ns, Address::parse("/m"));
    w.add("/m/p", 0, Service::Parameter);
    w.add("/m/msg", 0, Service::Message);
    w.add("/m/ret", 0, Service::Return);
    m.init();
    REQUIRE(w.log == std::vector<std::string>{"/m/p"});
}

/** Observers hear that init starts before the first child and that it is finished after the last. */
TEST_CASE("init started fires before the first child and finished after the last")
{
    World w;
    Model m(w.ns, Address::parse("/m"));
    w.add("/m/a");
    w.add("/m/b");
    auto handle = m.on_init_changed([&w](bool done) { w.log.push_back(done ? "finished" : "started"); });
    w.log.clear();
    m.init();
    REQUIRE(w.log == std::vector<std::string>{"started", "/m/a", "/m/b", "finished"});
}

/** A model with no children still reports both. */
TEST_CASE("model with no children still fires both")
{
    World w;
    Model m(w.ns, Address::parse("/m"));
    std::vector<bool> seen;
    auto handle = m.on_init_changed([&seen](bool done) { seen.push_back(done); });
    m.init();
    REQUIRE(seen == std::vector<bool>{false, true});
    REQUIRE(m.initialized());
}

/** An observer that registers after init hears the finished state at once (the old j.init end outlet). */
TEST_CASE("observer registering after init hears finished at once")
{
    World w;
    Model m(w.ns, Address::parse("/m"));
    REQUIRE_FALSE(m.initialized());
    std::vector<bool> early;
    auto before = m.on_init_changed([&early](bool done) { early.push_back(done); });
    REQUIRE(early.empty());
    m.init();
    std::vector<bool> late;
    auto after = m.on_init_changed([&late](bool done) { late.push_back(done); });
    REQUIRE(late == std::vector<bool>{true});
}

/** Dropping the handle unregisters the observer. */
TEST_CASE("observer handle unregisters")
{
    World w;
    Model m(w.ns, Address::parse("/m"));
    int calls = 0;
    {
        auto handle = m.on_init_changed([&calls](bool) { ++calls; });
        m.init();
        REQUIRE(calls == 2);
    }
    m.init();
    REQUIRE(calls == 2);
}

/** A second init runs everything again. */
TEST_CASE("second init runs again")
{
    World w;
    Model m(w.ns, Address::parse("/m"));
    w.add("/m/a");
    m.init();
    m.init();
    REQUIRE(w.log == std::vector<std::string>{"/m/a", "/m/a"});
}

/** The model is at its address and keeps description and priority. */
TEST_CASE("model attributes and address")
{
    World w;
    Model m(w.ns, Address::parse("/m"));
    m.set_description("a model");
    m.set_priority(4);
    REQUIRE(m.address().str() == "/m");
    REQUIRE(m.description() == "a model");
    REQUIRE(m.priority() == 4);
    Model second(w.ns, Address::parse("/m"));
    REQUIRE(second.address().str() == "/m.1");
}

/** A nested model runs its own init at its place among the parent's children. */
TEST_CASE("nested model inits inside its parent slot")
{
    World w;
    Model parent(w.ns, Address::parse("/m"));
    Model child(w.ns, Address::parse("/m/sub"));
    child.set_priority(1);
    w.add("/m/first", 0);
    w.add("/m/sub/inner", 0);
    w.add("/m/last", 2);
    parent.init();
    REQUIRE(w.log == std::vector<std::string>{"/m/first", "/m/sub/inner", "/m/last"});
}

/** Review Focus 1: a child removed by an earlier init is skipped, not called. */
TEST_CASE("data removed during init is skipped")
{
    World w;
    Model m(w.ns, Address::parse("/m"));
    Data& a = w.add("/m/a", 0);
    w.add("/m/b", 1);
    a.set_output([&w](const Value&) {
        w.log.push_back("/m/a");
        w.subscriptions[1] = Subscription(); // the later sibling unsubscribes while a initialises
    });
    m.init();
    REQUIRE(w.log == std::vector<std::string>{"/m/a"});
}

/** Review Focus 1: destroying the model first leaves its children registered and valid. */
TEST_CASE("model destroyed with children still registered leaves them valid")
{
    World w;
    w.add("/m/a");
    {
        Model m(w.ns, Address::parse("/m"));
        REQUIRE(w.ns.lookup(Address::parse("/m/a")) != nullptr);
    }
    REQUIRE(w.ns.lookup(Address::parse("/m/a")) != nullptr);
    REQUIRE(w.ns.lookup(Address::parse("/m"))->object() == nullptr);
    w.data[0]->command(Value{Atom(0.5)});
    REQUIRE(w.log.size() == 1);
}

/** The context map finds the model registered for a patcher, and the earliest if there are several. */
TEST_CASE("context map finds the model of a patcher")
{
    World w;
    Model a(w.ns, Address::parse("/a"));
    Model b(w.ns, Address::parse("/b"));
    jamoma::ContextMap map;
    int patcher_one = 0;
    int patcher_two = 0;
    REQUIRE(map.find(&patcher_one) == nullptr);
    map.add(&patcher_one, &a);
    map.add(&patcher_one, &b);
    map.add(&patcher_two, &b);
    REQUIRE(map.find(&patcher_one) == &a);
    REQUIRE(map.find(&patcher_two) == &b);
    map.remove(&patcher_one, &a);
    REQUIRE(map.find(&patcher_one) == &b);
    map.remove(&patcher_one, &a); // not registered any more: nothing happens
    map.remove(&patcher_one, &b);
    REQUIRE(map.find(&patcher_one) == nullptr);
}
