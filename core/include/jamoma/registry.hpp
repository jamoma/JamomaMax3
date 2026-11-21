// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file registry.hpp
 * @brief The process-wide registry: the one place all externals share state.
 */

#pragma once

#include <atomic>
#include <cstdint>

#include "jamoma/export.hpp"

namespace jamoma {

/**
 * @brief The registry that every external in a Max process shares.
 *
 * It lives in the shared core library, so there is exactly one instance per
 * process however many externals link to the library. The start-up loader
 * attaches to it when Max launches; externals work without the loader too.
 */
class JAMOMA_API Registry {
public:
    /**
     * @brief The one registry of this process.
     * @return A reference that stays valid until the process ends.
     */
    static Registry& instance() noexcept;

    /**
     * @brief Identifies this load of the library in this process.
     * @return A non-zero value that never changes during the life of the registry.
     */
    std::uint64_t instance_id() const noexcept;

    /**
     * @brief Tells whether the start-up loader has attached.
     * @return True once attach_loader() has been called.
     */
    bool loader_attached() const noexcept;

    /** @brief Records that the start-up loader attached. Calling it again changes nothing. */
    void attach_loader() noexcept;

    /**
     * @brief Lets exactly one caller per process warn that the start-up loader is missing.
     *
     * Every external calls this when it starts without the loader; only the first call
     * (and only while no loader is attached) returns true, so the user sees one warning
     * however many externals are created.
     * @return True for the one caller that should log the warning; false for all others.
     */
    bool claim_missing_loader_warning() noexcept;

    /**
     * @brief Attaches the start-up loader if it was built against this library's ABI.
     * @param caller_abi The ABI version the loader was built with (jamoma::kAbiVersion).
     * @return True if the loader is now attached; false if the ABI differs, in which case nothing is attached.
     */
    bool try_attach_loader(int caller_abi) noexcept;

    /**
     * @brief Checks that a caller was built against this library's binary interface.
     * @param caller_abi The ABI version the caller was built with.
     * @return True if it equals abi_version().
     */
    static bool check_abi(int caller_abi) noexcept;

    Registry(const Registry&) = delete;            /**< A registry is never copied. */
    Registry& operator=(const Registry&) = delete; /**< A registry is never assigned. */

private:
    /** Creates the registry and its instance id. Only instance() calls it. */
    Registry() noexcept;

    std::uint64_t id_;                       /**< The instance id. */
    std::atomic<bool> loader_attached_{false}; /**< Whether the start-up loader attached. */
    std::atomic<bool> missing_loader_warned_{false}; /**< Whether a caller has claimed the missing-loader warning. */
};

} // namespace jamoma
