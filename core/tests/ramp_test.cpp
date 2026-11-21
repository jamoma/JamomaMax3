// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file ramp_test.cpp
 * @brief Unit tests for the ramp engine, driven by a manual clock.
 */

#include <catch2/catch_test_macros.hpp>

#include <cmath>
#include <vector>

#include "jamoma/ramp.hpp"
#include "manual_clock.hpp"

/** A vector of numbers, as the ramp emits. */
using Values = std::vector<double>;

namespace {

/** A ramp and the scalar values it produced. */
struct Rig {
    ManualClock clock;                  /**< The clock. */
    std::vector<Values> seen;           /**< Every vector the ramp emitted. */
    jamoma::Ramp ramp{clock, [this](const Values& v) { seen.push_back(v); }}; /**< The ramp under test. */

    /** @return The first element of every emitted vector. */
    Values firsts() const
    {
        Values out;
        for (const Values& v : seen) {
            out.push_back(v.at(0));
        }
        return out;
    }
};

} // namespace

/** A linear ramp from 0 to 100 over 100 ms visits 0, 20, 40, 60, 80, 100 (old test). */
TEST_CASE("linear ramp visits the expected steps")
{
    Rig r;
    r.ramp.start({0.0}, {100.0}, 100.0, "linear");
    REQUIRE(r.ramp.running());
    r.clock.advance(100.0);
    REQUIRE(r.firsts() == Values{0.0, 20.0, 40.0, 60.0, 80.0, 100.0});
    REQUIRE_FALSE(r.ramp.running());
    REQUIRE_FALSE(r.clock.has_pending());
}

/** The old timing test: 0 to 1000 over 200 ms gives 0, 100 ... 1000. */
TEST_CASE("old timing test sequence")
{
    Rig r;
    r.ramp.start({0.0}, {1000.0}, 200.0, "linear");
    r.clock.advance(200.0);
    REQUIRE(r.firsts() == Values{0.0, 100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0, 1000.0});
}

/** The last value is exactly the target, and a duration that is no multiple of the tick still ends on it. */
TEST_CASE("last value is exactly the target")
{
    Rig r;
    r.ramp.start({0.0}, {1.0}, 30.0, "linear");
    r.clock.advance(30.0);
    REQUIRE(r.seen.size() == 3);
    REQUIRE(r.firsts().front() == 0.0);
    REQUIRE(std::fabs(r.firsts()[1] - 20.0 / 30.0) < 1e-12);
    REQUIRE(r.firsts().back() == 1.0);
}

/** A duration shorter than a tick gives the start value and then the target. */
TEST_CASE("short ramp gives start then target")
{
    Rig r;
    r.ramp.start({0.0}, {10.0}, 5.0, "linear");
    r.clock.advance(5.0);
    REQUIRE(r.firsts() == Values{0.0, 10.0});
}

/** Zero or negative duration jumps to the target at once. */
TEST_CASE("zero duration jumps to the target")
{
    Rig r;
    r.ramp.start({0.0}, {50.0}, 0.0, "linear");
    REQUIRE(r.firsts() == Values{50.0});
    REQUIRE_FALSE(r.ramp.running());
    r.ramp.start({0.0}, {60.0}, -5.0, "linear");
    REQUIRE(r.firsts().back() == 60.0);
}

/** Stopping cancels pending ticks. */
TEST_CASE("stop cancels pending ticks")
{
    Rig r;
    r.ramp.start({0.0}, {100.0}, 100.0, "linear");
    r.clock.advance(40.0);
    const std::size_t before = r.seen.size();
    r.ramp.stop();
    REQUIRE_FALSE(r.ramp.running());
    r.clock.advance(1000.0);
    REQUIRE(r.seen.size() == before);
}

/** Starting again replaces the running ramp. */
TEST_CASE("restart replaces the running ramp")
{
    Rig r;
    r.ramp.start({0.0}, {100.0}, 100.0, "linear");
    r.clock.advance(20.0);
    r.seen.clear();
    r.ramp.start({50.0}, {60.0}, 20.0, "linear");
    r.clock.advance(1000.0);
    REQUIRE(r.firsts() == Values{50.0, 60.0});
}

/** An unknown function name falls back to linear and is reported. */
TEST_CASE("unknown function falls back to linear")
{
    Rig r;
    r.ramp.start({0.0}, {100.0}, 100.0, "bogus");
    REQUIRE_FALSE(r.ramp.function_ok());
    r.clock.advance(100.0);
    REQUIRE(r.firsts() == Values{0.0, 20.0, 40.0, 60.0, 80.0, 100.0});
    r.ramp.start({0.0}, {1.0}, 10.0, "linear");
    REQUIRE(r.ramp.function_ok());
}

/** A ramp over a vector moves every element; a short start vector is padded with the target. */
TEST_CASE("ramp moves every element of a vector")
{
    Rig r;
    r.ramp.start({0.0, 10.0}, {100.0, 20.0}, 40.0, "linear");
    r.clock.advance(20.0);
    REQUIRE(r.seen.size() == 2);
    REQUIRE(r.seen[1] == Values{50.0, 15.0});
    r.clock.advance(20.0);
    REQUIRE(r.seen.back() == Values{100.0, 20.0});
    Rig p;
    p.ramp.start({0.0}, {100.0, 200.0}, 40.0, "linear");
    REQUIRE(p.seen[0] == Values{0.0, 200.0});
}

/** A ramp destroyed with a tick pending never calls back. */
TEST_CASE("destroyed ramp never calls back")
{
    ManualClock clock;
    int calls = 0;
    {
        jamoma::Ramp ramp(clock, [&](const Values&) { ++calls; });
        ramp.start({0.0}, {100.0}, 100.0, "linear");
        REQUIRE(calls == 1);
    }
    clock.advance(1000.0);
    REQUIRE(calls == 1);
}

/** Review Focus 4: stopping from inside the callback ends the ramp without further ticks. */
TEST_CASE("stop from inside the callback ends the ramp")
{
    ManualClock clock;
    int calls = 0;
    jamoma::Ramp* self = nullptr;
    jamoma::Ramp ramp(clock, [&](const Values&) {
        if (++calls == 2) {
            self->stop();
        }
    });
    self = &ramp;
    ramp.start({0.0}, {100.0}, 100.0, "linear");
    clock.advance(1000.0);
    REQUIRE(calls == 2);
    REQUIRE_FALSE(ramp.running());
}

/** Review Focus 4: starting a new ramp from inside the callback replaces the old one cleanly. */
TEST_CASE("restart from inside the callback replaces the ramp")
{
    ManualClock clock;
    std::vector<double> seen;
    jamoma::Ramp* self = nullptr;
    int calls = 0;
    jamoma::Ramp ramp(clock, [&](const Values& v) {
        seen.push_back(v[0]);
        if (++calls == 2) {
            self->start({500.0}, {600.0}, 20.0, "linear");
        }
    });
    self = &ramp;
    ramp.start({0.0}, {100.0}, 100.0, "linear");
    clock.advance(1000.0);
    REQUIRE(seen == Values{0.0, 20.0, 500.0, 600.0});
}
