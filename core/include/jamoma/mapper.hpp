// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file mapper.hpp
 * @brief The mapper behind `j.map`: y = f(x) between a range of inputs and a range of outputs, optionally bound to two parameters.
 *
 * The law is that of the old mapper (docs/inventory/j.map.md): clip the input to its range if the clip mode says so, scale it to 0..1, shape it
 * with a function of the library and scale to the output range (`inverse` flips the curve); the output is not clipped. An input or output address binds
 * the mapper to a parameter: values that the input parameter outputs are mapped and sent to the output parameter; the ranges of the two
 * parameters are followed until a limit is set by hand.
 */

#pragma once

#include <functional>
#include <memory>
#include <string>
#include <string_view>
#include <vector>

#include "jamoma/address.hpp"
#include "jamoma/atom.hpp"
#include "jamoma/export.hpp"
#include "jamoma/namespace.hpp"

namespace jamoma {

/** What happens to an input outside the input range. */
enum class MapperClip {
    None,  /**< Nothing: the value goes through the function as it is (the default, as in the old mapper). */
    Low,   /**< Values below the low end become the low end. */
    High,  /**< Values above the high end become the high end. */
    Both   /**< Both. */
};

/** The plain settings of a mapper. */
struct MapperSettings {
    double input_min = 0.0;   /**< The low end of the input range. */
    double input_max = 1.0;   /**< The high end of the input range. */
    double output_min = 0.0;  /**< The low end of the output range. */
    double output_max = 1.0;  /**< The high end of the output range. */
    bool inverse = false;     /**< Flip the curve: the function is applied to 1 - t. */
    bool active = true;       /**< Off: process() does nothing (map() still works). */
    double ramp = 0.0;        /**< A ramp time in milliseconds added to the commands sent to the output parameter (0 = none). */
    MapperClip clipmode = MapperClip::None;  /**< What happens to an input outside the input range. */
    unsigned input_index = 0; /**< If 1 or more and a list arrives: map only that item of the list (counted from 1). */
    double input_threshold_down = 0.0;   /**< The input is "going down" when it is at or below this. */
    double input_threshold_up = 1.0;     /**< The input is "going up" when it is at or above this. */
    double output_threshold_down = 0.0;  /**< The output is "going down" when it is at or below this. */
    double output_threshold_up = 1.0;    /**< The output is "going up" when it is at or above this. */
};

/**
 * @brief Maps numbers and, if bound, parameters. All members may be called from any thread; callbacks run without the internal lock.
 */
class JAMOMA_API Mapper {
public:
    /** @param ns The namespace the bound parameters live in (it must outlive the mapper). */
    explicit Mapper(Namespace& ns);
    ~Mapper();
    Mapper(const Mapper&) = delete;            /**< A mapper is never copied. */
    Mapper& operator=(const Mapper&) = delete; /**< A mapper is never assigned. */

    /** @return The settings now. */
    MapperSettings settings() const;
    /** @brief Sets a limit by hand; the range of a bound input parameter is no longer followed. @param v The value. */
    void set_input_min(double v);
    /** @copydoc set_input_min */
    void set_input_max(double v);
    /** @brief Sets a limit by hand; the range of a bound output parameter is no longer followed. @param v The value. */
    void set_output_min(double v);
    /** @copydoc set_output_min */
    void set_output_max(double v);
    /** @brief Sets what happens to an input outside the input range. @param mode The mode. */
    void set_clipmode(MapperClip mode);
    /** @brief Sets which item of a list is mapped (0 = all). @param index The position, counted from 1. */
    void set_input_index(unsigned index);
    /** @brief Sets a threshold; the thresholds of a bound parameter follow its range like the limits do. @param v The value. */
    void set_input_threshold_down(double v);
    /** @copydoc set_input_threshold_down */
    void set_input_threshold_up(double v);
    /** @copydoc set_input_threshold_down */
    void set_output_threshold_down(double v);
    /** @copydoc set_input_threshold_down */
    void set_output_threshold_up(double v);
    /** @brief Flips the curve. @param on True to flip. */
    void set_inverse(bool on);
    /** @brief Switches process() on or off. @param on True for on. */
    void set_active(bool on);
    /** @brief Sets the ramp time of the commands sent to the output parameter. @param ms Milliseconds; zero or less = none. */
    void set_ramp(double ms);

    /**
     * @brief Chooses the function; its parameters go back to their defaults.
     * @param name A name of function_names() ("linear" at the start).
     * @return False for an unknown name (the previous function stays).
     */
    bool set_function(std::string_view name);
    /** @return The name of the function. */
    std::string function() const;
    /** @brief Sets a parameter of the function (see Function::set). @param parameter Its name. @param value Its value. @return False if refused. */
    bool set_function_parameter(std::string_view parameter, const Value& value);
    /** @brief Reads a parameter of the function. @param parameter Its name. @return The value (empty if there is no such parameter). */
    Value function_parameter(std::string_view parameter) const;
    /** @return The names of the parameters of the function. */
    std::vector<std::string> function_parameters() const;

    /**
     * @brief Maps one number by the law above.
     * @param x The input; NaN gives the low end of the output range, infinity is clipped like any large number.
     * @return The output (finite, inside the output range).
     */
    double map(double x);
    /** @brief Maps every number of a value; atoms that are not numbers pass through unchanged. @param in The input. @return The output, as many atoms. */
    Value map(const Value& in);
    /** @brief The curve: `count` outputs for inputs evenly spread over `[input_min, input_max)`, with a copy of the function (its state is not touched). @param count How many (default 100). @return The outputs. */
    std::vector<double> samples(std::size_t count = 100) const;
    /** @brief Forgets the state of the function (the filter `lowpass` has some). */
    void reset();

    /** @brief Binds the input to a parameter and takes over its range; the empty address unbinds. @param address The address of the parameter. */
    void bind_input(const Address& address);
    /** @brief Binds the output to a parameter and takes over its range; the empty address unbinds. @param address The address of the parameter. */
    void bind_output(const Address& address);
    /** @return The address the input is bound to (empty if none). */
    Address input() const;
    /** @return The address the output is bound to (empty if none). */
    Address output() const;
    /** @brief Sets the function that gets every mapped value (what the data outlet of `j.map` outputs). @param callback The function. */
    void set_return(std::function<void(const Value&)> callback);
    /**
     * @brief Sets the function that is told when the input or the output crosses a threshold.
     * @param callback Called with `input/going/down`, `input/going/up`, `output/going/down` or `output/going/up` and the new state, each time the state changes.
     */
    void set_threshold_callback(std::function<void(std::string_view name, bool state)> callback);
    /**
     * @brief What arrives at the input: if active, maps it, sends it to the output parameter (with the ramp, if any) and calls the return function.
     * @param in The input value.
     */
    void process(const Value& in);

    struct Impl;                  /**< The state, defined in the source file (public only so that its helper functions can name it). */

private:
    std::shared_ptr<Impl> impl_;  /**< The state, shared weakly with the callbacks of the namespace and the bound parameters. */
};

} // namespace jamoma
