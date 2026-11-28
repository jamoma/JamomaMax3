// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file remote_array.hpp
 * @brief The core of j.remote_array: one remote for every instance of a bracketed name.
 *
 * Rules: docs/inventory/j.array.md.
 */

#pragma once

#include <cstddef>
#include <cstdint>
#include <functional>
#include <memory>
#include <string>
#include <string_view>

#include "jamoma/address.hpp"
#include "jamoma/data_array.hpp"
#include "jamoma/export.hpp"
#include "jamoma/namespace.hpp"
#include "jamoma/remote.hpp"

namespace jamoma {

/**
 * @brief Links the numbered nodes of an array to one UI object (see Remote for what each link does).
 *
 * Threading as DataArray: set_name, resize, rebind and the destructor are for the main thread; node changes may come from any
 * thread. The callback is called without a lock and may call back into the array, also to resize it.
 */
class JAMOMA_API RemoteArray {
public:
    /** Turns the name of an instance into the address to bind (the object resolves it against its patcher). */
    using Resolve = std::function<Address(const std::string& instance_name)>;
    /** Receives the number of an instance (from 1) and its value, or all values in Array format. */
    using ToUi = std::function<void(std::size_t index, const Value& value)>;

    /** @param ns The namespace (it must outlive the array). @param to_ui Called with what the UI object should show. */
    RemoteArray(Namespace& ns, ToUi to_ui);
    ~RemoteArray();
    RemoteArray(const RemoteArray&) = delete;            /**< An array is never copied. */
    RemoteArray& operator=(const RemoteArray&) = delete; /**< An array is never assigned. */

    /** @brief Builds the array of a bracketed name, or changes it. @param name The name. @param resolve Resolves instance names. @return False for a bad name. */
    bool set_name(const std::string& name, Resolve resolve);
    /** @brief Changes the size. @param size The new size. @return False without a name or above kMaxArraySize. */
    bool resize(std::size_t size);
    /** @brief Resolves the instance names again and binds those whose address changed. */
    void rebind();
    /** @return The number of instances. */
    std::size_t size() const;
    /** @return The name with the present size in the bracket, or an empty string. */
    std::string name() const;
    /** @brief Selects the instances that values go to. @param which A number from 1, or `*`. @return False if refused. */
    bool select(const Atom& which);
    /** @return The selected instance, 0 for all. */
    std::size_t selected() const;
    /** @param index An instance, from 1. @return As DataArray::identity. */
    std::uint64_t identity(std::size_t index) const;
    /** @brief Remote::from_ui for the selected instances. @param value The value. @return False if the array is empty. */
    bool from_ui(const Value& value);
    /** @brief Remote::set_without_output for the selected instances. @param value The value. @return False if the array is empty. */
    bool set(const Value& value);
    /** @brief Sends equal parts of a list, one to each instance. @param list The list. @return False for a wrong length or an empty array. */
    bool array(const Value& list);
    /** @brief Like array(), showing nothing here. @param list The list. @return False for a wrong length or an empty array. */
    bool set_array(const Value& list);
    /** @brief Sets the unit of every instance. @param unit The unit. */
    void set_unit(std::string_view unit);
    /** @brief Activates or deactivates every instance. @param on True for active. */
    void set_active(bool on);
    /** @brief Freezes every instance. @param on True for frozen. */
    void set_freeze(bool on);
    /** @brief Sets what is shown. @param format The format. */
    void set_format(ArrayFormat format);
    /** @return The format. */
    ArrayFormat format() const;

private:
    struct Impl;                 /**< The state, hidden from the header. */
    std::shared_ptr<Impl> impl_; /**< The state (shared weakly with the instances' callbacks). */
};

} // namespace jamoma
