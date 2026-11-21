// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file j.loader.cpp
 * @brief The start-up loader: loaded by Max when it launches (it lives in the package's
 *        extensions folder), it attaches to the process-wide registry in the core library.
 */

#include "c74_min.h"

#include "jamoma/registry.hpp"
#include "jamoma/version.hpp"

namespace {

/**
 * Runs when Max loads this bundle at launch: attaches to the registry, or reports an ABI
 * mismatch between this loader and the installed core library and attaches nothing.
 */
struct LoaderInit {
    /** Attaches to the registry and logs the outcome to the Max console. */
    LoaderInit()
    {
        if (jamoma::Registry::instance().try_attach_loader(jamoma::kAbiVersion)) {
            c74::max::post("Jamoma %d.%d.%d (abi %d) loaded", jamoma::version().major,
                jamoma::version().minor, jamoma::version().patch, jamoma::abi_version());
        } else {
            c74::max::error("Jamoma: core ABI mismatch (loader built for abi %d, library is abi %d)",
                jamoma::kAbiVersion, jamoma::abi_version());
        }
    }
};

/** The single instance, constructed when the bundle is loaded. */
const LoaderInit g_loader_init;

} // namespace

/** The class Min registers so that Max accepts the bundle as an external named j.loader. */
class j_loader : public c74::min::object<j_loader> {
};

MIN_EXTERNAL(j_loader);
