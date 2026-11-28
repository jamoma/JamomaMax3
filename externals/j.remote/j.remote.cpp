// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.remote.cpp
 * @brief j.remote: keeps a UI object and a node (parameter, message or return) showing the same value.
 *
 * What comes in (a number, a list, a message) is sent to the node as a command, in the unit the `unit` attribute names. The outlets are those of the
 * old object: changes of the node come out of the left outlet as `set <value>` (a UI object shows the value without sending it back) and out of the
 * second outlet as values; the third outlet is reserved (the old object used it to select a UI object) and the last is the dump outlet. A UI object that is
 * dragged while a ramp runs stops the ramp. The message `set <value>` sends a value to the node without output from this object (other j.remote objects
 * of the node show it).
 * A second argument names the remote: in a view, the changes of a named remote with a relative address also come out of the left outlet of
 * `j.view` as `<name> <value>`. `highlight` is accepted and has no effect.
 */

#include <atomic>
#include <memory>
#include <string>

#include "c74_min.h"

#include "jamoma/registry.hpp"
#include "jamoma/remote.hpp"
#include "max_address.hpp"
#include "max_atoms.hpp"
#include "max_context.hpp"
#include "max_queries.hpp"

using namespace c74::min;

/** The j.remote external. */
class j_remote : public c74::min::object<j_remote> {
    // State comes before the attributes: Min runs every attribute setter with its default while constructing them.
    std::unique_ptr<jamoma::Remote> remote_;   /**< The remote (reset first in the destructor, before the outlets go). */
    std::string text_;                         /**< The address as written. */
    std::string view_name_;                    /**< The second argument: the name under which a view reports the values (empty: not reported). */
    std::atomic<const void*> view_{nullptr};   /**< The view to report to, while there is a name, a relative address and a view. */
    bool ready_ = false;                       /**< True once the patcher has loaded and the address may be resolved. */
    jamoma_max::Alive alive_;                  /**< Lets deferred calls see that the object is gone. */
    jamoma_max::ContextWatch watch_;           /**< Binds again when the model of the patcher appears, is replaced or goes. */
    jamoma_max::Settle settle_;                /**< Lets a burst of such changes be dealt with once, when it is over. */
    jamoma::Address bound_;                    /**< The address the remote was bound to last. */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object. @param args The creation atoms: an optional address and name, then attributes. */
    explicit j_remote(const atoms& args = {})
    {
        if (c74::min::dummy()) {
            return; // the instance Min builds during class setup has no Max object
        }
        if (!args.empty() && args[0].type() == message_type::symbol_argument) {
            const std::string first = static_cast<symbol>(args[0]).c_str();
            if (!first.empty() && first[0] != '@') {
                text_ = first;
                if (args.size() >= 2 && args[1].type() == message_type::symbol_argument) {
                    const std::string second = static_cast<symbol>(args[1]).c_str();
                    if (!second.empty() && second[0] != '@') {
                        view_name_ = second;
                    }
                }
            }
        }
        remote_ = std::make_unique<jamoma::Remote>(jamoma::Registry::instance().names(), [this](const jamoma::Value& v) { show(v); });
        remote_->set_observer([this](const jamoma::Value& v) {
            if (const void* view = view_) {
                jamoma::Registry::instance().views().report(view, view_name_, v);
            }
        });
        jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
            ready_ = true;
            rebind();
            watch_.start([this] { settle_.request(maxobj(), alive_.weak(), [this] { follow(); }); });
        });
    }

    /** Unbinds before the outlets are destroyed. */
    ~j_remote() override
    {
        watch_.stop();
        remote_.reset();
    }

    inlet<> input{this, "(anything) value from the UI object"};                          /**< The inlet. */
    jamoma_max::dump_outlet set_out{this, "(set <value>) the value of the node, for a UI object"}; /**< Outlet 0: `set <value>`. */
    jamoma_max::dump_outlet value_out{this, "(anything) the value of the node"};          /**< Outlet 1: the value. */
    jamoma_max::dump_outlet attach_out{this, "(anything) reserved: selects a UI object in the old object"}; /**< Outlet 2: unused, kept so that old patchers connect to the right outlets. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump"};                            /**< Outlet 3: the dump outlet. */

    /** The address of the node, relative to the model or view of the patcher, or absolute. */
    attribute<symbol> address{this, "address", "", setter{MIN_FUNCTION {
        text_ = std::string(static_cast<symbol>(args[0]).c_str());
        rebind();
        return args;
    }}, getter{MIN_GETTER_FUNCTION {
        return atoms{symbol(text_)}; // also when it came as the argument
    }}};

    /** The unit the UI object works in (empty: the node's own). */
    attribute<symbol> unit{this, "unit", "", setter{MIN_FUNCTION {
        if (remote_) {
            remote_->set_unit(static_cast<symbol>(args[0]).c_str());
        }
        return args;
    }}};

    /** Whether the remote works at all. */
    attribute<int> active{this, "active", 1, style::onoff, setter{MIN_FUNCTION {
        if (remote_) {
            remote_->set_active(static_cast<int>(args[0]) != 0);
        }
        return args;
    }}};

    /** Whether changes of the node are kept from the UI object. */
    attribute<int> freeze{this, "freeze", 0, style::onoff, setter{MIN_FUNCTION {
        if (remote_) {
            remote_->set_freeze(static_cast<int>(args[0]) != 0);
        }
        return args;
    }}};

    /** Accepted so that old patchers load; it has no effect. */
    attribute<int> highlight{this, "highlight", 1, style::onoff};

    /** After construction: registers the last outlet as the dumpout. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        return {};
    }};

    /** A bang is sent to the node, which outputs its value: it comes out here, of the node's object and of every other object on the node. */
    message<threadsafe::yes> bang{this, "bang", MIN_FUNCTION {
        jamoma_max::run_on_main(maxobj(), alive_.weak(), [this] {
            if (remote_) {
                remote_->bang();
            }
        });
        return {};
    }};

    /** An integer goes to the node. */
    message<threadsafe::yes> m_int{this, "int", MIN_FUNCTION {
        send_later(jamoma_max::to_value(args));
        return {};
    }};

    /** A float goes to the node. */
    message<threadsafe::yes> m_float{this, "float", MIN_FUNCTION {
        send_later(jamoma_max::to_value(args));
        return {};
    }};

    /** A list goes to the node. */
    message<threadsafe::yes> m_list{this, "list", MIN_FUNCTION {
        send_later(jamoma_max::to_value(args));
        return {};
    }};

    /** Answers the attributes on the dump outlet. */
    message<> dump{this, "dump", MIN_FUNCTION {
        c74::max::t_atom a;
        c74::max::atom_setsym(&a, c74::max::gensym(text_.c_str()));
        c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym("address"), 1, &a);
        return {};
    }};

    /**
     * Any other message: `set <value>` sends a value without output here; `address <symbol>` sets the address; any other message is
     * sent to the node as it is.
     */
    message<threadsafe::yes> m_anything{this, "anything", MIN_FUNCTION {
        const atoms copy = args;
        jamoma_max::run_on_main(maxobj(), alive_.weak(), [this, copy] { handle_message(copy); });
        return {};
    }};

    /** Class setup: every attribute answers when its name is sent without a value, and to `get<name>`, as the old objects did. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION {
        jamoma_max::answer_queries<j_remote>(args[0], {"address", "unit", "active", "freeze", "highlight"});
        jamoma_max::answer_get_messages(args[0], {"address", "unit", "active", "freeze", "highlight"});
        return {};
    }};

private:
    /** Handles a message other than bang, int, float and list (on the main thread). @param args The message with its selector first. */
    void handle_message(const atoms& args)
    {
        atoms message = args;
        if (message.size() >= 2 && static_cast<symbol>(message[0]) == symbol("symbol")) {
            message.erase(message.begin());
        }
        const std::string selector = static_cast<symbol>(message[0]).c_str();
        if (selector == "set" && message.size() >= 2) {
            if (remote_) {
                remote_->set_without_output(jamoma_max::to_value(atoms(message.begin() + 1, message.end())));
            }
        } else if (selector == "address" && message.size() >= 2) {
            text_ = std::string(static_cast<symbol>(message[1]).c_str());
            rebind();
        } else if (remote_) {
            remote_->from_ui(jamoma_max::to_value(message));
        }
    }

    /** Sends a value to the node on the main thread. @param v The value. */
    void send_later(const jamoma::Value& v)
    {
        jamoma_max::run_on_main(maxobj(), alive_.weak(), [this, v] {
            if (remote_) {
                remote_->from_ui(v);
            }
        });
    }

    /** Follows the model of the patcher coming, going or being replaced: binds again only if the address that the written one resolves to has changed. */
    void follow()
    {
        if (!ready_ || !remote_) {
            return;
        }
        if ((text_.empty() ? jamoma::Address() : jamoma_max::resolve_in_patcher(maxobj(), text_)) != bound_) {
            rebind();
        }
    }

    /** Binds (again) to the address as written. */
    void rebind()
    {
        if (!ready_ || !remote_) {
            return;
        }
        // As the old object: only a remote with a name and a relative address is one of the things its view reports.
        view_ = view_name_.empty() || text_.empty() || text_[0] == '/' ? nullptr : jamoma_max::enclosing_view(jamoma_max::patcher_of(maxobj()));
        bound_ = text_.empty() ? jamoma::Address() : jamoma_max::resolve_in_patcher(maxobj(), text_);
        remote_->set_address(bound_);
    }

    /** Shows a value: out of the value outlet and as `set <value>` out of the set outlet (`set bang` for a bang). @param v The value. */
    void show(const jamoma::Value& v)
    {
        if (c74::max::systhread_ismainthread()) {
            output(v);
        } else {
            jamoma_max::defer_call(maxobj(), alive_.weak(), [this, v] { output(v); });
        }
    }

    /** Outputs on both outlets (set first, as the old object). @param v The value. */
    void output(const jamoma::Value& v)
    {
        std::vector<c74::max::t_atom> list;
        for (const jamoma::Atom& a : v) {
            list.emplace_back();
            if (a.is_int()) {
                c74::max::atom_setlong(&list.back(), static_cast<c74::max::t_atom_long>(a.as_int()));
            } else if (a.is_float()) {
                c74::max::atom_setfloat(&list.back(), a.as_double());
            } else {
                c74::max::atom_setsym(&list.back(), c74::max::gensym(a.as_symbol().c_str()));
            }
        }
        if (list.empty()) { // a bang (a node of type none): the old object sent `set bang`, which makes a button blink
            list.emplace_back();
            c74::max::atom_setsym(&list.back(), c74::max::gensym("bang"));
        }
        c74::max::outlet_anything(set_out.max_outlet(), c74::max::gensym("set"), static_cast<short>(list.size()), list.data());
        jamoma_max::output_value(value_out.max_outlet(), v); // an empty value comes out as a bang
    }
};

MIN_EXTERNAL(j_remote);
