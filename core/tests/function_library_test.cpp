// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file function_library_test.cpp
 * @brief Unit tests for the function library of j.map (docs/inventory/j.map.md).
 */

#include <catch2/catch_approx.hpp>
#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <cmath>
#include <limits>
#include <string>
#include <vector>

#include "jamoma/function_library.hpp"

using Catch::Approx;
using jamoma::Atom;
using jamoma::Function;
using jamoma::Value;

namespace {

/** @brief Makes a function that must exist. @param name The name. @return The function. */
std::unique_ptr<Function> make(const char* name) {
    auto f = Function::create(name);
    REQUIRE(f);
    return f;
}

} // namespace

TEST_CASE("function_names_lists_every_old_function", "[function]") {
    const auto names = jamoma::function_names();
    CHECK(names.size() == 38);
    CHECK(std::is_sorted(names.begin(), names.end()));
    for (const char* n : {"linear", "exponential", "logarithm", "power", "tanh", "smoothPolynomial", "lowpass", "freehand", "easeInBack", "easeOutBounce",
                          "easeInOutCircular", "easeInCubic", "easeOutElastic", "easeInOutExponential", "easeInQuadratic", "easeOutQuartic", "easeInQuintic", "easeInOutSine"})
        CHECK(std::find(names.begin(), names.end(), n) != names.end());
    CHECK(std::find(names.begin(), names.end(), "cosine") == names.end()); // the 0.5.7 library had it; the one the package is compatible with has not
}

TEST_CASE("function_unknown_name_is_null", "[function]") {
    CHECK_FALSE(Function::create("sawtooth"));
    CHECK_FALSE(Function::create("Linear"));
    CHECK_FALSE(Function::create(""));
}

TEST_CASE("function_endpoints_are_zero_and_one", "[function]") {
    for (const auto& name : jamoma::function_names()) {
        if (name == "lowpass")
            continue; // a filter: its first output is not its input
        auto f = make(name.c_str());
        INFO(name);
        CHECK(f->apply(0.0) == Approx(0.0).margin(1e-9));
        CHECK(f->apply(1.0) == Approx(1.0).margin(1e-9));
    }
}

TEST_CASE("function_known_values", "[function]") {
    const double pi = 3.14159265358979323846;
    CHECK(make("linear")->apply(0.3) == Approx(0.3));
    CHECK(make("easeInQuadratic")->apply(0.5) == Approx(0.25));
    CHECK(make("easeOutQuadratic")->apply(0.5) == Approx(0.75));
    CHECK(make("easeInOutQuadratic")->apply(0.25) == Approx(0.125));
    CHECK(make("easeInCubic")->apply(0.5) == Approx(0.125));
    CHECK(make("easeOutCubic")->apply(0.5) == Approx(0.875));
    CHECK(make("easeInOutCubic")->apply(0.75) == Approx(0.5 * std::pow(2 * 0.75 - 2, 3) + 1));
    CHECK(make("easeInQuartic")->apply(0.5) == Approx(0.0625));
    CHECK(make("easeOutQuintic")->apply(0.5) == Approx(1 - 0.03125));
    CHECK(make("easeInSine")->apply(0.5) == Approx(std::sin(-0.25 * pi) + 1));
    CHECK(make("easeOutSine")->apply(0.5) == Approx(std::sin(0.25 * pi)));
    CHECK(make("easeInOutSine")->apply(0.5) == Approx(0.5));
    CHECK(make("easeInCircular")->apply(0.5) == Approx(1 - std::sqrt(0.75)));
    CHECK(make("easeOutCircular")->apply(0.5) == Approx(std::sqrt(0.75)));
    CHECK(make("easeInBack")->apply(0.5) == Approx(0.125 - 0.5));
    CHECK(make("easeOutBounce")->apply(0.5) == Approx(0.71875));
    CHECK(make("easeInBounce")->apply(0.5) == Approx(1 - 0.71875));
    CHECK(make("easeInExponential")->apply(0.5) == Approx(std::pow(2, -5)));
    CHECK(make("easeOutExponential")->apply(0.5) == Approx(1 - std::pow(2, -5)));
    CHECK(make("easeInElastic")->apply(0.5) == Approx(std::sin(3.25 * pi) * std::pow(2, -5)));
    CHECK(make("easeOutElastic")->apply(0.5) == Approx(std::sin(-9.75 * pi) * std::pow(2, -5) + 1));
    CHECK(make("smoothPolynomial")->apply(0.5) == Approx(0.5));
    CHECK(make("smoothPolynomial")->apply(0.25) == Approx(0.25 * 0.25 * 0.25 * (0.25 * (6 * 0.25 - 15) + 10)));

    auto exp2 = make("exponential");
    REQUIRE(exp2->set("base", {2.0}));
    CHECK(exp2->apply(0.5) == Approx(std::sqrt(2.0) - 1.0));
    auto log2 = make("logarithm");
    REQUIRE(log2->set("base", {2.0}));
    CHECK(log2->apply(0.5) == Approx(std::log(1.5) / std::log(2.0)));
}

TEST_CASE("function_power_symmetries", "[function]") {
    auto pw = make("power");
    CHECK(pw->get("powerValue") == Value{1.0});
    CHECK(pw->get("symmetry") == Value{"none"});
    CHECK(pw->apply(0.5) == Approx(0.25)); // K = 2^1 = 2
    REQUIRE(pw->set("symmetry", {"axis"}));
    CHECK(pw->apply(0.25) == Approx(0.25)); // |2*0.25-1|^2
    REQUIRE(pw->set("symmetry", {"point"}));
    CHECK(pw->apply(0.25) == Approx(0.375)); // 0.5 (-0.25 + 1)
    CHECK_FALSE(pw->set("symmetry", {"sideways"}));
    CHECK(pw->get("symmetry") == Value{"point"});
}

TEST_CASE("function_tanh_default_is_symmetric", "[function]") {
    auto t = make("tanh");
    CHECK(t->get("offset") == Value{0.0});
    CHECK(t->get("width") == Value{0.5});
    CHECK(t->apply(0.5) == Approx(0.5));
    CHECK(t->apply(0.25) + t->apply(0.75) == Approx(1.0));
}

TEST_CASE("function_lowpass_keeps_state_until_reset", "[function]") {
    auto lp = make("lowpass");
    CHECK(lp->get("coefficient") == Value{0.75});
    CHECK(lp->apply(1.0) == Approx(0.25));
    CHECK(lp->apply(1.0) == Approx(0.4375));
    lp->reset();
    CHECK(lp->apply(1.0) == Approx(0.25));
}

TEST_CASE("function_freehand_follows_its_points", "[function]") {
    auto fh = make("freehand");
    CHECK(fh->apply(0.3) == Approx(0.3)); // an empty curve is the identity
    REQUIRE(fh->set("curveList", {0.0, 0.0, "linear", 0.5, 1.0, "linear", 1.0, 0.0, "linear"}));
    CHECK(fh->apply(0.25) == Approx(0.5));
    CHECK(fh->apply(0.5) == Approx(1.0));
    CHECK(fh->apply(0.75) == Approx(0.5));
    CHECK(fh->apply(1.0) == Approx(0.0));
    REQUIRE(fh->set("curveList", {0.2, 0.3, "linear", 0.8, 0.9, "easeInOutSine"}));
    CHECK(fh->apply(0.0) == Approx(0.3)); // before the first point: its y
    CHECK(fh->apply(0.5) == Approx(0.3 + 0.6 * 0.5)); // cosine halfway
    CHECK(fh->apply(1.0) == Approx(0.9)); // after the last point: its y
}

TEST_CASE("function_freehand_refuses_a_malformed_curve", "[function]") {
    auto fh = make("freehand");
    REQUIRE(fh->set("curveList", {0.0, 0.0, "linear", 1.0, 1.0, "linear"}));
    CHECK_FALSE(fh->set("curveList", {0.0, "linear"}));          // a point needs two numbers
    CHECK_FALSE(fh->set("curveList", {0.0, 0.0, "nosuchfunction", 1.0, 1.0}));
    CHECK(fh->apply(0.5) == Approx(0.5)); // the old curve stays
}

TEST_CASE("function_unknown_or_wrong_parameter_is_refused", "[function]") {
    auto e = make("exponential");
    CHECK_FALSE(e->set("nosuchparameter", {1.0}));
    CHECK_FALSE(e->set("base", {"two"}));
    CHECK(e->get("base") == Value{std::exp(1.0)});
    CHECK(e->get("nosuchparameter").empty());
    CHECK(make("linear")->parameter_names().empty());
    CHECK(make("power")->parameter_names() == std::vector<std::string>{"powerValue", "symmetry"});
}

TEST_CASE("function_base_is_limited_and_one_is_identity", "[function]") {
    auto e = make("exponential");
    REQUIRE(e->set("base", {1.0}));
    CHECK(e->apply(0.3) == Approx(0.3));
    REQUIRE(e->set("base", {-5.0})); // limited low, not refused
    CHECK(std::isfinite(e->apply(0.5)));
    REQUIRE(e->set("base", {1e9})); // limited high
    CHECK(std::isfinite(e->apply(0.5)));
    auto l = make("logarithm");
    REQUIRE(l->set("base", {1.0}));
    CHECK(l->apply(0.3) == Approx(0.3));
}

TEST_CASE("function_nan_and_infinity_stay_finite_and_in_range", "[function]") {
    const double nan = std::numeric_limits<double>::quiet_NaN();
    const double inf = std::numeric_limits<double>::infinity();
    for (const auto& name : jamoma::function_names()) {
        for (double x : {nan, inf, -inf, -1.0, 2.0, 0.0, 1.0, 0.5}) {
            auto f = make(name.c_str());
            INFO(name << " " << x);
            const double y = f->apply(x);
            CHECK(std::isfinite(y));
        }
    }
    CHECK(make("linear")->apply(nan) == Approx(0.0));
    CHECK(make("linear")->apply(inf) == Approx(0.0)); // not finite: 0
    CHECK(make("linear")->apply(-inf) == Approx(0.0));
    CHECK(make("linear")->apply(2.0) == Approx(2.0)); // outside 0..1 is not clipped
    CHECK(make("linear")->apply(-1.0) == Approx(-1.0));
}
