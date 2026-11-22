// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file dataspace_test.cpp
 * @brief Unit tests for the gain, time and position dataspaces. Numeric cases are those of the old DataspaceLib unit tests.
 */

#include <catch2/catch_test_macros.hpp>

#include <cmath>
#include <limits>
#include <string>
#include <vector>

#include "jamoma/dataspace.hpp"

using jamoma::Atom;
using jamoma::Dataspace;
using jamoma::Value;

namespace {

/** Converts one number in a dataspace. @param space The dataspace name. @param v The input. @param from The input unit. @param to The output unit. @return The first element of the result. */
double scalar(const std::string& space, double v, const std::string& from, const std::string& to)
{
    const Dataspace* d = Dataspace::find(space);
    REQUIRE(d != nullptr);
    const auto out = d->convert(Value{Atom(v)}, from, to);
    REQUIRE(out.has_value());
    REQUIRE(out->size() == 1);
    return (*out)[0].as_double();
}

/** True if two numbers agree within a relative tolerance. @param a One number. @param b The other. @param tolerance The relative tolerance. @return True if close. */
bool close(double a, double b, double tolerance = 1e-9)
{
    return std::fabs(a - b) <= tolerance * std::max(1.0, std::fabs(b));
}

/** Converts a vector. @param v The input. @param from The input unit. @param to The output unit. @return The result as doubles. */
std::vector<double> vec(std::vector<double> v, const std::string& from, const std::string& to)
{
    Value in;
    for (double x : v) {
        in.push_back(Atom(x));
    }
    const auto out = Dataspace::find("position")->convert(in, from, to);
    REQUIRE(out.has_value());
    std::vector<double> result;
    for (const Atom& a : *out) {
        result.push_back(a.as_double());
    }
    return result;
}

} // namespace

/** Dataspaces and units can be found by name, with aliases. */
TEST_CASE("find dataspaces and aliases")
{
    REQUIRE(Dataspace::find("gain") != nullptr);
    REQUIRE(Dataspace::find("time") != nullptr);
    REQUIRE(Dataspace::find("position") != nullptr);
    REQUIRE(Dataspace::find("nonsense") == nullptr);
    const Dataspace* gain = Dataspace::find("gain");
    for (const char* u : {"linear", "midigain", "dB", "db", "db-raw", "dB-raw"}) {
        REQUIRE(gain->has_unit(u));
    }
    REQUIRE_FALSE(gain->has_unit("furlongs"));
    REQUIRE(gain->default_unit() == "linear");
    REQUIRE(Dataspace::find("time")->default_unit() == "second");
    REQUIRE(Dataspace::find("position")->default_unit() == "cart3D");
}

/** An unknown unit gives no result. */
TEST_CASE("unknown unit is nullopt")
{
    const Dataspace* gain = Dataspace::find("gain");
    REQUIRE_FALSE(gain->convert(Value{Atom(1.0)}, "furlongs", "linear").has_value());
    REQUIRE_FALSE(gain->convert(Value{Atom(1.0)}, "linear", "furlongs").has_value());
}

/** Gain: the cases of the old GainDataspace test. */
TEST_CASE("gain conversions match the old tests")
{
    REQUIRE(close(scalar("gain", 1.23, "linear", "linear"), 1.23));
    REQUIRE(close(scalar("gain", 0.0, "dB", "linear"), 1.0));
    REQUIRE(close(scalar("gain", 0.0, "dB-raw", "linear"), 1.0));
    REQUIRE(close(scalar("gain", 100.0, "midigain", "linear"), 1.0));
    REQUIRE(close(scalar("gain", 1.0, "linear", "dB"), 0.0));
    REQUIRE(close(scalar("gain", 1.0, "linear", "dB-raw"), 0.0));
    REQUIRE(close(scalar("gain", 1.0, "linear", "midigain"), 100.0));
    REQUIRE(close(scalar("gain", 127.0, "midigain", "dB"), 12.0));
    REQUIRE(close(scalar("gain", 12.0, "dB", "midigain"), 127.0));
}

/** Gain: the floors. */
TEST_CASE("gain floors")
{
    REQUIRE(scalar("gain", 0.0, "midigain", "linear") == 0.0);
    REQUIRE(scalar("gain", 0.0, "linear", "midigain") == 0.0);
    REQUIRE(scalar("gain", 0.0, "linear", "dB") == -96.0);
    REQUIRE(scalar("gain", -96.0, "dB", "linear") == 0.0);
    REQUIRE(scalar("gain", -100.0, "dB", "linear") == 0.0);
    REQUIRE(scalar("gain", -5.0, "linear", "linear") == 0.0);
}

/** Time: the cases of the old TimeDataspace test. */
TEST_CASE("time conversions match the old tests")
{
    REQUIRE(close(scalar("time", 256.0, "second", "second"), 256.0));
    REQUIRE(close(scalar("time", 1234.5, "millisecond", "second"), 1.2345));
    REQUIRE(close(scalar("time", 1.23 * 44100.0, "sample", "second"), 1.23));
    REQUIRE(close(scalar("time", 4.0, "Hz", "second"), 0.25));
    REQUIRE(close(scalar("time", 120.0, "bpm", "second"), 0.5));
    REQUIRE(close(scalar("time", 57.0, "midinote", "second"), 1.0 / 220.0));
    REQUIRE(close(scalar("time", 69.0, "midinote", "second"), 1.0 / 440.0));
    REQUIRE(close(scalar("time", 5700.0, "cents", "second"), 1.0 / 220.0));
    REQUIRE(close(scalar("time", 6900.0, "cents", "second"), 1.0 / 440.0));
    REQUIRE(close(scalar("time", 1.2345, "second", "millisecond"), 1234.5));
    REQUIRE(close(scalar("time", 192000.0 / 44100.0, "second", "sample"), 192000.0));
    REQUIRE(close(scalar("time", 0.25, "second", "Hz"), 4.0));
    REQUIRE(close(scalar("time", 0.5, "second", "bpm"), 120.0));
}

/** Aliases of a unit give the same result. */
TEST_CASE("alias units are equal")
{
    REQUIRE(scalar("gain", -6.0, "dB", "linear") == scalar("gain", -6.0, "db", "linear"));
    REQUIRE(scalar("time", 100.0, "ms", "second") == scalar("time", 100.0, "millisecond", "second"));
    REQUIRE(scalar("time", 2.0, "Hz", "second") == scalar("time", 2.0, "hz", "second"));
    REQUIRE(scalar("time", 2.0, "Hz", "second") == scalar("time", 2.0, "Hertz", "second"));
    REQUIRE(scalar("time", 2.0, "s", "ms") == scalar("time", 2.0, "second", "millisecond"));
}

/** Every unit of gain and time is invertible through the neutral unit within a tight tolerance. */
TEST_CASE("scalar units are invertible")
{
    const std::vector<std::string> gain_units{"linear", "midigain", "dB", "db-raw"};
    for (const auto& unit : gain_units) {
        for (double neutral : {0.25, 0.5, 1.0, 2.0}) {
            const double there = scalar("gain", neutral, "linear", unit);
            REQUIRE(close(scalar("gain", there, unit, "linear"), neutral));
        }
    }
    const std::vector<std::string> time_units{"second", "ms", "sample", "bpm", "Hz", "midinote", "cents", "mel", "bark"};
    for (const auto& unit : time_units) {
        for (double neutral : {0.002, 0.01, 0.5, 2.5}) {
            const double there = scalar("time", neutral, "second", unit);
            REQUIRE(close(scalar("time", there, unit, "second"), neutral, 1e-8));
        }
    }
}

/** A list is converted element by element for scalar units. */
TEST_CASE("scalar units convert every element")
{
    const auto out = Dataspace::find("time")->convert(Value{Atom(1000.0), Atom(2000.0)}, "ms", "second");
    REQUIRE(out.has_value());
    REQUIRE(out->size() == 2);
    REQUIRE(close((*out)[0].as_double(), 1.0));
    REQUIRE(close((*out)[1].as_double(), 2.0));
}

/** Position: conversions into xyz. */
TEST_CASE("position to xyz")
{
    REQUIRE(vec({1, 2, 3}, "xyz", "xyz") == std::vector<double>{1, 2, 3});
    REQUIRE(vec({1, 2}, "xy", "xyz") == std::vector<double>{1, 2, 0});
    REQUIRE(vec({1, 2, 3}, "openGL", "xyz") == std::vector<double>{1, -3, 2});
    const auto front = vec({0, 0, 1}, "aed", "xyz");
    REQUIRE(close(front[0], 0.0));
    REQUIRE(close(front[1], 1.0));
    REQUIRE(close(front[2], 0.0));
    const auto right = vec({90, 0, 1}, "aed", "xyz");
    REQUIRE(close(right[0], 1.0));
    REQUIRE(close(right[1], 0.0));
    const auto up = vec({0, 90, 1}, "aed", "xyz");
    REQUIRE(close(up[2], 1.0));
    const auto polar = vec({90, 2}, "polar", "xyz");
    REQUIRE(close(polar[0], 2.0));
    REQUIRE(close(polar[1], 0.0));
    REQUIRE(polar[2] == 0.0);
    const auto cyl = vec({2, 0, 5}, "daz", "xyz");
    REQUIRE(close(cyl[0], 0.0));
    REQUIRE(close(cyl[1], 2.0));
    REQUIRE(close(cyl[2], 5.0));
}

/** Position: conversions out of xyz. */
TEST_CASE("position from xyz")
{
    REQUIRE(vec({1, 2, 3}, "xyz", "xy") == std::vector<double>{1, 2});
    REQUIRE(vec({1, 2, 3}, "xyz", "openGL") == std::vector<double>{1, 3, -2});
    const auto aed = vec({1, 0, 0}, "xyz", "aed");
    REQUIRE(close(aed[0], 90.0));
    REQUIRE(close(aed[1], 0.0));
    REQUIRE(close(aed[2], 1.0));
    const auto polar = vec({0, 3, 0}, "xyz", "polar");
    REQUIRE(close(polar[0], 0.0));
    REQUIRE(close(polar[1], 3.0));
    const auto cyl = vec({0, 2, 5}, "xyz", "daz");
    REQUIRE(close(cyl[0], 2.0));
    REQUIRE(close(cyl[1], 0.0));
    REQUIRE(close(cyl[2], 5.0));
}

/** Position: a round trip through every unit. */
TEST_CASE("position units are invertible")
{
    for (const std::string unit : {"xyz", "aed", "openGL", "daz"}) {
        const auto there = vec({1.5, -2.0, 0.75}, "xyz", unit);
        const auto back = vec(there, unit, "xyz");
        REQUIRE(close(back[0], 1.5));
        REQUIRE(close(back[1], -2.0));
        REQUIRE(close(back[2], 0.75));
    }
    for (const std::string unit : {"xy", "polar"}) {
        const auto there = vec({1.5, -2.0, 0.0}, "xyz", unit);
        const auto back = vec(there, unit, "xyz");
        REQUIRE(close(back[0], 1.5));
        REQUIRE(close(back[1], -2.0));
    }
}

/** Review Focus 3: NaN stays NaN. */
TEST_CASE("convert of nan is nan")
{
    const double nan = std::numeric_limits<double>::quiet_NaN();
    REQUIRE(std::isnan(scalar("gain", nan, "linear", "dB")));
    REQUIRE(std::isnan(scalar("time", nan, "ms", "second")));
}

/** Review Focus 3: the origin converts without NaN, and missing position elements count as zero. */
TEST_CASE("position at the origin and short inputs")
{
    const auto origin = vec({0, 0, 0}, "aed", "xyz");
    REQUIRE(origin == std::vector<double>{0, 0, 0});
    const auto short_input = vec({1}, "xyz", "xyz");
    REQUIRE(short_input == std::vector<double>{1, 0, 0});
}

/** The temperature dataspace: the cases of the old TemperatureDataspace test. */
TEST_CASE("temperature conversions match the old tests")
{
    REQUIRE(jamoma::Dataspace::find("temperature") != nullptr);
    REQUIRE(close(scalar("temperature", 256.0, "Kelvin", "Kelvin"), 256.0));
    REQUIRE(close(scalar("temperature", 0.0, "Celsius", "Kelvin"), 273.15));
    REQUIRE(close(scalar("temperature", 32.0, "Fahrenheit", "Kelvin"), 273.15));
    REQUIRE(close(scalar("temperature", 273.15, "Kelvin", "Celsius"), 0.0));
    REQUIRE(close(scalar("temperature", 273.15, "Kelvin", "Fahrenheit"), 32.0));
    REQUIRE(close(scalar("temperature", 100.0, "C", "F"), 212.0));
    REQUIRE(close(scalar("temperature", 0.0, "K", "C"), -273.15));
}

/** The menus of j.unit: the names of the dataspaces and the canonical names of the units. */
TEST_CASE("dataspace and unit names")
{
    REQUIRE(Dataspace::names() == std::vector<std::string>{"gain", "time", "position", "temperature"});
    REQUIRE(Dataspace::find("temperature")->unit_names() == std::vector<std::string>{"Kelvin", "Celsius", "Fahrenheit"});
    REQUIRE(Dataspace::find("gain")->unit_names().front() == "linear");
    REQUIRE(Dataspace::find("temperature")->default_unit() == "Kelvin");
}

/** The aed values a ramp produces on the way (old ramp_and_dataspace test) convert back to xyz without loss. */
TEST_CASE("aed values along a ramp convert to xyz")
{
    const std::vector<std::vector<double>> aed{{-135.0, -35.26439, 1.732051}, {-137.371842, -9.49312, 1.212642}, {-140.792796, 31.455607, 1.149783},
                                               {-146.103833, 61.156594, 1.59828}, {-155.224859, 75.408396, 2.273324}, {-172.874984, 82.346951, 3.026962}};
    for (const auto& v : aed) {
        const auto xyz = vec(v, "aed", "xyz");
        REQUIRE(xyz.size() == 3);
        for (double x : xyz) {
            REQUIRE(std::isfinite(x));
        }
    }
}
