// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file dataspace.cpp
 * @brief Implementation of the gain, time and position dataspaces (formulas of the old DataspaceLib).
 */

#include "jamoma/dataspace.hpp"

#include <algorithm>
#include <cmath>
#include <functional>
#include <vector>

namespace jamoma {

namespace {

const double kPi = 3.14159265358979323846;                                              /**< Pi. */
const double kDegreesToRadians = kPi / 180.0;                                           /**< Degrees to radians. */
const double kRadiansToDegrees = 180.0 / kPi;                                           /**< Radians to degrees. */
const double kSampleRate = 44100.0;                                                     /**< Sample rate of the sample unit. */
const double kDecibelFloor = -96.0;                                                     /**< Lowest dB value, treated as silence. */
const double kMidiGainPow = std::log(12.0 / 96.0 + 1.0) / std::log(127.0 / 100.0);      /**< Exponent of the midigain curve (127 is +12 dB). */

/** A scalar conversion: one number to one number. */
using Scalar = std::function<double(double)>;
/** A vector conversion: a list of numbers to a list of numbers. */
using Vector = std::function<std::vector<double>(const std::vector<double>&)>;

/** @param v The numbers. @param i The index. @return v[i], or 0 if there is no such element. */
double at(const std::vector<double>& v, std::size_t i)
{
    return i < v.size() ? v[i] : 0.0;
}

} // namespace

/** One unit: its names and its conversions to and from the neutral unit. */
struct UnitDefinition {
    std::vector<std::string> names;   /**< The names; the first is the canonical one. */
    Scalar scalar_to;                 /**< Scalar: unit to neutral (empty for vector units). */
    Scalar scalar_from;               /**< Scalar: neutral to unit (empty for vector units). */
    Vector vector_to;                 /**< Vector: unit to neutral (empty for scalar units). */
    Vector vector_from;               /**< Vector: neutral to unit (empty for scalar units). */
};

/** The units of a dataspace. */
struct Dataspace::Impl {
    std::string name;                 /**< The dataspace name. */
    std::string neutral;              /**< The neutral unit. */
    std::vector<UnitDefinition> units; /**< The units. */

    /** @param unit A unit name or alias. @return The unit, or null. */
    const UnitDefinition* find_unit(std::string_view unit) const
    {
        for (const UnitDefinition& u : units) {
            for (const std::string& n : u.names) {
                if (n == unit) {
                    return &u;
                }
            }
        }
        return nullptr;
    }
};

namespace {

/** A scalar unit. @param names The names. @param to Unit to neutral. @param from Neutral to unit. @return The unit. */
UnitDefinition scalar_unit(std::vector<std::string> names, Scalar to, Scalar from)
{
    UnitDefinition u;
    u.names = std::move(names);
    u.scalar_to = std::move(to);
    u.scalar_from = std::move(from);
    return u;
}

/** A vector unit. @param names The names. @param to Unit to neutral. @param from Neutral to unit. @return The unit. */
UnitDefinition vector_unit(std::vector<std::string> names, Vector to, Vector from)
{
    UnitDefinition u;
    u.names = std::move(names);
    u.vector_to = std::move(to);
    u.vector_from = std::move(from);
    return u;
}

/** @return The gain dataspace tables. */
Dataspace::Impl make_gain()
{
    Dataspace::Impl d;
    d.name = "gain";
    d.neutral = "linear";
    d.units.push_back(scalar_unit({"linear"}, [](double x) { return x < 0.0 ? 0.0 : x; }, [](double x) { return x; }));
    d.units.push_back(scalar_unit(
        {"midigain"},
        [](double v) {
            if (v <= 0.0) {
                return 0.0;
            }
            const double db = 96.0 * (std::pow(v / 100.0, kMidiGainPow) - 1.0);
            return db <= kDecibelFloor ? 0.0 : std::pow(10.0, db * 0.05);
        },
        [](double v) {
            if (v <= 0.0) {
                return 0.0;
            }
            const double db = v >= 0.0 ? 20.0 * std::log10(v) : 0.0;
            return db <= kDecibelFloor ? 0.0 : 100.0 * std::exp(std::log(db / 96.0 + 1.0) / kMidiGainPow);
        }));
    d.units.push_back(scalar_unit(
        {"dB", "db"},
        [](double x) { return x <= kDecibelFloor ? 0.0 : std::pow(10.0, x * 0.05); },
        [](double x) {
            const double db = std::log10(x) * 20.0;
            return db < kDecibelFloor ? kDecibelFloor : db;
        }));
    d.units.push_back(scalar_unit({"db-raw", "dB-raw"}, [](double x) { return std::pow(10.0, x * 0.05); }, [](double x) { return std::log10(x) * 20.0; }));
    return d;
}

/** @return The angle dataspace tables (neutral: radian; angles are not wrapped). */
Dataspace::Impl make_angle()
{
    Dataspace::Impl d;
    d.name = "angle";
    d.neutral = "radian";
    d.units.push_back(scalar_unit({"radian", "rad"}, [](double x) { return x; }, [](double x) { return x; }));
    d.units.push_back(scalar_unit({"degree", "deg"}, [](double x) { return x * kDegreesToRadians; }, [](double x) { return x * kRadiansToDegrees; }));
    return d;
}

/** @param names The names. @param per_neutral How many of the unit make one neutral unit. @return A unit that is a plain division and multiplication. */
UnitDefinition divided_unit(std::vector<std::string> names, double per_neutral)
{
    return scalar_unit(std::move(names), [per_neutral](double x) { return x / per_neutral; }, [per_neutral](double x) { return x * per_neutral; });
}

/** @return The distance dataspace tables (neutral: meters; the factors for inches and feet are the rounded ones of the old library). */
Dataspace::Impl make_distance()
{
    Dataspace::Impl d;
    d.name = "distance";
    d.neutral = "meters";
    d.units.push_back(divided_unit({"meters", "m"}, 1.0));
    d.units.push_back(divided_unit({"centimeters", "cm"}, 100.0));
    d.units.push_back(divided_unit({"inches", "\""}, 39.37));
    d.units.push_back(divided_unit({"feet", "'"}, 3.281));
    return d;
}

/** @return The speed dataspace tables (neutral: meters per second; both factors of a unit are those of the old library, which are not exact inverses). */
Dataspace::Impl make_speed()
{
    Dataspace::Impl d;
    d.name = "speed";
    d.neutral = "m/s";
    const auto unit = [&d](std::vector<std::string> names, double to, double from) {
        d.units.push_back(scalar_unit(std::move(names), [to](double x) { return x * to; }, [from](double x) { return x * from; }));
    };
    unit({"m/s"}, 1.0, 1.0);
    unit({"mi/h", "mph"}, 0.44704, 2.236936);
    unit({"km/h", "kmph"}, 1.0 / 3.6, 3.6);
    unit({"kn"}, 0.514444, 1.943844);
    unit({"ft/s"}, 0.3048, 3.2808399);
    return d;
}

/** @return The none dataspace: one unit, which changes nothing. */
Dataspace::Impl make_none()
{
    Dataspace::Impl d;
    d.name = "none";
    d.neutral = "none";
    d.units.push_back(vector_unit({"none"}, [](const std::vector<double>& v) { return v; }, [](const std::vector<double>& v) { return v; }));
    return d;
}

/** @param yaw_pitch_roll Angles in degrees. @return The rotation as a quaternion x y z w. */
std::vector<double> euler_to_quaternion(const std::vector<double>& yaw_pitch_roll)
{
    const double yaw = at(yaw_pitch_roll, 0) * kDegreesToRadians * -0.5;
    const double pitch = at(yaw_pitch_roll, 1) * kDegreesToRadians * 0.5;
    const double roll = at(yaw_pitch_roll, 2) * kDegreesToRadians * 0.5;
    const double sy = std::sin(yaw), cy = std::cos(yaw);
    const double sp = std::sin(pitch), cp = std::cos(pitch);
    const double sr = std::sin(roll), cr = std::cos(roll);
    return {cy * sp * cr - sy * cp * sr, cy * cp * sr + sy * sp * cr, sy * cp * cr + cy * sp * sr, cy * cp * cr - sy * sp * sr};
}

/** @param q A quaternion x y z w. @return Yaw, pitch and roll in degrees. */
std::vector<double> quaternion_to_euler(const std::vector<double>& q)
{
    const double x = at(q, 0), y = at(q, 1), z = at(q, 2), w = at(q, 3);
    const double sine = std::clamp(2.0 * (w * x + y * z), -1.0, 1.0); // rounding may push it past 1 at the poles
    return {kRadiansToDegrees * std::atan2(-2.0 * (z * w - x * y), w * w - x * x + y * y - z * z),
            kRadiansToDegrees * std::asin(sine),
            kRadiansToDegrees * std::atan2(2.0 * (w * y + x * z), w * w - x * x - y * y + z * z)};
}

/** @param axis_angle An axis x y z (any length) and an angle in degrees. @return The rotation as a quaternion; a zero axis gives x y z of 0. */
std::vector<double> axis_to_quaternion(const std::vector<double>& axis_angle)
{
    const double x = at(axis_angle, 0), y = at(axis_angle, 1), z = at(axis_angle, 2);
    const double half = at(axis_angle, 3) * kDegreesToRadians * 0.5;
    const double length = std::sqrt(x * x + y * y + z * z);
    const double scale = length > 0.0 ? std::sin(half) / length : 0.0;
    return {x * scale, y * scale, z * scale, std::cos(half)};
}

/** @param q A quaternion x y z w. @return The axis x y z and the angle in degrees. */
std::vector<double> quaternion_to_axis(const std::vector<double>& q)
{
    const double w = at(q, 3);
    const double sine = std::sqrt(std::max(0.0, 1.0 - w * w));
    const double scale = sine < 0.0005 ? 1.0 : 1.0 / sine;
    return {at(q, 0) * scale, at(q, 1) * scale, at(q, 2) * scale, kRadiansToDegrees * 2.0 * std::atan2(sine, w)};
}

/** @return The orientation dataspace tables (neutral: quaternion x y z w). */
Dataspace::Impl make_orientation()
{
    Dataspace::Impl d;
    d.name = "orientation";
    d.neutral = "quaternion";
    d.units.push_back(vector_unit({"quaternion", "quat"}, [](const std::vector<double>& v) { return v; }, [](const std::vector<double>& v) { return v; }));
    d.units.push_back(vector_unit({"euler", "ypr"}, euler_to_quaternion, quaternion_to_euler));
    d.units.push_back(vector_unit({"axis", "xyza"}, axis_to_quaternion, quaternion_to_axis));
    return d;
}

/** @param degrees A hue. @return It within [0, 360); 0 if it is not finite. */
double wrap_hue(double degrees)
{
    if (!std::isfinite(degrees)) {
        return 0.0;
    }
    const double h = std::fmod(degrees, 360.0);
    return h < 0.0 ? h + 360.0 : h;
}

/**
 * @brief The red, green and blue of a hue between a darkest and a lightest level.
 * @param hue The hue in degrees. @param low The level of the weakest component. @param high The level of the strongest. @return The three components.
 */
std::vector<double> hue_to_rgb(double hue, double low, double high)
{
    const auto component = [&](double h) {
        h = wrap_hue(h);
        if (h < 60.0) {
            return low + (high - low) * h / 60.0;
        }
        if (h < 180.0) {
            return high;
        }
        if (h < 240.0) {
            return low + (high - low) * (240.0 - h) / 60.0;
        }
        return low;
    };
    const double h = wrap_hue(hue); // before the thirds are added: a hue that is not finite counts as 0
    return {component(h + 120.0), component(h), component(h - 120.0)};
}

/** The strongest and weakest component of a colour, and its hue. */
struct Spread {
    double high; /**< The strongest of red, green and blue. */
    double low;  /**< The weakest. */
    double hue;  /**< The hue in degrees; 0 for a grey. */
};

/** @param rgb Red, green and blue. @return Their strongest, weakest and hue. */
Spread spread_of(const std::vector<double>& rgb)
{
    const double r = at(rgb, 0);
    const double g = at(rgb, 1);
    const double b = at(rgb, 2);
    Spread s{std::max({r, g, b}), std::min({r, g, b}), 0.0};
    const double delta = s.high - s.low;
    if (delta != 0.0) {
        const double sixths = s.high == r ? (g - b) / delta : s.high == g ? 2.0 + (b - r) / delta : 4.0 + (r - g) / delta;
        s.hue = wrap_hue(60.0 * sixths);
    }
    return s;
}

/** @param v A colour. @param scale A factor. @param offset Added after the factor. @return The first three elements, each times the factor plus the offset. */
std::vector<double> scaled(const std::vector<double>& v, double scale, double offset)
{
    return {at(v, 0) * scale + offset, at(v, 1) * scale + offset, at(v, 2) * scale + offset};
}

/** @return The colour dataspace tables (neutral: rgb from 0 to 1; hue in degrees, saturation, lightness and value from 0 to 100). */
Dataspace::Impl make_color()
{
    using V = const std::vector<double>&;
    Dataspace::Impl d;
    d.name = "color";
    d.neutral = "rgb";
    d.units.push_back(vector_unit({"cmy"}, [](V v) { return scaled(v, -1.0 / 255.0, 1.0); }, [](V v) { return scaled(v, -255.0, 255.0); }));
    d.units.push_back(vector_unit(
        {"hsl"},
        [](V v) {
            const double s = at(v, 1) / 100.0;
            const double l = at(v, 2) / 100.0;
            const double high = l <= 0.5 ? l * (1.0 + s) : l + s - l * s;
            return hue_to_rgb(at(v, 0), 2.0 * l - high, high);
        },
        [](V v) {
            const Spread c = spread_of(v);
            const double l = (c.high + c.low) / 2.0;
            const double range = l < 0.5 ? c.high + c.low : 2.0 - c.high - c.low;
            const double s = c.high == c.low || range == 0.0 ? 0.0 : (c.high - c.low) / range;
            return std::vector<double>{c.hue, s * 100.0, l * 100.0};
        }));
    d.units.push_back(vector_unit(
        {"hsv"},
        [](V v) {
            const double value = at(v, 2) / 100.0;
            return hue_to_rgb(at(v, 0), value * (1.0 - at(v, 1) / 100.0), value);
        },
        [](V v) {
            const Spread c = spread_of(v);
            const double s = c.high == 0.0 ? 0.0 : (c.high - c.low) / c.high;
            return std::vector<double>{c.hue, s * 100.0, c.high * 100.0};
        }));
    d.units.push_back(vector_unit({"rgb"}, [](V v) { return scaled(v, 1.0, 0.0); }, [](V v) { return scaled(v, 1.0, 0.0); }));
    d.units.push_back(vector_unit({"rgb8"}, [](V v) { return scaled(v, 1.0 / 255.0, 0.0); }, [](V v) { return scaled(v, 255.0, 0.0); }));
    return d;
}

/** @return The temperature dataspace tables. */
Dataspace::Impl make_temperature()
{
    Dataspace::Impl d;
    d.name = "temperature";
    d.neutral = "Kelvin";
    d.units.push_back(scalar_unit({"Kelvin", "K"}, [](double x) { return x; }, [](double x) { return x; }));
    d.units.push_back(scalar_unit({"Celsius", "C"}, [](double x) { return x + 273.15; }, [](double x) { return x - 273.15; }));
    d.units.push_back(scalar_unit({"Fahrenheit", "F"}, [](double x) { return (x + 459.67) / 1.8; }, [](double x) { return x * 1.8 - 459.67; }));
    return d;
}

Dataspace::Impl make_time()
{
    Dataspace::Impl d;
    d.name = "time";
    d.neutral = "second";
    d.units.push_back(scalar_unit({"second", "s"}, [](double x) { return x; }, [](double x) { return x; }));
    d.units.push_back(scalar_unit({"ms", "millisecond"}, [](double x) { return 0.001 * x; }, [](double x) { return 1000.0 * x; }));
    d.units.push_back(scalar_unit({"sample"}, [](double x) { return x / kSampleRate; }, [](double x) { return x * kSampleRate; }));
    d.units.push_back(scalar_unit({"bpm"}, [](double x) { return 60.0 / x; }, [](double x) { return 60.0 / x; }));
    d.units.push_back(scalar_unit({"Hz", "hz", "Hertz", "fps"}, [](double x) { return 1.0 / x; }, [](double x) { return 1.0 / x; }));
    d.units.push_back(scalar_unit(
        {"midinote"},
        [](double x) { return 1.0 / (440.0 * std::pow(2.0, (x - 69.0) / 12.0)); },
        [](double x) { return 69.0 - 12.0 * std::log(440.0 * x) / std::log(2.0); }));
    d.units.push_back(scalar_unit(
        {"cents"},
        [](double x) { return 1.0 / (440.0 * std::pow(2.0, (x - 6900.0) / 1200.0)); },
        [](double x) { return 6900.0 + 1200.0 * std::log(1.0 / (440.0 * x)) / std::log(2.0); }));
    d.units.push_back(scalar_unit(
        {"mel"},
        [](double x) { return 1.0 / (700.0 * (std::pow(10.0, x / 2595.0) - 1.0)); },
        [](double x) { return 2595.0 * std::log10(1.0 + 1.0 / (x * 700.0)); }));
    d.units.push_back(scalar_unit(
        {"bark"},
        [](double x) { return 1.0 / (600.0 * std::sinh(x / 6.0)); },
        [](double x) { return 6.0 * std::asinh(1.0 / (x * 600.0)); }));
    // Playback speed: the period is inversely proportional to it (speed 2^(n/12) sounds like MIDI note n); the same formula both ways.
    const auto speed = [](double x) { return std::pow(2.0, 69.0 / 12.0) / (440.0 * x); };
    d.units.push_back(scalar_unit({"speed"}, speed, speed));
    return d;
}

/** @return The position dataspace tables (neutral unit: cartesian x y z). */
Dataspace::Impl make_position()
{
    Dataspace::Impl d;
    d.name = "position";
    d.neutral = "cart3D";
    d.units.push_back(vector_unit(
        {"cart3D", "xyz"},
        [](const std::vector<double>& v) { return std::vector<double>{at(v, 0), at(v, 1), at(v, 2)}; },
        [](const std::vector<double>& v) { return std::vector<double>{at(v, 0), at(v, 1), at(v, 2)}; }));
    d.units.push_back(vector_unit(
        {"cart2D", "xy"},
        [](const std::vector<double>& v) { return std::vector<double>{at(v, 0), at(v, 1), 0.0}; },
        [](const std::vector<double>& v) { return std::vector<double>{at(v, 0), at(v, 1)}; }));
    d.units.push_back(vector_unit(
        {"spherical", "aed"},
        [](const std::vector<double>& v) {
            const double a = at(v, 0) * kDegreesToRadians;
            const double e = at(v, 1) * kDegreesToRadians;
            const double dist = at(v, 2);
            const double t = std::cos(e) * dist;
            return std::vector<double>{std::sin(a) * t, std::cos(a) * t, std::sin(e) * dist};
        },
        [](const std::vector<double>& v) {
            const double x = at(v, 0);
            const double y = at(v, 1);
            const double z = at(v, 2);
            const double t = x * x + y * y;
            return std::vector<double>{std::atan2(x, y) * kRadiansToDegrees, std::atan2(z, std::sqrt(t)) * kRadiansToDegrees, std::sqrt(t + z * z)};
        }));
    d.units.push_back(vector_unit(
        {"polar", "ad"},
        [](const std::vector<double>& v) {
            const double a = at(v, 0) * kDegreesToRadians;
            const double dist = at(v, 1);
            return std::vector<double>{std::sin(a) * dist, std::cos(a) * dist, 0.0};
        },
        [](const std::vector<double>& v) {
            const double x = at(v, 0);
            const double y = at(v, 1);
            return std::vector<double>{std::atan2(x, y) * kRadiansToDegrees, std::sqrt(x * x + y * y)};
        }));
    d.units.push_back(vector_unit(
        {"openGL"},
        [](const std::vector<double>& v) { return std::vector<double>{at(v, 0), -1.0 * at(v, 2), at(v, 1)}; },
        [](const std::vector<double>& v) { return std::vector<double>{at(v, 0), at(v, 2), -1.0 * at(v, 1)}; }));
    d.units.push_back(vector_unit(
        {"cylindrical", "daz"},
        [](const std::vector<double>& v) {
            const double dist = at(v, 0);
            const double a = at(v, 1) * kDegreesToRadians;
            return std::vector<double>{std::sin(a) * dist, std::cos(a) * dist, at(v, 2)};
        },
        [](const std::vector<double>& v) {
            const double x = at(v, 0);
            const double y = at(v, 1);
            return std::vector<double>{std::sqrt(x * x + y * y), std::atan2(x, y) * kRadiansToDegrees, at(v, 2)};
        }));
    return d;
}

} // namespace

/** Builds and finds the dataspaces. */
struct DataspaceTables {
    /** @param name The dataspace name. @return The dataspace, or null. */
    static const Dataspace* get(std::string_view name)
    {
        static const Dataspace::Impl gain_impl = make_gain();
        static const Dataspace::Impl time_impl = make_time();
        static const Dataspace::Impl position_impl = make_position();
        static const Dataspace::Impl temperature_impl = make_temperature();
        static const Dataspace gain(&gain_impl);
        static const Dataspace time(&time_impl);
        static const Dataspace position(&position_impl);
        static const Dataspace temperature(&temperature_impl);
        static const Dataspace::Impl color_impl = make_color();
        static const Dataspace color(&color_impl);
        static const Dataspace::Impl angle_impl = make_angle();
        static const Dataspace angle(&angle_impl);
        static const Dataspace::Impl distance_impl = make_distance();
        static const Dataspace distance(&distance_impl);
        static const Dataspace::Impl speed_impl = make_speed();
        static const Dataspace speed(&speed_impl);
        static const Dataspace::Impl orientation_impl = make_orientation();
        static const Dataspace orientation(&orientation_impl);
        static const Dataspace::Impl none_impl = make_none();
        static const Dataspace none(&none_impl);
        if (name == "gain") return &gain;
        if (name == "time") return &time;
        if (name == "position") return &position;
        if (name == "temperature") return &temperature;
        if (name == "color") return &color;
        if (name == "angle") return &angle;
        if (name == "distance") return &distance;
        if (name == "speed") return &speed;
        if (name == "orientation") return &orientation;
        if (name == "none") return &none;
        return nullptr;
    }
};

const Dataspace* Dataspace::find(std::string_view name)
{
    return DataspaceTables::get(name);
}

const std::string& Dataspace::name() const
{
    return impl_->name;
}

std::string Dataspace::default_unit() const
{
    return impl_->neutral;
}

std::vector<std::string> Dataspace::names() { return {"none", "gain", "time", "position", "temperature", "color", "angle", "distance", "speed", "orientation"}; }

std::vector<std::string> Dataspace::unit_names() const
{
    std::vector<std::string> out;
    for (const UnitDefinition& u : impl_->units) {
        out.push_back(u.names.front());
    }
    return out;
}

bool Dataspace::has_unit(std::string_view unit) const
{
    return impl_->find_unit(unit) != nullptr;
}

std::optional<Value> Dataspace::convert(const Value& input, std::string_view from, std::string_view to) const
{
    const UnitDefinition* source = impl_->find_unit(from);
    const UnitDefinition* target = impl_->find_unit(to);
    if (source == nullptr || target == nullptr) {
        return std::nullopt;
    }
    if (impl_->name == "none") {
        return input; // as it came, words too
    }
    std::vector<double> numbers;
    numbers.reserve(input.size());
    for (const Atom& atom : input) {
        numbers.push_back(atom.as_double());
    }
    // Into the neutral unit.
    std::vector<double> neutral;
    if (source->scalar_to) {
        for (double x : numbers) {
            neutral.push_back(source->scalar_to(x));
        }
    } else {
        neutral = source->vector_to(numbers);
    }
    // Out of it.
    std::vector<double> result;
    if (target->scalar_from) {
        for (double x : neutral) {
            result.push_back(target->scalar_from(x));
        }
    } else {
        result = target->vector_from(neutral);
    }
    Value out;
    out.reserve(result.size());
    for (double x : result) {
        out.push_back(Atom(x));
    }
    return out;
}

bool UnitConverter::set_dataspace(std::string_view name)
{
    const Dataspace* d = Dataspace::find(name);
    if (d == nullptr) {
        return false;
    }
    std::lock_guard<std::mutex> lock(mutex_);
    dataspace_ = std::string(name);
    input_ = output_ = d->default_unit();
    return true;
}

bool UnitConverter::set_input(std::string_view unit)
{
    std::lock_guard<std::mutex> lock(mutex_);
    const Dataspace* d = Dataspace::find(dataspace_);
    if (d == nullptr || !d->has_unit(unit)) {
        return false;
    }
    input_ = std::string(unit);
    return true;
}

bool UnitConverter::set_output(std::string_view unit)
{
    std::lock_guard<std::mutex> lock(mutex_);
    const Dataspace* d = Dataspace::find(dataspace_);
    if (d == nullptr || !d->has_unit(unit)) {
        return false;
    }
    output_ = std::string(unit);
    return true;
}

std::string UnitConverter::dataspace() const
{
    std::lock_guard<std::mutex> lock(mutex_);
    return dataspace_;
}

std::string UnitConverter::input() const
{
    std::lock_guard<std::mutex> lock(mutex_);
    return input_;
}

std::string UnitConverter::output() const
{
    std::lock_guard<std::mutex> lock(mutex_);
    return output_;
}

std::optional<Value> UnitConverter::convert(const Value& value) const
{
    if (value.empty()) {
        return std::nullopt;
    }
    std::string space, from, to;
    {
        std::lock_guard<std::mutex> lock(mutex_);
        space = dataspace_;
        from = input_;
        to = output_;
    }
    const Dataspace* d = Dataspace::find(space);
    return d != nullptr ? d->convert(value, from, to) : std::nullopt;
}

} // namespace jamoma
