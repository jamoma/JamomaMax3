// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file route_search.hpp
 * @brief The rule of j.route: whether a message holds a word at one of some positions (the old source/j.route).
 */

#pragma once

#include <cstdint>
#include <mutex>
#include <string>
#include <vector>

#include "jamoma/export.hpp"

namespace jamoma {

/**
 * @brief What one j.route looks for. The settings may be changed on one thread while another asks.
 *
 * The start state looks for `default` at position 1. Several words are looked for as one text with spaces between them.
 */
class JAMOMA_API RouteSearch {
public:
    /** @brief Sets what is looked for; no words match nothing. @param words The words. */
    void set_words(std::vector<std::string> words);
    /** @return The words. */
    std::vector<std::string> words() const;
    /** @brief Sets where it is looked for, counted from 1; one hit is enough. @param positions The positions. */
    void set_positions(std::vector<std::int64_t> positions);
    /** @return The positions. */
    std::vector<std::int64_t> positions() const;
    /** @brief Whether an element only has to start with the text. @param on True for partial matches. */
    void set_partial(bool on);
    /** @return True if partial matches count. */
    bool partial() const;
    /** @param elements The elements of a message as text, the first being position 1. @return True if one of them matches at a position. */
    bool matches(const std::vector<std::string>& elements) const;

private:
    mutable std::mutex mutex_;                       /**< Guards the settings. */
    std::vector<std::string> words_{"default"};      /**< The words. */
    std::vector<std::int64_t> positions_{1};         /**< The positions. */
    bool partial_ = false;                           /**< Whether a start is enough. */
};

} // namespace jamoma
