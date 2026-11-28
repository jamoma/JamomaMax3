// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.route.cpp
 * @brief j.route: sends a message on, unchanged, out of the left outlet if it holds the search text at one of the search positions, else out of the middle one.
 *
 * In a message the selector is position 1 and the arguments follow; in a list (and for a number) the first item is position 1. Numbers are compared as
 * their text (`%ld`, `%f`). `searchstring` (default `default`), `searchpositions` (default 1) and `partialmatch` (default 0) are attributes.
 * A bang does nothing, as in the old object.
 */

#include <cstdio>
#include <string>
#include <vector>

#include "c74_min.h"

#include "jamoma/route_search.hpp"
#include "max_context.hpp"
#include "max_osc.hpp"
#include "max_queries.hpp"

using namespace c74::min;

/** The j.route external. */
class j_route : public c74::min::object<j_route> {
    jamoma::RouteSearch search_; /**< What is looked for (declared before the attributes, whose setters use it). */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    inlet<> input{this, "(anything) messages to route"};                                   /**< The inlet. */
    jamoma_max::dump_outlet match_out{this, "(anything) messages that match"};             /**< Outlet 0. */
    jamoma_max::dump_outlet other_out{this, "(anything) messages that do not match"};      /**< Outlet 1. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump"};                             /**< Outlet 2: the dump outlet. */

    /** After construction: registers the last outlet as the dumpout. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        return {};
    }};

    /** A bang does nothing. */
    message<threadsafe::yes> bang{this, "bang", MIN_FUNCTION { return {}; }};

    /** An integer is routed as a list of one item. */
    message<threadsafe::yes> m_int{this, "int", MIN_FUNCTION {
        route_list(args);
        return {};
    }};

    /** A float is routed as a list of one item. */
    message<threadsafe::yes> m_float{this, "float", MIN_FUNCTION {
        route_list(args);
        return {};
    }};

    /** A list: its first item is position 1. */
    message<threadsafe::yes> m_list{this, "list", MIN_FUNCTION {
        route_list(args);
        return {};
    }};

    /** A message: its selector is position 1. */
    message<threadsafe::yes> m_anything{this, "anything", MIN_FUNCTION {
        if (args.empty()) {
            return {};
        }
        const atoms arguments(args.begin() + 1, args.end());
        std::vector<std::string> elements = texts(arguments);
        elements.insert(elements.begin(), std::string(static_cast<symbol>(args[0]).c_str()));
        c74::max::t_symbol* selector = c74::max::gensym(elements.front().c_str());
        c74::max::outlet_anything(outlet_for(elements), selector, static_cast<short>(arguments.size()), jamoma_max::raw_atoms(arguments));
        return {};
    }};

    /** Class setup: adds the attributes, of which two are lists that Min's attribute types cannot hold. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION {
        c74::max::t_class* c = args[0];
        c74::max::class_addattr(c, c74::max::attr_offset_array_new("searchstring", c74::max::gensym("symbol"), 100, 0,
                                                                   method_of(&words_getter), method_of(&words_setter), 0, 0));
        c74::max::class_addattr(c, c74::max::attr_offset_array_new("searchpositions", c74::max::gensym("long"), 100, 0,
                                                                   method_of(&positions_getter), method_of(&positions_setter), 0, 0));
        c74::max::class_addattr(c, c74::max::attr_offset_new("partialmatch", c74::max::gensym("long"), 0,
                                                             method_of(&partial_getter), method_of(&partial_setter), 0));
        c74::max::class_attr_addattr_parse(c, "partialmatch", "style", c74::max::gensym("symbol"), 0, "onoff");
        jamoma_max::answer_get_messages(c, {"searchstring", "searchpositions", "partialmatch"});
        return {};
    }};

private:
    /**
     * Answers `<name> <values>` on the dump outlet when the name of an attribute was sent without a value.
     * @param self The object. @param attr The attribute. @param argc The count the setter was called with. @return True if it was such a query.
     */
    static bool answered_query(c74::min::minwrap<j_route>* self, c74::max::t_object* attr, long argc)
    {
        if (argc != 0) {
            return false;
        }
        auto* object = self->m_min_object.maxobj();
        auto* name = static_cast<c74::max::t_symbol*>(c74::max::object_method(attr, c74::max::gensym("getname")));
        long count = 0;
        c74::max::t_atom* values = nullptr;
        if (c74::max::object_attr_getvalueof(object, name, &count, &values) == c74::max::MAX_ERR_NONE) {
            c74::max::outlet_anything(self->m_min_object.dump_out.max_outlet(), name, static_cast<short>(count), values);
        }
        if (values != nullptr) {
            c74::max::sysmem_freeptr(values);
        }
        return true;
    }

    /** @param function A getter or setter. @return It as the type the Max API takes. */
    template <class Function>
    static c74::max::method method_of(Function* function) { return reinterpret_cast<c74::max::method>(function); }

    /** @param o A Max object of this class. @return The search of the object. */
    static jamoma::RouteSearch& search_of(c74::max::t_object* o) { return c74::min::wrapper_find_self<j_route>(o)->m_min_object.search_; }

    /** Reads `searchstring`. @param o The object. @param argc Receives the count. @param argv Receives the atoms. @return A Max error code. */
    static c74::max::t_max_err words_getter(c74::max::t_object* o, c74::max::t_object*, long* argc, c74::max::t_atom** argv)
    {
        const std::vector<std::string> words = search_of(o).words();
        char allocated = 0;
        c74::max::atom_alloc_array(static_cast<long>(words.size()), argc, argv, &allocated);
        for (std::size_t i = 0; i < words.size(); ++i) {
            c74::max::atom_setsym(*argv + i, c74::max::gensym(words[i].c_str()));
        }
        return c74::max::MAX_ERR_NONE;
    }

    /** Sets `searchstring`. @param self The object. @param attr The attribute. @param argc The count. @param argv The atoms. @return A Max error code. */
    static c74::max::t_max_err words_setter(c74::min::minwrap<j_route>* self, c74::max::t_object* attr, long argc, c74::max::t_atom* argv)
    {
        if (answered_query(self, attr, argc)) {
            return c74::max::MAX_ERR_NONE;
        }
        self->m_min_object.search_.set_words(texts(atoms_of(argc, argv)));
        return c74::max::MAX_ERR_NONE;
    }

    /** Reads `searchpositions`. @param o The object. @param argc Receives the count. @param argv Receives the atoms. @return A Max error code. */
    static c74::max::t_max_err positions_getter(c74::max::t_object* o, c74::max::t_object*, long* argc, c74::max::t_atom** argv)
    {
        const std::vector<std::int64_t> positions = search_of(o).positions();
        char allocated = 0;
        c74::max::atom_alloc_array(static_cast<long>(positions.size()), argc, argv, &allocated);
        for (std::size_t i = 0; i < positions.size(); ++i) {
            c74::max::atom_setlong(*argv + i, static_cast<c74::max::t_atom_long>(positions[i]));
        }
        return c74::max::MAX_ERR_NONE;
    }

    /** Sets `searchpositions`. @param self The object. @param attr The attribute. @param argc The count. @param argv The atoms. @return A Max error code. */
    static c74::max::t_max_err positions_setter(c74::min::minwrap<j_route>* self, c74::max::t_object* attr, long argc, c74::max::t_atom* argv)
    {
        if (answered_query(self, attr, argc)) {
            return c74::max::MAX_ERR_NONE;
        }
        std::vector<std::int64_t> positions;
        for (long i = 0; i < argc; ++i) {
            positions.push_back(static_cast<std::int64_t>(c74::max::atom_getlong(argv + i)));
        }
        self->m_min_object.search_.set_positions(std::move(positions));
        return c74::max::MAX_ERR_NONE;
    }

    /** Reads `partialmatch`. @param o The object. @param argc Receives the count. @param argv Receives the atom. @return A Max error code. */
    static c74::max::t_max_err partial_getter(c74::max::t_object* o, c74::max::t_object*, long* argc, c74::max::t_atom** argv)
    {
        char allocated = 0;
        c74::max::atom_alloc_array(1, argc, argv, &allocated);
        c74::max::atom_setlong(*argv, search_of(o).partial() ? 1 : 0);
        return c74::max::MAX_ERR_NONE;
    }

    /** Sets `partialmatch`. @param self The object. @param attr The attribute. @param argc The count. @param argv The atoms. @return A Max error code. */
    static c74::max::t_max_err partial_setter(c74::min::minwrap<j_route>* self, c74::max::t_object* attr, long argc, c74::max::t_atom* argv)
    {
        if (answered_query(self, attr, argc)) {
            return c74::max::MAX_ERR_NONE;
        }
        self->m_min_object.search_.set_partial(c74::max::atom_getlong(argv) != 0);
        return c74::max::MAX_ERR_NONE;
    }

    /** @param argc A count. @param argv Max atoms. @return The same as Min atoms. */
    static atoms atoms_of(long argc, c74::max::t_atom* argv)
    {
        atoms result;
        for (long i = 0; i < argc; ++i) {
            result.push_back(c74::min::atom(argv[i]));
        }
        return result;
    }

    /** @param in Atoms. @return The text of each (empty for one that is neither a number nor a symbol). */
    static std::vector<std::string> texts(const atoms& in)
    {
        std::vector<std::string> result;
        for (const auto& a : in) {
            char number[64] = "";
            if (a.type() == message_type::symbol_argument) {
                result.emplace_back(static_cast<symbol>(a).c_str());
                continue;
            }
            if (a.type() == message_type::int_argument) {
                std::snprintf(number, sizeof(number), "%ld", static_cast<long>(a));
            } else if (a.type() == message_type::float_argument) {
                std::snprintf(number, sizeof(number), "%f", static_cast<double>(a));
            }
            result.emplace_back(number);
        }
        return result;
    }

    /** @param elements A message as text. @return The outlet it leaves. */
    c74::max::t_outlet* outlet_for(const std::vector<std::string>& elements) const
    {
        return search_.matches(elements) ? match_out.max_outlet() : other_out.max_outlet();
    }

    /** Sends a list on. @param args The list. */
    void route_list(const atoms& args)
    {
        c74::max::outlet_anything(outlet_for(texts(args)), c74::max::gensym("list"), static_cast<short>(args.size()), jamoma_max::raw_atoms(args));
    }
};

MIN_EXTERNAL(j_route);
