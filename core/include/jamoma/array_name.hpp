// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file array_name.hpp
 * @brief The rules of the array objects that need no namespace: bracketed names, the selected instance, cutting a list into parts.
 *
 * See docs/inventory/j.array.md.
 */

#pragma once

#include <cstddef>
#include <optional>
#include <string>
#include <string_view>
#include <vector>

#include "jamoma/atom.hpp"
#include "jamoma/export.hpp"

namespace jamoma {

/** The largest number of instances of an array. */
inline constexpr std::size_t kMaxArraySize = 256;

/** A name with a size in brackets, `cc.[128]`: instance i has the bracket replaced by i. */
struct JAMOMA_API ArrayName {
    std::string before;    /**< The text before the bracket. */
    std::string after;     /**< The text after the bracket. */
    std::size_t size = 0;  /**< The number of instances, 0 to kMaxArraySize. */

    /** @param index An instance, from 1. @return Its name. */
    std::string instance(std::size_t index) const;
    /** @param n A size. @return The bracketed name with that size. */
    std::string with_size(std::size_t n) const;
    /** @param other Another name. @return True if the two differ at most in their size. */
    bool same_shape(const ArrayName& other) const;
};

/**
 * @brief Reads a bracketed name.
 * @param text The name.
 * @return The name, or nothing unless there is exactly one bracket pair and it holds a whole number of at most kMaxArraySize.
 */
JAMOMA_API std::optional<ArrayName> parse_array_name(std::string_view text);

/** Which instances of an array a value goes to: one of them, or all (the start state). */
class JAMOMA_API ArraySelection {
public:
    /**
     * @brief Selects instances.
     * @param which A number from 1 to the size (a float is rounded down), or the symbol `*` for all.
     * @param size The size of the array.
     * @return False if refused; the selection then stays.
     */
    bool select(const Atom& which, std::size_t size);
    /** @brief Falls back to all if the selected instance no longer exists. @param size The new size. */
    void resized(std::size_t size);
    /** @return The selected instance, or 0 for all. */
    std::size_t index() const noexcept { return index_; }
    /** @param size The size of the array. @return The selected instances in ascending order, from 1. */
    std::vector<std::size_t> targets(std::size_t size) const;

private:
    std::size_t index_ = 0; /**< The selected instance; 0 means all. */
};

/**
 * @brief Cuts a list into one part per instance.
 * @param list The list.
 * @param size The number of instances.
 * @return Equal parts in order, or nothing if the size is 0, the list is empty or its length is not a multiple of the size.
 */
JAMOMA_API std::optional<std::vector<Value>> split_array(const Value& list, std::size_t size);

} // namespace jamoma
