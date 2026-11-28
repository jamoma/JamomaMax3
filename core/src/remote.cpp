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
    sender_.send(command);
}

void Remote::bang()
{
    if (active_) {
        sender_.send(Value{});
    }
}

void Remote::set_without_output(const Value& value)
{
    if (!active_ || value.empty()) {
        return;
    }
    // The node answers on this thread while the command is sent; changes from other threads (a ramp) are shown as usual.
    const std::thread::id before = setting_.exchange(std::this_thread::get_id());
    struct Restore {
        std::atomic<std::thread::id>& flag; /**< The flag. */
        std::thread::id value;              /**< What it was. */
        ~Restore() { flag = value; }        /**< Puts it back, also if the command throws. */
    } restore{setting_, before};
    from_ui(value);
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
    Value result = value;
    ns_.read_object(node, [&](Object& object) {
        auto* data = dynamic_cast<Data*>(&object);
        if (data == nullptr) {
            return;
        }
        const auto space = data->get_attribute("dataspace");
        const auto from = data->get_attribute("unit");
        if (!space || space->empty() || !from || from->empty()) {
            return;
        }
        const Dataspace* dataspace = Dataspace::find(space->at(0).to_string());
        if (dataspace == nullptr) {
            return;
        }
        const auto converted = dataspace->convert(value, from->at(0).to_string(), unit);
        if (converted) {
            result = *converted;
        }
    });
    return result;
}

void Remote::node_changed(const Value& value)
{
    if (!active_) {
        return;
    }
    if (setting_ == std::this_thread::get_id()) { // the answer to a `set` of this remote: remembered by from_ui, not shown
        if (observer_ && !freeze_) {
            observer_(value.empty() ? value : to_ui_unit(value));
        }
        return;
    }
    if (value.empty()) { // a bang of a node of type none: shown (a button blinks) but it is no value to remember
        if (!freeze_ && observer_) {
            observer_(value);
        }
        if (!freeze_ && to_ui_) {
            to_ui_(value);
        }
        return;
    }
    const Value shown = to_ui_unit(value);
    {
        std::lock_guard<std::mutex> lock(mutex_);
        current_ = shown;
    }
    if (!freeze_ && observer_) {
        observer_(shown);
    }
    if (!freeze_ && to_ui_) {
        to_ui_(shown);
    }
}

} // namespace jamoma
