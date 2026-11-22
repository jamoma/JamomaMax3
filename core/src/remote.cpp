// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file remote.cpp
 * @brief The remote (see remote.hpp).
 */

#include "jamoma/remote.hpp"

#include <algorithm>

#include "jamoma/data.hpp"
#include "jamoma/dataspace.hpp"

namespace jamoma {

namespace {

/** The remote that is sending to its node on this thread (the node's synchronous answer is not shown to the UI). */
thread_local const Remote* g_sending = nullptr;

/** @param v A value. @return True if it is not empty and every atom is a number. */
bool all_numbers(const Value& v)
{
    return !v.empty() && std::all_of(v.begin(), v.end(), [](const Atom& a) { return a.is_number(); });
}

} // namespace

Remote::Remote(Namespace& ns, std::function<void(const Value&)> to_ui) : ns_(ns), to_ui_(std::move(to_ui)), sender_(ns)
{
    receiver_ = std::make_unique<Receiver>(
        ns, [this](const Address& a) {
            std::lock_guard<std::mutex> lock(mutex_);
            node_ = a;
        },
        [this](const Value& v) { node_changed(v); });
}

Remote::~Remote() { receiver_.reset(); }

void Remote::set_address(const Address& address)
{
    sender_.set_address(address);
    receiver_->set_address(address);
}

void Remote::set_unit(std::string_view unit)
{
    std::lock_guard<std::mutex> lock(mutex_);
    unit_ = std::string(unit);
}

void Remote::set_active(bool on) { active_ = on; }

void Remote::set_freeze(bool on) { freeze_ = on; }

std::optional<Value> Remote::current() const
{
    std::lock_guard<std::mutex> lock(mutex_);
    return current_;
}

void Remote::from_ui(const Value& value)
{
    if (!active_ || value.empty()) {
        return;
    }
    Value command = value;
    std::string unit;
    {
        std::lock_guard<std::mutex> lock(mutex_);
        unit = unit_;
        current_ = value;
    }
    if (!unit.empty() && all_numbers(value)) {
        command.emplace_back(unit);
    }
    const Remote* previous = g_sending;
    g_sending = this;
    sender_.send(command);
    g_sending = previous;
}

void Remote::set_without_echo(const Value& value)
{
    if (!active_ || value.empty()) {
        return;
    }
    {
        std::lock_guard<std::mutex> lock(mutex_);
        current_ = value;
    }
    if (!freeze_ && to_ui_) {
        to_ui_(value);
    }
}

Value Remote::to_ui_unit(const Value& value) const
{
    std::string unit;
    Address node;
    {
        std::lock_guard<std::mutex> lock(mutex_);
        unit = unit_;
        node = node_;
    }
    if (unit.empty() || !all_numbers(value)) {
        return value;
    }
    Node* found = ns_.lookup(node);
    auto* data = found != nullptr ? dynamic_cast<Data*>(found->object()) : nullptr;
    if (data == nullptr) {
        return value;
    }
    const auto space = data->get_attribute("dataspace");
    const auto from = data->get_attribute("unit");
    if (!space || space->empty() || !from || from->empty()) {
        return value;
    }
    const Dataspace* dataspace = Dataspace::find(space->at(0).to_string());
    if (dataspace == nullptr) {
        return value;
    }
    const auto converted = dataspace->convert(value, from->at(0).to_string(), unit);
    return converted ? *converted : value;
}

void Remote::node_changed(const Value& value)
{
    if (!active_ || value.empty()) {
        return;
    }
    if (g_sending == this) {
        return; // the node's answer to our own command: the UI object already shows it
    }
    const Value shown = to_ui_unit(value);
    {
        std::lock_guard<std::mutex> lock(mutex_);
        current_ = shown;
    }
    if (!freeze_ && to_ui_) {
        to_ui_(shown);
    }
}

} // namespace jamoma
