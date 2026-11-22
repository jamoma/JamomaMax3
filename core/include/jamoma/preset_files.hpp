// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file preset_files.hpp
 * @brief Reading and writing presets as the old text files and the old XML files.
 *
 * The text form is the model's file (`<class>.model.presets.txt`): per preset a `- preset "name"` flag, an optional `- description "..."` flag, comment lines
 * (`# ...`) and commands (`<relative address> <value...>`). The XML form is what the old cue and application files held: `<jamoma version="0.6">` with one
 * `<preset name>` per preset and in it `<flag>`, `<command address unit ramp>`, `<script address>` and comments. Readers never throw: whatever cannot be
 * understood is reported as a one-line problem and the rest is still read. Comments and flags other than the name and description are kept in
 * Preset::flags (comments with their leading `#`), so a file read and written again keeps them (written before the commands).
 */

#pragma once

#include <string>
#include <string_view>
#include <vector>

#include "jamoma/export.hpp"
#include "jamoma/preset.hpp"

namespace jamoma {

/** What a reader found. */
struct ReadResult {
    std::vector<Preset> presets;       /**< The presets that could be read, in file order. */
    std::vector<std::string> problems; /**< One line of text for everything that was skipped or doubtful. */
};

/** @brief Reads the text form. @param text The file content. @return The presets and the problems. */
JAMOMA_API ReadResult read_presets_text(std::string_view text);
/** @brief Writes the text form. @param presets The presets. @return The file content. */
JAMOMA_API std::string write_presets_text(const std::vector<Preset>& presets);
/** @brief Reads the XML form. @param text The file content. @return The presets and the problems. */
JAMOMA_API ReadResult read_presets_xml(std::string_view text);
/** @brief Writes the XML form. @param presets The presets. @return The file content. */
JAMOMA_API std::string write_presets_xml(const std::vector<Preset>& presets);

} // namespace jamoma
