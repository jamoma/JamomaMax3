// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

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

/** As the old objects: priority 0 means none, and comes after every other priority. */
TEST_CASE("priority zero is initialised last")
{
    World w;
    Model m(w.ns, Address::parse("/m"));
    w.add("/m/aaa", 0);
    w.add("/m/zzz", 3);
    w.add("/m/mmm", 1);
    m.init();
    REQUIRE(w.log == std::vector<std::string>{"/m/mmm", "/m/zzz", "/m/aaa"});
}

/** Parameters are initialised in order of priority, lowest first. */
TEST_CASE("init visits parameters in priority order")
{
    World w;
    Model m(w.ns, Address::parse("/m"));
    w.add("/m/a", 2);
    w.add("/m/b", 0);
    w.add("/m/c", 1);
    m.init();
    REQUIRE(w.log == std::vector<std::string>{"/m/c", "/m/a", "/m/b"});
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
    child.set_priority(2);
    w.add("/m/first", 1);
    w.add("/m/sub/inner", 0);
    w.add("/m/last", 3);
    parent.init();
    REQUIRE(w.log == std::vector<std::string>{"/m/first", "/m/sub/inner", "/m/last"});
}

/** Review Focus 1: a child removed by an earlier init is skipped, not called. */
TEST_CASE("data removed during init is skipped")
{
    World w;
    Model m(w.ns, Address::parse("/m"));
    Data& a = w.add("/m/a", 1);
    w.add("/m/b", 2);
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

/** The context map tells observers when a model is registered for a patcher or removed; the handle stops it. */
TEST_CASE("context map observer hears add and remove")
{
    World w;
    Model a(w.ns, Address::parse("/a"));
    jamoma::ContextMap map;
    int patcher = 0;
    std::vector<std::string> events;
    auto handle = map.observe([&events, &patcher, &a](const void* p, Model* m, bool added) {
        events.push_back(std::string(p == &patcher ? "patcher " : "other ") + (m == &a ? "a " : "?") + (added ? "added" : "removed"));
    });
    map.add(&patcher, &a);
    map.remove(&patcher, &a);
    map.remove(&patcher, &a); // nothing there: no event
    REQUIRE(events == std::vector<std::string>{"patcher a added", "patcher a removed"});
    handle.reset();
    map.add(&patcher, &a);
    REQUIRE(events.size() == 2);
}

/** An observer of the context map may drop its own handle, and the handle may outlive the map. */
TEST_CASE("context map observer may unregister itself and outlive the map")
{
    World w;
    Model a(w.ns, Address::parse("/a"));
    int patcher = 0;
    int calls = 0;
    std::shared_ptr<void> survivor;
    {
        jamoma::ContextMap map;
        std::shared_ptr<void> handle;
        handle = map.observe([&](const void*, Model*, bool) {
            ++calls;
            handle.reset();
        });
        map.add(&patcher, &a);
        map.add(&patcher, &a);
        REQUIRE(calls == 1);
        survivor = map.observe([](const void*, Model*, bool) {});
    }
    REQUIRE_NOTHROW(survivor.reset());
}

/** The model owns a preset manager for its own address, so everything that knows the model can reach its presets. */
TEST_CASE("model owns its preset manager")
{
    World w;
    Model m(w.ns, Address::parse("/m"));
    w.add("/m/a", 0);
    w.data[0]->command({2.0});
    REQUIRE(m.presets().new_preset("one"));
    REQUIRE(m.presets().presets().at(0).entries.at(0).address.str() == "a");
    Model second(w.ns, Address::parse("/m")); // becomes /m.1: its manager looks below its own address
    REQUIRE(second.address() != m.address());
    REQUIRE(second.presets().new_preset("x"));
    REQUIRE(second.presets().presets().at(0).entries.empty());
}

/** The context map lists its registrations in order. */
TEST_CASE("context map lists its entries")
{
    World w;
    Model a(w.ns, Address::parse("/a"));
    Model b(w.ns, Address::parse("/b"));
    int p1 = 0;
    int p2 = 0;
    jamoma::ContextMap map;
    map.add(&p1, &a);
    map.add(&p2, &b);
    const auto all = map.all();
    REQUIRE(all.size() == 2);
    REQUIRE(all[0].first == &p1);
    REQUIRE(all[1].second == &b);
}

/** A view is known by its patcher and the model argument it was given. */
TEST_CASE("view map keeps the argument of a view")
{
    jamoma::ViewMap map;
    int p = 0;
    int q = 0;
    map.add(&p, "/qmetro");
    REQUIRE(map.find(&p).has_value());
    REQUIRE(*map.find(&p) == "/qmetro");
    REQUIRE_FALSE(map.find(&q).has_value());
    map.remove(&p);
    REQUIRE_FALSE(map.find(&p).has_value());
}

/** A view can be given another model address; observers are told which view changed, once per change. */
TEST_CASE("view map changes the address of a view and tells its observers")
{
    jamoma::ViewMap map;
    int p = 0;
    int q = 0;
    std::vector<const void*> told;
    auto handle = map.observe([&](const void* patcher) { told.push_back(patcher); });
    map.add(&p, "/one");
    REQUIRE(map.set_argument(&p, "/two"));
    REQUIRE(*map.find(&p) == "/two");
    REQUIRE(told == std::vector<const void*>{&p});

    REQUIRE_FALSE(map.set_argument(&p, "/two")); // unchanged
    REQUIRE_FALSE(map.set_argument(&q, "/two")); // no view there
    REQUIRE_FALSE(map.find(&q).has_value());
    REQUIRE(told.size() == 1);

    handle.reset();
    REQUIRE(map.set_argument(&p, "/three"));
    REQUIRE(told.size() == 1);
}

/** The observer may call the map and outlive it. */
TEST_CASE("view map observers may call the map and their handles may outlive it")
{
    std::shared_ptr<void> handle;
    {
        jamoma::ViewMap map;
        int p = 0;
        std::string seen;
        handle = map.observe([&](const void* patcher) { seen = map.find(patcher).value_or(""); });
        map.add(&p, "/one");
        map.set_argument(&p, "/two");
        REQUIRE(seen == "/two");
    }
    handle.reset();
}
