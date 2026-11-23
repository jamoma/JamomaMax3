// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file preset.hpp
 * @brief The preset manager: stores the parameters of a model as named presets and recalls them (the old TTPresetManager).
 *
 * A preset is a name, a description and a list of entries (address relative to the model, value). Presets hold their values, never
 * pointers into the namespace, so recalling after nodes came and went is safe: an entry whose node is gone is skipped and reported.
 * Positions in this interface are 0-based; a text that names a preset by position (`"2"`) is 1-based, as in the old messages.
 * All calls are for the main thread.
 */

#pragma once

#include <cstddef>
#include <functional>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "jamoma/address.hpp"
#include "jamoma/atom.hpp"
#include "jamoma/export.hpp"
#include "jamoma/namespace.hpp"

namespace jamoma {

/** One line of a preset: the address of a parameter (relative to the model) and the value to send to it. */
struct PresetEntry {
    Address address; /**< The address relative to the model, as in the files. */
    Value value;     /**< The command to send (a value, optionally with a unit and `ramp <ms>`). */
};

/** A named list of entries. */
struct Preset {
    std::string name;                 /**< The name. */
    std::string description;          /**< The description (empty if none). */
    std::vector<PresetEntry> entries; /**< The entries, in the order they are recalled. */
    std::vector<std::string> flags;   /**< Other flag lines of a text file (without the leading `- `), kept so a file written back is unchanged. */
};

/** What a recall or an output did. */
struct RecallReport {
    bool found = false;                 /**< False if there is no such preset (then nothing changed). */
    std::size_t applied = 0;            /**< How many entries were sent to their node. */
    std::vector<Address> skipped;       /**< Entries whose node does not exist (any more). */
    std::vector<PresetEntry> entries;   /**< For output(): the entries of the preset. */
};

/** Stores and recalls the parameters of one model. */
class JAMOMA_API PresetManager {
public:
    /**
     * @brief Creates a manager.
     * @param ns The namespace the model lives in (it must outlive the manager).
     * @param model The address of the model whose parameters are stored.
     */
    PresetManager(Namespace& ns, Address model);

    /** @brief Changes the model whose parameters are stored (used by the model once it knows its final address). @param model The address. */
    void set_model(Address model) { model_ = std::move(model); }
    /** @return The presets in order. */
    const std::vector<Preset>& presets() const noexcept { return presets_; }
    /** @return The names of the presets in order. */
    std::vector<std::string> names() const;
    /** @return The index of the preset last stored or recalled, if any. */
    std::optional<std::size_t> current() const noexcept { return current_; }

    /**
     * @brief Stores the present state as a preset; an existing name is stored again in place.
     * @param name The name (not empty). @param position Where to put a new preset (0-based; the end if absent or too big).
     * @return False for an empty name.
     */
    bool new_preset(std::string_view name, std::optional<std::size_t> position = {});
    /** @brief Stores the present state into an existing preset. @param name_or_index Its name or 1-based position. @return False if there is none. */
    bool update(std::string_view name_or_index);
    /**
     * @brief Sends the entries of a preset to their nodes, in order, as commands (ranges, clipping and ramps apply as for any command).
     * @param name_or_index The name or the 1-based position. @return What happened; `found` is false (and nothing changed) for an unknown preset.
     */
    RecallReport recall(std::string_view name_or_index);
    /** @brief Like recall() but only reports: the entries come back in the report and nothing is sent. @param name_or_index The name or 1-based position. @return The report. */
    RecallReport output(std::string_view name_or_index) const;
    /**
     * @brief Sends a blend of two presets: numbers and lists of numbers of the same length are interpolated element by element, any other value is taken from the nearer preset (the second at 0.5);
     *        an entry that only one preset has keeps that preset's value.
     * @param a The first preset (name or 1-based position). @param b The second. @param position 0 is the first, 1 the second; outside that it is clamped.
     * @return What happened; `found` is false (and nothing changed) if a preset is unknown.
     */
    RecallReport interpolate(std::string_view a, std::string_view b, double position);
    /**
     * @brief Sends a weighted mix of presets: numbers are summed with their factors and divided by the sum of the factors of the presets that have the entry; other values come from the first preset with the largest factor.
     * @param weighted Pairs of a preset (name or 1-based position) and a factor (negative counts as 0). @return What happened; nothing is sent if a preset is unknown or the factors sum to 0.
     */
    RecallReport mix(const std::vector<std::pair<std::string, double>>& weighted);
    /** @brief Removes a preset. @param name_or_index Its name or 1-based position. @return False if there is none. */
    bool remove(std::string_view name_or_index);
    /** @brief Renames a preset. @param from Its name or 1-based position. @param to The new name (not taken). @return False if not possible. */
    bool rename(std::string_view from, std::string_view to);
    /** @brief Copies a preset. @param from Its name or 1-based position. @param to The new name (not taken). @param position Where to put it (0-based; the end if absent). @return False if not possible. */
    bool copy(std::string_view from, std::string_view to, std::optional<std::size_t> position = {});
    /** @brief Moves a preset. @param name_or_index Its name or 1-based position. @param position The new 0-based position (less than the count). @return False if not possible. */
    bool move(std::string_view name_or_index, std::size_t position);
    /** @brief The first name of the form `<stem> <n>` (n from 1) that no preset has. @param stem The text before the number. @return The name. */
    std::string free_name(std::string_view stem) const;
    /** @brief Removes every preset. */
    void clear();
    /**
     * @brief Listens to changes of the list, of a preset's content and of the current preset.
     * @param callback Called after each change, on the thread that made it (it may drop its own handle).
     * @return A handle; dropping it unregisters the observer (it may outlive the manager).
     */
    std::shared_ptr<void> observe(std::function<void()> callback);
    /** @brief Replaces the whole list (what a file reader does); there is no current preset afterwards. @param presets The new list. */
    void replace_all(std::vector<Preset> presets);

private:
    /** @return The 0-based index a name or 1-based position text refers to. @param key The text. */
    std::optional<std::size_t> find(std::string_view key) const;
    /** @return The parameters below the model now, as entries in order of priority, name, instance. */
    std::vector<PresetEntry> store() const;
    /** Sends entries to their nodes as commands. @param entries The entries. @param report Where to count and list what was skipped. */
    void apply(const std::vector<PresetEntry>& entries, RecallReport& report);

    /** Tells the observers. */
    void changed();

    struct Observers;                    /**< The observers, shared with their handles. */
    std::shared_ptr<Observers> observers_; /**< The observers. */
    Namespace& ns_;                  /**< The namespace. */
    Address model_;                  /**< The model. */
    std::vector<Preset> presets_;    /**< The presets. */
    std::optional<std::size_t> current_; /**< The current preset. */
};

} // namespace jamoma
