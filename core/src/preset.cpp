// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file preset.cpp
 * @brief The preset manager (see preset.hpp).
 */

#include "jamoma/preset.hpp"

#include <algorithm>
#include <cmath>
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

/** The observers of a manager. */
struct PresetManager::Observers {
    unsigned next_id = 1;                                              /**< The id of the next observer. */
    std::vector<std::pair<unsigned, std::function<void()>>> entries;   /**< The observers. */
};

PresetManager::PresetManager(Namespace& ns, Address model) : observers_(std::make_shared<Observers>()), ns_(ns), model_(std::move(model)) {}

std::shared_ptr<void> PresetManager::observe(std::function<void()> callback)
{
    const unsigned id = observers_->next_id++;
    observers_->entries.emplace_back(id, std::move(callback));
    static int token = 0;
    std::weak_ptr<Observers> weak = observers_;
    return std::shared_ptr<void>(&token, [weak, id](void*) {
        if (auto observers = weak.lock()) {
            auto& list = observers->entries;
            list.erase(std::remove_if(list.begin(), list.end(), [id](const auto& e) { return e.first == id; }), list.end());
        }
    });
}

void PresetManager::changed()
{
    const auto copy = observers_->entries; // an observer may unregister itself
    for (const auto& entry : copy) {
        const auto& list = observers_->entries;
        if (std::any_of(list.begin(), list.end(), [&entry](const auto& e) { return e.first == entry.first; })) {
            entry.second();
        }
    }
}

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
            changed();
            return true;
        }
    }
    Preset preset;
    preset.name = std::string(name);
    preset.entries = std::move(entries);
    const std::size_t at = position.has_value() ? std::min(*position, presets_.size()) : presets_.size();
    presets_.insert(presets_.begin() + static_cast<std::ptrdiff_t>(at), std::move(preset));
    current_ = at;
    changed();
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
    changed();
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
    changed();
    apply(std::vector<PresetEntry>(presets_[*index].entries), report); // a copy: a command may run observers that change the list
    return report;
}

void PresetManager::apply(const std::vector<PresetEntry>& entries, RecallReport& report)
{
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
}

namespace {

/** @param v A value. @return True if it is not empty and every atom is a number. */
bool all_numbers(const Value& v)
{
    return !v.empty() && std::all_of(v.begin(), v.end(), [](const Atom& a) { return a.is_number(); });
}

/** Finds an entry by address. @param entries The entries. @param address The address. @return The entry or null. */
const PresetEntry* find_entry(const std::vector<PresetEntry>& entries, const Address& address)
{
    for (const PresetEntry& e : entries) {
        if (e.address == address) {
            return &e;
        }
    }
    return nullptr;
}

} // namespace

RecallReport PresetManager::interpolate(std::string_view a, std::string_view b, double position)
{
    RecallReport report;
    const auto ia = find(a);
    const auto ib = find(b);
    if (!ia || !ib || std::isnan(position)) {
        return report;
    }
    report.found = true;
    const double p = std::clamp(position, 0.0, 1.0);
    const std::vector<PresetEntry> first = presets_[*ia].entries;
    const std::vector<PresetEntry> second = presets_[*ib].entries;
    std::vector<PresetEntry> out;
    for (const PresetEntry& e : first) {
        const PresetEntry* other = find_entry(second, e.address);
        if (other == nullptr) {
            out.push_back(e);
        } else if (all_numbers(e.value) && all_numbers(other->value) && e.value.size() == other->value.size()) {
            Value v;
            for (std::size_t i = 0; i < e.value.size(); ++i) {
                v.emplace_back(e.value[i].as_double() * (1.0 - p) + other->value[i].as_double() * p);
            }
            out.push_back({e.address, std::move(v)});
        } else {
            out.push_back(p < 0.5 ? e : *other);
        }
    }
    for (const PresetEntry& e : second) {
        if (find_entry(first, e.address) == nullptr) {
            out.push_back(e);
        }
    }
    apply(out, report);
    return report;
}

RecallReport PresetManager::mix(const std::vector<std::pair<std::string, double>>& weighted)
{
    RecallReport report;
    std::vector<std::pair<std::size_t, double>> parts;
    double sum = 0.0;
    for (const auto& [key, factor] : weighted) {
        const auto index = find(key);
        if (!index) {
            return report;
        }
        parts.emplace_back(*index, std::max(0.0, factor));
        sum += std::max(0.0, factor);
    }
    report.found = true;
    if (parts.empty() || sum <= 0.0) {
        return report;
    }
    std::vector<Address> order;
    for (const auto& part : parts) {
        for (const PresetEntry& e : presets_[part.first].entries) {
            if (std::find(order.begin(), order.end(), e.address) == order.end()) {
                order.push_back(e.address);
            }
        }
    }
    std::vector<PresetEntry> out;
    for (const Address& address : order) {
        double total = 0.0;
        double largest = -1.0;
        const PresetEntry* strongest = nullptr;
        bool numeric = true;
        std::size_t size = 0;
        for (const auto& part : parts) {
            const PresetEntry* e = find_entry(presets_[part.first].entries, address);
            if (e == nullptr || part.second <= 0.0) {
                continue;
            }
            total += part.second;
            if (part.second > largest) {
                largest = part.second;
                strongest = e;
            }
            numeric = numeric && all_numbers(e->value) && (size == 0 || size == e->value.size());
            size = e->value.size();
        }
        if (strongest == nullptr) {
            continue;
        }
        if (!numeric) {
            out.push_back(*strongest);
            continue;
        }
        Value v(size, Atom(0.0));
        for (const auto& part : parts) {
            const PresetEntry* e = find_entry(presets_[part.first].entries, address);
            if (e == nullptr || part.second <= 0.0) {
                continue;
            }
            for (std::size_t i = 0; i < size; ++i) {
                v[i] = Atom(v[i].as_double() + e->value[i].as_double() * part.second / total);
            }
        }
        out.push_back({address, std::move(v)});
    }
    apply(out, report);
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
    changed();
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
    changed();
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
    changed();
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
    changed();
    return true;
}

std::string PresetManager::free_name(std::string_view stem) const
{
    for (unsigned n = 1;; ++n) {
        const std::string name = std::string(stem) + " " + std::to_string(n);
        if (std::none_of(presets_.begin(), presets_.end(), [&name](const Preset& p) { return p.name == name; })) {
            return name;
        }
    }
}

std::string PresetManager::unused_name(std::string_view wanted) const
{
    const std::size_t first = wanted.find_first_not_of(" \t");
    if (first == std::string_view::npos) {
        return free_name("preset");
    }
    const std::string name(wanted.substr(first, wanted.find_last_not_of(" \t") - first + 1));
    const bool taken = std::any_of(presets_.begin(), presets_.end(), [&name](const Preset& p) { return p.name == name; });
    return taken ? free_name(name) : name;
}

void PresetManager::clear()
{
    presets_.clear();
    current_.reset();
    changed();
}

bool PresetManager::set_entries(std::string_view name, std::vector<PresetEntry> entries, bool make_current)
{
    if (name.empty()) {
        return false;
    }
    std::size_t at = presets_.size();
    for (std::size_t i = 0; i < presets_.size(); ++i) {
        if (presets_[i].name == name) {
            at = i;
            break;
        }
    }
    if (at == presets_.size()) {
        Preset preset;
        preset.name = std::string(name);
        presets_.push_back(std::move(preset));
    }
    presets_[at].entries = std::move(entries);
    if (make_current) {
        current_ = at;
    }
    changed();
    return true;
}

bool PresetManager::set_description(std::string_view name, std::string text)
{
    for (Preset& p : presets_) {
        if (p.name == name) {
            p.description = std::move(text);
            changed();
            return true;
        }
    }
    return false;
}

void PresetManager::replace_all(std::vector<Preset> presets)
{
    presets_ = std::move(presets);
    current_.reset();
    changed();
}

} // namespace jamoma
