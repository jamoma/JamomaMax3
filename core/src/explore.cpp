// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file explore.cpp
 * @brief Exploration of the namespace, the output formats of j.namespace and the shared selection.
 */

#include "jamoma/priority.hpp"
#include "jamoma/explore.hpp"

#include <algorithm>
#include <map>
#include <utility>

#include "jamoma/data.hpp"

namespace jamoma {

namespace {

/** One item with the priority of its node (for sorting). */
struct Item {
    std::string text;  /**< The item as listed. */
    int priority = 0;  /**< The priority of its node. */
};

/** @param object A node's object or null. @return Its priority (0 if it has none). */
int priority_of(Object* object)
{
    if (const auto* data = dynamic_cast<Data*>(object))
        return data->priority();
    return 0;
}

/** @param base An address as text. @return The text with a separator at its end, unless it is the root or empty. */
std::string with_separator(const std::string& base) { return !base.empty() && base.back() == '/' ? base : base + "/"; }

} // namespace

ExploreResult explore(const Namespace& ns, const Address& address, const ExploreOptions& options)
{
    ExploreResult result;
    std::vector<Item> items;
    // Whether a node below `base` passes the filters (the namespace is locked: only the node itself is looked at).
    const auto passes = [&options](const Address& base, const std::string& relative, const Object* object) {
        if (options.filters == nullptr || options.filters->empty())
            return true;
        const std::string root = base.str();
        return options.filters->accepts(Address::parse(with_separator(root.empty() ? "/" : root) + relative), object);
    };
    switch (options.output) {
    case ExploreOutput::Attributes:
        result.found = ns.visit_below(address, [](const std::string&, const std::string&, const std::string&, Object*) {});
        if (result.found) {
            ns.read_object(address, [&](Object& object) {
                if (dynamic_cast<Data*>(&object) != nullptr)
                    for (const auto& name : Data::attribute_names())
                        items.push_back({name, 0});
            });
        }
        break;
    case ExploreOutput::Brothers: {
        const auto& path = address.path();
        if (path.empty()) {
            result.found = true;
            break;
        }
        const std::string name = path.back().name;
        result.found = ns.visit_below(address.parent(), [&](const std::string& relative, const std::string& n, const std::string& instance, Object* object) {
            if (object != nullptr && relative.find('/') == std::string::npos && n == name && passes(address.parent(), relative, object))
                items.push_back({instance.empty() ? "0" : instance, priority_of(object)});
        });
        break;
    }
    default: {
        const bool children = options.output == ExploreOutput::Children;
        result.found = ns.visit_below(address, [&](const std::string& relative, const std::string& n, const std::string&, Object* object) {
            if (object == nullptr)
                return;
            if (!passes(address, relative, object))
                return;
            const bool direct = relative.find('/') == std::string::npos;
            if (children) {
                if (direct && std::none_of(items.begin(), items.end(), [&](const Item& i) { return i.text == n; }))
                    items.push_back({n, priority_of(object)});
                return;
            }
            if (options.depth > 0 && static_cast<unsigned>(std::count(relative.begin(), relative.end(), '/')) + 1 > options.depth)
                return;
            items.push_back({relative, priority_of(object)});
        });
        break;
    }
    }
    if (options.sort == ExploreSort::Alphabetic)
        std::stable_sort(items.begin(), items.end(), [](const Item& a, const Item& b) { return a.text < b.text; });
    else if (options.sort == ExploreSort::Priority)
        std::stable_sort(items.begin(), items.end(), [](const Item& a, const Item& b) { return a.priority != b.priority ? priority_before(a.priority, b.priority) : a.text < b.text; });
    for (auto& i : items)
        result.items.push_back(std::move(i.text));
    return result;
}

std::vector<OutMessage> format_items(ExploreFormat format, ExploreOutput output, const Address& address, const std::vector<std::string>& items)
{
    std::vector<OutMessage> out;
    switch (format) {
    case ExploreFormat::None:
        if (!items.empty())
            out.push_back({"", Value(items.begin(), items.end())});
        break;
    case ExploreFormat::Umenu:
    case ExploreFormat::UmenuPrefix:
        out.push_back({"clear", {}});
        if (format == ExploreFormat::UmenuPrefix) {
            out.push_back({"prefix_mode", Value{0}});
            const std::string base = address.str();
            const bool root = address.path().empty();
            std::string prefix = base;
            if (output == ExploreOutput::Attributes)
                prefix += ":";
            else if (!root)
                prefix += output == ExploreOutput::Brothers ? "." : "/";
            out.push_back({"prefix", Value{prefix}});
        }
        for (const auto& item : items)
            out.push_back({"append", Value{item}});
        break;
    case ExploreFormat::JitCellblock:
        out.push_back({"clear", Value{"all"}});
        out.push_back({"rows", Value{static_cast<std::int64_t>(items.size())}});
        for (std::size_t i = 0; i < items.size(); ++i)
            out.push_back({"set", Value{0, static_cast<std::int64_t>(i), items[i]}});
        break;
    case ExploreFormat::Coll:
        out.push_back({"clear", {}});
        for (const auto& item : items)
            out.push_back({"store", Value{item, 0}});
        break;
    }
    return out;
}

std::vector<OutMessage> format_selection(ExploreFormat format, const std::vector<bool>& selected)
{
    std::vector<OutMessage> out;
    switch (format) {
    case ExploreFormat::None: {
        Value flags;
        for (bool s : selected)
            flags.push_back(s ? 1 : 0);
        out.push_back({"selection", flags});
        break;
    }
    case ExploreFormat::Umenu:
    case ExploreFormat::UmenuPrefix:
        out.push_back({"clearchecks", {}});
        for (std::size_t i = 0; i < selected.size(); ++i)
            out.push_back({"checkitem", Value{static_cast<std::int64_t>(i), selected[i] ? 1 : 0}});
        break;
    case ExploreFormat::JitCellblock:
        for (std::size_t i = 0; i < selected.size(); ++i)
            out.push_back({"cell", selected[i] ? Value{0, static_cast<std::int64_t>(i), "brgb", 158, 0, 92} : Value{0, static_cast<std::int64_t>(i), "brgb", 0, 0, 0}});
        break;
    case ExploreFormat::Coll:
        break;
    }
    return out;
}

std::string item_key(ExploreOutput output, const Address& address, std::string_view item)
{
    const std::string base = address.str();
    switch (output) {
    case ExploreOutput::Attributes:
        return base + ":" + std::string(item);
    case ExploreOutput::Brothers: {
        if (address.path().empty())
            return with_separator(base) + std::string(item);
        const std::string parent = address.parent().str();
        return with_separator(parent.empty() ? "/" : parent) + address.path().back().name + (item == "0" ? "" : "." + std::string(item));
    }
    default:
        return with_separator(base.empty() ? "/" : base) + std::string(item);
    }
}

std::shared_ptr<Selection> Selection::named(std::string_view name)
{
    if (name.empty() || name == "none")
        return std::shared_ptr<Selection>(new Selection());
    static std::mutex* mutex = new std::mutex(); // never destroyed: objects may outlive static destruction
    static auto* registry = new std::map<std::string, std::weak_ptr<Selection>>();
    std::lock_guard<std::mutex> lock(*mutex);
    auto& slot = (*registry)[std::string(name)];
    if (auto existing = slot.lock())
        return existing;
    std::shared_ptr<Selection> made(new Selection());
    slot = made;
    return made;
}

bool Selection::is_selected(std::string_view key) const
{
    std::lock_guard<std::mutex> lock(mutex_);
    return keys_.count(std::string(key)) != 0;
}

void Selection::set(std::string_view key, bool on)
{
    std::lock_guard<std::mutex> lock(mutex_);
    if (on)
        keys_.insert(std::string(key));
    else
        keys_.erase(std::string(key));
}

bool Selection::toggle(std::string_view key)
{
    std::lock_guard<std::mutex> lock(mutex_);
    const std::string k(key);
    if (keys_.erase(k) != 0)
        return false;
    keys_.insert(k);
    return true;
}

void Selection::set_all(const std::vector<std::string>& keys, bool on)
{
    std::lock_guard<std::mutex> lock(mutex_);
    for (const auto& k : keys) {
        if (on)
            keys_.insert(k);
        else
            keys_.erase(k);
    }
}

void Selection::clear()
{
    std::lock_guard<std::mutex> lock(mutex_);
    keys_.clear();
}

std::vector<std::string> Selection::selected() const
{
    std::lock_guard<std::mutex> lock(mutex_);
    return {keys_.begin(), keys_.end()};
}

} // namespace jamoma
