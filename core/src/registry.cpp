// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file registry.cpp
 * @brief Implementation of the process-wide registry.
 */

#include "jamoma/registry.hpp"

#include <chrono>

#include "jamoma/version.hpp"

namespace jamoma {

Registry::Registry() noexcept
{
    const auto ticks = static_cast<std::uint64_t>(
        std::chrono::steady_clock::now().time_since_epoch().count());
    const auto address = static_cast<std::uint64_t>(reinterpret_cast<std::uintptr_t>(this));
    const std::uint64_t id = ticks ^ (address * 0x9E3779B97F4A7C15ull);
    id_ = id != 0 ? id : 1;
}

Registry& Registry::instance() noexcept
{
    static Registry registry;
    return registry;
}

std::uint64_t Registry::instance_id() const noexcept
{
    return id_;
}

bool Registry::loader_attached() const noexcept
{
    return loader_attached_.load(std::memory_order_acquire);
}

void Registry::attach_loader() noexcept
{
    loader_attached_.store(true, std::memory_order_release);
}

bool Registry::claim_missing_loader_warning() noexcept
{
    if (loader_attached()) {
        return false;
    }
    return !missing_loader_warned_.exchange(true, std::memory_order_acq_rel);
}

bool Registry::try_attach_loader(int caller_abi) noexcept
{
    if (!check_abi(caller_abi)) {
        return false;
    }
    attach_loader();
    return true;
}

bool Registry::check_abi(int caller_abi) noexcept
{
    return caller_abi == abi_version();
}

} // namespace jamoma
