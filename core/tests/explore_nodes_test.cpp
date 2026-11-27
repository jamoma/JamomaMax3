// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file explore_nodes_test.cpp
 * @brief Unit tests for the exploration of the namespace by j.namespace (docs/inventory/j.namespace.md).
 */

#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <atomic>
#include <memory>
#include <thread>
#include <vector>

#include "jamoma/data.hpp"
#include "jamoma/explore.hpp"

using jamoma::Address;
using jamoma::ExploreFormat;
using jamoma::ExploreOptions;
using jamoma::ExploreOutput;
using jamoma::ExploreSort;
using jamoma::OutMessage;
using jamoma::Value;

namespace {

/** A namespace with some parameters, each registered through its own subscription. */
struct Tree {
    jamoma::Namespace ns;                                       /**< The namespace. */
    std::vector<std::unique_ptr<jamoma::Data>> data;            /**< The objects. */
    std::vector<jamoma::Subscription> subscriptions;            /**< Their registrations. */

    /** @brief Registers a parameter. @param address Where. @param priority Its initialisation priority. */
    void add(const char* address, int priority = 0)
    {
        auto d = std::make_unique<jamoma::Data>(jamoma::Service::Parameter);
        d->set_priority(priority);
        subscriptions.push_back(ns.subscribe(Address::parse(address), *d));
        data.push_back(std::move(d));
    }
};

/** @return The tree of most tests: /m/audio/gain, /m/audio/mute, /m/freq, /m/q, /m.1/freq, and the objects /m and /m.1 themselves. */
std::unique_ptr<Tree> sample()
{
    auto t = std::make_unique<Tree>();
    t->add("/m");
    t->add("/m/freq", 2);
    t->add("/m/audio/gain", 1);
    t->add("/m/audio/mute", 3);
    t->add("/m/q", 0);
    t->add("/m.1");
    t->add("/m.1/freq");
    return t;
}

/** @param items Text items. @return The same as a vector (for the checks). */
std::vector<std::string> v(std::initializer_list<const char*> items) { return {items.begin(), items.end()}; }

} // namespace

/** Descendants lists every object below relative to the address. */
TEST_CASE("explore_descendants_lists_every_object_below_relative_to_the_address", "[explore]")
{
    auto t = sample();
    const auto r = jamoma::explore(t->ns, Address::parse("/m"), {});
    CHECK(r.found);
    CHECK(r.items == v({"audio/gain", "audio/mute", "freq", "q"})); // /m/audio has no object: not an item; alphabetic is the default
}

/** Depth limits the levels. */
TEST_CASE("explore_depth_limits_the_levels", "[explore]")
{
    auto t = sample();
    ExploreOptions o;
    o.depth = 1;
    CHECK(jamoma::explore(t->ns, Address::parse("/m"), o).items == v({"freq", "q"}));
    o.depth = 2;
    CHECK(jamoma::explore(t->ns, Address::parse("/m"), o).items.size() == 4);
}

/** Children lists direct nodes with an object. */
TEST_CASE("explore_children_lists_direct_nodes_with_an_object", "[explore]")
{
    auto t = sample();
    ExploreOptions o;
    o.output = ExploreOutput::Children;
    CHECK(jamoma::explore(t->ns, Address::parse("/m"), o).items == v({"freq", "q"}));
    CHECK(jamoma::explore(t->ns, Address::parse("/"), o).items == v({"m"})); // the name part only, repetitions removed: m and m.1 are one
}

/** Brothers lists the instances of the same name. */
TEST_CASE("explore_brothers_lists_the_instances_of_the_same_name", "[explore]")
{
    auto t = sample();
    t->add("/m.2");
    ExploreOptions o;
    o.output = ExploreOutput::Brothers;
    CHECK(jamoma::explore(t->ns, Address::parse("/m.1"), o).items == v({"0", "1", "2"})); // /m has no instance: 0
    CHECK(jamoma::explore(t->ns, Address::parse("/freq"), o).items.empty());
}

/** Attributes lists the attributes of the node. */
TEST_CASE("explore_attributes_lists_the_attributes_of_the_node", "[explore]")
{
    auto t = sample();
    ExploreOptions o;
    o.output = ExploreOutput::Attributes;
    const auto r = jamoma::explore(t->ns, Address::parse("/m/freq"), o);
    CHECK(r.found);
    CHECK(r.items.size() == jamoma::Data::attribute_names().size());
    CHECK(std::is_sorted(r.items.begin(), r.items.end()));
    CHECK(std::find(r.items.begin(), r.items.end(), "range") != r.items.end());
    o.output = ExploreOutput::Attributes;
    CHECK(jamoma::explore(t->ns, Address::parse("/m/audio"), o).items.empty()); // a node without object has none
}

/** Sort priority then name. */
TEST_CASE("explore_sort_priority_then_name", "[explore]")
{
    auto t = sample();
    ExploreOptions o;
    o.sort = ExploreSort::Priority;
    CHECK(jamoma::explore(t->ns, Address::parse("/m"), o).items == v({"audio/gain", "freq", "audio/mute", "q"})); // q has priority 0 (none): last
    o.sort = ExploreSort::Alphabetic;
    CHECK(jamoma::explore(t->ns, Address::parse("/m"), o).items == v({"audio/gain", "audio/mute", "freq", "q"}));
}

/** Nonexistent address finds nothing. */
TEST_CASE("explore_nonexistent_address_finds_nothing", "[explore]")
{
    auto t = sample();
    const auto r = jamoma::explore(t->ns, Address::parse("/nothing/here"), {});
    CHECK_FALSE(r.found);
    CHECK(r.items.empty());
    CHECK(jamoma::explore(t->ns, Address(), {}).found); // the empty address is the root
}

/** Is stable while nodes come and go. */
TEST_CASE("explore_is_stable_while_nodes_come_and_go", "[explore]")
{
    auto t = sample();
    std::atomic<bool> stop{false};
    std::thread churn([&] {
        jamoma::Data d(jamoma::Service::Parameter);
        while (!stop) {
            auto s = t->ns.subscribe(Address::parse("/m/temp"), d);
        }
    });
    for (int i = 0; i < 2000; ++i) {
        const auto r = jamoma::explore(t->ns, Address::parse("/m"), {});
        REQUIRE(r.items.size() >= 4);
        REQUIRE(r.items.size() <= 5);
    }
    stop = true;
    churn.join();
}

/** Item keys are absolute addresses. */
TEST_CASE("explore_item_keys_are_absolute_addresses", "[explore]")
{
    CHECK(jamoma::item_key(ExploreOutput::Descendants, Address::parse("/m"), "audio/gain") == "/m/audio/gain");
    CHECK(jamoma::item_key(ExploreOutput::Descendants, Address::parse("/"), "m/freq") == "/m/freq");
    CHECK(jamoma::item_key(ExploreOutput::Children, Address::parse("/m"), "freq") == "/m/freq");
    CHECK(jamoma::item_key(ExploreOutput::Attributes, Address::parse("/m/freq"), "range") == "/m/freq:range");
    CHECK(jamoma::item_key(ExploreOutput::Brothers, Address::parse("/m.1"), "2") == "/m.2");
    CHECK(jamoma::item_key(ExploreOutput::Brothers, Address::parse("/m.1"), "0") == "/m");
}

/** Format none lists items in one message. */
TEST_CASE("explore_format_none_lists_items_in_one_message", "[explore]")
{
    const auto m = jamoma::format_items(ExploreFormat::None, ExploreOutput::Descendants, Address::parse("/m"), v({"a", "b"}));
    CHECK(m == std::vector<OutMessage>{{"", Value{"a", "b"}}});
    CHECK(jamoma::format_items(ExploreFormat::None, ExploreOutput::Descendants, Address::parse("/m"), {}).empty());
}

/** Format umenu. */
TEST_CASE("explore_format_umenu", "[explore]")
{
    const auto m = jamoma::format_items(ExploreFormat::Umenu, ExploreOutput::Descendants, Address::parse("/m"), v({"a", "b"}));
    CHECK(m == std::vector<OutMessage>{{"clear", {}}, {"append", Value{"a"}}, {"append", Value{"b"}}});
}

/** Format umenu prefix depends on the output. */
TEST_CASE("explore_format_umenu_prefix_depends_on_the_output", "[explore]")
{
    auto prefix = [](ExploreOutput o, const char* address) {
        const auto m = jamoma::format_items(ExploreFormat::UmenuPrefix, o, Address::parse(address), {});
        REQUIRE(m.size() == 3);
        CHECK(m[0] == OutMessage{"clear", {}});
        CHECK(m[1] == OutMessage{"prefix_mode", Value{0}});
        return m[2].args.at(0).as_symbol();
    };
    CHECK(prefix(ExploreOutput::Descendants, "/m") == "/m/");
    CHECK(prefix(ExploreOutput::Children, "/m") == "/m/");
    CHECK(prefix(ExploreOutput::Brothers, "/m.1") == "/m.1.");
    CHECK(prefix(ExploreOutput::Attributes, "/m/freq") == "/m/freq:");
    CHECK(prefix(ExploreOutput::Descendants, "/") == "/");
    CHECK(prefix(ExploreOutput::Attributes, "/") == "/:");
}

/** Format jit cellblock and coll. */
TEST_CASE("explore_format_jit_cellblock_and_coll", "[explore]")
{
    const auto cell = jamoma::format_items(ExploreFormat::JitCellblock, ExploreOutput::Descendants, Address::parse("/m"), v({"a", "b"}));
    CHECK(cell == std::vector<OutMessage>{{"clear", Value{"all"}}, {"rows", Value{2}}, {"set", Value{0, 0, "a"}}, {"set", Value{0, 1, "b"}}});
    const auto coll = jamoma::format_items(ExploreFormat::Coll, ExploreOutput::Descendants, Address::parse("/m"), v({"a", "b"}));
    CHECK(coll == std::vector<OutMessage>{{"clear", {}}, {"store", Value{"a", 0}}, {"store", Value{"b", 0}}});
}

/** Format selection. */
TEST_CASE("explore_format_selection", "[explore]")
{
    const std::vector<bool> flags{true, false};
    CHECK(jamoma::format_selection(ExploreFormat::None, flags) == std::vector<OutMessage>{{"selection", Value{1, 0}}});
    CHECK(jamoma::format_selection(ExploreFormat::Umenu, flags)
          == std::vector<OutMessage>{{"clearchecks", {}}, {"checkitem", Value{0, 1}}, {"checkitem", Value{1, 0}}});
    CHECK(jamoma::format_selection(ExploreFormat::JitCellblock, flags)
          == std::vector<OutMessage>{{"cell", Value{0, 0, "brgb", 158, 0, 92}}, {"cell", Value{0, 1, "brgb", 0, 0, 0}}});
    CHECK(jamoma::format_selection(ExploreFormat::Coll, flags).empty());
}

/** Selection is shared by name. */
TEST_CASE("explore_selection_is_shared_by_name", "[explore]")
{
    auto a = jamoma::Selection::named("shared_test");
    auto b = jamoma::Selection::named("shared_test");
    CHECK(a == b);
    a->set("/m/freq", true);
    CHECK(b->is_selected("/m/freq"));
    CHECK(jamoma::Selection::named("none") != jamoma::Selection::named("none")); // each "none" is private
    CHECK(jamoma::Selection::named("") != jamoma::Selection::named(""));
    a->clear();
}

/** Selection toggle set all and selected. */
TEST_CASE("explore_selection_toggle_set_all_and_selected", "[explore]")
{
    auto s = jamoma::Selection::named("toggle_test");
    s->clear();
    CHECK(s->toggle("/b"));
    CHECK_FALSE(s->toggle("/b"));
    s->set_all({"/c", "/a"}, true);
    CHECK(s->selected() == v({"/a", "/c"}));
    s->set_all({"/a"}, false);
    CHECK(s->selected() == v({"/c"}));
    s->clear();
    CHECK(s->selected().empty());
}
