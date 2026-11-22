// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.receive.cpp
 * @brief j.receive: outputs the value of the node (or nodes) at an address, and the address they came from.
 *
 * Outlets from the left: the value, the address of the node, the dump outlet. The address is written relative to the model of the patcher
 * or absolute; it is bound once the patcher has loaded. The work is done by jamoma::Receiver (core/include/jamoma/receiver.hpp).
 */

#include <memory>
#include <string>

#include "c74_min.h"

#include "jamoma/receiver.hpp"
#include "jamoma/registry.hpp"
#include "max_address.hpp"

using namespace c74::min;

/** The j.receive external. */
class j_receive : public c74::min::object<j_receive> {
    // State comes before the attributes: Min runs every attribute setter with its default while constructing them.
    std::unique_ptr<jamoma::Receiver> receiver_; /**< The receiver (reset first in the destructor, before the outlets go). */
    std::string text_;                           /**< The address as written. */
    bool ready_ = false;                         /**< True once the patcher has loaded and the address may be resolved. */
    jamoma_max::Alive alive_;                    /**< Lets deferred calls see that the object is gone. */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object. @param args The creation atoms: an optional address, then attributes. */
    explicit j_receive(const atoms& args = {})
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
        receiver_ = std::make_unique<jamoma::Receiver>(
            jamoma::Registry::instance().names(), [this](const jamoma::Address& a) { report_address(a); },
            [this](const jamoma::Value& v) { report_value(v); });
        jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
            ready_ = true;
            rebind();
        });
    }

    /** Unbinds before the outlets are destroyed. */
    ~j_receive() override { receiver_.reset(); }

    inlet<> input{this, "(anything) set the address"};                              /**< The inlet. */
    jamoma_max::dump_outlet value_out{this, "(anything) the value"};                /**< Outlet 0. */
    jamoma_max::dump_outlet address_out{this, "(symbol) the address of the node"};  /**< Outlet 1. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump"};                      /**< Outlet 2: the dump outlet. */

    /** The address to listen to, relative to the model of the patcher or absolute. */
    attribute<symbol> address{this, "address", "", setter{MIN_FUNCTION {
        text_ = std::string(static_cast<symbol>(args[0]).c_str());
        rebind();
        return args;
    }}};

    /** Whether new values are output (when off, only a bang outputs). */
    attribute<int> active{this, "active", 1, setter{MIN_FUNCTION {
        if (receiver_) {
            receiver_->set_active(static_cast<int>(args[0]) != 0);
        }
        return args;
    }}};

    /** After construction: registers the last outlet as the dumpout. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        return {};
    }};

    /** Outputs the current value; an error goes to the dump outlet if there is none. */
    message<> bang{this, "bang", MIN_FUNCTION {
        if (!receiver_ || !receiver_->bang()) {
            c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym("error"), 0, nullptr);
        }
        return {};
    }};

    /** Answers the attributes on the dump outlet. */
    message<> dump{this, "dump", MIN_FUNCTION {
        c74::max::t_atom a;
        c74::max::atom_setsym(&a, c74::max::gensym(text_.c_str()));
        c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym("address"), 1, &a);
        c74::max::atom_setlong(&a, receiver_ && receiver_->active() ? 1 : 0);
        c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym("active"), 1, &a);
        return {};
    }};

    /** Messages to set the address (`address <symbol>`, or just a symbol) and the attributes by name. */
    message<> m_anything{this, "anything", MIN_FUNCTION {
        atoms message = args;
        if (message.size() >= 2 && static_cast<symbol>(message[0]) == symbol("symbol")) {
            message.erase(message.begin());
        }
        const std::string selector = static_cast<symbol>(message[0]).c_str();
        if (selector == "address" && message.size() >= 2) {
            text_ = std::string(static_cast<symbol>(message[1]).c_str());
            rebind();
        } else if (message.size() == 1 && selector == "active") {
            c74::max::t_atom a;
            c74::max::atom_setlong(&a, receiver_ && receiver_->active() ? 1 : 0);
            c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym("active"), 1, &a);
        } else if (selector == "active" && message.size() >= 2 && receiver_) {
            receiver_->set_active(static_cast<int>(message[1]) != 0);
        } else if (message.size() == 1 && selector != "address") {
            text_ = selector; // a bare symbol sets the address
            rebind();
        }
        return {};
    }};

    /**
     * Class setup: nothing to add; the base class registers the attributes.
     */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION { return {}; }};

private:
    /** Binds (again) to the address as written, resolved against the model of the patcher. */
    void rebind()
    {
        if (!ready_ || !receiver_) {
            return;
        }
        receiver_->set_address(jamoma_max::resolve_in_patcher(maxobj(), text_));
    }

    /** Outputs the address of the node a value belongs to. @param a The address. */
    void report_address(const jamoma::Address& a)
    {
        const std::string text = a.str();
        if (c74::max::systhread_ismainthread()) {
            c74::max::outlet_anything(address_out.max_outlet(), c74::max::gensym(text.c_str()), 0, nullptr);
        } else {
            jamoma_max::defer_call(maxobj(), alive_.weak(), [this, text] {
                c74::max::outlet_anything(address_out.max_outlet(), c74::max::gensym(text.c_str()), 0, nullptr);
            });
        }
    }

    /** Outputs a value. @param v The value. */
    void report_value(const jamoma::Value& v)
    {
        if (c74::max::systhread_ismainthread()) {
            jamoma_max::output_value(value_out.max_outlet(), v);
        } else {
            jamoma_max::defer_call(maxobj(), alive_.weak(), [this, v] { jamoma_max::output_value(value_out.max_outlet(), v); });
        }
    }
};

MIN_EXTERNAL(j_receive);
