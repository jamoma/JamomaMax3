// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file array_name.cpp
 * @brief The rules of array_name.hpp.
 */

#include "jamoma/array_name.hpp"

#include <charconv>
#include <cmath>
#include <system_error>

namespace jamoma {

std::string ArrayName::instance(std::size_t index) const
{
    return before + std::to_string(index) + after;
}

std::string ArrayName::with_size(std::size_t n) const
{
    return before + "[" + std::to_string(n) + "]" + after;
}

bool ArrayName::same_shape(const ArrayName& other) const
{
    return before == other.before && after == other.after;
}

std::optional<ArrayName> parse_array_name(std::string_view text)
{
    const std::size_t open = text.find('[');
    const std::size_t close = text.find(']');
    if (open == std::string_view::npos || close == std::string_view::npos || close < open || text.rfind('[') != open || text.rfind(']') != close) {
        return std::nullopt;
    }
    const char* first = text.data() + open + 1;
    const char* last = text.data() + close;
    std::size_t size = 0;
    const auto [end, error] = std::from_chars(first, last, size);
    if (first == last || error != std::errc() || end != last || size > kMaxArraySize) {
        return std::nullopt;
    }
    return ArrayName{std::string(text.substr(0, open)), std::string(text.substr(close + 1)), size};
}

bool ArraySelection::select(const Atom& which, std::size_t size)
{
    if (which.is_symbol()) {
        if (which.as_symbol() != "*") {
            return false;
        }
        index_ = 0;
        return true;
    }
    const double number = std::floor(which.as_double());
    if (!(number >= 1.0 && number <= static_cast<double>(size))) {
        return false;
    }
    index_ = static_cast<std::size_t>(number);
    return true;
}

void ArraySelection::resized(std::size_t size)
{
    if (index_ > size) {
        index_ = 0;
    }
}

std::vector<std::size_t> ArraySelection::targets(std::size_t size) const
{
    std::vector<std::size_t> result;
    if (index_ != 0) {
        if (index_ <= size) {
            result.push_back(index_);
        }
        return result;
    }
    for (std::size_t i = 1; i <= size; ++i) {
        result.push_back(i);
    }
    return result;
}

std::optional<std::vector<Value>> split_array(const Value& list, std::size_t size)
{
    if (size == 0 || list.empty() || list.size() % size != 0) {
        return std::nullopt;
    }
    const std::size_t length = list.size() / size;
    std::vector<Value> parts;
    parts.reserve(size);
    for (std::size_t i = 0; i < size; ++i) {
        parts.emplace_back(list.begin() + static_cast<std::ptrdiff_t>(i * length), list.begin() + static_cast<std::ptrdiff_t>((i + 1) * length));
    }
    return parts;
}

} // namespace jamoma
