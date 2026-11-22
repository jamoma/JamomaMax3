// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file j.savebang.cpp
 * @brief j.savebang: sends a bang when the patcher that contains it is saved.
 *
 * A plain Max class, because the `save` message is an internal (A_CANT) message that Max sends to every object when it
 * saves the patcher.
 */

#include "c74_min.h"

using namespace c74::max;

namespace {

/** The class of j.savebang. */
t_class* s_class = nullptr;

/** The object data. */
struct t_savebang {
    t_object ob;   /**< The Max object header. */
    void* outlet;  /**< The outlet that gets the bang. */
};

/** Creates the object. @return The new object. */
void* savebang_new()
{
    auto* x = static_cast<t_savebang*>(object_alloc(s_class));
    if (x != nullptr) {
        x->outlet = outlet_new(x, nullptr);
    }
    return x;
}

/** Answers the assist strings. @param b Unused. @param m 1 for inlet, 2 for outlet. @param a Index. @param dst Where to write. */
void savebang_assist(t_savebang*, void*, long, long, char* dst)
{
    strcpy(dst, "sends a bang when the containing patcher is saved");
}

/** Max tells every object that the patcher is being saved. @param x The object. */
void savebang_save(t_savebang* x, t_symbol*, long, t_atom*)
{
    outlet_bang(x->outlet);
}

} // namespace

/** Class setup, called by Max. */
void ext_main(void*)
{
    t_class* c = class_new("j.savebang", reinterpret_cast<method>(savebang_new), nullptr, sizeof(t_savebang), nullptr, 0);
    class_addmethod(c, reinterpret_cast<method>(savebang_save), "save", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(savebang_assist), "assist", A_CANT, 0);
    class_register(CLASS_BOX, c);
    s_class = c;
}
