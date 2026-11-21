// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file atom.cpp
 * @brief Implementation of Atom and Value.
 */

#include "jamoma/atom.hpp"

#include <charconv>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <limits>

namespace jamoma {

std::int64_t Atom::as_int() const noexcept
{
    if (const auto* i = std::get_if<std::int64_t>(&data_)) {
        return *i;
    }
    if (const auto* d = std::get_if<double>(&data_)) {
        if (std::isnan(*d)) {
            return 0;
        }
        constexpr double upper = 9223372036854775808.0; // 2^63, not representable as int64
        if (*d >= upper) {
            return std::numeric_limits<std::int64_t>::max();
        }
        if (*d <= -upper) {
            return std::numeric_limits<std::int64_t>::min();
        }
        return static_cast<std::int64_t>(*d);
    }
    return 0;
}

double Atom::as_double() const noexcept
{
    if (const auto* i = std::get_if<std::int64_t>(&data_)) {
        return static_cast<double>(*i);
    }
    if (const auto* d = std::get_if<double>(&data_)) {
        return *d;
    }
    return 0.0;
}

std::string Atom::as_symbol() const
{
    if (const auto* s = std::get_if<std::string>(&data_)) {
        return *s;
    }
    return to_string();
}

std::string Atom::to_string() const
{
    if (const auto* s = std::get_if<std::string>(&data_)) {
        return *s;
    }
    char buffer[64];
    if (const auto* i = std::get_if<std::int64_t>(&data_)) {
        const auto result = std::to_chars(buffer, buffer + sizeof buffer, *i);
        return std::string(buffer, result.ptr);
    }
    const double d = std::get<double>(data_);
    if (std::isnan(d)) {
        return "nan";
    }
    if (std::isinf(d)) {
        return d > 0 ? "inf" : "-inf";
    }
    // std::to_chars for double needs macOS 13.3; find the shortest precision that reads back exactly instead.
    for (int precision = 1; precision <= 17; ++precision) {
        std::snprintf(buffer, sizeof buffer, "%.*g", precision, d);
        if (std::strtod(buffer, nullptr) == d) {
            break;
        }
    }
    std::string text(buffer);
    if (text.find_first_of(".eE") == std::string::npos) {
        text += ".0";
    }
    return text;
}

std::string to_string(const Value& value)
{
    std::string text;
    for (std::size_t i = 0; i < value.size(); ++i) {
        if (i != 0) {
            text += ' ';
        }
        text += value[i].to_string();
    }
    return text;
}

} // namespace jamoma
