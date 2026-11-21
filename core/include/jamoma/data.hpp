// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file data.hpp
 * @brief The data object behind j.parameter, j.message and j.return.
 *
 * A port of the behaviour of the old TTData (TTData.cpp and TTDataTypedMethods.cpp): typed values, range and clip mode,
 * repetition filter, default and init, step size, active, and a re-entrancy guard. Units and ramps are added in later
 * tasks of milestone 1.
 */

#pragma once

#include <functional>
#include <memory>
#include <string>
#include <string_view>
#include <vector>

#include "jamoma/atom.hpp"
#include "jamoma/clip.hpp"
#include "jamoma/command.hpp"
#include "jamoma/export.hpp"
#include "jamoma/namespace.hpp"

namespace jamoma {

/** The type of the value of a data object. */
enum class DataType { None, Generic, String, Boolean, Integer, Decimal, Array };

/** The role of a data object in a model. */
enum class Service { Parameter, Message, Return };

/**
 * @brief The data type with a given name.
 * @param name One of none, generic, string, boolean, integer, decimal, array.
 * @return The type; Generic for an unknown name (as the old object did).
 */
JAMOMA_API DataType data_type_from_name(std::string_view name);

/**
 * @brief The name of a data type.
 * @param type The type.
 * @return Its name.
 */
JAMOMA_API std::string_view data_type_name(DataType type);

/**
 * @brief A typed, optionally ranged value that receives commands and outputs its value.
 *
 * Defaults per type (set by set_type, as the old setType): decimal and array: 0. with step 0.1 and range 0. 1.; integer: 0,
 * step 1, range 0 1; boolean: 0, step 1, range 0 1; string: the symbol none, no range; none: an empty value; generic: 0.
 * A step size or range set explicitly is kept across a type change; the value and the default are reset.
 *
 * Threading: the state is guarded by a mutex; the output callback runs without it. A command that arrives while another is
 * in progress (also from inside the output callback) is dropped, as the old object did.
 */
class JAMOMA_API Data : public Object {
public:
    /** @param service The role of the object. */
    explicit Data(Service service = Service::Parameter);
    ~Data() override;

    /** @return The role of the object. */
    Service service() const noexcept;

    /** @brief Sets the type and resets value and default; step size and range follow the type unless set explicitly. @param type The type. */
    void set_type(DataType type);
    /** @return The type. */
    DataType type() const;
    /** @brief Sets the range: two numbers (low, high) for numeric types, or the allowed symbols for a string. @param range The range. */
    void set_range(const Value& range);
    /** @return The range. */
    Value range() const;
    /** @brief Sets the clip mode applied to numeric values against a numeric range. @param mode The mode. */
    void set_clipmode(ClipMode mode);
    /** @return The clip mode. */
    ClipMode clipmode() const;
    /** @brief Sets the repetition filter: a value equal to the current one is not output again (once initialised). @param on True to filter. */
    void set_repetitions_filter(bool on);
    /** @return True if the repetition filter is on. */
    bool repetitions_filter() const;
    /** @brief Sets the default value that init sends. @param value The default. */
    void set_default(const Value& value);
    /** @return The default value. */
    Value default_value() const;
    /** @brief Sets the step size used by inc and dec. @param step The step. */
    void set_stepsize(double step);
    /** @return The step size. */
    double stepsize() const;
    /** @brief Activates or deactivates the object; an inactive object ignores commands. @param on True for active. */
    void set_active(bool on);
    /** @return True if active. */
    bool active() const;
    /** @brief Sets the initialisation priority. @param priority The priority. */
    void set_priority(int priority);
    /** @return The priority. */
    int priority() const;
    /** @brief Sets the description text. @param text The description. */
    void set_description(std::string text);
    /** @return The description. */
    std::string description() const;
    /** @brief Sets the tags. @param tags The tags. */
    void set_tags(std::vector<std::string> tags);
    /** @return The tags. */
    std::vector<std::string> tags() const;

    /** @brief Sets the dataspace (gain, time or position) of a numeric object; an unknown name disables conversion. @param name The dataspace name, or empty for none. */
    void set_dataspace(std::string name);
    /** @return The dataspace name, or an empty string. */
    std::string dataspace() const;
    /** @brief Sets the unit the object's value is kept in; a command may give its own unit. @param unit The unit name. */
    void set_unit(std::string unit);
    /** @return The unit of the value: the one set, else the neutral unit of the dataspace, else an empty string. */
    std::string unit() const;

    /** @return A copy of the current value. */
    Value value() const;
    /** @return True once a value has been output (or after a command) and until the next init. */
    bool initialized() const;

    /** @brief Sets the function that receives every output value. It is called without the object's lock. @param output The function. */
    void set_output(std::function<void(const Value&)> output);

    /**
     * @brief Sends a message to the object: parse (numeric types), convert to the type, repetition filter, clip, store, output.
     *
     * An empty message (a bang) outputs the current value. A symbol sent to a decimal, integer or array becomes 0; the boolean
     * type rejects a symbol silently. A string keeps only the first atom and turns a number into its text.
     * @param input The message.
     */
    void command(const Value& input);
    /** @brief Increases each element by step size times the first argument (1 without argument); `n ramp t` adds a ramp. Ignored for strings. @param args The arguments. */
    void inc(const Value& args);
    /** @brief The opposite of inc. @param args The arguments. */
    void dec(const Value& args);
    /** @brief Clears initialised and sends the default through command (nothing is sent for the none type or an unusable default). */
    void init();

private:
    struct Impl;                    /**< The state, hidden from the header. */
    std::unique_ptr<Impl> impl_;    /**< The state. */
};

} // namespace jamoma
