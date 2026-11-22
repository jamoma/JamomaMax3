// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file dataspace.hpp
 * @brief Dataspaces: measurement units and conversion between them (gain, time, position).
 */

#pragma once

#include <optional>
#include <mutex>
#include <string>
#include <vector>
#include <string_view>

#include "jamoma/atom.hpp"
#include "jamoma/export.hpp"

namespace jamoma {

/**
 * @brief A set of units that can be converted into each other through a neutral unit.
 *
 * Ported from the old DataspaceLib. Gain: neutral unit linear; units linear, midigain, dB and db-raw. Time: neutral unit second;
 * units second, ms, sample (at 44100 Hz), bpm, Hz, midinote, cents, mel and bark. Position: neutral unit cart3D; units cart3D (xyz),
 * cart2D (xy), spherical (aed), polar (ad), openGL and cylindrical (daz). Units have aliases (dB and db, ms and millisecond, and so on).
 * Scalar units convert every element of a list; position units convert the whole vector (missing elements count as 0).
 */
class JAMOMA_API Dataspace {
public:
    struct Impl;                         /**< The unit tables (an incomplete type outside the library). */

    /**
     * @brief Finds a dataspace.
     * @param name gain, time or position.
     * @return The dataspace, or null for an unknown name.
     */
    static const Dataspace* find(std::string_view name);

    /** @return The names of the dataspaces that exist, in a fixed order (gain, time, position, temperature). */
    static std::vector<std::string> names();
    /** @return The canonical name of every unit of this dataspace (the first of each unit's names), in the order they were defined. */
    std::vector<std::string> unit_names() const;
    /** @return The name of the dataspace. */
    const std::string& name() const;
    /** @return The name of the neutral unit, which is the default unit. */
    std::string default_unit() const;
    /**
     * @brief Tells whether a unit (or an alias of it) belongs to the dataspace.
     * @param unit The unit name.
     * @return True if known.
     */
    bool has_unit(std::string_view unit) const;
    /**
     * @brief Converts a value between two units of this dataspace.
     * @param input The value.
     * @param from The unit of the input.
     * @param to The unit of the result.
     * @return The converted value, or nothing if either unit is unknown.
     */
    std::optional<Value> convert(const Value& input, std::string_view from, std::string_view to) const;

private:
    /** Creates a dataspace over its tables. @param impl The tables. */
    explicit Dataspace(const Impl* impl) : impl_(impl) {}
    const Impl* impl_;                   /**< The tables of this dataspace. */
    friend struct DataspaceTables;       /**< Builds the dataspaces. */
};

/**
 * @brief The state of a unit converter such as j.unit: a dataspace and the units numbers come in and go out in. Safe to use from several threads.
 *
 * Starts in the temperature dataspace (the old j.unit default) with both units at its neutral unit. Setting the dataspace resets both units to
 * the neutral unit of the new one. A name that does not exist is refused and changes nothing.
 */
class JAMOMA_API UnitConverter {
public:
    /** @brief Sets the dataspace and resets both units to its neutral unit. @param name The dataspace. @return False if there is no such dataspace. */
    bool set_dataspace(std::string_view name);
    /** @brief Sets the unit of the incoming numbers. @param unit The unit. @return False if the current dataspace has no such unit. */
    bool set_input(std::string_view unit);
    /** @brief Sets the unit of the outgoing numbers. @param unit The unit. @return False if the current dataspace has no such unit. */
    bool set_output(std::string_view unit);
    /** @return The dataspace name. */
    std::string dataspace() const;
    /** @return The unit of the incoming numbers. */
    std::string input() const;
    /** @return The unit of the outgoing numbers. */
    std::string output() const;
    /** @brief Converts a number or list. @param value The input in the input unit. @return The result in the output unit, or nothing for an empty input. */
    std::optional<Value> convert(const Value& value) const;

private:
    mutable std::mutex mutex_;                   /**< Guards the three names. */
    std::string dataspace_ = "temperature";      /**< The dataspace name. */
    std::string input_ = "Kelvin";               /**< The input unit. */
    std::string output_ = "Kelvin";              /**< The output unit. */
};

} // namespace jamoma
