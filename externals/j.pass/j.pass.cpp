// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.pass.cpp
 * @brief j.pass: routes a message to the outlet of the argument it matches (like route), optionally stripping a leading slash.
 *
 * A plain Max class. Behaviour follows the old j.pass: every argument gets an outlet (the first on the left), the last outlet
 * is the overflow and dumpout outlet; a leading slash on an argument or on a message is dropped; attributes `strip`
 * (default 1: the matched message is sent without the slash) and `stripnonmatches` (default 0).
 */

#include "c74_min.h"

#include <cstddef>

using namespace c74::max;

namespace {

constexpr long kMaxArguments = 100; /**< The most arguments (and outlets) an object can have. */

/** The class of j.pass. */
t_class* s_class = nullptr;

/** The object data. */
struct t_pass {
    t_object ob;                       /**< The Max object header. */
    void* outlets[kMaxArguments];      /**< One outlet per argument. */
    void* overflow;                    /**< The overflow outlet, also the dumpout outlet. */
    t_atom arguments[kMaxArguments];   /**< The arguments (slash stripped). */
    long count;                        /**< How many arguments there are. */
    long strip;                        /**< Attribute: send matches without the leading slash. */
    long stripnonmatches;              /**< Attribute: send non-matches without the leading slash. */
};

/** @param name A message name. @return The name without one leading slash. */
t_symbol* without_slash(t_symbol* name)
{
    const char* text = name->s_name;
    return (*text == '/') ? gensym(text + 1) : name;
}

/**
 * Creates the object.
 * @param argc The number of creation atoms. @param argv The creation atoms. @return The new object.
 */
void* pass_new(t_symbol*, long argc, t_atom* argv)
{
    auto* x = static_cast<t_pass*>(object_alloc(s_class));
    if (x == nullptr) {
        return nullptr;
    }
    const long attribute_start = attr_args_offset(static_cast<short>(argc), argv);
    x->overflow = outlet_new(x, nullptr);
    object_obex_store(x, gensym("dumpout"), static_cast<t_object*>(x->overflow));
    x->count = attribute_start < kMaxArguments ? attribute_start : kMaxArguments;
    for (long i = x->count - 1; i >= 0; --i) {
        x->outlets[i] = outlet_new(x, nullptr);
        switch (atom_gettype(argv + i)) {
        case A_LONG: atom_setlong(&x->arguments[i], atom_getlong(argv + i)); break;
        case A_FLOAT: atom_setfloat(&x->arguments[i], atom_getfloat(argv + i)); break;
        case A_SYM: atom_setsym(&x->arguments[i], without_slash(atom_getsym(argv + i))); break;
        default: atom_setlong(&x->arguments[i], 0); break;
        }
    }
    x->strip = 1;
    x->stripnonmatches = 0;
    attr_args_process(x, static_cast<short>(argc), argv);
    return x;
}

/** Answers the assist strings. @param x The object. @param msg 1 inlet, 2 outlet. @param arg Index. @param dst Where to write. */
void pass_assist(t_pass* x, void*, long msg, long arg, char* dst)
{
    if (msg == 1) {
        strcpy(dst, "Input");
        return;
    }
    if (arg < x->count) {
        const t_atom* a = &x->arguments[arg];
        if (atom_gettype(a) == A_LONG) {
            snprintf(dst, 200, "%ld", static_cast<long>(atom_getlong(a)));
        } else if (atom_gettype(a) == A_FLOAT) {
            snprintf(dst, 200, "%f", atom_getfloat(a));
        } else {
            strcpy(dst, atom_getsym(a)->s_name);
        }
    } else {
        strcpy(dst, "dumpout / overflow from non-matching input");
    }
}

/** An integer goes to the outlet of the first equal integer argument. @param x The object. @param n The number. */
void pass_int(t_pass* x, t_atom_long n)
{
    for (long i = 0; i < x->count; ++i) {
        if (atom_gettype(&x->arguments[i]) == A_LONG && n == atom_getlong(&x->arguments[i])) {
            outlet_int(x->outlets[i], n);
            return;
        }
    }
    outlet_int(x->overflow, n);
}

/** A float goes to the outlet of the first equal float argument. @param x The object. @param f The number. */
void pass_float(t_pass* x, double f)
{
    for (long i = 0; i < x->count; ++i) {
        if (atom_gettype(&x->arguments[i]) == A_FLOAT && f == atom_getfloat(&x->arguments[i])) {
            outlet_float(x->outlets[i], f);
            return;
        }
    }
    outlet_float(x->overflow, f);
}

/** A message goes to the outlet of the argument with the same name. @param x The object. @param msg The selector. @param argc Atom count. @param argv Atoms. */
void pass_anything(t_pass* x, t_symbol* msg, long argc, t_atom* argv)
{
    t_symbol* name = without_slash(msg);
    for (long i = 0; i < x->count; ++i) {
        if (atom_gettype(&x->arguments[i]) == A_SYM && name == atom_getsym(&x->arguments[i])) {
            outlet_anything(x->outlets[i], x->strip != 0 ? name : msg, static_cast<short>(argc), argv);
            return;
        }
    }
    outlet_anything(x->overflow, x->stripnonmatches != 0 ? name : msg, static_cast<short>(argc), argv);
}

/** A list is matched on its first element. @param x The object. @param msg The selector (list). @param argc Atom count. @param argv Atoms. */
void pass_list(t_pass* x, t_symbol* msg, long argc, t_atom* argv)
{
    if (argc < 1) {
        outlet_list(x->overflow, nullptr, 0, argv);
        return;
    }
    t_symbol* message = (x->strip != 0) ? without_slash(msg) : msg;
    const long type = atom_gettype(argv);
    for (long i = 0; i < x->count; ++i) {
        const t_atom* a = &x->arguments[i];
        if (atom_gettype(a) != type) {
            continue;
        }
        if ((type == A_LONG && atom_getlong(argv) == atom_getlong(a)) || (type == A_FLOAT && atom_getfloat(argv) == atom_getfloat(a))) {
            outlet_list(x->outlets[i], nullptr, static_cast<short>(argc), argv);
            return;
        }
        if (type == A_SYM && atom_getsym(argv) == atom_getsym(a)) {
            outlet_anything(x->outlets[i], message, static_cast<short>(argc), argv);
            return;
        }
    }
    outlet_list(x->overflow, nullptr, static_cast<short>(argc), argv);
}

} // namespace

/** Class setup, called by Max. */
void ext_main(void*)
{
    t_class* c = class_new("j.pass", reinterpret_cast<method>(pass_new), nullptr, sizeof(t_pass), nullptr, A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(pass_int), "int", A_LONG, 0);
    class_addmethod(c, reinterpret_cast<method>(pass_float), "float", A_FLOAT, 0);
    class_addmethod(c, reinterpret_cast<method>(pass_list), "list", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(pass_anything), "anything", A_GIMME, 0);
    class_addmethod(c, reinterpret_cast<method>(pass_assist), "assist", A_CANT, 0);
    class_addmethod(c, reinterpret_cast<method>(object_obex_dumpout), "dumpout", A_CANT, 0);
    class_addattr(c, attr_offset_new("strip", gensym("long"), 0, nullptr, nullptr, static_cast<long>(offsetof(t_pass, strip))));
    class_addattr(c, attr_offset_new("stripnonmatches", gensym("long"), 0, nullptr, nullptr, static_cast<long>(offsetof(t_pass, stripnonmatches))));
    class_register(CLASS_BOX, c);
    s_class = c;
}
