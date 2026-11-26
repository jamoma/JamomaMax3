// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file mapper_test.cpp
 * @brief Unit tests for the mapper of j.map (docs/inventory/j.map.md).
 */

#include <catch2/catch_approx.hpp>
#include <catch2/catch_test_macros.hpp>

#include <cmath>
#include <functional>
#include <limits>
#include <string>
#include <utility>
#include <vector>

#include "jamoma/data.hpp"
#include "jamoma/mapper.hpp"
#include "manual_clock.hpp"

using Catch::Approx;
using jamoma::Address;
using jamoma::Data;
using jamoma::DataType;
using jamoma::Mapper;
using jamoma::Value;

namespace {

/** A decimal parameter in a namespace. */
struct Param {
    ManualClock clock;                   /**< The clock of the parameter. */
    Data data{jamoma::Service::Parameter}; /**< The parameter. */
    jamoma::Subscription subscription;   /**< Its registration. */

    /** @param ns The namespace. @param address Where to register. @param lo Low end of the range. @param hi High end of the range. */
    Param(jamoma::Namespace& ns, const char* address, double lo, double hi)
    {
        data.set_type(DataType::Decimal);
        data.set_clock(&clock);
        data.set_attribute("ramp/drive", {"system"});
        data.set_range({lo, hi});
        subscription = ns.subscribe(Address::parse(address), data);
    }
    /** @return The value as a number. */
    double value() const { return data.value().at(0).as_double(); }
};

} // namespace

TEST_CASE("mapper_linear_default_is_identity", "[mapper]")
{
    jamoma::Namespace ns;
    Mapper m(ns);
    CHECK(m.map(0.0) == Approx(0.0));
    CHECK(m.map(0.3) == Approx(0.3));
    CHECK(m.map(1.0) == Approx(1.0));
    CHECK(m.function() == "linear");
}

TEST_CASE("mapper_scales_between_ranges", "[mapper]")
{
    jamoma::Namespace ns;
    Mapper m(ns);
    m.set_input_min(10);
    m.set_input_max(20);
    m.set_output_min(-1);
    m.set_output_max(1);
    CHECK(m.map(10) == Approx(-1.0));
    CHECK(m.map(15) == Approx(0.0).margin(1e-12));
    CHECK(m.map(20) == Approx(1.0));
}

TEST_CASE("mapper_does_not_clip_by_default_and_clipmodes_clip_the_input", "[mapper]")
{
    jamoma::Namespace ns;
    Mapper m(ns);
    m.set_output_min(0);
    m.set_output_max(100);
    CHECK(m.settings().clipmode == jamoma::MapperClip::None);
    CHECK(m.map(-0.5) == Approx(-50.0)); // the old default: the value goes through the function as it is
    CHECK(m.map(2.0) == Approx(200.0));
    m.set_clipmode(jamoma::MapperClip::Low);
    CHECK(m.map(-0.5) == Approx(0.0));
    CHECK(m.map(2.0) == Approx(200.0));
    m.set_clipmode(jamoma::MapperClip::High);
    CHECK(m.map(-0.5) == Approx(-50.0));
    CHECK(m.map(2.0) == Approx(100.0));
    m.set_clipmode(jamoma::MapperClip::Both);
    CHECK(m.map(-0.5) == Approx(0.0));
    CHECK(m.map(2.0) == Approx(100.0));
}

TEST_CASE("mapper_uses_the_function", "[mapper]")
{
    jamoma::Namespace ns;
    Mapper m(ns);
    REQUIRE(m.set_function("easeInOutSine"));
    CHECK(m.map(0.5) == Approx(0.5));
    CHECK(m.map(0.25) == Approx(0.5 * (1 - std::cos(3.14159265358979323846 * 0.25))));
    CHECK_FALSE(m.set_function("sawtooth"));
    CHECK(m.function() == "easeInOutSine"); // the previous function stays
    REQUIRE(m.set_function("power"));
    REQUIRE(m.set_function_parameter("powerValue", {2.0}));
    CHECK(m.map(0.5) == Approx(std::pow(0.5, 4.0)));
    CHECK(m.function_parameters() == std::vector<std::string>{"powerValue", "symmetry"});
}

TEST_CASE("mapper_inverse_flips_the_curve_in_any_output_range", "[mapper]")
{
    jamoma::Namespace ns;
    Mapper m(ns);
    m.set_inverse(true);
    CHECK(m.map(0.0) == Approx(1.0));
    CHECK(m.map(0.25) == Approx(0.75));
    m.set_output_min(10);
    m.set_output_max(30); // the old law was wrong here: (outputMax - f) instead of (1 - f)
    CHECK(m.map(0.0) == Approx(30.0));
    CHECK(m.map(1.0) == Approx(10.0));
    CHECK(m.map(0.5) == Approx(20.0));
}

TEST_CASE("mapper_reversed_ranges_reverse", "[mapper]")
{
    jamoma::Namespace ns;
    Mapper m(ns);
    m.set_output_min(1);
    m.set_output_max(0);
    CHECK(m.map(0.0) == Approx(1.0));
    CHECK(m.map(1.0) == Approx(0.0));
    m.set_output_min(0);
    m.set_output_max(1);
    m.set_input_min(1);
    m.set_input_max(0);
    CHECK(m.map(0.0) == Approx(1.0));
    CHECK(m.map(1.0) == Approx(0.0));
    CHECK(m.map(0.25) == Approx(0.75));
}

TEST_CASE("mapper_equal_input_limits_never_divide_by_zero", "[mapper]")
{
    jamoma::Namespace ns;
    Mapper m(ns);
    m.set_input_min(5);
    m.set_input_max(5);
    m.set_output_min(2);
    m.set_output_max(8);
    CHECK(m.map(5.0) == Approx(2.0));
    CHECK(m.map(5.5) == Approx(2.0 + 6.0 * 0.5)); // the old arithmetic: a = 1 when the limits are equal
    m.set_clipmode(jamoma::MapperClip::Both);
    for (double x : {-3.0, 5.0, 9.0})
        CHECK(m.map(x) == Approx(2.0)); // clipped to the single value, which is the low end of the output
}

TEST_CASE("mapper_nan_and_infinity_give_finite_numbers", "[mapper]")
{
    jamoma::Namespace ns;
    Mapper m(ns);
    m.set_output_min(2);
    m.set_output_max(8);
    const double nan = std::numeric_limits<double>::quiet_NaN();
    const double inf = std::numeric_limits<double>::infinity();
    CHECK(m.map(nan) == Approx(2.0));
    CHECK(std::isfinite(m.map(inf)));
    CHECK(std::isfinite(m.map(-inf)));
    m.set_clipmode(jamoma::MapperClip::Both);
    CHECK(m.map(inf) == Approx(8.0)); // clipped like any large number
    CHECK(m.map(-inf) == Approx(2.0));
    m.set_output_min(nan); // a hostile limit is ignored: the output never becomes NaN
    CHECK(std::isfinite(m.map(0.5)));
    CHECK(m.settings().output_min == Approx(2.0));
}

TEST_CASE("mapper_input_index_picks_one_item_of_a_list", "[mapper]")
{
    jamoma::Namespace ns;
    Mapper m(ns);
    m.set_output_max(10);
    m.set_input_index(2);
    const Value one = m.map(Value{0.0, 0.5, 1.0});
    REQUIRE(one.size() == 1);
    CHECK(one[0].as_double() == Approx(5.0));
    m.set_input_index(9); // beyond the list: every item
    CHECK(m.map(Value{0.0, 0.5}).size() == 2);
    m.set_input_index(0);
    CHECK(m.map(Value{0.0, 0.5}).size() == 2);
}

TEST_CASE("mapper_tells_when_a_threshold_is_crossed", "[mapper]")
{
    jamoma::Namespace ns;
    Mapper m(ns);
    std::vector<std::pair<std::string, bool>> events;
    m.set_threshold_callback([&](std::string_view name, bool state) { events.emplace_back(std::string(name), state); });
    m.process({0.5}); // between the thresholds 0 and 1: nothing
    CHECK(events.empty());
    m.process({0.0}); // at the low threshold: the input and the output (linear) are going down
    REQUIRE(events.size() == 2);
    CHECK(events[0] == std::make_pair(std::string("input/going/down"), true));
    CHECK(events[1] == std::make_pair(std::string("output/going/down"), true));
    events.clear();
    m.process({0.0}); // no change: no message
    CHECK(events.empty());
    m.process({0.5});
    REQUIRE(events.size() == 2);
    CHECK(events[0] == std::make_pair(std::string("input/going/down"), false));
    events.clear();
    m.process({1.0});
    REQUIRE(events.size() == 2);
    CHECK(events[0] == std::make_pair(std::string("input/going/up"), true));
    CHECK(events[1] == std::make_pair(std::string("output/going/up"), true));
    events.clear();
    m.set_input_threshold_up(0.8);
    m.process({0.9}); // the input is still up (0.9 >= 0.8); the output (threshold 1) is not any more
    REQUIRE(events.size() == 1);
    CHECK(events[0] == std::make_pair(std::string("output/going/up"), false));
}

TEST_CASE("mapper_maps_lists_and_passes_symbols_through", "[mapper]")
{
    jamoma::Namespace ns;
    Mapper m(ns);
    m.set_output_max(10);
    const Value out = m.map(Value{0.5, "hello", 1.0});
    REQUIRE(out.size() == 3);
    CHECK(out[0].as_double() == Approx(5.0));
    CHECK(out[1].as_symbol() == "hello");
    CHECK(out[2].as_double() == Approx(10.0));
}

TEST_CASE("mapper_samples_match_map_and_leave_the_state_alone", "[mapper]")
{
    jamoma::Namespace ns;
    Mapper m(ns);
    m.set_input_min(0);
    m.set_input_max(10);
    REQUIRE(m.set_function("lowpass"));
    const auto s = m.samples(100);
    REQUIRE(s.size() == 100);
    CHECK(s[0] == Approx(0.0));
    CHECK(m.map(10.0) == Approx(0.25)); // the first real call: the state was not advanced by samples()
    m.reset();
    CHECK(m.map(10.0) == Approx(0.25));
    REQUIRE(m.set_function("linear"));
    const auto lin = m.samples(10);
    for (std::size_t i = 0; i < lin.size(); ++i)
        CHECK(lin[i] == Approx(static_cast<double>(i) / 10.0));
}

TEST_CASE("mapper_inactive_process_does_nothing", "[mapper]")
{
    jamoma::Namespace ns;
    Mapper m(ns);
    std::vector<Value> seen;
    m.set_return([&](const Value& v) { seen.push_back(v); });
    m.process({0.5});
    REQUIRE(seen.size() == 1);
    m.set_active(false);
    m.process({0.5});
    CHECK(seen.size() == 1);
    CHECK(m.map(0.5) == Approx(0.5)); // map() itself still works
}

TEST_CASE("mapper_follows_the_range_of_bound_parameters", "[mapper]")
{
    jamoma::Namespace ns;
    Param in(ns, "/from", 10.0, 20.0);
    Param out(ns, "/to", 0.0, 100.0);
    Mapper m(ns);
    m.bind_input(Address::parse("/from"));
    m.bind_output(Address::parse("/to"));
    CHECK(m.settings().input_min == Approx(10.0));
    CHECK(m.settings().input_max == Approx(20.0));
    CHECK(m.settings().output_max == Approx(100.0));
    CHECK(m.settings().input_threshold_down == Approx(10.0));
    CHECK(m.settings().input_threshold_up == Approx(20.0));
    in.data.set_attribute("range", {0.0, 4.0});
    CHECK(m.settings().input_max == Approx(4.0));
    CHECK(m.settings().input_threshold_up == Approx(4.0));
    m.set_input_max(8.0); // by hand: the range is not followed any more
    in.data.set_attribute("range", {0.0, 2.0});
    CHECK(m.settings().input_max == Approx(8.0));
}

TEST_CASE("mapper_sends_what_the_input_parameter_outputs_to_the_output_parameter", "[mapper]")
{
    jamoma::Namespace ns;
    Param in(ns, "/from", 0.0, 10.0);
    Param out(ns, "/to", 0.0, 1.0);
    Mapper m(ns);
    std::vector<Value> seen;
    m.set_return([&](const Value& v) { seen.push_back(v); });
    m.bind_input(Address::parse("/from"));
    m.bind_output(Address::parse("/to"));
    in.data.command({5.0});
    CHECK(out.value() == Approx(0.5));
    REQUIRE_FALSE(seen.empty());
    CHECK(seen.back().at(0).as_double() == Approx(0.5));
    m.bind_input(Address()); // unbound: nothing follows
    seen.clear();
    in.data.command({10.0});
    CHECK(seen.empty());
}

TEST_CASE("mapper_binds_a_parameter_that_appears_later", "[mapper]")
{
    jamoma::Namespace ns;
    Mapper m(ns);
    m.bind_input(Address::parse("/late"));
    CHECK(m.settings().input_max == Approx(1.0));
    Param late(ns, "/late", -5.0, 5.0);
    CHECK(m.settings().input_min == Approx(-5.0));
    CHECK(m.settings().input_max == Approx(5.0));
}

TEST_CASE("mapper_ramp_is_added_to_the_command_for_the_output_parameter", "[mapper]")
{
    jamoma::Namespace ns;
    Param out(ns, "/to", 0.0, 1.0);
    Mapper m(ns);
    m.bind_output(Address::parse("/to"));
    m.set_ramp(200.0);
    m.process({1.0});
    out.clock.advance(100.0);
    CHECK(out.value() > 0.0);
    CHECK(out.value() < 1.0);
    out.clock.advance(150.0);
    CHECK(out.value() == Approx(1.0));
}

TEST_CASE("mapper_hands_the_send_to_the_dispatcher_and_returns_at_once", "[mapper]")
{
    jamoma::Namespace ns;
    Param out(ns, "/to", 0.0, 1.0);
    Mapper m(ns);
    m.bind_output(Address::parse("/to"));
    std::vector<std::function<void()>> waiting;
    std::vector<Value> seen;
    m.set_send_dispatcher([&](std::function<void()> work) { waiting.push_back(std::move(work)); });
    m.set_return([&](const Value& v) { seen.push_back(v); });
    m.process({0.5});
    REQUIRE(seen.size() == 1);              // the mapped value is returned on the calling thread, at once
    CHECK(out.value() == Approx(0.0));      // the parameter is written only when the dispatcher runs the work
    REQUIRE(waiting.size() == 1);
    waiting[0]();
    CHECK(out.value() == Approx(0.5));
}

TEST_CASE("mapper_work_left_with_the_dispatcher_is_harmless_after_the_mapper_is_gone", "[mapper]")
{
    jamoma::Namespace ns;
    Param out(ns, "/to", 0.0, 1.0);
    std::vector<std::function<void()>> waiting;
    {
        Mapper m(ns);
        m.bind_output(Address::parse("/to"));
        m.set_send_dispatcher([&](std::function<void()> work) { waiting.push_back(std::move(work)); });
        m.process({0.5});
    }
    REQUIRE(waiting.size() == 1);
    CHECK_NOTHROW(waiting[0]());
    CHECK(out.value() == Approx(0.0));
}
