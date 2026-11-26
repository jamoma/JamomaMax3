// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file max_files.hpp
 * @brief Finding the files a user names in a message: in the Max search path, next to the patcher, or through a file dialog.
 */

#pragma once

#include <cstdio>
#include <string>

#include "c74_min.h"

namespace jamoma_max {

/** @return A path as Max writes it (`Macintosh HD:/Users/me/x.txt`, as opendialog gives it) in the native form of the system; a native path stays as it is. @param name The path. */
inline std::string native_path(const std::string& name)
{
    char out[c74::max::MAX_PATH_CHARS];
    if (c74::max::path_nameconform(name.c_str(), out, c74::max::PATH_STYLE_NATIVE, c74::max::PATH_TYPE_BOOT) == 0 && out[0] != '\0') {
        return out;
    }
    return name;
}

/** @return True if the name is a path (it has a slash at the start or a volume), not a file name to search for. @param name The name. */
inline bool is_path(const std::string& name) { return !name.empty() && (name[0] == '/' || name.find(':') != std::string::npos); }

/** @return The native path of a file the user named for reading: as given if it is a path, else found in the Max search path (empty if not found). @param name The name. */
inline std::string find_file(const std::string& name)
{
    if (is_path(name)) {
        return native_path(name);
    }
    char file[c74::max::MAX_FILENAME_CHARS];
    std::snprintf(file, sizeof file, "%s", name.c_str());
    short vol = 0;
    c74::max::t_fourcc type = 0;
    if (c74::max::locatefile_extended(file, &vol, &type, nullptr, 0) != 0) {
        return {};
    }
    char full[c74::max::MAX_PATH_CHARS];
    c74::max::path_toabsolutesystempath(vol, file, full);
    return full;
}

/**
 * @return The native path of a file the user named for writing: as given if it is a path, else in the folder of the patcher (empty if that is unknown).
 * @param patcher The patcher (may be null). @param name The name.
 */
inline std::string target_file(const void* patcher, const std::string& name)
{
    if (is_path(name)) {
        return native_path(name);
    }
    c74::max::t_symbol* path = patcher == nullptr ? nullptr
        : c74::max::object_attr_getsym(const_cast<c74::max::t_object*>(static_cast<const c74::max::t_object*>(patcher)), c74::max::gensym("filepath"));
    std::string folder = path != nullptr && path->s_name != nullptr ? path->s_name : "";
    const std::size_t slash = folder.find_last_of("/\\");
    if (slash == std::string::npos) {
        return {};
    }
    return folder.substr(0, slash + 1) + name;
}

/** Asks for a file with the system dialog. @param saving True for a save dialog. @param suggested The name offered when saving. @return The native path, or empty if cancelled. */
inline std::string ask_for_file(bool saving, const std::string& suggested)
{
    char file[c74::max::MAX_FILENAME_CHARS] = "";
    short vol = 0;
    c74::max::t_fourcc type = 0;
    if (saving) {
        std::snprintf(file, sizeof file, "%s", suggested.c_str());
        short binary = 0;
        if (c74::max::saveas_dialog(file, &vol, &binary) != 0) {
            return {};
        }
    } else if (c74::max::open_dialog(file, &vol, &type, nullptr, 0) != 0) {
        return {};
    }
    char full[c74::max::MAX_PATH_CHARS];
    c74::max::path_toabsolutesystempath(vol, file, full);
    return full;
}

} // namespace jamoma_max
