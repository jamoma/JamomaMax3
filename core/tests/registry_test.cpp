// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file registry_test.cpp
 * @brief Unit tests for the process-wide registry of the core library.
 *
 * Each test case runs in its own process under ctest, so the state of the
 * registry is fresh in every case. Run directly, the cases that depend on a
 * fresh state come before the one that attaches the loader.
 */

#include <catch2/catch_test_macros.hpp>

#include "jamoma/registry.hpp"
#include "jamoma/version.hpp"

/** There is exactly one registry in a process. */
TEST_CASE("instance is a singleton")
{
    REQUIRE(&jamoma::Registry::instance() == &jamoma::Registry::instance());
}

/** The instance id identifies this load of the library: non-zero and constant. */
TEST_CASE("instance id is stable and non-zero")
{
    const std::uint64_t first = jamoma::Registry::instance().instance_id();
    REQUIRE(first != 0);
    REQUIRE(jamoma::Registry::instance().instance_id() == first);
}

/** The ABI check accepts the library's own version and rejects any other. */
TEST_CASE("check_abi accepts current and rejects other")
{
    REQUIRE(jamoma::Registry::check_abi(jamoma::abi_version()));
    REQUIRE_FALSE(jamoma::Registry::check_abi(jamoma::abi_version() + 1));
    REQUIRE_FALSE(jamoma::Registry::check_abi(0));
}

/** An external may run before the loader did: the registry works and reports that no loader attached. */
TEST_CASE("usable without loader")
{
    REQUIRE_FALSE(jamoma::Registry::instance().loader_attached());
    REQUIRE(jamoma::Registry::instance().instance_id() != 0);
}

/** A loader built against another ABI is refused and nothing is attached. */
TEST_CASE("try_attach_loader rejects an ABI mismatch")
{
    REQUIRE_FALSE(jamoma::Registry::instance().try_attach_loader(jamoma::kAbiVersion + 1));
    REQUIRE_FALSE(jamoma::Registry::instance().loader_attached());
}

/** A loader built against this ABI is accepted and attached. */
TEST_CASE("try_attach_loader accepts the current ABI")
{
    REQUIRE(jamoma::Registry::instance().try_attach_loader(jamoma::kAbiVersion));
    REQUIRE(jamoma::Registry::instance().loader_attached());
}

/** The missing-loader warning is claimed by exactly one caller in the process, however many externals ask. */
TEST_CASE("claim_missing_loader_warning is granted once")
{
    REQUIRE(jamoma::Registry::instance().claim_missing_loader_warning());
    REQUIRE_FALSE(jamoma::Registry::instance().claim_missing_loader_warning());
    REQUIRE_FALSE(jamoma::Registry::instance().claim_missing_loader_warning());
}

/** With the loader attached there is nothing to warn about, and the claim is refused. */
TEST_CASE("claim_missing_loader_warning is refused when the loader attached")
{
    jamoma::Registry::instance().attach_loader();
    REQUIRE_FALSE(jamoma::Registry::instance().claim_missing_loader_warning());
}

/** Attaching the loader twice changes nothing the second time. */
TEST_CASE("attach_loader is idempotent")
{
    const std::uint64_t id = jamoma::Registry::instance().instance_id();
    jamoma::Registry::instance().attach_loader();
    jamoma::Registry::instance().attach_loader();
    REQUIRE(jamoma::Registry::instance().loader_attached());
    REQUIRE(jamoma::Registry::instance().instance_id() == id);
}
