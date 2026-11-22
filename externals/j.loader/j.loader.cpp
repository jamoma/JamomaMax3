// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file j.loader.cpp
 * @brief The start-up loader: loaded by Max when it launches (it lives in the package's
 *        extensions folder), it attaches to the process-wide registry in the core library.
 *
 * The work is done from the class setup (called from the external's main function), not from a
 * static initialiser: on Windows a static initialiser runs inside DllMain under the loader lock,
 * where calling into Max can deadlock.
 */

#include "c74_min.h"

#include "jamoma/registry.hpp"
#include "jamoma/version.hpp"

/** The class Min registers so that Max accepts the bundle as an external named j.loader. */
class j_loader : public c74::min::object<j_loader> {
public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /**
     * Called once when Max sets the class up at launch: attaches to the registry, or reports an
     * ABI mismatch between this loader and the installed core library and attaches nothing.
     */
    c74::min::message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION {
        if (jamoma::Registry::instance().try_attach_loader(jamoma::kAbiVersion)) {
            c74::max::post("Jamoma %d.%d.%d (abi %d) loaded", jamoma::version().major,
                jamoma::version().minor, jamoma::version().patch, jamoma::abi_version());
        } else {
            c74::max::error("Jamoma: core ABI mismatch (loader built for abi %d, library is abi %d)",
                jamoma::kAbiVersion, jamoma::abi_version());
        }
        return {};
    }};
};

MIN_EXTERNAL(j_loader);
