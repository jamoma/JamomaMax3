// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file explore_filter.hpp
 * @brief The filters of j.namespace: named rules that decide which nodes an exploration lists.
 *
 * Ported from the old TTExplorer filter bank (jamoma_explorer_default_filter_bank, testNodeUsingFilter). A rule names conditions on a node
 * (`object` Data or Container or none, `attribute` and `value`, `part`, `parent`, `name`, `instance`) and a `mode` that says how it combines
 * with the rules before it: `restrict` (the default), `include`, `exclude` or `hamlet`. The texts of `part`, `parent`, `name` and `instance`
 * are regular expressions; `part` and `parent` may match anywhere, `name` and `instance` at the start.
 */

#pragma once

#include <map>
#include <optional>
#include <string>
#include <string_view>
#include <vector>

#include "jamoma/address.hpp"
#include "jamoma/atom.hpp"
#include "jamoma/export.hpp"
#include "jamoma/namespace.hpp"

namespace jamoma {

/** The filters one explorer knows, and the list of those that are in use. A copy is independent. */
class JAMOMA_API ExploreFilters {
public:
    /** Starts with the ready-made filters (data, parameter, message, return, model, view, none, remote, in, out, in~, out~, genericTag, noGenericTag); none is in use. */
    ExploreFilters();
    /**
     * @brief Makes a filter or adds conditions to one, and puts it in use (the `filter/set` message).
     * @param rule The name, then pairs of a condition and its value.
     * @return False (nothing changes) for an empty rule, a name that is not a symbol, an unknown condition, a missing value or a text that is
     *         not a regular expression.
     */
    bool set(const Value& rule);
    /** @brief Sets the filters in use, in order (names without a filter are kept and have no effect). @param names The names. */
    void set_list(const Value& names);
    /** @return The names of the filters in use. */
    Value list() const;
    /**
     * @brief The `filter/remove` message.
     * @param name With one name: that filter is forgotten and no longer used. Empty: every filter in use is forgotten.
     */
    void remove(const Value& name);
    /** @param name A filter. @return Its name followed by its conditions and values, or nothing if there is none. */
    std::optional<Value> info(std::string_view name) const;
    /** @return True if no filter is in use. */
    bool empty() const noexcept { return list_.empty(); }
    /**
     * @brief Whether a node passes the filters in use.
     * @param node The absolute address of the node. @param object Its object, or null.
     * @return True if it is to be listed.
     */
    bool accepts(const Address& node, const Object* object) const;

private:
    /** One filter. */
    struct Rule {
        std::string mode = "restrict";                  /**< How it combines. */
        std::vector<std::pair<std::string, Value>> conditions; /**< The conditions in the order given. */
    };

    std::map<std::string, Rule> bank_;  /**< The filters by name. */
    std::vector<std::string> list_;     /**< The names in use, in order. */
};

} // namespace jamoma
