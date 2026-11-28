// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file dataspace_test.cpp
 * @brief Unit tests for the gain, time and position dataspaces. Numeric cases are those of the old DataspaceLib unit tests.
 */

#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <atomic>
#include <thread>
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

/** Angles: radians (the neutral unit) and degrees, with their short names. */
TEST_CASE("angle conversions")
{
    const double pi = std::acos(-1.0);
    REQUIRE(Dataspace::find("angle") != nullptr);
    REQUIRE(Dataspace::find("angle")->default_unit() == "radian");
    REQUIRE(Dataspace::find("angle")->unit_names() == std::vector<std::string>{"radian", "degree"});
    REQUIRE(close(scalar("angle", pi, "radian", "degree"), 180.0));
    REQUIRE(close(scalar("angle", -90.0, "degree", "radian"), -pi / 2.0));
    REQUIRE(close(scalar("angle", 720.0, "deg", "rad"), 4.0 * pi)); // not wrapped
}

/** Checks a conversion of a list. @param space The dataspace. @param v The numbers. @param from Their unit. @param to The wanted unit. @param expected The result. */
void vector_case(const char* space, const std::vector<double>& v, const char* from, const char* to, const std::vector<double>& expected)
{
    Value in;
    for (double x : v) {
        in.push_back(Atom(x));
    }
    const auto out = Dataspace::find(space)->convert(in, from, to);
    REQUIRE(out.has_value());
    REQUIRE(out->size() == expected.size());
    for (std::size_t i = 0; i < expected.size(); ++i) {
        INFO(from << " -> " << to << " element " << i << " got " << out->at(i).as_double());
        REQUIRE(close(out->at(i).as_double(), expected[i]));
    }
}

/** Distance: meters (neutral), centimeters, inches and feet, with the old factors. */
TEST_CASE("distance conversions")
{
    REQUIRE(Dataspace::find("distance") != nullptr);
    REQUIRE(Dataspace::find("distance")->default_unit() == "meters");
    REQUIRE(Dataspace::find("distance")->unit_names() == std::vector<std::string>{"meters", "centimeters", "inches", "feet"});
    REQUIRE(close(scalar("distance", 123.4, "cm", "meters"), 1.234));
    REQUIRE(close(scalar("distance", 1.234, "m", "centimeters"), 123.4));
    REQUIRE(close(scalar("distance", 39.37, "inches", "m"), 1.0));
    REQUIRE(close(scalar("distance", 1.0, "m", "\""), 39.37));
    REQUIRE(close(scalar("distance", 3.281, "feet", "m"), 1.0));
    REQUIRE(close(scalar("distance", 1.0, "m", "'"), 3.281));
}

/** Speed: the cases of the old test; meters per second is the neutral unit. */
TEST_CASE("speed conversions")
{
    REQUIRE(Dataspace::find("speed") != nullptr);
    REQUIRE(Dataspace::find("speed")->default_unit() == "m/s");
    REQUIRE(Dataspace::find("speed")->unit_names() == std::vector<std::string>{"m/s", "mi/h", "km/h", "kn", "ft/s"});
    REQUIRE(close(scalar("speed", 36.0, "kmph", "m/s"), 10.0));
    REQUIRE(close(scalar("speed", 10.0, "m/s", "km/h"), 36.0));
    REQUIRE(close(scalar("speed", 50.0, "mph", "m/s"), 22.352));
    REQUIRE(close(scalar("speed", 1.0, "m/s", "mi/h"), 2.236936));
    REQUIRE(close(scalar("speed", 45.0, "kn", "m/s"), 45.0 * 0.514444));
    REQUIRE(close(scalar("speed", 1.0, "m/s", "kn"), 1.943844));
    REQUIRE(close(scalar("speed", 20.0, "ft/s", "m/s"), 6.096));
    REQUIRE(close(scalar("speed", 1.0, "m/s", "ft/s"), 3.2808399));
}

/** The playback speed unit of the time dataspace: 1 is the period of MIDI note 0 seen from the other side, and the conversion is its own inverse. */
TEST_CASE("time speed unit")
{
    const double k = std::pow(2.0, 69.0 / 12.0) / 440.0;
    REQUIRE(Dataspace::find("time")->has_unit("speed"));
    REQUIRE(close(scalar("time", 1.0, "speed", "second"), k));
    REQUIRE(close(scalar("time", k, "second", "speed"), 1.0));
    REQUIRE(close(scalar("time", 2.0, "speed", "midinote"), 12.0));
}

/** Orientation: the cases of the old test (quaternion x y z w is the neutral unit; yaw pitch roll and axis angle in degrees). */
TEST_CASE("orientation conversions")
{
    REQUIRE(Dataspace::find("orientation") != nullptr);
    REQUIRE(Dataspace::find("orientation")->default_unit() == "quaternion");
    REQUIRE(Dataspace::find("orientation")->unit_names() == std::vector<std::string>{"quaternion", "euler", "axis"});
    const std::vector<double> quat{0.0, -0.5, -0.7071067811865475, 0.5};
    const std::vector<double> euler{90.0, 45.0, -45.0};
    const std::vector<double> axis{0.0, -0.5773502691896258, -0.8164965809277260, 120.0};
    vector_case("orientation", euler, "euler", "quaternion", quat);
    vector_case("orientation", axis, "xyza", "quat", quat);
    vector_case("orientation", quat, "quat", "ypr", euler);
    vector_case("orientation", quat, "quaternion", "axis", axis);
    vector_case("orientation", euler, "euler", "axis", axis);
    vector_case("orientation", axis, "axis", "euler", euler);
}

/** Orientation: no rotation, a zero axis, and the pole where rounding would push the pitch past 90 degrees. */
TEST_CASE("orientation at the edges")
{
    vector_case("orientation", {0.0, 0.0, 0.0}, "euler", "quat", {0.0, 0.0, 0.0, 1.0});
    vector_case("orientation", {0.0, 0.0, 0.0, 90.0}, "axis", "quat", {0.0, 0.0, 0.0, std::cos(std::acos(-1.0) / 4.0)});
    vector_case("orientation", {0.0, 0.0, 0.0, 1.0}, "quat", "axis", {0.0, 0.0, 0.0, 0.0});
    vector_case("orientation", {0.0, 0.0, 2.0, 180.0}, "axis", "quat", {0.0, 0.0, 1.0, 0.0});
    const auto pole = Dataspace::find("orientation")->convert(Value{Atom(0.0), Atom(90.0), Atom(0.0)}, "euler", "quat");
    const auto back = Dataspace::find("orientation")->convert(*pole, "quat", "euler");
    REQUIRE(std::isfinite(back->at(1).as_double()));
    REQUIRE(std::abs(back->at(1).as_double() - 90.0) < 1e-4);
    const auto over = Dataspace::find("orientation")->convert(Value{Atom(0.7072), Atom(0.0), Atom(0.0), Atom(0.7072)}, "quat", "euler");
    REQUIRE(std::isfinite(over->at(1).as_double()));
}

/** The none dataspace hands everything on as it came, words too. */
TEST_CASE("none dataspace")
{
    const Dataspace* none = Dataspace::find("none");
    REQUIRE(none != nullptr);
    REQUIRE(none->default_unit() == "none");
    REQUIRE(none->unit_names() == std::vector<std::string>{"none"});
    const Value in{Atom("word"), Atom(2)};
    REQUIRE(*none->convert(in, "none", "none") == in);
}

/** The menus of j.unit: the names of the dataspaces and the canonical names of the units. */
TEST_CASE("dataspace and unit names")
{
    REQUIRE(Dataspace::names() == std::vector<std::string>{"none", "gain", "time", "position", "temperature", "color", "angle", "distance", "speed", "orientation"});
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

/** The converter of j.unit: setting the dataspace resets the units to its neutral unit; unknown names are refused and change nothing. */
TEST_CASE("unit converter keeps a consistent state")
{
    jamoma::UnitConverter c;
    REQUIRE(c.dataspace() == "temperature");
    REQUIRE(c.input() == "Kelvin");
    REQUIRE(c.set_dataspace("gain"));
    REQUIRE(c.input() == "linear");
    REQUIRE(c.set_input("db"));
    REQUIRE(c.set_output("linear"));
    REQUIRE_FALSE(c.set_input("furlong"));
    REQUIRE(c.input() == "db");
    REQUIRE_FALSE(c.set_dataspace("colour"));
    REQUIRE(c.dataspace() == "gain");
    const auto out = c.convert(jamoma::Value{jamoma::Atom(-6.0)});
    REQUIRE(out.has_value());
    REQUIRE(close((*out)[0].as_double(), 0.501187, 1e-5));
    REQUIRE_FALSE(c.convert(jamoma::Value{}).has_value());
}

/** Review: setting and converting from two threads is race free (run under the thread sanitizer). */
TEST_CASE("unit converter is race free")
{
    jamoma::UnitConverter c;
    std::atomic<bool> stop{false};
    std::atomic<long> converted{0};
    std::thread reader([&] {
        while (!stop.load()) {
            if (c.convert(jamoma::Value{jamoma::Atom(1.0)})) {
                ++converted;
            }
        }
    });
    while (converted.load() == 0) {
        std::this_thread::yield(); // the other thread has to be running before the changes start, or the test tests nothing
    }
    for (int i = 0; i < 2000; ++i) {
        c.set_dataspace(i % 2 == 0 ? "gain" : "temperature");
        c.set_input(i % 2 == 0 ? "db" : "Celsius");
        c.set_output(i % 2 == 0 ? "linear" : "Fahrenheit");
    }
    stop = true;
    reader.join();
    REQUIRE(converted.load() > 0);
}

namespace {

/** Converts a colour. @param v The numbers. @param from The unit. @param to The unit. @param expected What should come out. */
void colour(const jamoma::Value& v, const char* from, const char* to, const std::vector<double>& expected)
{
    INFO(from << " -> " << to);
    const jamoma::Dataspace* space = jamoma::Dataspace::find("color");
    REQUIRE(space != nullptr);
    const auto out = space->convert(v, from, to);
    REQUIRE(out);
    REQUIRE(out->size() == expected.size());
    for (std::size_t i = 0; i < expected.size(); ++i) {
        INFO("element " << i << ": " << out->at(i).as_double());
        REQUIRE(close(out->at(i).as_double(), expected[i]));
    }
}

} // namespace

/** The colour dataspace: neutral rgb, with cmy, hsl, hsv and rgb8 (the cases of the old ColorDataspace test among them). */
TEST_CASE("color conversions to and from rgb")
{
    const jamoma::Dataspace* space = jamoma::Dataspace::find("color");
    REQUIRE(space != nullptr);
    CHECK(space->default_unit() == "rgb");
    CHECK(space->unit_names() == std::vector<std::string>{"cmy", "hsl", "hsv", "rgb", "rgb8"});
    const auto names = jamoma::Dataspace::names();
    CHECK(std::find(names.begin(), names.end(), "color") != names.end());
    colour({0.1, 0.6, 0.9}, "rgb", "rgb", {0.1, 0.6, 0.9});
    colour({255.0, 127.5, 0.0}, "cmy", "rgb", {0.0, 0.5, 1.0});
    colour({0.0, 0.5, 1.0}, "rgb", "cmy", {255.0, 127.5, 0.0});
    colour({255.0, 127.5, 0.0}, "rgb8", "rgb", {1.0, 0.5, 0.0});
    colour({1.0, 0.5, 0.0}, "rgb", "rgb8", {255.0, 127.5, 0.0});
    colour({120.0, 100.0, 50.0}, "hsl", "rgb", {0.0, 1.0, 0.0});
    colour({0.0, 1.0, 0.0}, "rgb", "hsl", {120.0, 100.0, 50.0});
    colour({240.0, 50.0, 75.0}, "hsl", "rgb", {0.625, 0.625, 0.875});
    colour({0.625, 0.625, 0.875}, "rgb", "hsl", {240.0, 50.0, 75.0});
    colour({120.0, 100.0, 100.0}, "hsv", "rgb", {0.0, 1.0, 0.0});
    colour({0.0, 1.0, 0.0}, "rgb", "hsv", {120.0, 100.0, 100.0});
    colour({30.0, 100.0, 50.0}, "hsv", "rgb", {0.5, 0.25, 0.0});
    colour({210.0, 50.0, 80.0}, "hsv", "rgb", {0.4, 0.6, 0.8});
    colour({300.0, 100.0, 100.0}, "hsv", "rgb", {1.0, 0.0, 1.0});
}

/** Greys, hues outside the circle and short lists give plain numbers. */
TEST_CASE("color conversions at the edges")
{
    colour({0.5, 0.5, 0.5}, "rgb", "hsv", {0.0, 0.0, 50.0});
    colour({0.0, 0.0, 0.0}, "rgb", "hsv", {0.0, 0.0, 0.0});
    colour({0.5, 0.5, 0.5}, "rgb", "hsl", {0.0, 0.0, 50.0});
    colour({1.0, 1.0, 1.0}, "rgb", "hsl", {0.0, 0.0, 100.0});
    colour({360.0, 100.0, 100.0}, "hsv", "rgb", {1.0, 0.0, 0.0});
    colour({-120.0, 100.0, 100.0}, "hsv", "rgb", {0.0, 0.0, 1.0});
    colour({840.0, 100.0, 50.0}, "hsl", "rgb", {0.0, 1.0, 0.0});
    colour({0.0, 0.0, 0.0}, "cmy", "rgb", {1.0, 1.0, 1.0});
    colour({1.0}, "rgb", "rgb8", {255.0, 0.0, 0.0});
    colour({std::numeric_limits<double>::infinity(), 100.0, 100.0}, "hsv", "rgb", {1.0, 0.0, 0.0});
}
