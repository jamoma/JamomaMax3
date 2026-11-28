// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file explore_filter_test.cpp
 * @brief Unit tests for the filters of j.namespace.
 */

#include <catch2/catch_test_macros.hpp>

#include <memory>
#include <string>
#include <vector>

#include "jamoma/data.hpp"
#include "jamoma/explore.hpp"
#include "jamoma/explore_filter.hpp"
#include "jamoma/model.hpp"

using jamoma::Address;
using jamoma::Data;
using jamoma::ExploreFilters;
using jamoma::Service;
using jamoma::Value;

namespace {

/** A model with a parameter, a message, a return, a generic parameter and a model inside it. */
struct World {
    jamoma::Namespace ns;                                 /**< The namespace. */
    jamoma::Model model{ns, Address::parse("/synth")};    /**< The model. */
    jamoma::Model inner{ns, Address::parse("/synth/filter")}; /**< A model inside it. */
    std::vector<std::unique_ptr<Data>> data;              /**< The data objects. */
    std::vector<jamoma::Subscription> subscriptions;      /**< Their registrations. */

    World()
    {
        add("/synth/gain", Service::Parameter);
        add("/synth/reset", Service::Message);
        add("/synth/level", Service::Return);
        add("/synth/data/active", Service::Parameter)->set_tags({"generic"});
        add("/synth/filter/cutoff.2", Service::Parameter);
    }

    /** @param address Where. @param service Which service. @return The new object. */
    Data* add(const char* address, Service service)
    {
        data.push_back(std::make_unique<Data>(service));
        subscriptions.push_back(ns.subscribe(Address::parse(address), *data.back()));
        return data.back().get();
    }

    /** @param filters The filters. @return The descendants of the root that pass them. */
    std::vector<std::string> found(const ExploreFilters& filters) const
    {
        jamoma::ExploreOptions options;
        options.filters = &filters;
        return jamoma::explore(ns, Address::parse("/"), options).items;
    }
};

using Names = std::vector<std::string>; /**< A list of addresses. */

} // namespace

/** Nothing in use: everything passes. */
TEST_CASE("explore_filter_none_in_use_lists_everything", "[explore_filter]")
{
    const World w;
    const ExploreFilters f;
    CHECK(f.empty());
    CHECK(w.found(f).size() == 7);
}

/** The two filters the browser window uses. */
TEST_CASE("explore_filter_data_and_model", "[explore_filter]")
{
    const World w;
    ExploreFilters f;
    f.set_list(Value{"data"});
    CHECK(w.found(f) == Names{"synth/data/active", "synth/filter/cutoff.2", "synth/gain", "synth/level", "synth/reset"});
    f.set_list(Value{"model"});
    CHECK(w.found(f) == Names{"synth", "synth/filter"});
    CHECK(f.list() == Value{"model"});
}

/** Filters on the service and on tags. */
TEST_CASE("explore_filter_services_and_tags", "[explore_filter]")
{
    const World w;
    ExploreFilters f;
    f.set_list(Value{"message"});
    CHECK(w.found(f) == Names{"synth/reset"});
    f.set_list(Value{"return"});
    CHECK(w.found(f) == Names{"synth/level"});
    f.set_list(Value{"parameter", "noGenericTag"});
    CHECK(w.found(f) == Names{"synth/filter/cutoff.2", "synth/gain"});
    f.set_list(Value{"genericTag"});
    CHECK(w.found(f) == Names{"synth/data/active"});
    f.set_list(Value{"view"});
    CHECK(w.found(f).empty());
}

/** The search field of the browser window: parts of the address, one rule per word. */
TEST_CASE("explore_filter_set_parts_restrict_each_other", "[explore_filter]")
{
    const World w;
    ExploreFilters f;
    f.set_list(Value{"data"});
    REQUIRE(f.set(Value{"livesearch.0", "part", "filt", "mode", "restrict"}));
    CHECK(f.list() == Value{"data", "livesearch.0"});
    CHECK(w.found(f) == Names{"synth/filter/cutoff.2"});
    REQUIRE(f.set(Value{"livesearch.1", "part", "gain", "mode", "restrict"}));
    CHECK(w.found(f).empty());
    f.remove(Value{"livesearch.1"});
    f.remove(Value{"livesearch.0"});
    CHECK(w.found(f).size() == 5);
}

/** name, instance and parent. */
TEST_CASE("explore_filter_name_instance_and_parent", "[explore_filter]")
{
    const World w;
    ExploreFilters f;
    REQUIRE(f.set(Value{"a", "name", "cut"}));
    CHECK(w.found(f) == Names{"synth/filter/cutoff.2"});
    f.remove(Value{});
    REQUIRE(f.set(Value{"b", "name", "utoff"})); // a name has to match at its start
    CHECK(w.found(f).empty());
    f.remove(Value{});
    REQUIRE(f.set(Value{"c", "instance", 2}));
    CHECK(w.found(f) == Names{"synth/filter/cutoff.2"});
    f.remove(Value{});
    REQUIRE(f.set(Value{"d", "parent", "data"}));
    CHECK(w.found(f) == Names{"synth/data/active"});
}

/** The other ways of combining. */
TEST_CASE("explore_filter_include_exclude_hamlet", "[explore_filter]")
{
    const World w;
    ExploreFilters f;
    f.set_list(Value{"model"});
    REQUIRE(f.set(Value{"more", "name", "gain", "mode", "include"}));
    CHECK(w.found(f) == Names{"synth", "synth/filter", "synth/gain"}); // include adds to what the rules before let through
    f.remove(Value{});
    f = ExploreFilters();
    REQUIRE(f.set(Value{"not", "part", "filter", "mode", "exclude"}));
    CHECK(w.found(f).size() == 5);
}

/** Removing and asking. */
TEST_CASE("explore_filter_remove_and_info", "[explore_filter]")
{
    ExploreFilters f;
    REQUIRE(f.set(Value{"x", "part", "a", "mode", "exclude"}));
    CHECK(f.info("x") == std::optional<Value>(Value{"x", "part", "a", "mode", "exclude"}));
    CHECK_FALSE(f.info("nothing"));
    f.set_list(Value{"data", "x"});
    f.remove(Value{}); // forgets every filter in use, the ready-made data included
    CHECK(f.empty());
    CHECK_FALSE(f.info("data"));
    CHECK(f.info("model"));
}

/** Bad rules change nothing. */
TEST_CASE("explore_filter_rejects_bad_rules", "[explore_filter]")
{
    ExploreFilters f;
    for (const Value& bad : {Value{}, Value{3, "part", "a"}, Value{"x", "part"}, Value{"x", "colour", "red"}, Value{"x", "part", "("}, Value{"x"}}) {
        CHECK_FALSE(f.set(bad));
    }
    CHECK(f.empty());
    CHECK_FALSE(f.info("x"));
}
