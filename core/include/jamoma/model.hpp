// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file model.hpp
 * @brief The model: a node in the namespace that initialises the parameters below it, and the map from patchers to models.
 */

#pragma once

#include <functional>
#include <memory>
#include <mutex>
#include <string>
#include <utility>
#include <vector>

#include "jamoma/address.hpp"
#include "jamoma/export.hpp"
#include "jamoma/namespace.hpp"
#include "jamoma/preset.hpp"

namespace jamoma {

/**
 * @brief A model: registers itself in the namespace, holds description and priority, and initialises its parameters.
 *
 * Ported from the old TTContainer: init() first reports "started", then walks the children in order of priority, then name, then
 * instance, and sends init to every Data with the parameter service (not to messages or returns); a nested Model runs its own
 * init at its place; each child is found again by name and instance before it is used, so one that was removed meanwhile is
 * skipped; finally it reports "finished". The namespace must outlive the model. Not thread safe: use it on the main thread.
 */
class JAMOMA_API Model : public Object {
public:
    /**
     * @brief Creates a model and subscribes it at an address.
     * @param ns The namespace.
     * @param address Where to put the model (a second model at the same address becomes instance 1, and so on).
     */
    Model(Namespace& ns, const Address& address);
    ~Model() override;

    /** @return The address the model ended up at. */
    const Address& address() const noexcept;
    /** @brief Sets the description. @param text The description. */
    void set_description(std::string text);
    /** @return The description. */
    std::string description() const;
    /** @brief Sets the priority used when a parent model initialises. @param priority The priority. */
    void set_priority(int priority);
    /** @return The priority. */
    int priority() const;
    /** @return True after init has finished and until the next init starts. */
    bool initialized() const;

    /** @return The preset manager of the model; it stores and recalls the parameters below the model's address. */
    PresetManager& presets();

    /** @brief Initialises the parameters below the model (see the class description). */
    void init();

    /**
     * @brief Listens to the initialisation state.
     *
     * The callback gets false when init starts and true when it is finished. If the model is already initialised when the
     * observer registers, it gets true at once (this is what the old j.init relied on).
     * @param callback The function to call.
     * @return A handle; dropping it unregisters the observer.
     */
    std::shared_ptr<void> on_init_changed(std::function<void(bool)> callback);

private:
    struct Impl;                          /**< The state, hidden from the header. */
    std::shared_ptr<Impl> impl_;          /**< The state (shared weakly with observer handles). */
};

/**
 * @brief The map from patchers to the models in them, shared by every external in the process.
 *
 * A patcher is identified by an opaque pointer. j.model registers its model under its patcher; a data object looks up the model
 * of its own patcher, or of the nearest enclosing one (the walk up the patchers is done by the Max layer). Thread safe.
 */
class JAMOMA_API ContextMap {
public:
    ContextMap();

    /** @brief Registers a model for a patcher (the earliest registered one wins in find()). @param patcher The patcher. @param model The model. */
    void add(const void* patcher, Model* model);
    /** @brief Removes a registration; nothing happens if it is not there. @param patcher The patcher. @param model The model. */
    void remove(const void* patcher, Model* model);
    /**
     * @brief Watches models being registered for patchers and removed again.
     *
     * The callback runs on the thread that calls add() or remove(), after the map's lock is released, so it may drop its own handle or call
     * the map. It gets the patcher, the model and true for an add, false for a removal (a remove() that finds nothing is silent).
     * @param callback The function to call.
     * @return A handle that unregisters the observer when dropped; it may outlive the map.
     */
    std::shared_ptr<void> observe(std::function<void(const void* patcher, Model* model, bool added)> callback);
    /** @brief Finds the model of a patcher. @param patcher The patcher. @return The earliest registered model, or null. */
    Model* find(const void* patcher) const;

private:
    struct Observers;                                       /**< The observers, shared with their handles so that a handle may outlive the map. */
    mutable std::mutex mutex_;                              /**< Guards the entries. */
    std::vector<std::pair<const void*, Model*>> entries_;   /**< The registrations in order. */
    std::shared_ptr<Observers> observers_;                  /**< The observers of add and remove. */
};

} // namespace jamoma
