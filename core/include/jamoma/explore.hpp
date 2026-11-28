// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file explore.hpp
 * @brief What `j.namespace` does: list what is below an address, format the list for a Max object, and keep a selection of the items.
 *
 * The rules are those of the old explorer (docs/inventory/j.namespace.md). Only nodes that hold an object count as items. A selection is
 * a set of absolute addresses that can be shared by name between several objects (`j.namespace` and `j.cue` use it).
 */

#pragma once

#include <memory>
#include <mutex>
#include <set>
#include <string>
#include <string_view>
#include <vector>

#include "jamoma/address.hpp"
#include "jamoma/atom.hpp"
#include "jamoma/explore_filter.hpp"
#include "jamoma/export.hpp"
#include "jamoma/namespace.hpp"

namespace jamoma {

/** Which items of the namespace are listed. */
enum class ExploreOutput {
    Descendants, /**< Every node below the address, as an address relative to it. */
    Children,    /**< The nodes directly below the address (their names). */
    Brothers,    /**< The instances of the nodes that have the same name as the address (the instance part only; 0 for none). */
    Attributes   /**< The attributes of the node at the address. */
};

/** In which order the items are listed. */
enum class ExploreSort {
    None,       /**< The order of the namespace. */
    Alphabetic, /**< By text. */
    Priority    /**< By initialisation priority, then by text. */
};

/** How a Max object is told the items. */
enum class ExploreFormat { None, Umenu, UmenuPrefix, JitCellblock, Coll };

/** What to list. */
struct ExploreOptions {
    ExploreOutput output = ExploreOutput::Descendants; /**< Which items. */
    ExploreSort sort = ExploreSort::Alphabetic;        /**< In which order. */
    unsigned depth = 0;                                /**< How many levels below the address (0 = all). */
    const ExploreFilters* filters = nullptr;           /**< The filters nodes have to pass (not applied to attributes), or null. */
};

/** The items found. */
struct ExploreResult {
    bool found = false;              /**< False if there is nothing at the address (then there are no items). */
    std::vector<std::string> items;  /**< The items, in order. */
};

/** One message for an outlet: a selector and its arguments (an empty selector is a plain list). */
struct OutMessage {
    std::string selector; /**< The selector (empty: output the arguments as a list). */
    Value args;           /**< The arguments. */
    /** @param other Another message. @return True if both are the same. */
    bool operator==(const OutMessage& other) const { return selector == other.selector && args == other.args; }
};

/**
 * @brief Lists what is below an address.
 * @param ns The namespace.
 * @param address The address to explore (the root for the empty address).
 * @param options What to list.
 * @return The items; nothing found for an address that does not exist.
 */
JAMOMA_API ExploreResult explore(const Namespace& ns, const Address& address, const ExploreOptions& options);

/**
 * @brief The messages that tell a Max object the items.
 * @param format The format.
 * @param output Which items these are (the prefix of `umenu_prefix` depends on it).
 * @param address The address that was explored.
 * @param items The items.
 * @return The messages for the data outlet, in order (empty for the format `none` and no item).
 */
JAMOMA_API std::vector<OutMessage> format_items(ExploreFormat format, ExploreOutput output, const Address& address, const std::vector<std::string>& items);

/**
 * @brief The messages that show which items are selected.
 * @param format The format.
 * @param selected One flag for every item, in order.
 * @return The messages for the data outlet.
 */
JAMOMA_API std::vector<OutMessage> format_selection(ExploreFormat format, const std::vector<bool>& selected);

/**
 * @brief The key under which an item is stored in a selection: its absolute address.
 * @param output Which items these are.
 * @param address The address that was explored.
 * @param item The item as listed.
 * @return `/a/b` for a node, `/a/b:attribute` for an attribute, the node with its instance for a brother.
 */
JAMOMA_API std::string item_key(ExploreOutput output, const Address& address, std::string_view item);

/** @brief A set of selected addresses, shared by name. All members may be called from any thread. */
class JAMOMA_API Selection {
public:
    /**
     * @brief Finds or makes the selection with a name; objects that use the same name share one.
     * @param name The name; empty or "none" gives a selection of its own.
     * @return The selection.
     */
    static std::shared_ptr<Selection> named(std::string_view name);
    /** @param key An item key (see item_key()). @return True if it is selected. */
    bool is_selected(std::string_view key) const;
    /** @brief Selects or deselects one item. @param key An item key. @param on True to select. */
    void set(std::string_view key, bool on);
    /** @brief Switches one item. @param key An item key. @return The new state. */
    bool toggle(std::string_view key);
    /** @brief Selects exactly these items among those given and leaves the rest of the selection alone. @param keys The item keys. @param on True to select, false to deselect. */
    void set_all(const std::vector<std::string>& keys, bool on);
    /** @brief Deselects everything. */
    void clear();
    /** @return The selected keys, sorted. */
    std::vector<std::string> selected() const;

private:
    Selection() = default;
    mutable std::mutex mutex_;      /**< Guards the set. */
    std::set<std::string> keys_;    /**< The selected keys. */
};

} // namespace jamoma
