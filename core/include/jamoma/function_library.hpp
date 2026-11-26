// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file function_library.hpp
 * @brief The function library of `j.map`: curves from 0..1 to 0..1 that shape a mapping.
 *
 * The eleven functions of the old Jamoma function library, with the same names, parameters (named, as the old attributes were)
 * and formulas. A function is made by name; it has named parameters; applying it to a number in 0..1 gives the shaped number.
 * Input outside 0..1 is clipped to it (NaN gives 0), so the result is always finite. `lowpass` is a filter and keeps its state
 * between calls; the others have none.
 */

#pragma once

#include <memory>
#include <string>
#include <string_view>
#include <vector>

#include "jamoma/atom.hpp"
#include "jamoma/export.hpp"

namespace jamoma {

/** @return The names of the functions, in the order j.map lists them: cosine, crossFadeIn, crossFadeOut, exponential, freehand, linear, logarithm, lowpass, power, smoothPolynomial, tanh. */
JAMOMA_API std::vector<std::string> function_names();

/** @brief One function of the library, with its parameters. */
class JAMOMA_API Function {
public:
    virtual ~Function();
    Function(const Function&) = delete;            /**< A function is never copied. */
    Function& operator=(const Function&) = delete; /**< A function is never assigned. */

    /**
     * @brief Makes a function with its default parameters.
     * @param name One of function_names() (exact spelling).
     * @return The function, or null if there is no function of that name.
     */
    static std::unique_ptr<Function> create(std::string_view name);

    /** @return The name of the function. */
    const std::string& name() const noexcept { return name_; }
    /** @return The names of the parameters (empty if there are none), in the order of the old attributes. */
    virtual std::vector<std::string> parameter_names() const;
    /**
     * @brief Reads a parameter.
     * @param parameter The parameter name.
     * @return Its value, or an empty value if there is no such parameter.
     */
    virtual Value get(std::string_view parameter) const;
    /**
     * @brief Sets a parameter; a value out of range is limited as the old attribute did, a value of the wrong kind is refused.
     * @param parameter The parameter name.
     * @param value The new value.
     * @return False if there is no such parameter or the value was refused (nothing changed).
     */
    virtual bool set(std::string_view parameter, const Value& value);
    /**
     * @brief Shapes a number.
     * @param x The input; limited to 0..1, NaN counts as 0.
     * @return The shaped number (finite).
     */
    double apply(double x);
    /** @brief Forgets the state of a filter (only `lowpass` has any). */
    virtual void reset();

protected:
    /** @param name The name of the function. */
    explicit Function(std::string name) : name_(std::move(name)) {}
    /** @brief The curve itself. @param x A number in 0..1. @return The shaped number. */
    virtual double calculate(double x) = 0;

private:
    std::string name_; /**< The name. */
};

} // namespace jamoma
