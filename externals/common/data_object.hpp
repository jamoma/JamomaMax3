// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file data_object.hpp
 * @brief The shared body of j.parameter, j.message and j.return: a Min object wrapping a jamoma::Data.
 *
 * The three externals are one template instantiated three times, as the old ones were one source built three ways.
 */

#pragma once

#include <atomic>

#include <stdexcept>
#include <string>

#include "c74_min.h"

#include "data_attributes.hpp"
#include "jamoma/data.hpp"
#include "jamoma/registry.hpp"
#include "jamoma/version.hpp"
#include "max_atoms.hpp"
#include "max_clock.hpp"
#include "max_context.hpp"

namespace jamoma_max {

// Min's MIN_FUNCTION and MIN_GETTER_FUNCTION macros name `atoms` unqualified.
using namespace c74::min;

/**
 * @brief A Max object that owns a data object, subscribes it to the namespace and outputs its value.
 * @tparam Derived The external class (Min requires the CRTP).
 * @tparam S The role of the object.
 */
template <class Derived, jamoma::Service S>
class data_object : public c74::min::object<Derived> {
    // The clock is declared before the data so it outlives it; the subscription after it so it is released first.
    MaxClock clock_;                       /**< The ramp clock. */
    jamoma::Data data_{S};                 /**< The data object. */
    jamoma::Subscription subscription_;    /**< The registration in the namespace. */
    std::string name_;                     /**< The name (relative address). */
    std::string prefix_;                   /**< The address of the model this object lives in, or empty (then it is at the root). */
    Alive alive_;                          /**< Lets deferred calls see that the object is gone. */
    ContextWatch watch_;                   /**< Finds the model again when it appears later, is replaced or goes. */
    bool joined_ = false;                  /**< True once the patcher has loaded and the model has been looked for. */
    std::atomic<const void*> view_{nullptr}; /**< The view the object belongs to, if it is a parameter or return in one (its changes are reported there). */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };
    /**
     * Creates the object.
     * @param args The creation arguments: the first is the name (the relative address); attributes are applied by Max afterwards.
     */
    explicit data_object(const c74::min::atoms& args = {})
    {
        if (c74::min::dummy()) {
            return; // Min builds one instance without a Max object while it sets the class up: no side effects
        }
        if (!jamoma::Registry::check_abi(jamoma::kAbiVersion)) {
            throw std::runtime_error("Jamoma: core ABI mismatch");
        }
        if (jamoma::Registry::instance().claim_missing_loader_warning()) {
            c74::max::error("Jamoma: the start-up loader (j.loader) is not attached; it is installed in the package's extensions folder");
        }
        std::string name = default_name();
        if (!args.empty() && args[0].type() == c74::min::message_type::symbol_argument) {
            const std::string first = static_cast<c74::min::symbol>(args[0]).c_str();
            if (!first.empty() && first[0] != '@') {
                name = first;
            }
        }
        data_.set_clock(&clock_);
        data_.set_output([this](const jamoma::Value& v) { output_value(v); });
        name_ = name;
        subscribe(name);
        // Once the whole patcher exists, move under the model of the patcher (if there is one).
        defer_call(this->maxobj(), alive_.weak(), [this] { join_model(); });
    }

    /**
     * Unsubscribes first and cuts the data object off from the clock and the outlets, so that nothing (another thread's lookup,
     * a ramp tick that is running now) can reach members that are about to be destroyed.
     */
    ~data_object() override
    {
        watch_.stop();
        subscription_ = jamoma::Subscription();
        data_.set_output(nullptr);
        data_.set_clock(nullptr);
    }

    c74::min::inlet<> input{this, "(anything) value or message"};         /**< The inlet. */
    c74::min::outlet<> data_out{this, "(anything) the value"};            /**< Outlet 0: the value. */
    dump_outlet dump_out{this, "(anything) dump"};                        /**< Outlet 1: the dump outlet (attribute queries answer here). */

    /** After construction: registers the second outlet as the dumpout, where Max sends the answers to `get<attribute>` queries. */
    c74::min::message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(this->maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        return {};
    }};

    /** A bang outputs the current value. */
    c74::min::message<threadsafe::yes> bang{this, "bang", MIN_FUNCTION {
        data_.command(jamoma::Value{});
        return {};
    }};

    /** An integer is a command. */
    c74::min::message<threadsafe::yes> m_int{this, "int", MIN_FUNCTION {
        data_.command(to_value(args));
        return {};
    }};

    /** A float is a command. */
    c74::min::message<threadsafe::yes> m_float{this, "float", MIN_FUNCTION {
        data_.command(to_value(args));
        return {};
    }};

    /** A list is a command. */
    c74::min::message<threadsafe::yes> m_list{this, "list", MIN_FUNCTION {
        data_.command(to_value(args));
        return {};
    }};

    /**
     * Any other message. A symbol arrives as `symbol <name>` and is treated as the message `<name>`. The plus and minus symbols
     * step the value; a message named like an attribute is an attribute message (see attribute_message()); anything else is a command.
     */
    c74::min::message<threadsafe::yes> m_anything{this, "anything", MIN_FUNCTION {
        c74::min::atoms message = args;
        if (message.size() >= 2 && static_cast<c74::min::symbol>(message[0]) == c74::min::symbol("symbol")) {
            message.erase(message.begin());
        }
        const std::string selector = static_cast<c74::min::symbol>(message[0]).c_str();
        c74::max::t_symbol* name = c74::max::gensym(selector.c_str());
        if (selector == "+") {
            data_.inc(to_value(rest(message)));
        } else if (selector == "-") {
            data_.dec(to_value(rest(message)));
        } else if (c74::max::object_attr_get(this->maxobj(), name) != nullptr) {
            attribute_message(name, message);
        } else if (data_.has_function_parameter(selector)) {
            function_parameter_message(name, message);
        } else {
            data_.command(to_value(message));
        }
        return {};
    }};

    /** Increases the value by the step size (times the argument). */
    c74::min::message<threadsafe::yes> inc{this, "inc", MIN_FUNCTION {
        data_.inc(to_value(args));
        return {};
    }};

    /** Decreases the value by the step size (times the argument). */
    c74::min::message<threadsafe::yes> dec{this, "dec", MIN_FUNCTION {
        data_.dec(to_value(args));
        return {};
    }};

    /** Sets the address (name) of the object in the namespace. */
    c74::min::message<> address{this, "address", MIN_FUNCTION {
        if (!args.empty()) {
            subscribe(std::string(static_cast<c74::min::symbol>(args[0]).c_str()));
        }
        return {};
    }};

    /** Answers `<attribute> <value>` on the dump outlet for every attribute, in table order. */
    c74::min::message<> dump{this, "dump", MIN_FUNCTION {
        for (const std::string& name : jamoma::Data::attribute_names()) {
            dump_attribute(name);
        }
        return {};
    }};

    /** Sends the default value through the object (the model's init does this for every data object). */
    c74::min::message<> init{this, "init", MIN_FUNCTION {
        data_.init();
        return {};
    }};

    /**
     * Class setup: reports an ABI mismatch once and adds the attributes of a data object (see data_attributes).
     */
    c74::min::message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION {
        if (!jamoma::Registry::check_abi(jamoma::kAbiVersion)) {
            c74::max::error("Jamoma: core ABI mismatch (built for abi %d, library is abi %d)", jamoma::kAbiVersion, jamoma::abi_version());
        }
        data_attributes<Derived>::add_to_class(args[0]);
        return {};
    }};

    /** @param name An attribute. @return Its current value. */
    jamoma::Value attribute_value(const std::string& name) const { return data_.get_attribute(name).value_or(jamoma::Value{}); }

    /** Sets an attribute. @param name The attribute. @param v The new value (nothing happens if it is empty). */
    void set_attribute_value(const std::string& name, const jamoma::Value& v) { data_.set_attribute(name, v); }

    /** Answers `<name> <value>` on the dump outlet (the old attribute query). @param name The attribute. */
    void dump_attribute(const std::string& name) { send_attribute(dump_out.max_outlet(), name, attribute_value(name)); }

protected:
    /** @return The name used when no name is given. */
    static std::string default_name()
    {
        switch (S) {
        case jamoma::Service::Parameter: return "parameter";
        case jamoma::Service::Message: return "message";
        case jamoma::Service::Return: return "return";
        }
        return "data";
    }

private:
    /**
     * Handles `symbol <attribute> [values]` (a symbol that names an attribute): alone it queries, with values it sets.
     * @param name The attribute name.
     * @param message The whole message (the name first).
     */
    void attribute_message(c74::max::t_symbol* name, const c74::min::atoms& message)
    {
        if (data_attributes<Derived>::is_attribute(name->s_name)) {
            if (message.size() == 1) {
                dump_attribute(name->s_name);
            } else {
                set_attribute_value(name->s_name, to_value(rest(message)));
            }
        }
    }

    /**
     * Handles `<parameter of the ramp function> [values]`: alone it answers `<name> <value>` on the dump outlet, with values it sets.
     * @param name The parameter name. @param message The whole message (the name first).
     */
    void function_parameter_message(c74::max::t_symbol* name, const c74::min::atoms& message)
    {
        if (message.size() == 1) {
            send_attribute(dump_out.max_outlet(), name->s_name, data_.function_parameter(name->s_name));
        } else if (!data_.set_function_parameter(name->s_name, to_value(rest(message)))) {
            c74::max::object_error(this->maxobj(), "%s: the value is not accepted by the ramp function", name->s_name);
        }
    }

    /** Drops the first atom. @param in The atoms. @return The rest. */
    static c74::min::atoms rest(const c74::min::atoms& in)
    {
        return in.size() > 1 ? c74::min::atoms(in.begin() + 1, in.end()) : c74::min::atoms{};
    }

    /** Subscribes (or re-subscribes) the data object to the namespace at the root. @param name The relative address. */
    void subscribe(const std::string& name)
    {
        name_ = name;
        subscription_ = jamoma::Subscription();
        subscription_ = jamoma::Registry::instance().names().subscribe(jamoma::Address::parse(prefix_ + "/" + name), data_);
    }

    /** Finds the model of the patcher (or of an enclosing one) and subscribes below it. */
    void join_model()
    {
        if (S != jamoma::Service::Message) {
            view_ = enclosing_view(patcher_of(this->maxobj()));
        }
        const jamoma::Model* model = find_model(this->maxobj());
        const std::string prefix = model != nullptr ? model->address().str() : std::string();
        if (!joined_) {
            joined_ = true;
            watch_.start([this] { join_model(); });
        }
        if (prefix != prefix_) {
            prefix_ = prefix;
            subscribe(name_);
        }
        if (model == nullptr && S == jamoma::Service::Parameter && !data_.initialized()) {
            // As the old object: a parameter that ends up at the root (no model to initialise it) initialises itself.
            data_.init();
        }
    }

    /** Sends a value out of the data outlet. @param v The value. */
    void output_value(const jamoma::Value& v)
    {
        if (const void* view = view_) { // first: what the outlet is connected to may free this object
            jamoma::Registry::instance().views().report(view, name_, v);
        }
        if (v.empty()) {
            data_out.send("bang");
        } else if (v.size() == 1 && v[0].is_int()) {
            data_out.send(static_cast<c74::max::t_atom_long>(v[0].as_int()));
        } else if (v.size() == 1 && v[0].is_float()) {
            data_out.send(v[0].as_double());
        } else {
            data_out.send(to_atoms(v));
        }
    }

};

} // namespace jamoma_max
