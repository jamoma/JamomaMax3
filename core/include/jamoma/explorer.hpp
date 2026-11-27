// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file explorer.hpp
 * @brief The model explorer: what lives below a model (parameters, messages, returns) and the names of its presets, and when that changes.
 *
 * It is what a user interface object such as `j.ui` reads. The contents are read from the namespace when asked (so a snapshot is always
 * current); the callback only says that something changed: a node below the model came or went, the model came or went, or a preset changed.
 */

#pragma once

#include <functional>
#include <memory>
#include <string>
#include <vector>

#include "jamoma/address.hpp"
#include "jamoma/export.hpp"
#include "jamoma/namespace.hpp"

namespace jamoma {

/** What is below a model, as addresses relative to it, sorted by priority and then name. */
struct ModelContents {
    std::vector<std::string> parameters; /**< The nodes with the parameter service. */
    std::vector<std::string> messages;   /**< The nodes with the message service. */
    std::vector<std::string> returns;    /**< The nodes with the return service. */
    std::vector<std::string> generic_parameters; /**< The parameters tagged `generic`, which are not listed in `parameters`. */
    std::vector<std::string> generic_messages;   /**< The messages tagged `generic`. */
    std::vector<std::string> generic_returns;    /**< The returns tagged `generic`. */
    std::vector<std::string> presets;    /**< The names of the presets of the model, in order. */
};

/**
 * @brief Follows a model and what is below it.
 *
 * The callback runs on the thread that made the change, after the namespace's lock is released; it may destroy the explorer. The preset names
 * are read from the model's preset manager, which belongs to the main thread, so call contents() on the main thread. Nodes may come and go on
 * any thread while contents() runs.
 */
class JAMOMA_API ModelExplorer {
public:
    /**
     * @brief Creates an explorer that follows nothing.
     * @param ns The namespace (it must outlive the explorer).
     * @param on_change Called after the contents changed.
     */
    ModelExplorer(Namespace& ns, std::function<void()> on_change);
    ~ModelExplorer();
    ModelExplorer(const ModelExplorer&) = delete;            /**< An explorer is never copied. */
    ModelExplorer& operator=(const ModelExplorer&) = delete; /**< An explorer is never assigned. */

    /** @brief Follows another model; the empty address follows nothing. @param model The address of the model. */
    void set_model(const Address& model);
    /** @return The address of the model that is followed. */
    Address model() const;
    /** @return What is below the model now (empty if there is no model). */
    ModelContents contents() const;

private:
    struct State;                      /**< The state, shared weakly with the observers. */
    std::shared_ptr<State> state_;     /**< The state. */
};

} // namespace jamoma
