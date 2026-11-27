// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file explorer_test.cpp
 * @brief Unit tests for the model explorer.
 */

#include <catch2/catch_test_macros.hpp>

#include <atomic>
#include <memory>
#include <string>
#include <thread>
#include <vector>

#include "jamoma/data.hpp"
#include "jamoma/explorer.hpp"
#include "jamoma/model.hpp"

using jamoma::Address;
using jamoma::Data;
using jamoma::DataType;
using jamoma::ModelExplorer;
using jamoma::Service;

namespace {

/** A namespace, some data objects, and an explorer that counts changes. */
struct Rig {
    jamoma::Namespace ns;                                   /**< The namespace. */
    std::vector<std::unique_ptr<Data>> data;                /**< The data objects. */
    std::vector<jamoma::Subscription> subscriptions;        /**< Their registrations. */
    int changes = 0;                                        /**< How often the explorer reported. */
    ModelExplorer explorer{ns, [this] { ++changes; }};      /**< The explorer under test. */

    /** Adds a data object. @param address Where. @param priority Its priority. @param service Its service. @return The index. */
    std::size_t add(const std::string& address, int priority = 0, Service service = Service::Parameter)
    {
        data.push_back(std::make_unique<Data>(service));
        data.back()->set_type(DataType::Decimal);
        data.back()->set_priority(priority);
        subscriptions.push_back(ns.subscribe(Address::parse(address), *data.back()));
        return data.size() - 1;
    }
};

} // namespace

/** Parameters, messages and returns are listed apart, by priority and then name. */
TEST_CASE("explorer lists parameters messages returns sorted")
{
    Rig r;
    jamoma::Model model(r.ns, Address::parse("/m"));
    r.add("/m/b");
    r.add("/m/a");
    r.add("/m/z", -1);
    r.add("/m/y", 2);
    r.add("/m/go", 0, Service::Message);
    r.add("/m/out", 0, Service::Return);
    r.add("/m/sub/x");
    r.explorer.set_model(Address::parse("/m"));
    const auto c = r.explorer.contents();
    REQUIRE(c.parameters == std::vector<std::string>{"z", "y", "a", "b", "sub/x"}); // priority 0 (none) comes last
    REQUIRE(c.messages == std::vector<std::string>{"go"});
    REQUIRE(c.returns == std::vector<std::string>{"out"});
    model.presets().new_preset("p");
    REQUIRE(r.explorer.contents().presets == std::vector<std::string>{"p"});
}

/** A node coming or going below the model is reported. */
TEST_CASE("explorer follows new and removed nodes")
{
    Rig r;
    jamoma::Model model(r.ns, Address::parse("/m"));
    r.explorer.set_model(Address::parse("/m"));
    r.changes = 0;
    const std::size_t i = r.add("/m/a");
    REQUIRE(r.changes >= 1);
    REQUIRE(r.explorer.contents().parameters.size() == 1);
    const int before = r.changes;
    r.subscriptions[i] = jamoma::Subscription();
    REQUIRE(r.changes > before);
    REQUIRE(r.explorer.contents().parameters.empty());
}

/** The model appearing later, and going, are followed; its presets too. */
TEST_CASE("explorer follows the model appearing and going")
{
    Rig r;
    r.explorer.set_model(Address::parse("/m"));
    REQUIRE(r.explorer.contents().parameters.empty());
    auto model = std::make_unique<jamoma::Model>(r.ns, Address::parse("/m"));
    REQUIRE(r.changes >= 1);
    r.add("/m/a");
    REQUIRE(r.explorer.contents().parameters.size() == 1);
    const int before = r.changes;
    model->presets().new_preset("one");
    REQUIRE(r.changes > before);
    REQUIRE(r.explorer.contents().presets.size() == 1);
    r.subscriptions.clear();
    model.reset();
    REQUIRE(r.explorer.contents().presets.empty());
    REQUIRE(r.explorer.contents().parameters.empty());
}

/** Hundreds of parameters come back in order. */
TEST_CASE("hundreds of parameters are listed in order")
{
    Rig r;
    jamoma::Model model(r.ns, Address::parse("/m"));
    r.explorer.set_model(Address::parse("/m"));
    for (int i = 0; i < 500; ++i) {
        char name[32];
        std::snprintf(name, sizeof name, "/m/p%04d", 499 - i);
        r.add(name);
    }
    const auto c = r.explorer.contents();
    REQUIRE(c.parameters.size() == 500);
    REQUIRE(c.parameters.front() == "p0000");
    REQUIRE(c.parameters.back() == "p0499");
}

/** The callback may destroy the explorer. */
TEST_CASE("teardown inside on change is safe")
{
    jamoma::Namespace ns;
    std::unique_ptr<ModelExplorer> explorer;
    explorer = std::make_unique<ModelExplorer>(ns, [&explorer] { explorer.reset(); });
    explorer->set_model(Address::parse("/m"));
    Data d;
    auto subscription = ns.subscribe(Address::parse("/m/a"), d);
    REQUIRE(explorer == nullptr);
}

/** Reading the contents while another thread adds and removes nodes (the sanitizer builds are the ones that can fail this). */
TEST_CASE("contents while nodes change is race free")
{
    Rig r;
    jamoma::Model model(r.ns, Address::parse("/m"));
    r.explorer.set_model(Address::parse("/m"));
    std::atomic<bool> stop{false};
    std::thread worker([&r, &stop] {
        std::vector<std::unique_ptr<Data>> data;
        for (int i = 0; i < 300 && !stop; ++i) {
            auto d = std::make_unique<Data>();
            auto s = r.ns.subscribe(Address::parse("/m/t" + std::to_string(i % 20)), *d);
            data.push_back(std::move(d));
            s = jamoma::Subscription();
            data.clear();
        }
    });
    std::size_t seen = 0;
    for (int i = 0; i < 300; ++i) {
        seen += r.explorer.contents().parameters.size();
    }
    stop = true;
    worker.join();
    REQUIRE(seen >= 0);
}

/** Data tagged `generic` (as the amenities) is listed apart from the model's own (the two kinds of sections of the panel's menu). */
TEST_CASE("explorer lists generic data apart")
{
    Rig r;
    jamoma::Model model(r.ns, Address::parse("/m"));
    r.add("/m/own");
    const std::size_t p = r.add("/m/data/active");
    const std::size_t m = r.add("/m/data/do", 0, Service::Message);
    const std::size_t o = r.add("/m/data/got", 0, Service::Return);
    for (const std::size_t i : {p, m, o}) {
        r.data[i]->set_tags({"generic"});
    }
    r.explorer.set_model(Address::parse("/m"));
    const auto c = r.explorer.contents();
    REQUIRE(c.parameters == std::vector<std::string>{"own"});
    REQUIRE(c.messages.empty());
    REQUIRE(c.returns.empty());
    REQUIRE(c.generic_parameters == std::vector<std::string>{"data/active"});
    REQUIRE(c.generic_messages == std::vector<std::string>{"data/do"});
    REQUIRE(c.generic_returns == std::vector<std::string>{"data/got"});
}
