// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file dataspace.cpp
 * @brief Implementation of the gain, time and position dataspaces (formulas of the old DataspaceLib).
 */

#include "jamoma/dataspace.hpp"

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

/** @return The time dataspace tables. */
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
        if (name == "gain") return &gain;
        if (name == "time") return &time;
        if (name == "position") return &position;
        if (name == "temperature") return &temperature;
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

std::vector<std::string> Dataspace::names() { return {"gain", "time", "position", "temperature"}; }

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
