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
#include <optional>
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
    /**
     * @brief Gives the model another name under which it and everything below it can be addressed too (its own address stays).
     * @param alias An absolute address, or a name beside the model; empty or `none` removes the alias.
     * @return False if the address is taken or lies in or around the model (the alias before is removed all the same).
     */
    bool set_alias(const std::string& alias);
    /** @return The alias as an absolute address, or an empty string. */
    std::string alias() const;
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
    /** @return Every registration, in the order they were made. */
    std::vector<std::pair<const void*, Model*>> all() const;
    /** @brief Finds the model of a patcher. @param patcher The patcher. @return The earliest registered model, or null. */
    Model* find(const void* patcher) const;

private:
    struct Observers;                                       /**< The observers, shared with their handles so that a handle may outlive the map. */
    mutable std::mutex mutex_;                              /**< Guards the entries. */
    std::vector<std::pair<const void*, Model*>> entries_;   /**< The registrations in order. */
    std::shared_ptr<Observers> observers_;                  /**< The observers of add and remove. */
};

/**
 * @brief The map from patchers to the views in them: a view is known by the model argument it was given (empty if none).
 *
 * Which model a view is bound to is worked out from the context map when it is asked (the Max layer does that), so nothing here
 * has to follow models coming and going. Thread safe.
 */
class JAMOMA_API ViewMap {
public:
    ViewMap();

    /** @brief Registers a view. @param patcher The patcher of the view. @param argument The model address as given to the view (may be empty). */
    void add(const void* patcher, std::string argument);
    /** @brief Removes a view. @param patcher The patcher of the view. */
    void remove(const void* patcher);
    /**
     * @brief Gives a view another model argument and tells the observers.
     * @param patcher The patcher of the view. @param argument The new model address (may be empty).
     * @return True if there is a view there and its argument changed.
     */
    bool set_argument(const void* patcher, std::string argument);
    /**
     * @brief Watches the argument of views being changed (adding and removing a view is not told).
     *
     * The callback runs on the thread that calls set_argument(), after the map's lock is released, so it may drop its own handle or call the map.
     * @param callback The function to call with the patcher of the view.
     * @return A handle that unregisters the observer when dropped; it may outlive the map.
     */
    std::shared_ptr<void> observe(std::function<void(const void* patcher)> callback);
    /** @brief Finds a view. @param patcher The patcher. @return The model argument it was given, or nothing if there is no view there. */
    std::optional<std::string> find(const void* patcher) const;
    /**
     * @brief Listens to what the objects of a view report (the left outlet of `j.view`).
     *
     * The callback runs on the thread that calls report(), with no lock held.
     * @param patcher The patcher of the view. @param callback Called with the name and the value.
     * @return A handle that stops the listening when dropped; it may outlive the map.
     */
    std::shared_ptr<void> listen(const void* patcher, std::function<void(const std::string& name, const Value& value)> callback);
    /** @brief Tells the listeners of a view about a value. @param patcher The patcher of the view. @param name Who it comes from. @param value The value. */
    void report(const void* patcher, const std::string& name, const Value& value) const;

private:
    struct Observers;                                           /**< The observers, shared with their handles so that a handle may outlive the map. */
    struct Listeners;                                           /**< The listeners to reports, shared with their handles in the same way. */
    mutable std::mutex mutex_;                                  /**< Guards the entries. */
    std::vector<std::pair<const void*, std::string>> entries_;  /**< The views. */
    std::shared_ptr<Observers> observers_;                      /**< The observers of changed arguments. */
    std::shared_ptr<Listeners> listeners_;                      /**< The listeners to reports. */
};

} // namespace jamoma
