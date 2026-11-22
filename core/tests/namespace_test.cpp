// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file namespace_test.cpp
 * @brief Unit tests for the namespace tree and subscriptions (rules in docs/inventory/namespace.md).
 */

#include <catch2/catch_test_macros.hpp>

#include <atomic>
#include <memory>
#include <thread>
#include <utility>
#include <vector>

#include "jamoma/namespace.hpp"

using jamoma::Address;
using jamoma::Namespace;
using jamoma::Object;
using jamoma::Subscription;

namespace {

/** An object that records whether it has been destroyed. */
struct Probe : Object {
    /** @param flag Set to true when the probe is destroyed. */
    explicit Probe(bool* flag = nullptr) : destroyed(flag) {}
    ~Probe() override
    {
        if (destroyed) {
            *destroyed = true;
        }
    }
    bool* destroyed; /**< Where to record destruction, or null. */
};

} // namespace

/** Subscribing creates the nodes along the path; the ancestors have no object. */
TEST_CASE("subscribe creates nodes along the path")
{
    Namespace ns;
    Probe p;
    Subscription s = ns.subscribe(Address::parse("/m/p"), p);
    REQUIRE(ns.lookup(Address::parse("/m")) != nullptr);
    REQUIRE(ns.lookup(Address::parse("/m"))->object() == nullptr);
    REQUIRE(ns.lookup(Address::parse("/m/p"))->object() == &p);
    REQUIRE(s.address().str() == "/m/p");
    REQUIRE_FALSE(s.created_instance());
}

/** A second object under the same name becomes instance 1, a third instance 2. */
TEST_CASE("second object under same name gets an instance")
{
    Namespace ns;
    Probe a, b, c;
    Subscription sa = ns.subscribe(Address::parse("/m/p"), a);
    Subscription sb = ns.subscribe(Address::parse("/m/p"), b);
    Subscription sc = ns.subscribe(Address::parse("/m/p"), c);
    REQUIRE(sa.address().str() == "/m/p");
    REQUIRE(sb.address().str() == "/m/p.1");
    REQUIRE(sc.address().str() == "/m/p.2");
    REQUIRE_FALSE(sa.created_instance());
    REQUIRE(sb.created_instance());
    REQUIRE(sc.created_instance());
}

/** An explicit instance that is free is kept. */
TEST_CASE("explicit instance is kept when free")
{
    Namespace ns;
    Probe a;
    Subscription s = ns.subscribe(Address::parse("/m/p.4"), a);
    REQUIRE(s.address().str() == "/m/p.4");
    REQUIRE_FALSE(s.created_instance());
}

/** An explicit instance that is taken becomes the first free number, not the next higher one. */
TEST_CASE("explicit instance taken gets first free number")
{
    Namespace ns;
    Probe a, b;
    Subscription sa = ns.subscribe(Address::parse("/m/p.4"), a);
    Subscription sb = ns.subscribe(Address::parse("/m/p.4"), b);
    REQUIRE(sb.address().str() == "/m/p.1");
    REQUIRE(sb.created_instance());
}

/** A freed number is reused by the next duplicate, and a live instance never changes number. */
TEST_CASE("freed instance number is reused and live ones keep theirs")
{
    Namespace ns;
    Probe a, b, c, d;
    Subscription sa = ns.subscribe(Address::parse("/m/p"), a);
    auto sb = std::make_unique<Subscription>(ns.subscribe(Address::parse("/m/p"), b));
    Subscription sc = ns.subscribe(Address::parse("/m/p"), c);
    REQUIRE(sb->address().str() == "/m/p.1");
    REQUIRE(sc.address().str() == "/m/p.2");
    sb.reset();
    Subscription sd = ns.subscribe(Address::parse("/m/p"), d);
    REQUIRE(sd.address().str() == "/m/p.1");
    REQUIRE(sc.address().str() == "/m/p.2");
    REQUIRE(ns.lookup(Address::parse("/m/p.2"))->object() == &c);
    REQUIRE(ns.lookup(Address::parse("/m/p.1"))->object() == &d);
}

/** Review Focus 2: removing the first of two instances leaves the other at its own address. */
TEST_CASE("removing one of two instances keeps the other address")
{
    Namespace ns;
    Probe a, b;
    auto sa = std::make_unique<Subscription>(ns.subscribe(Address::parse("/m/p"), a));
    Subscription sb = ns.subscribe(Address::parse("/m/p"), b);
    sa.reset();
    REQUIRE(sb.address().str() == "/m/p.1");
    REQUIRE(ns.lookup(Address::parse("/m/p.1"))->object() == &b);
    REQUIRE(ns.lookup(Address::parse("/m/p")) == nullptr);
}

/** An object subscribing to a node that exists without an object attaches to it. */
TEST_CASE("subscribe attaches to a node without object")
{
    Namespace ns;
    Probe child, owner;
    Subscription sc = ns.subscribe(Address::parse("/m/p/x"), child);
    Subscription so = ns.subscribe(Address::parse("/m/p"), owner);
    REQUIRE(so.address().str() == "/m/p");
    REQUIRE_FALSE(so.created_instance());
    REQUIRE(ns.lookup(Address::parse("/m/p"))->object() == &owner);
}

/** Unsubscribing removes a childless node and prunes ancestors that have no object and no children. */
TEST_CASE("unsubscribe removes childless node and empty ancestors")
{
    Namespace ns;
    Probe a;
    {
        Subscription s = ns.subscribe(Address::parse("/a/b/c"), a);
        REQUIRE(ns.lookup(Address::parse("/a/b/c")) != nullptr);
    }
    REQUIRE(ns.lookup(Address::parse("/a/b/c")) == nullptr);
    REQUIRE(ns.lookup(Address::parse("/a/b")) == nullptr);
    REQUIRE(ns.lookup(Address::parse("/a")) == nullptr);
}

/** A node that has children only loses its object. */
TEST_CASE("unsubscribe keeps node that has children")
{
    Namespace ns;
    Probe owner, child;
    auto so = std::make_unique<Subscription>(ns.subscribe(Address::parse("/m"), owner));
    Subscription sc = ns.subscribe(Address::parse("/m/p"), child);
    so.reset();
    REQUIRE(ns.lookup(Address::parse("/m")) != nullptr);
    REQUIRE(ns.lookup(Address::parse("/m"))->object() == nullptr);
    REQUIRE(ns.lookup(Address::parse("/m/p"))->object() == &child);
}

/** An ancestor that has its own object survives the removal of its last child. */
TEST_CASE("unsubscribe keeps ancestors that have objects")
{
    Namespace ns;
    Probe owner, child;
    Subscription so = ns.subscribe(Address::parse("/m"), owner);
    {
        Subscription sc = ns.subscribe(Address::parse("/m/p"), child);
    }
    REQUIRE(ns.lookup(Address::parse("/m"))->object() == &owner);
    REQUIRE(ns.lookup(Address::parse("/m/p")) == nullptr);
}

/** Lookup of a missing address is null; directory and attribute parts are ignored. */
TEST_CASE("lookup ignores directory and attribute and misses cleanly")
{
    Namespace ns;
    Probe a;
    Subscription s = ns.subscribe(Address::parse("/m/p"), a);
    REQUIRE(ns.lookup(Address::parse("/m/q")) == nullptr);
    REQUIRE(ns.lookup(Address::parse("/m/p:range")) == ns.lookup(Address::parse("/m/p")));
    REQUIRE(ns.lookup(Address::parse("app:/m/p")) == ns.lookup(Address::parse("/m/p")));
    REQUIRE(ns.lookup(Address::parse("")) == nullptr);
}

/** The root can be looked up and can hold an object. */
TEST_CASE("root can hold an object")
{
    Namespace ns;
    Probe a;
    REQUIRE(ns.lookup(Address::parse("/")) == ns.root());
    Subscription s = ns.subscribe(Address::parse("/"), a);
    REQUIRE(ns.root()->object() == &a);
    REQUIRE(s.address().str() == "/");
}

/** A wildcard instance finds every instance of a name, including the one without instance. */
TEST_CASE("find with wildcard instance returns all instances")
{
    Namespace ns;
    Probe a, b, c, other;
    Subscription sa = ns.subscribe(Address::parse("/m/p"), a);
    Subscription sb = ns.subscribe(Address::parse("/m/p"), b);
    Subscription sc = ns.subscribe(Address::parse("/m/p"), c);
    Subscription so = ns.subscribe(Address::parse("/m/q"), other);
    REQUIRE(ns.find(Address::parse("/m/p.*")).size() == 3);
    REQUIRE(ns.find(Address::parse("/m/p.1")).size() == 1);
    REQUIRE(ns.find(Address::parse("/m/nothing.*")).empty());
}

/** A moved-from subscription no longer owns the registration; the moved-to one does. */
TEST_CASE("subscription survives move")
{
    Namespace ns;
    Probe a;
    Subscription first = ns.subscribe(Address::parse("/m/p"), a);
    Subscription second = std::move(first);
    REQUIRE(ns.lookup(Address::parse("/m/p")) != nullptr);
    {
        Subscription third = std::move(second);
        REQUIRE(ns.lookup(Address::parse("/m/p")) != nullptr);
    }
    REQUIRE(ns.lookup(Address::parse("/m/p")) == nullptr);
}

/** Review Focus 1: once the subscription is gone, lookup never returns the object. */
TEST_CASE("object freed after unsubscribe is never returned by lookup")
{
    Namespace ns;
    bool freed = false;
    {
        auto probe = std::make_unique<Probe>(&freed);
        Subscription s = ns.subscribe(Address::parse("/m/p"), *probe);
        REQUIRE(ns.lookup(Address::parse("/m/p"))->object() == probe.get());
    } // the subscription is destroyed first (declared after), then the probe
    REQUIRE(freed);
    REQUIRE(ns.lookup(Address::parse("/m/p")) == nullptr);
}

/** Review Focus 1: a subscription that outlives its namespace is destroyed without touching freed memory. */
TEST_CASE("subscription outliving its namespace is safe")
{
    Probe a;
    std::unique_ptr<Subscription> s;
    {
        Namespace ns;
        s = std::make_unique<Subscription>(ns.subscribe(Address::parse("/m/p"), a));
    }
    REQUIRE_NOTHROW(s.reset());
}

/** Directory and attribute parts of the subscribed address are ignored. */
TEST_CASE("subscribe ignores directory and attribute")
{
    Namespace ns;
    Probe a;
    Subscription s = ns.subscribe(Address::parse("app:/m/p:range"), a);
    REQUIRE(s.address().str() == "/m/p");
    REQUIRE(ns.lookup(Address::parse("/m/p"))->object() == &a);
}

/**
 * One thread subscribes and unsubscribes (the structure changes on one thread only) while two others look nodes up and search
 * with a pattern. Meant to be run under the thread sanitizer (nothing should be reported); the checks keep it honest otherwise.
 */
TEST_CASE("concurrent use is race free")
{
    Namespace ns;
    std::atomic<bool> stop{false};
    std::atomic<long> searches{0};
    auto reader = [&ns, &stop, &searches] {
        while (!stop.load()) {
            ns.lookup(Address::parse("/m/a"));
            ns.find(Address::parse("/m/*"));
            ++searches;
        }
    };
    std::thread first(reader);
    std::thread second(reader);
    std::vector<std::unique_ptr<Probe>> objects;
    for (int i = 0; i < 2000; ++i) {
        objects.push_back(std::make_unique<Probe>());
        Subscription s = ns.subscribe(Address::parse(i % 2 == 0 ? "/m/a" : "/m/b"), *objects.back());
        REQUIRE(s.node() != nullptr);
    }
    stop = true;
    first.join();
    second.join();
    REQUIRE(searches.load() > 0);
    REQUIRE(ns.lookup(Address::parse("/m/a")) == nullptr); // every subscription was released again
}

/** Observers hear an object appear (new node or attached to an existing empty node) and go. */
TEST_CASE("namespace observer hears created and destroyed")
{
    Namespace ns;
    struct Event {
        std::string address; /**< The address of the node. */
        bool created;        /**< Whether the object appeared. */
        bool has_object;     /**< Whether an object was passed. */
    };
    std::vector<Event> events;
    const auto handle = ns.observe(Address::parse("/m/a"), [&events](const Address& a, Object* o, bool created) {
        events.push_back({a.str(), created, o != nullptr});
    });
    Probe parent;
    Subscription holder = ns.subscribe(Address::parse("/m"), parent); // a node that is not /m/a: no event
    Probe a;
    {
        Subscription s = ns.subscribe(Address::parse("/m/a"), a);
        REQUIRE(events.size() == 1);
    }
    REQUIRE(events.size() == 2);
    REQUIRE(events[0].created);
    REQUIRE(events[0].has_object);
    REQUIRE(events[0].address == "/m/a");
    REQUIRE_FALSE(events[1].created);
    REQUIRE_FALSE(events[1].has_object);
    // An object attached to a node that already exists without one counts as created.
    Probe child;
    Subscription kid = ns.subscribe(Address::parse("/m/a/x"), child); // creates /m/a without an object
    REQUIRE(events.size() == 2);
    Subscription late = ns.subscribe(Address::parse("/m/a"), a);
    REQUIRE(events.size() == 3);
    REQUIRE(events[2].created);
}

/** A pattern with an instance of `*` sees every instance. */
TEST_CASE("namespace observer wildcard")
{
    Namespace ns;
    std::vector<std::string> seen;
    const auto handle = ns.observe(Address::parse("/m/*"), [&seen](const Address& a, Object*, bool created) {
        if (created) {
            seen.push_back(a.str());
        }
    });
    Probe a, b, c, other;
    Subscription sa = ns.subscribe(Address::parse("/m/a"), a);
    Subscription sb = ns.subscribe(Address::parse("/m/b"), b);
    Subscription sc = ns.subscribe(Address::parse("/m/b"), c); // /m/b.1
    Subscription so = ns.subscribe(Address::parse("/n/a"), other);
    REQUIRE(seen == std::vector<std::string>{"/m/a", "/m/b", "/m/b.1"});
}

/** An observer may unregister itself and subscribe in its callback; dropping the handle stops the events. */
TEST_CASE("observer may unsubscribe itself in its callback")
{
    Namespace ns;
    int calls = 0;
    std::shared_ptr<void> handle;
    Probe a, b, c;
    Subscription inner;
    handle = ns.observe(Address::parse("/m/*"), [&](const Address&, Object*, bool created) {
        ++calls;
        if (created && calls == 1) {
            handle.reset();
            inner = ns.subscribe(Address::parse("/m/inner"), c); // subscribing inside a callback must not deadlock
        }
    });
    Subscription sa = ns.subscribe(Address::parse("/m/a"), a);
    Subscription sb = ns.subscribe(Address::parse("/m/b"), b);
    REQUIRE(calls == 1);
}

/** The thread sanitizer sees no race between changes, lookups and observers. */
TEST_CASE("concurrent observers are race free")
{
    Namespace ns;
    std::atomic<bool> stop{false};
    std::atomic<long> rounds{0};
    std::thread watcher([&] {
        while (!stop.load()) {
            const auto handle = ns.observe(Address::parse("/m/*"), [](const Address&, Object*, bool) {});
            ns.lookup(Address::parse("/m/a"));
            ++rounds;
        }
    });
    std::vector<std::unique_ptr<Probe>> objects;
    for (int n = 0; n < 1000; ++n) {
        objects.push_back(std::make_unique<Probe>());
        Subscription s = ns.subscribe(Address::parse(n % 2 == 0 ? "/m/a" : "/m/b"), *objects.back());
        REQUIRE(s.node() != nullptr);
    }
    stop = true;
    watcher.join();
    REQUIRE(rounds.load() > 0);
}

/** A name of a star matches every child, whatever its instance, and works on any level of the path. */
TEST_CASE("find with wildcard name")
{
    Namespace ns;
    Probe a, b, c, d;
    Subscription sa = ns.subscribe(Address::parse("/m/a"), a);
    Subscription sb = ns.subscribe(Address::parse("/m/b"), b);
    Subscription sc = ns.subscribe(Address::parse("/m/b"), c); // /m/b.1
    Subscription sd = ns.subscribe(Address::parse("/n/a"), d);
    REQUIRE(ns.find(Address::parse("/m/*")).size() == 3);
    REQUIRE(ns.find(Address::parse("/*/a")).size() == 2);
    REQUIRE(ns.find(Address::parse("/m/b.1")).size() == 1);
    REQUIRE(ns.find(Address::parse("/x/*")).empty());
}
