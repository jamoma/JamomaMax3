// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file cue.hpp
 * @brief The cue list behind `j.cue`: the state of chosen parameters of several models, stored under a name and recalled.
 *
 * A cue is a preset whose addresses are absolute (it spans models): the list is a PresetManager on the root of the namespace, so storing
 * order, recall, output, interpolation, mixing, moving, renaming, copying and removing are those of presets. What a cue list adds is
 * storing from a selection of addresses, a start address for recall, the ramp and the description of a cue, and the two file formats of
 * the old cue files (docs/inventory/j.cue.md): the text form (`CUE name` and lines `/address value...`) and the XML form (`<cue name>`).
 */

#pragma once

#include <optional>
#include <string>
#include <string_view>
#include <vector>

#include "jamoma/address.hpp"
#include "jamoma/export.hpp"
#include "jamoma/namespace.hpp"
#include "jamoma/preset.hpp"

namespace jamoma {

/** What happened when a cue was stored. */
struct StoreReport {
    bool stored = false;                /**< False if the name was empty (then nothing changed). */
    std::vector<std::string> skipped;   /**< Selected addresses that were not stored: no such parameter, no value, or an attribute. */
};

/** @brief A list of cues. Main thread, like PresetManager (observers may be called on it). */
class JAMOMA_API CueList {
public:
    /** @param ns The namespace the cues store from and recall to (it must outlive the list). */
    explicit CueList(Namespace& ns);

    /** @return The presets that hold the cues (addresses relative to the root, without the leading slash). */
    PresetManager& cues() { return manager_; }
    /** @copydoc cues() */
    const PresetManager& cues() const { return manager_; }

    /**
     * @brief Stores the current values of some parameters under a name (a cue of that name is replaced), and makes it the current cue.
     * @param name The cue name.
     * @param keys Absolute addresses of parameters (the keys of a Selection).
     * @return What was stored and what was skipped.
     */
    StoreReport store(std::string_view name, const std::vector<std::string>& keys);
    /**
     * @brief Recalls a cue: sends every line to its parameter, in order. Lines whose parameter does not exist (any more) are reported, not errors.
     * @param name_or_index The name, or a 1-based position as text.
     * @param start Only the lines at or below this address (the root: all lines); a recall from an address does not change the current cue.
     * @return The report (as PresetManager::recall).
     */
    RecallReport recall(std::string_view name_or_index, const Address& start = Address());

    /** @brief Gives every line of a cue the ramp time, replacing any ramp it had. @param name The cue. @param ms Milliseconds; zero or less removes the ramp. @return False if there is no such cue. */
    bool set_ramp(std::string_view name, double ms);
    /** @brief Reads the ramp of a cue. @param name The cue. @return The time of the first line that has a ramp, 0 if none; nothing if there is no such cue. */
    std::optional<double> ramp(std::string_view name) const;
    /** @brief Sets the description of a cue. @param name The cue. @param text The text. @return False if there is no such cue. */
    bool set_description(std::string_view name, std::string_view text);
    /** @brief Reads the description of a cue. @param name The cue. @return The text; nothing if there is no such cue. */
    std::optional<std::string> description(std::string_view name) const;

    /** @return The cues in the text form of the old cue files. */
    std::string write_text() const;
    /**
     * @brief Replaces all cues by those of a text; whatever can be read is kept.
     * @param text The text.
     * @return One line for everything that was skipped or doubtful (empty if the text was fine).
     */
    std::vector<std::string> read_text(std::string_view text);
    /** @return The cues in the XML form of the old cue files. */
    std::string write_xml() const;
    /** @brief Replaces all cues by those of an XML file; whatever can be read is kept. @param xml The file. @return One line for everything skipped or doubtful. */
    std::vector<std::string> read_xml(std::string_view xml);

    /** @return The text shown in the edit window (the text form). */
    std::string edit_text() const { return write_text(); }
    /** @brief Reads the text of the edit window back; a text with no cue in it changes nothing. @param text The edited text. @return The problems found, as read_text(). */
    std::vector<std::string> apply_edit_text(std::string_view text);

private:
    Namespace& ns_;          /**< The namespace. */
    PresetManager manager_;  /**< The cues. */
};

} // namespace jamoma
