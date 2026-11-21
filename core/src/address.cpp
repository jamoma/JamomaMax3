// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file address.cpp
 * @brief Implementation of Address.
 */

#include "jamoma/address.hpp"

namespace jamoma {

namespace {

/** Splits one path segment into name and instance; instance "0" means no instance. */
Segment make_segment(std::string_view text)
{
    Segment segment;
    const auto dot = text.find('.');
    if (dot == std::string_view::npos || dot == 0) {
        segment.name = std::string(text);
        return segment;
    }
    segment.name = std::string(text.substr(0, dot));
    segment.instance = std::string(text.substr(dot + 1));
    if (segment.instance == "0") {
        segment.instance.clear();
    }
    return segment;
}

} // namespace

Address Address::parse(std::string_view text)
{
    Address address;
    if (text.empty()) {
        return address;
    }
    const auto directory_end = text.find(":/");
    if (directory_end != std::string_view::npos && text.substr(0, directory_end).find('/') == std::string_view::npos) {
        address.directory_ = std::string(text.substr(0, directory_end));
        text.remove_prefix(directory_end + 1);
    }
    const auto colon = text.rfind(':');
    if (colon != std::string_view::npos && text.substr(colon + 1).find('/') == std::string_view::npos) {
        address.attribute_ = std::string(text.substr(colon + 1));
        text = text.substr(0, colon);
    }
    address.absolute_ = !address.directory_.empty() || (!text.empty() && text.front() == '/');
    std::size_t start = 0;
    while (start <= text.size()) {
        auto end = text.find('/', start);
        if (end == std::string_view::npos) {
            end = text.size();
        }
        if (end > start) {
            address.path_.push_back(make_segment(text.substr(start, end - start)));
        }
        start = end + 1;
    }
    return address;
}

Address Address::parent() const
{
    Address result = *this;
    result.attribute_.clear();
    if (!result.path_.empty()) {
        result.path_.pop_back();
    }
    return result;
}

Address Address::append(const Address& relative) const
{
    Address result = *this;
    result.path_.insert(result.path_.end(), relative.path_.begin(), relative.path_.end());
    result.attribute_ = relative.attribute_;
    return result;
}

Address Address::with_attribute(std::string_view attribute) const
{
    Address result = *this;
    result.attribute_ = std::string(attribute);
    return result;
}

std::string Address::str() const
{
    std::string text;
    if (!directory_.empty()) {
        text += directory_;
        text += ':';
    }
    if (absolute_) {
        text += '/';
    }
    for (std::size_t i = 0; i < path_.size(); ++i) {
        if (i != 0) {
            text += '/';
        }
        text += path_[i].name;
        if (!path_[i].instance.empty()) {
            text += '.';
            text += path_[i].instance;
        }
    }
    if (!attribute_.empty()) {
        text += ':';
        text += attribute_;
    }
    return text;
}

bool Address::operator==(const Address& other) const
{
    return directory_ == other.directory_ && absolute_ == other.absolute_ && path_ == other.path_ && attribute_ == other.attribute_;
}

} // namespace jamoma
