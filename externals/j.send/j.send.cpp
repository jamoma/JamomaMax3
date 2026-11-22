// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.send.cpp
 * @brief j.send: forwards what it receives to the node (or nodes) at an address.
 *
 * The one outlet is the dump outlet: after binding it reports `address <absolute address>`. The address is written relative to the model of
 * the patcher or absolute, and is resolved once the patcher has loaded. Without an address a message whose selector is an absolute address
 * sets the target and sends the rest, as the old object did. The work is done by jamoma::Sender (core/include/jamoma/sender.hpp).
 */

#include <memory>
#include <string>

#include "c74_min.h"

#include "jamoma/registry.hpp"
#include "jamoma/sender.hpp"
#include "max_address.hpp"

using namespace c74::min;

/** The j.send external. */
class j_send : public c74::min::object<j_send> {
    // State comes before the attributes: Min runs every attribute setter with its default while constructing them.
    std::unique_ptr<jamoma::Sender> sender_; /**< The sender. */
    std::string text_;                       /**< The address as written. */
    bool ready_ = false;                     /**< True once the patcher has loaded and the address may be resolved. */
    jamoma_max::Alive alive_;                /**< Lets deferred calls see that the object is gone. */
    jamoma_max::ContextWatch watch_;         /**< Binds again when the model of the patcher appears, is replaced or goes. */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object. @param args The creation atoms: an optional address, then attributes. */
    explicit j_send(const atoms& args = {})
    {
        if (c74::min::dummy()) {
            return; // the instance Min builds during class setup has no Max object
        }
        if (!args.empty() && args[0].type() == message_type::symbol_argument) {
            const std::string first = static_cast<symbol>(args[0]).c_str();
            if (!first.empty() && first[0] != '@') {
                text_ = first;
            }
        }
        sender_ = std::make_unique<jamoma::Sender>(jamoma::Registry::instance().names());
        jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
            ready_ = true;
            rebind();
            watch_.start([this] { rebind(); });
        });
    }

    /** Nothing to release before the members go. */
    ~j_send() override
    {
        watch_.stop();
        sender_.reset();
    }

    inlet<> input{this, "(anything) value or message to forward"};                  /**< The inlet. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump and the target address"}; /**< Outlet 0: the dump outlet. */

    /** The address to send to, relative to the model of the patcher or absolute. */
    attribute<symbol> address{this, "address", "", setter{MIN_FUNCTION {
        text_ = std::string(static_cast<symbol>(args[0]).c_str());
        rebind();
        return args;
    }}};

    /** After construction: registers the outlet as the dumpout. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        return {};
    }};

    /** A bang is forwarded. */
    message<threadsafe::yes> bang{this, "bang", MIN_FUNCTION {
        forward_later(jamoma::Value{});
        return {};
    }};

    /** An integer is forwarded. */
    message<threadsafe::yes> m_int{this, "int", MIN_FUNCTION {
        forward_later(jamoma_max::to_value(args));
        return {};
    }};

    /** A float is forwarded. */
    message<threadsafe::yes> m_float{this, "float", MIN_FUNCTION {
        forward_later(jamoma_max::to_value(args));
        return {};
    }};

    /** A list is forwarded. */
    message<threadsafe::yes> m_list{this, "list", MIN_FUNCTION {
        forward_later(jamoma_max::to_value(args));
        return {};
    }};

    /** Answers the address on the dump outlet. */
    message<> dump{this, "dump", MIN_FUNCTION {
        c74::max::t_atom a;
        c74::max::atom_setsym(&a, c74::max::gensym(text_.c_str()));
        c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym("address"), 1, &a);
        return {};
    }};

    /**
     * Any other message: `address <symbol>` sets the target; a symbol (`symbol <name>`) is forwarded as a symbol; with no address
     * of its own, a message whose selector is an absolute address sets the target and sends the rest; any other message is forwarded whole.
     */
    message<threadsafe::yes> m_anything{this, "anything", MIN_FUNCTION {
        const atoms copy = args;
        jamoma_max::run_on_main(maxobj(), alive_.weak(), [this, copy] { handle_message(copy); });
        return {};
    }};

    /** Class setup: nothing to add. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION { return {}; }};

private:
    /** Handles a message other than bang, int, float and list (on the main thread). @param args The message with its selector first. */
    void handle_message(const atoms& args)
    {
        atoms message = args;
        bool is_symbol = false;
        if (message.size() >= 2 && static_cast<symbol>(message[0]) == symbol("symbol")) {
            message.erase(message.begin());
            is_symbol = true;
        }
        const std::string selector = static_cast<symbol>(message[0]).c_str();
        if (!is_symbol && selector == "address" && message.size() >= 2) {
            text_ = std::string(static_cast<symbol>(message[1]).c_str());
            rebind();
        } else if (text_.empty() && !is_symbol && !selector.empty() && selector[0] == '/') {
            text_ = selector; // dynamic address: the message names the target
            rebind();
            forward(jamoma_max::to_value(atoms(message.begin() + 1, message.end())));
        } else if (!text_.empty() || is_symbol) {
            forward(jamoma_max::to_value(message));
        }
    }

    /** Forwards a value on the main thread (the Sender and the namespace nodes belong to it). @param v The value. */
    void forward_later(const jamoma::Value& v)
    {
        jamoma_max::run_on_main(maxobj(), alive_.weak(), [this, v] { forward(v); });
    }

    /** Binds (again) to the address as written, resolved against the model of the patcher, and reports it. */
    void rebind()
    {
        if (!ready_ || !sender_ || text_.empty()) {
            return;
        }
        const jamoma::Address absolute = jamoma_max::resolve_in_patcher(maxobj(), text_);
        sender_->set_address(absolute);
        c74::max::t_atom a;
        c74::max::atom_setsym(&a, c74::max::gensym(absolute.str().c_str()));
        c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym("address"), 1, &a);
    }

    /** Sends a value to the target; an error goes to the dump outlet if nothing was reached. @param v The value. */
    void forward(const jamoma::Value& v)
    {
        if (sender_ && !sender_->send(v)) {
            c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym("error"), 0, nullptr);
        }
    }
};

MIN_EXTERNAL(j_send);
