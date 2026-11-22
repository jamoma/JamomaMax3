// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file address.hpp
 * @brief Address: an OSC-style address in the Jamoma namespace.
 */

#pragma once

#include <string>
#include <string_view>
#include <vector>

#include "jamoma/export.hpp"

namespace jamoma {

/** One step of an address path: a name with an optional instance. */
struct Segment {
    std::string name;     /**< The name before the first '.'. */
    std::string instance; /**< The text after the first '.'; empty means no instance. */

    /** @brief Segments are equal if name and instance are equal. @param other The segment to compare with. @return True if equal. */
    bool operator==(const Segment& other) const { return name == other.name && instance == other.instance; }
};

/**
 * @brief An address of the form `directory:/parent/name.instance:attribute`.
 *
 * Rules (from the old Jamoma addresses): the directory is the text before a `:/` (and may not contain a slash);
 * the attribute is the text after a last colon that is followed by no slash; the instance of a segment is the text after
 * its first dot, and the instance `0` is the same as no instance; repeated slashes collapse; a segment that begins with
 * a dot is a name without instance. Parsing never throws: malformed text gives a defined address, and `///` is the root `/`.
 */
class JAMOMA_API Address {
public:
    /** Creates the empty address. */
    Address() = default;

    /**
     * @brief Parses address text.
     * @param text The text.
     * @return The address (empty if the text is empty).
     */
    static Address parse(std::string_view text);

    /** @return The directory part, or an empty string. */
    const std::string& directory() const noexcept { return directory_; }
    /** @return True if the path starts at the root (leading slash or a directory). */
    bool absolute() const noexcept { return absolute_; }
    /** @return The path segments. */
    const std::vector<Segment>& path() const noexcept { return path_; }
    /** @return The attribute part, or an empty string. */
    const std::string& attribute() const noexcept { return attribute_; }
    /** @return True if there is no directory, no path, no root slash and no attribute. */
    bool empty() const noexcept { return directory_.empty() && !absolute_ && path_.empty() && attribute_.empty(); }

    /**
     * @brief The address of the parent node.
     * @return The address without its last segment and without attribute; the root's parent is the root; the parent of a
     *         one-segment relative address is the empty address.
     */
    Address parent() const;
    /**
     * @brief Appends a relative address.
     * @param relative The address to append (its directory and absoluteness are ignored).
     * @return This address's directory and absoluteness, the two paths joined, and the attribute of `relative`.
     */
    Address append(const Address& relative) const;
    /**
     * @brief Replaces the attribute.
     * @param attribute The new attribute; empty removes it.
     * @return The changed copy.
     */
    Address with_attribute(std::string_view attribute) const;
    /** @return The text form (parsing it gives an equal address). */
    std::string str() const;

    /** @brief Equality of directory, absoluteness, path and attribute. @param other The address to compare with. @return True if equal. */
    bool operator==(const Address& other) const;
    /** @brief Negation of operator==. @param other The address to compare with. @return True if different. */
    bool operator!=(const Address& other) const { return !(*this == other); }

private:
    std::string directory_;        /**< The directory part. */
    bool absolute_ = false;        /**< Whether the path starts at the root. */
    std::vector<Segment> path_;    /**< The path segments. */
    std::string attribute_;        /**< The attribute part. */
};

/**
 * @brief Resolves an address written in a patcher against the model the patcher belongs to.
 *
 * An absolute address stays as it is; a relative one is appended to the model's address (to the root if there is no model); the empty
 * address stays empty. This is the rule of the old `j.send` and `j.receive`. `.` and `..` segments are not interpreted.
 * @param address The address as written.
 * @param model The address of the model, or the empty address if there is none.
 * @return The address to bind to.
 */
JAMOMA_API Address resolve_relative(const Address& address, const Address& model);

} // namespace jamoma
