// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.oscroute.cpp
 * @brief j.oscroute: routes OSC messages by the start of their address, with `*` as a wildcard.
 *
 * One outlet for each argument and a dump outlet; one inlet more than there are arguments, so that a symbol in inlet n replaces the nth pattern. Without an
 * argument there is one pattern, `/nil`. Behaviour: docs/inventory/osc-tools.md.
 */

#include <cstdio>
#include <memory>
#include <string>
#include <vector>

#include "c74_min.h"

#include "jamoma/osc_tools.hpp"
#include "max_context.hpp"
#include "max_osc.hpp"

using namespace c74::min;

/** The j.oscroute external. */
class j_oscroute : public c74::min::object<j_oscroute> {
    std::vector<std::string> patterns_;                                  /**< What is matched, one per outlet. */
    std::vector<std::unique_ptr<inlet<>>> inlets_;                       /**< The inlet for messages and one per pattern. */
    std::vector<std::unique_ptr<jamoma_max::dump_outlet>> outlets_;      /**< One per pattern, and the dump outlet last. */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object. @param args The patterns (symbols or numbers). */
    explicit j_oscroute(const atoms& args = {})
    {
        for (const auto& a : args) {
            if (a.type() == message_type::symbol_argument) {
                patterns_.emplace_back(static_cast<symbol>(a).c_str());
            } else if (a.type() == message_type::int_argument) {
                patterns_.push_back(std::to_string(static_cast<long long>(a)));
            } else if (a.type() == message_type::float_argument) {
                char text[256];
                std::snprintf(text, sizeof(text), "%f", static_cast<double>(a)); // as the old object wrote it
                patterns_.emplace_back(text);
            }
        }
        if (patterns_.empty()) {
            patterns_.emplace_back("/nil");
        }
        inlets_.push_back(std::make_unique<inlet<>>(this, "(anything) OSC message"));
        for (const std::string& pattern : patterns_) {
            inlets_.push_back(std::make_unique<inlet<>>(this, "(symbol) replaces the pattern " + pattern));
        }
        for (const std::string& pattern : patterns_) {
            outlets_.push_back(std::make_unique<jamoma_max::dump_outlet>(this, "(anything) matches " + pattern));
        }
        outlets_.push_back(std::make_unique<jamoma_max::dump_outlet>(this, "(anything) dump: what matches nothing"));
    }

    /** A bang leaves the dump outlet. */
    message<threadsafe::yes> bang{this, "bang", MIN_FUNCTION {
        if (!outlets_.empty()) {
            c74::max::outlet_bang(dump());
        }
        return {};
    }};

    /** An integer leaves the dump outlet. */
    message<threadsafe::yes> m_int{this, "int", MIN_FUNCTION {
        if (!outlets_.empty()) {
            c74::max::outlet_int(dump(), static_cast<c74::max::t_atom_long>(static_cast<long long>(args[0])));
        }
        return {};
    }};

    /** A float leaves the dump outlet. */
    message<threadsafe::yes> m_float{this, "float", MIN_FUNCTION {
        if (!outlets_.empty()) {
            c74::max::outlet_float(dump(), static_cast<double>(args[0]));
        }
        return {};
    }};

    /** A list has no address: it leaves the dump outlet. */
    message<threadsafe::yes> m_list{this, "list", MIN_FUNCTION {
        if (!outlets_.empty()) {
            c74::max::outlet_list(dump(), nullptr, static_cast<short>(args.size()), jamoma_max::raw_atoms(args));
        }
        return {};
    }};

    /** A message: in the first inlet it is routed by its selector; in another its selector becomes that inlet's pattern. */
    message<threadsafe::yes> m_anything{this, "anything", MIN_FUNCTION {
        if (args.empty() || outlets_.empty()) {
            return {};
        }
        const std::string selector = static_cast<symbol>(args[0]).c_str();
        if (inlet > 0) {
            if (static_cast<std::size_t>(inlet) <= patterns_.size()) {
                patterns_[static_cast<std::size_t>(inlet) - 1] = selector;
            }
            return {};
        }
        const atoms arguments(args.begin() + 1, args.end());
        const std::vector<jamoma::OscRouteMatch> matches = jamoma::route_osc(selector, patterns_);
        if (matches.empty()) {
            send(dump(), selector, arguments);
        }
        for (const jamoma::OscRouteMatch& match : matches) {
            if (match.rest.empty()) {
                jamoma_max::send_arguments(outlets_[match.outlet]->max_outlet(), arguments);
            } else {
                send(outlets_[match.outlet]->max_outlet(), match.rest, arguments);
            }
        }
        return {};
    }};

    /** Class setup: nothing to add. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION { return {}; }};

private:
    /** @return The dump outlet. */
    c74::max::t_outlet* dump() const { return outlets_.back()->max_outlet(); }

    /** Sends a message. @param outlet The outlet. @param selector The message. @param arguments Its arguments. */
    static void send(c74::max::t_outlet* outlet, const std::string& selector, const atoms& arguments)
    {
        c74::max::outlet_anything(outlet, c74::max::gensym(selector.c_str()), static_cast<short>(arguments.size()), jamoma_max::raw_atoms(arguments));
    }
};

MIN_EXTERNAL(j_oscroute);
