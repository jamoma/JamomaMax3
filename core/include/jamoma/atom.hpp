// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file atom.hpp
 * @brief Atom and Value: the data that Jamoma objects exchange, independent of Max.
 */

#pragma once

#include <cstdint>
#include <string>
#include <variant>
#include <vector>

#include "jamoma/export.hpp"

namespace jamoma {

/**
 * @brief One item of a message: an integer, a floating-point number or a symbol (text).
 *
 * An integer and a float with the same numeric value are different atoms. Conversions never
 * invoke undefined behaviour: NaN becomes 0 as an integer and out-of-range floats saturate.
 */
class JAMOMA_API Atom {
public:
    /** Creates the integer 0. */
    Atom() : data_(std::int64_t{0}) {}
    /** Creates an integer atom. @param v The value. */
    Atom(std::int64_t v) : data_(v) {}
    /** Creates an integer atom from an int. @param v The value. */
    Atom(int v) : data_(static_cast<std::int64_t>(v)) {}
    /** Creates a float atom. @param v The value. */
    Atom(double v) : data_(v) {}
    /** Creates a symbol atom. @param v The text. */
    Atom(std::string v) : data_(std::move(v)) {}
    /** Creates a symbol atom. @param v The text. */
    Atom(const char* v) : data_(std::string(v)) {}

    /** @return True if the atom holds an integer. */
    bool is_int() const noexcept { return std::holds_alternative<std::int64_t>(data_); }
    /** @return True if the atom holds a float. */
    bool is_float() const noexcept { return std::holds_alternative<double>(data_); }
    /** @return True if the atom holds a symbol. */
    bool is_symbol() const noexcept { return std::holds_alternative<std::string>(data_); }
    /** @return True if the atom holds an integer or a float. */
    bool is_number() const noexcept { return !is_symbol(); }

    /**
     * @brief The atom as an integer.
     * @return The integer; a float truncated toward zero (NaN gives 0, out-of-range values saturate); 0 for a symbol.
     */
    std::int64_t as_int() const noexcept;
    /**
     * @brief The atom as a double.
     * @return The number; 0.0 for a symbol.
     */
    double as_double() const noexcept;
    /**
     * @brief The text of the atom.
     * @return The symbol itself, or the text form of a number (see to_string()).
     */
    std::string as_symbol() const;
    /**
     * @brief The text form of the atom.
     * @return An integer as digits; a float in the shortest form that reads back exactly, always with a decimal
     *         point or exponent (3.0 prints as "3.0"); a symbol as it is.
     */
    std::string to_string() const;

    /** @brief Atoms are equal if they have the same kind and the same content. @param other The atom to compare with. @return True if equal. */
    bool operator==(const Atom& other) const noexcept { return data_ == other.data_; }
    /** @brief Negation of operator==. @param other The atom to compare with. @return True if different. */
    bool operator!=(const Atom& other) const noexcept { return !(*this == other); }

private:
    std::variant<std::int64_t, double, std::string> data_; /**< The content. */
};

/** A message: a list of atoms. */
using Value = std::vector<Atom>;

/**
 * @brief The text form of a value.
 * @param value The value.
 * @return The text forms of its atoms, separated by single spaces.
 */
JAMOMA_API std::string to_string(const Value& value);

} // namespace jamoma
