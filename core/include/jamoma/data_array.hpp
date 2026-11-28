// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file data_array.hpp
 * @brief The core of j.parameter_array, j.message_array and j.return_array: numbered data objects made from one bracketed name.
 *
 * Rules: docs/inventory/j.array.md.
 */

#pragma once

#include <cstddef>
#include <functional>
#include <memory>
#include <optional>
#include <string>
#include <string_view>

#include "jamoma/address.hpp"
#include "jamoma/array_name.hpp"
#include "jamoma/data.hpp"
#include "jamoma/export.hpp"
#include "jamoma/namespace.hpp"

namespace jamoma {

/** What the value outlet of an array carries: the value of the instance that changed, or the values of all instances. */
enum class ArrayFormat { Single, Array };

/**
 * @brief Owns the instances of an array and their registrations, and passes messages and attributes on to them.
 *
 * Threading: the structure calls (set_name, resize, the destructor) are for the main thread; values may be sent from any
 * thread. The output callback is called without a lock and may call back into the array, also to resize it; an instance that
 * has been removed is never reported.
 */
class JAMOMA_API DataArray {
public:
    /** Receives the number of an instance (from 1) and its value, or all values in Array format. */
    using Output = std::function<void(std::size_t index, const Value& value)>;
    /** Makes the clock of one instance (every instance ramps on its own). */
    using ClockMaker = std::function<std::unique_ptr<Clock>()>;

    /** @param ns The namespace (it must outlive the array). @param service The role of every instance. */
    DataArray(Namespace& ns, Service service);
    ~DataArray();
    DataArray(const DataArray&) = delete;            /**< An array is never copied. */
    DataArray& operator=(const DataArray&) = delete; /**< An array is never assigned. */

    /** @brief Sets what makes the clocks of instances created from now on. @param maker The function, or empty for no ramps. */
    void set_clock_maker(ClockMaker maker);
    /** @brief Sets the function that receives every output. @param output The function. */
    void set_output(Output output);
    /**
     * @brief Builds the array of a bracketed name below a prefix, or changes it.
     *
     * With a name of the same shape the instances that remain are kept (and registered again if the prefix changed); another
     * shape removes them all first.
     * @param name A relative bracketed name. @param prefix The address the name is below (empty: the root).
     * @param init_new Whether instances made now are initialised (messages never are).
     * @return False (nothing changes) for a bad or absolute name.
     */
    bool set_name(const std::string& name, const Address& prefix, bool init_new);
    /** @brief Changes the size. @param size The new size. @param init_new As for set_name. @return False without a name or above kMaxArraySize. */
    bool resize(std::size_t size, bool init_new);
    /** @return The number of instances. */
    std::size_t size() const;
    /** @return The name with the present size in the bracket, or an empty string. */
    std::string name() const;
    /** @brief Selects the instances that values go to. @param which A number from 1, or `*`. @return False if refused. */
    bool select(const Atom& which);
    /** @return The selected instance, 0 for all. */
    std::size_t selected() const;
    /** @brief Sends a message to the selected instances in index order. @param input The message. @return False if the array is empty. */
    bool command(const Value& input);
    /** @brief Data::inc on the selected instances. @param args The arguments. @return False if the array is empty. */
    bool inc(const Value& args);
    /** @brief Data::dec on the selected instances. @param args The arguments. @return False if the array is empty. */
    bool dec(const Value& args);
    /** @brief Cuts a list into equal parts, one for each instance. @param list The list. @return False for a wrong length or an empty array. */
    bool array(const Value& list);
    /**
     * @brief Sets an attribute of every instance and remembers it for instances made later.
     * @param name The attribute. @param value The value (`value` is a command to all, and is not remembered).
     * @return False for an unknown or read-only attribute or an empty value.
     */
    bool set_attribute(std::string_view name, const Value& value);
    /** @brief Reads an attribute of the watched instance (the selected one; with all selected, the one that output last). @param name The attribute. @return Its value, or nothing if unknown. */
    std::optional<Value> get_attribute(std::string_view name) const;
    /** @param name A name. @return True if the ramp function has a parameter of that name. */
    bool has_function_parameter(std::string_view name) const;
    /** @param name A parameter of the ramp function. @return Its value in the watched instance. */
    Value function_parameter(std::string_view name) const;
    /** @brief Sets a parameter of the ramp function in every instance and remembers it. @param name The parameter. @param value The value. @return False if refused. */
    bool set_function_parameter(std::string_view name, const Value& value);
    /** @brief Sets the output format. @param format The format. */
    void set_format(ArrayFormat format);
    /** @return The output format. */
    ArrayFormat format() const;
    /** @return The values of all instances in index order; one without a value gives its default, else 0 (a string: none). */
    Value collected() const;
    /** @brief Initialises every instance (nothing for messages). */
    void init();
    /** @brief Initialises the instances that have no value yet (parameters only: what a parameter without a model does). */
    void init_uninitialized();

private:
    struct Impl;                 /**< The state, hidden from the header. */
    std::shared_ptr<Impl> impl_; /**< The state (shared weakly with the instances' output functions). */
};

} // namespace jamoma
