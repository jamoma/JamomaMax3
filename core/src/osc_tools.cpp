// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file osc_tools.cpp
 * @brief The string rules of osc_tools.hpp.
 */

#include "jamoma/osc_tools.hpp"

#include <charconv>
#include <cstdint>
#include <system_error>

namespace jamoma {

namespace {

/** @param text The text of an instance. @return It as an integer if all of it is one (nothing counts as 0), else as a symbol. */
Atom instance_atom(std::string_view text)
{
    if (text.empty()) {
        return Atom(0);
    }
    const char* first = text.data() + (text.front() == '+' ? 1 : 0);
    const char* last = text.data() + text.size();
    std::int64_t number = 0;
    const auto [end, error] = std::from_chars(first, last, number);
    if (error == std::errc() && end == last) {
        return Atom(number);
    }
    return Atom(std::string(text));
}

} // namespace

std::optional<OscInstanceSplit> split_osc_instance(std::string_view selector)
{
    const std::size_t from = selector.starts_with('/') ? 1 : 0;
    const std::size_t dot = selector.find('.', from);
    const std::size_t slash = selector.find('/', from);
    if (dot == std::string_view::npos || slash < dot) { // npos is the largest value: no slash is never before the dot
        return std::nullopt;
    }
    const std::size_t end = slash == std::string_view::npos ? selector.size() : slash;
    OscInstanceSplit result{std::string(selector.substr(0, dot)), instance_atom(selector.substr(dot + 1, end - dot - 1))};
    result.address += selector.substr(end);
    return result;
}

std::vector<OscRouteMatch> route_osc(std::string_view selector, std::span<const std::string> patterns)
{
    std::vector<OscRouteMatch> result;
    // The whole pattern, alone or followed by a slash: the first one that fits.
    for (std::size_t i = 0; i < patterns.size(); ++i) {
        const std::string_view pattern = patterns[i];
        if (!selector.starts_with(pattern)) {
            continue;
        }
        if (selector.size() == pattern.size()) {
            result.push_back({i, std::string()});
            break;
        }
        if (selector[pattern.size()] == '/') {
            result.push_back({i, std::string(selector.substr(pattern.size() + 1))});
            break;
        }
    }
    // Then the patterns with a star: again the first one that fits.
    for (std::size_t i = 0; i < patterns.size(); ++i) {
        const std::string_view pattern = patterns[i];
        const std::size_t star = pattern.find('*');
        if (star == std::string_view::npos) {
            continue;
        }
        if (star + 1 == pattern.size()) { // at the end: what is before it, then everything from the next slash
            if (!selector.starts_with(pattern.substr(0, star))) {
                continue;
            }
            const std::size_t slash = selector.find('/', star);
            result.push_back({i, slash == std::string_view::npos ? std::string() : std::string(selector.substr(slash))});
            break;
        }
        const std::size_t after = pattern.find_first_not_of('*', star); // elsewhere: only what follows counts
        const std::string_view tail = after == std::string_view::npos ? std::string_view() : pattern.substr(after);
        if (selector.ends_with(tail)) {
            result.push_back({i, std::string(tail)});
            break;
        }
    }
    return result;
}

OscRouter::OscRouter(std::vector<std::string> patterns) : patterns_(std::move(patterns)) {}

void OscRouter::set(std::size_t index, std::string pattern)
{
    const std::lock_guard<std::mutex> lock(mutex_);
    if (index < patterns_.size()) {
        patterns_[index] = std::move(pattern);
    }
}

std::size_t OscRouter::size() const
{
    const std::lock_guard<std::mutex> lock(mutex_);
    return patterns_.size();
}

std::vector<OscRouteMatch> OscRouter::route(std::string_view selector) const
{
    std::vector<std::string> patterns;
    {
        const std::lock_guard<std::mutex> lock(mutex_);
        patterns = patterns_;
    }
    return route_osc(selector, patterns);
}

} // namespace jamoma
