// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file registry_exit_test.cpp
 * @brief Checks that the registry is still intact while other static objects are destroyed at exit.
 *
 * At Max's quit, externals are freed (and unsubscribe) late, possibly after ordinary static destruction. The registry
 * therefore must outlive all of it. Here a namespace-scope object is constructed BEFORE the registry is first used, so
 * a normal function-local static registry would be destroyed first; the object's destructor then still looks up a node.
 * The program exits with status 0 if it does, 1 if the registry content is gone.
 */

#include <cstdlib>

#include "jamoma/namespace.hpp"
#include "jamoma/registry.hpp"

namespace {

/** Looks up a node in the registry's namespace when it is destroyed, late in the exit sequence. */
struct LateObserver {
    ~LateObserver()
    {
        const bool intact = jamoma::Registry::instance().names().lookup(jamoma::Address::parse("/exit/test")) != nullptr;
        std::_Exit(intact ? 0 : 1);
    }
};

/** Constructed before main, so destroyed after anything first used in main. */
LateObserver g_late_observer;

/** The object subscribed in main and deliberately never unsubscribed. */
struct Dummy : jamoma::Object {};

} // namespace

/** Subscribes an object and returns; the check happens in the static destructor. @return 0. */
int main()
{
    static Dummy dummy;
    new jamoma::Subscription(jamoma::Registry::instance().names().subscribe(jamoma::Address::parse("/exit/test"), dummy));
    return 0;
}
