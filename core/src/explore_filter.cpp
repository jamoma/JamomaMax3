// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file explore_filter.cpp
 * @brief The filters of j.namespace.
 */

#include "jamoma/explore_filter.hpp"

#include <algorithm>
#include <regex>

#include "jamoma/data.hpp"
#include "jamoma/model.hpp"

namespace jamoma {

namespace {

/** @param condition A condition name. @return True if filters know it. */
bool known_condition(std::string_view condition)
{
    static constexpr std::string_view names[] = {"object", "attribute", "value", "part", "parent", "name", "instance", "mode"};
    return std::find(std::begin(names), std::end(names), condition) != std::end(names);
}

/** @param condition A condition name. @return True if its value is a regular expression. */
bool is_pattern(std::string_view condition)
{
    return condition == "part" || condition == "parent" || condition == "name" || condition == "instance";
}

/** @param text The text. @param pattern A regular expression. @param at_start Whether the match has to begin the text. @return True for a match that is not empty. */
bool matches(const std::string& text, const std::string& pattern, bool at_start)
{
    try {
        std::smatch match;
        const auto flags = at_start ? std::regex_constants::match_continuous : std::regex_constants::match_default;
        return std::regex_search(text, match, std::regex(pattern), flags) && match.length() > 0;
    } catch (const std::regex_error&) {
        return false; // too complex for this text
    }
}

/** @param object An object. @return Its kind as the `object` condition names it. */
std::string kind_of(const Object* object)
{
    if (object == nullptr) {
        return "none";
    }
    if (dynamic_cast<const Data*>(object) != nullptr) {
        return "Data";
    }
    return dynamic_cast<const Model*>(object) != nullptr ? "Container" : "Object";
}

/** @param object An object. @param name An attribute. @return Its value, or nothing if the object has no such attribute. */
std::optional<Value> attribute_of(const Object* object, const std::string& name)
{
    if (const auto* data = dynamic_cast<const Data*>(object)) {
        return data->get_attribute(name);
    }
    if (const auto* model = dynamic_cast<const Model*>(object)) {
        if (name == "service") {
            return Value{Atom("model")};
        }
        if (name == "description") {
            return Value{Atom(model->description())};
        }
        if (name == "priority") {
            return Value{Atom(model->priority())};
        }
    }
    return std::nullopt;
}

} // namespace

ExploreFilters::ExploreFilters()
{
    const auto make = [this](const char* name, std::vector<std::pair<std::string, Value>> conditions, const char* mode = "restrict") {
        bank_[name] = Rule{mode, std::move(conditions)};
    };
    const auto word = [](const char* text) { return Value{Atom(text)}; };
    make("data", {{"object", word("Data")}});
    for (const char* service : {"parameter", "message", "return"}) {
        make(service, {{"object", word("Data")}, {"attribute", word("service")}, {"value", word(service)}});
    }
    for (const char* service : {"model", "view"}) {
        make(service, {{"object", word("Container")}, {"attribute", word("service")}, {"value", word(service)}});
    }
    make("none", {{"object", word("none")}});
    make("genericTag", {{"attribute", word("tags")}, {"value", word("generic")}});
    make("noGenericTag", {{"attribute", word("tags")}, {"value", word("generic")}}, "exclude");
}

bool ExploreFilters::set(const Value& rule)
{
    if (rule.size() < 3 || rule.size() % 2 == 0 || !rule[0].is_symbol()) {
        return false;
    }
    const std::string name = rule[0].as_symbol();
    const auto found = bank_.find(name);
    Rule made = found != bank_.end() ? found->second : Rule{};
    for (std::size_t i = 1; i + 1 < rule.size(); i += 2) {
        const std::string condition = rule[i].to_string();
        if (!known_condition(condition)) {
            return false;
        }
        const std::string text = rule[i + 1].to_string();
        if (condition == "mode") {
            made.mode = text;
            continue;
        }
        if (is_pattern(condition)) {
            try {
                std::regex check(text);
            } catch (const std::regex_error&) {
                return false;
            }
        }
        const auto same = std::find_if(made.conditions.begin(), made.conditions.end(), [&](const auto& c) { return c.first == condition; });
        if (same != made.conditions.end()) {
            same->second = Value{rule[i + 1]};
        } else {
            made.conditions.emplace_back(condition, Value{rule[i + 1]});
        }
    }
    bank_[name] = std::move(made);
    if (std::find(list_.begin(), list_.end(), name) == list_.end()) {
        list_.push_back(name);
    }
    return true;
}

void ExploreFilters::set_list(const Value& names)
{
    list_.clear();
    for (const Atom& name : names) {
        const std::string text = name.to_string();
        if (!text.empty() && text != "none_" && std::find(list_.begin(), list_.end(), text) == list_.end()) {
            list_.push_back(text);
        }
    }
}

Value ExploreFilters::list() const
{
    Value names;
    for (const std::string& name : list_) {
        names.emplace_back(name);
    }
    return names;
}

void ExploreFilters::remove(const Value& name)
{
    if (name.size() == 1) {
        const std::string text = name[0].to_string();
        bank_.erase(text);
        std::erase(list_, text);
        return;
    }
    for (const std::string& used : list_) {
        bank_.erase(used);
    }
    list_.clear();
}

std::optional<Value> ExploreFilters::info(std::string_view name) const
{
    const auto found = bank_.find(std::string(name));
    if (found == bank_.end()) {
        return std::nullopt;
    }
    Value result{Atom(std::string(name))};
    for (const auto& [condition, value] : found->second.conditions) {
        result.emplace_back(condition);
        result.insert(result.end(), value.begin(), value.end());
    }
    result.emplace_back("mode");
    result.emplace_back(found->second.mode);
    return result;
}

bool ExploreFilters::accepts(const Address& node, const Object* object) const
{
    bool result = true;
    for (const std::string& name : list_) {
        const auto found = bank_.find(name);
        if (found == bank_.end()) {
            continue;
        }
        const Rule& rule = found->second;
        bool match = true;
        const std::string* attribute = nullptr;
        std::string attribute_name;
        for (const auto& [condition, value] : rule.conditions) {
            const std::string text = value.empty() ? std::string() : value[0].to_string();
            if (condition == "object") {
                match = match && kind_of(object) == text;
            } else if (condition == "attribute") {
                attribute_name = text;
                attribute = &attribute_name;
                match = match && attribute_of(object, text).has_value();
            } else if (condition == "part") {
                match = match && matches(node.str(), text, false);
            } else if (condition == "parent") {
                match = match && matches(node.parent().str(), text, false);
            } else if (condition == "name") {
                match = match && !node.path().empty() && matches(node.path().back().name, text, true);
            } else if (condition == "instance") {
                match = match && !node.path().empty() && matches(node.path().back().instance, text, true);
            }
        }
        for (const auto& [condition, value] : rule.conditions) {
            if (condition != "value" || attribute == nullptr) {
                continue;
            }
            const std::optional<Value> actual = attribute_of(object, *attribute);
            if (!actual) {
                match = false;
            } else if (*attribute == "tags") { // one of the tags is enough
                match = match && std::any_of(value.begin(), value.end(), [&](const Atom& wanted) {
                            return std::find(actual->begin(), actual->end(), wanted) != actual->end();
                        });
            } else {
                match = match && *actual == value;
            }
        }
        if (rule.mode == "include") {
            result = result || match;
        } else if (rule.mode == "exclude") {
            result = result && !match;
        } else if (rule.mode == "hamlet") {
            result = result || !match;
        } else {
            result = result && match;
        }
    }
    return result;
}

} // namespace jamoma
