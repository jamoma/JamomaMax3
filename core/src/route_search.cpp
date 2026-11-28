// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file route_search.cpp
 * @brief The rule of route_search.hpp.
 */

#include "jamoma/route_search.hpp"

#include <algorithm>
#include <utility>

namespace jamoma {

void RouteSearch::set_words(std::vector<std::string> words)
{
    const std::lock_guard<std::mutex> lock(mutex_);
    words_ = std::move(words);
}

std::vector<std::string> RouteSearch::words() const
{
    const std::lock_guard<std::mutex> lock(mutex_);
    return words_;
}

void RouteSearch::set_positions(std::vector<std::int64_t> positions)
{
    const std::lock_guard<std::mutex> lock(mutex_);
    positions_ = std::move(positions);
}

std::vector<std::int64_t> RouteSearch::positions() const
{
    const std::lock_guard<std::mutex> lock(mutex_);
    return positions_;
}

void RouteSearch::set_partial(bool on)
{
    const std::lock_guard<std::mutex> lock(mutex_);
    partial_ = on;
}

bool RouteSearch::partial() const
{
    const std::lock_guard<std::mutex> lock(mutex_);
    return partial_;
}

bool RouteSearch::matches(const std::vector<std::string>& elements) const
{
    const std::lock_guard<std::mutex> lock(mutex_); // held while comparing: nothing is called out
    if (words_.empty()) {
        return false;
    }
    std::string text = words_.front();
    for (std::size_t i = 1; i < words_.size(); ++i) {
        text += " " + words_[i];
    }
    return std::any_of(positions_.begin(), positions_.end(), [&](std::int64_t position) {
        if (position < 1 || static_cast<std::uint64_t>(position) > elements.size()) {
            return false;
        }
        const std::string& element = elements[static_cast<std::size_t>(position - 1)];
        return partial_ ? element.starts_with(text) : element == text;
    });
}

} // namespace jamoma
