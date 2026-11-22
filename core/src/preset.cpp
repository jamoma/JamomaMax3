// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file preset.cpp
 * @brief The preset manager (see preset.hpp).
 */

#include "jamoma/preset.hpp"

#include <algorithm>
#include <cstdlib>

#include "jamoma/data.hpp"

namespace jamoma {

namespace {

/** A parameter found while storing. */
struct Found {
    int priority;       /**< Its priority. */
    std::string name;   /**< Its address relative to the model. */
    int instance;       /**< Its instance number (0 if none). */
    Data* data;         /**< The object. */
};

/**
 * Collects the parameters below a node.
 * @param node The node. @param prefix The relative address of the node. @param out Where to add them.
 */
void collect(Node* node, const std::string& prefix, std::vector<Found>& out)
{
    for (Node* kid : node->children()) {
        std::string text = prefix.empty() ? kid->name() : prefix + "/" + kid->name();
        if (!kid->instance().empty()) {
            text += "." + kid->instance();
        }
        if (auto* data = dynamic_cast<Data*>(kid->object())) {
            if (data->service() == Service::Parameter) {
                out.push_back({data->priority(), kid->name(), kid->instance().empty() ? 0 : std::atoi(kid->instance().c_str()), data});
                out.back().name = text;
            }
        }
        collect(kid, text, out);
    }
}

} // namespace

PresetManager::PresetManager(Namespace& ns, Address model) : ns_(ns), model_(std::move(model)) {}

std::vector<std::string> PresetManager::names() const
{
    std::vector<std::string> out;
    for (const Preset& p : presets_) {
        out.push_back(p.name);
    }
    return out;
}

std::vector<PresetEntry> PresetManager::store() const
{
    std::vector<Found> found;
    if (Node* node = ns_.lookup(model_)) {
        collect(node, std::string(), found);
    }
    std::stable_sort(found.begin(), found.end(), [](const Found& a, const Found& b) {
        if (a.priority != b.priority) {
            return a.priority < b.priority;
        }
        if (a.name != b.name) {
            return a.name < b.name;
        }
        return a.instance < b.instance;
    });
    std::vector<PresetEntry> entries;
    for (const Found& f : found) {
        Value value = f.data->value();
        if (!value.empty()) {
            entries.push_back({Address::parse(f.name), std::move(value)});
        }
    }
    return entries;
}

std::optional<std::size_t> PresetManager::find(std::string_view key) const
{
    for (std::size_t i = 0; i < presets_.size(); ++i) {
        if (presets_[i].name == key) {
            return i;
        }
    }
    if (!key.empty() && std::all_of(key.begin(), key.end(), [](char c) { return c >= '0' && c <= '9'; })) {
        const std::size_t position = static_cast<std::size_t>(std::atoll(std::string(key).c_str()));
        if (position >= 1 && position <= presets_.size()) {
            return position - 1;
        }
    }
    return std::nullopt;
}

bool PresetManager::new_preset(std::string_view name, std::optional<std::size_t> position)
{
    if (name.empty()) {
        return false;
    }
    std::vector<PresetEntry> entries = store();
    for (std::size_t i = 0; i < presets_.size(); ++i) {
        if (presets_[i].name == name) {
            presets_[i].entries = std::move(entries);
            current_ = i;
            return true;
        }
    }
    Preset preset;
    preset.name = std::string(name);
    preset.entries = std::move(entries);
    const std::size_t at = position.has_value() ? std::min(*position, presets_.size()) : presets_.size();
    presets_.insert(presets_.begin() + static_cast<std::ptrdiff_t>(at), std::move(preset));
    current_ = at;
    return true;
}

bool PresetManager::update(std::string_view name_or_index)
{
    const auto index = find(name_or_index);
    if (!index) {
        return false;
    }
    presets_[*index].entries = store();
    current_ = *index;
    return true;
}

RecallReport PresetManager::output(std::string_view name_or_index) const
{
    RecallReport report;
    if (const auto index = find(name_or_index)) {
        report.found = true;
        report.entries = presets_[*index].entries;
    }
    return report;
}

RecallReport PresetManager::recall(std::string_view name_or_index)
{
    RecallReport report;
    const auto index = find(name_or_index);
    if (!index) {
        return report;
    }
    report.found = true;
    current_ = *index;
    const std::vector<PresetEntry> entries = presets_[*index].entries; // a copy: a command may run observers that change the list
    for (const PresetEntry& entry : entries) {
        Node* node = ns_.lookup(model_.append(entry.address));
        auto* data = node != nullptr ? dynamic_cast<Data*>(node->object()) : nullptr;
        if (data == nullptr) {
            report.skipped.push_back(entry.address);
            continue;
        }
        data->command(entry.value);
        ++report.applied;
    }
    return report;
}

bool PresetManager::remove(std::string_view name_or_index)
{
    const auto index = find(name_or_index);
    if (!index) {
        return false;
    }
    presets_.erase(presets_.begin() + static_cast<std::ptrdiff_t>(*index));
    if (current_) {
        if (*current_ == *index) {
            current_.reset();
        } else if (*current_ > *index) {
            --*current_;
        }
    }
    return true;
}

bool PresetManager::rename(std::string_view from, std::string_view to)
{
    const auto index = find(from);
    if (!index || to.empty()) {
        return false;
    }
    for (const Preset& p : presets_) {
        if (p.name == to) {
            return false;
        }
    }
    presets_[*index].name = std::string(to);
    return true;
}

bool PresetManager::copy(std::string_view from, std::string_view to, std::optional<std::size_t> position)
{
    const auto index = find(from);
    if (!index || to.empty()) {
        return false;
    }
    for (const Preset& p : presets_) {
        if (p.name == to) {
            return false;
        }
    }
    Preset preset = presets_[*index];
    preset.name = std::string(to);
    const std::size_t at = position.has_value() ? std::min(*position, presets_.size()) : presets_.size();
    presets_.insert(presets_.begin() + static_cast<std::ptrdiff_t>(at), std::move(preset));
    if (current_ && *current_ >= at) {
        ++*current_;
    }
    return true;
}

bool PresetManager::move(std::string_view name_or_index, std::size_t position)
{
    const auto index = find(name_or_index);
    if (!index || position >= presets_.size()) {
        return false;
    }
    std::optional<std::size_t> follow = current_;
    Preset preset = std::move(presets_[*index]);
    presets_.erase(presets_.begin() + static_cast<std::ptrdiff_t>(*index));
    presets_.insert(presets_.begin() + static_cast<std::ptrdiff_t>(position), std::move(preset));
    if (follow) {
        std::size_t c = *follow;
        if (c == *index) {
            c = position;
        } else {
            if (c > *index) {
                --c;
            }
            if (c >= position) {
                ++c;
            }
        }
        current_ = c;
    }
    return true;
}

void PresetManager::clear()
{
    presets_.clear();
    current_.reset();
}

void PresetManager::replace_all(std::vector<Preset> presets)
{
    presets_ = std::move(presets);
    current_.reset();
}

} // namespace jamoma
