// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file array_object.hpp
 * @brief The shared body of j.parameter_array, j.message_array and j.return_array: a Min object wrapping a jamoma::DataArray.
 *
 * Behaviour: docs/inventory/j.array.md.
 */

#pragma once

#include <memory>
#include <stdexcept>
#include <string>

#include "c74_min.h"

#include "data_attributes.hpp"
#include "jamoma/data_array.hpp"
#include "jamoma/registry.hpp"
#include "jamoma/version.hpp"
#include "max_address.hpp"
#include "max_atoms.hpp"
#include "max_clock.hpp"
#include "max_context.hpp"

namespace jamoma_max {

// Min's MIN_FUNCTION macro names `atoms` unqualified.
using namespace c74::min;

/**
 * @brief A Max object that owns numbered data objects made from one bracketed name, such as `cc.[128]`.
 * @tparam Derived The external class (Min requires the CRTP).
 * @tparam S The role of the instances.
 */
template <class Derived, jamoma::Service S>
class array_object : public c74::min::object<Derived> {
    std::unique_ptr<jamoma::DataArray> array_; /**< The instances (null only in the instance Min builds during class setup). */
    std::string prefix_;                       /**< The address of the model the array lives in, or empty (then it is at the root). */
    Alive alive_;                              /**< Lets deferred calls see that the object is gone. */
    ContextWatch watch_;                       /**< Finds the model again when it appears later, is replaced or goes. */
    bool joined_ = false;                      /**< True once the patcher has loaded and the model has been looked for. */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /**
     * Creates the object.
     * @param args The creation arguments: the first is the bracketed name; attributes are applied by Max afterwards.
     */
    explicit array_object(const c74::min::atoms& args = {})
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
        array_ = std::make_unique<jamoma::DataArray>(jamoma::Registry::instance().names(), S);
        array_->set_clock_maker([] { return std::unique_ptr<jamoma::Clock>(std::make_unique<MaxClock>()); });
        array_->set_output([this](std::size_t index, const jamoma::Value& v) {
            const std::weak_ptr<int> alive = alive_.weak();
            const std::uint64_t instance = array_->identity(index);
            c74::max::outlet_int(index_out.max_outlet(), static_cast<c74::max::t_atom_long>(index)); // the index first
            // What follows the index outlet may have resized the array or freed the object.
            if (alive.expired() || !array_ || array_->identity(index) != instance) {
                return;
            }
            jamoma_max::output_value(data_out.max_outlet(), v);
        });
        std::string name;
        if (!args.empty() && args[0].type() == c74::min::message_type::symbol_argument) {
            const std::string first = static_cast<c74::min::symbol>(args[0]).c_str();
            if (!first.empty() && first[0] != '@') {
                name = first;
            }
        }
        // The nodes are made at once (at the root), so that the box attributes find them.
        if (name.empty()) {
            c74::max::object_error(this->maxobj(), "needs a name as first argument, such as name.[4]");
        } else if (!array_->set_name(name, jamoma::Address(), false)) {
            report_bad_name(name);
        }
        // Once the whole patcher exists, move under the model of the patcher (if there is one).
        defer_call(this->maxobj(), alive_.weak(), [this] { join_model(); });
    }

    /** Stops watching and cuts the array off from the outlets before the members go. */
    ~array_object() override
    {
        watch_.stop();
        if (array_) {
            array_->set_output(nullptr);
        }
        array_.reset();
    }

    c74::min::inlet<> input{this, "(anything) value or message for the selected instances"};  /**< Inlet 0. */
    c74::min::inlet<> index_in{this, "(int or *) the instance to address, * for all"};       /**< Inlet 1. */
    dump_outlet data_out{this, "(anything) the value"};                                      /**< Outlet 0: the value. */
    dump_outlet index_out{this, "(int) the instance"};                                       /**< Outlet 1: the number of the instance. */
    dump_outlet dump_out{this, "(anything) dump"};                                           /**< Outlet 2: the dump outlet. */

    /** After construction: registers the last outlet as the dumpout. */
    c74::min::message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(this->maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        return {};
    }};

    /** A bang makes the selected instances output their values. */
    c74::min::message<threadsafe::yes> bang{this, "bang", MIN_FUNCTION {
        if (inlet == 0) {
            command(jamoma::Value{});
        }
        return {};
    }};

    /** An integer is a command, or in the right inlet the instance. */
    c74::min::message<threadsafe::yes> m_int{this, "int", MIN_FUNCTION {
        value_or_index(args, inlet);
        return {};
    }};

    /** A float is a command, or in the right inlet the instance. */
    c74::min::message<threadsafe::yes> m_float{this, "float", MIN_FUNCTION {
        value_or_index(args, inlet);
        return {};
    }};

    /** A list is a command; in the right inlet its first item is the instance. */
    c74::min::message<threadsafe::yes> m_list{this, "list", MIN_FUNCTION {
        value_or_index(args, inlet);
        return {};
    }};

    /**
     * Any other message. In the right inlet it selects (`*`). In the left one: `+` and `-` step the values, a message named like an
     * attribute is an attribute message, a parameter of the ramp function is set or asked for, and anything else is a command.
     */
    c74::min::message<threadsafe::yes> m_anything{this, "anything", MIN_FUNCTION {
        c74::min::atoms message = args;
        if (message.size() >= 2 && static_cast<c74::min::symbol>(message[0]) == c74::min::symbol("symbol")) {
            message.erase(message.begin());
        }
        if (!array_ || message.empty()) {
            return {};
        }
        if (inlet == 1) {
            select(jamoma_max::to_value(message));
            return {};
        }
        const std::string selector = static_cast<c74::min::symbol>(message[0]).c_str();
        if (selector == "+") {
            if (!array_->inc(to_value(rest(message)))) {
                report_empty();
            }
        } else if (selector == "-") {
            if (!array_->dec(to_value(rest(message)))) {
                report_empty();
            }
        } else if (data_attributes<Derived>::is_attribute(selector)) {
            if (message.size() == 1) {
                dump_attribute(selector);
            } else {
                set_attribute_value(selector, to_value(rest(message)));
            }
        } else if (array_->has_function_parameter(selector)) {
            if (message.size() == 1) {
                send_attribute(dump_out.max_outlet(), selector, array_->function_parameter(selector));
            } else if (!array_->set_function_parameter(selector, to_value(rest(message)))) {
                c74::max::object_error(this->maxobj(), "%s: the value is not accepted by the ramp function", selector.c_str());
            }
        } else {
            command(to_value(message));
        }
        return {};
    }};

    /** Cuts a list into equal parts, one for each instance. */
    c74::min::message<threadsafe::yes> m_array{this, "array", MIN_FUNCTION {
        if (array_ && !array_->array(to_value(args))) {
            if (array_->size() == 0) {
                report_empty();
            } else {
                c74::max::object_error(this->maxobj(), "array: the length of the list has to be a multiple of the size (%d)", static_cast<int>(array_->size()));
            }
        }
        return {};
    }};

    /** Selects the instance that values go to (as the right inlet). */
    c74::min::message<threadsafe::yes> array_select{this, "array/select", MIN_FUNCTION {
        select(to_value(args));
        return {};
    }};

    /** Changes the number of instances. */
    c74::min::message<threadsafe::yes> array_resize{this, "array/resize", MIN_FUNCTION {
        if (args.empty()) {
            return {};
        }
        if (args[0].type() != c74::min::message_type::int_argument && args[0].type() != c74::min::message_type::float_argument) {
            c74::max::object_error(this->maxobj(), "array/resize needs a number (the array is left as it is)");
            return {};
        }
        const long size = static_cast<long>(args[0]);
        run_on_main(this->maxobj(), alive_.weak(), [this, size] {
            if (array_ && (size < 0 || !array_->resize(static_cast<std::size_t>(size), joined_))) {
                c74::max::object_error(this->maxobj(), "array/resize: %ld is not a valid size (0 to %d)", size, static_cast<int>(jamoma::kMaxArraySize));
            }
        });
        return {};
    }};

    /** Increases the selected instances by their step size (times the argument). */
    c74::min::message<threadsafe::yes> inc{this, "inc", MIN_FUNCTION {
        if (array_ && !array_->inc(to_value(args))) {
            report_empty();
        }
        return {};
    }};

    /** Decreases the selected instances by their step size (times the argument). */
    c74::min::message<threadsafe::yes> dec{this, "dec", MIN_FUNCTION {
        if (array_ && !array_->dec(to_value(args))) {
            report_empty();
        }
        return {};
    }};

    /** Sets the bracketed name, and with it the size. */
    c74::min::message<threadsafe::yes> address{this, "address", MIN_FUNCTION {
        if (args.empty()) {
            return {};
        }
        const std::string name = static_cast<c74::min::symbol>(args[0]).c_str();
        run_on_main(this->maxobj(), alive_.weak(), [this, name] {
            if (!array_ || array_->name() == name) {
                return;
            }
            if (!array_->set_name(name, jamoma::Address::parse(prefix_), joined_)) {
                report_bad_name(name);
            }
        });
        return {};
    }};

    /** Answers every attribute of the watched instance, and the format, on the dump outlet. */
    c74::min::message<> dump{this, "dump", MIN_FUNCTION {
        for (const std::string& name : jamoma::Data::attribute_names()) {
            dump_attribute(name);
        }
        send_attribute(dump_out.max_outlet(), "format", {jamoma::Atom(array_ && array_->format() == jamoma::ArrayFormat::Array ? "array" : "single")});
        return {};
    }};

    /** Sends the default value through every instance. */
    c74::min::message<> init{this, "init", MIN_FUNCTION {
        if (array_) {
            array_->init();
        }
        return {};
    }};

    /** Class setup: reports an ABI mismatch once and adds the attributes of a data object and `format`. */
    c74::min::message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION {
        if (!jamoma::Registry::check_abi(jamoma::kAbiVersion)) {
            c74::max::error("Jamoma: core ABI mismatch (built for abi %d, library is abi %d)", jamoma::kAbiVersion, jamoma::abi_version());
        }
        c74::max::t_class* c = args[0];
        data_attributes<Derived>::add_to_class(c);
        c74::max::class_addattr(c, c74::max::attr_offset_new("format", c74::max::gensym("symbol"), 0,
                                                             reinterpret_cast<c74::max::method>(&format_getter),
                                                             reinterpret_cast<c74::max::method>(&format_setter), 0));
        c74::max::class_attr_addattr_parse(c, "format", "style", c74::max::gensym("symbol"), 0, "enum");
        c74::max::class_attr_addattr_parse(c, "format", "enumvals", c74::max::gensym("atom"), 0, "single array");
        answer_get_messages(c, {"format"});
        return {};
    }};

    /** @param name An attribute. @return Its value in the watched instance. */
    jamoma::Value attribute_value(const std::string& name) const
    {
        return array_ ? array_->get_attribute(name).value_or(jamoma::Value{}) : jamoma::Value{};
    }

    /** Sets an attribute of every instance. @param name The attribute. @param v The new value. */
    void set_attribute_value(const std::string& name, const jamoma::Value& v)
    {
        if (array_) {
            array_->set_attribute(name, v);
        }
    }

    /** Answers `<name> <value>` on the dump outlet. @param name The attribute. */
    void dump_attribute(const std::string& name) { send_attribute(dump_out.max_outlet(), name, attribute_value(name)); }

private:
    /** The Max getter of `format`. @param o The object. @param argc Receives the count. @param argv Receives the atom. @return A Max error code. */
    static c74::max::t_max_err format_getter(c74::max::t_object* o, c74::max::t_object*, long* argc, c74::max::t_atom** argv)
    {
        const array_object& self = c74::min::wrapper_find_self<Derived>(o)->m_min_object;
        char allocated = 0;
        c74::max::atom_alloc_array(1, argc, argv, &allocated);
        const bool all = self.array_ && self.array_->format() == jamoma::ArrayFormat::Array;
        c74::max::atom_setsym(*argv, c74::max::gensym(all ? "array" : "single"));
        return c74::max::MAX_ERR_NONE;
    }

    /** The Max setter of `format` (`array`; anything else, also nothing, is `single`). @param o The object. @param argc The count. @param argv The atoms. @return A Max error code. */
    static c74::max::t_max_err format_setter(c74::max::t_object* o, c74::max::t_object*, long argc, c74::max::t_atom* argv)
    {
        array_object& self = c74::min::wrapper_find_self<Derived>(o)->m_min_object;
        if (self.array_) {
            const bool all = argc > 0 && c74::max::atom_getsym(argv) == c74::max::gensym("array");
            self.array_->set_format(all ? jamoma::ArrayFormat::Array : jamoma::ArrayFormat::Single);
        }
        return c74::max::MAX_ERR_NONE;
    }

    /** Drops the first atom. @param in The atoms. @return The rest. */
    static c74::min::atoms rest(const c74::min::atoms& in)
    {
        return in.size() > 1 ? c74::min::atoms(in.begin() + 1, in.end()) : c74::min::atoms{};
    }

    /** Sends a message to the selected instances. @param v The message. */
    void command(const jamoma::Value& v)
    {
        if (array_ && !array_->command(v)) {
            report_empty();
        }
    }

    /** A number or list: a command in the left inlet, the instance in the right one. @param args The atoms. @param inlet The inlet. */
    void value_or_index(const c74::min::atoms& args, int inlet)
    {
        if (inlet == 1) {
            select(to_value(args));
        } else {
            command(to_value(args));
        }
    }

    /** Selects an instance. @param which The number, or `*`, as the first item. */
    void select(const jamoma::Value& which)
    {
        if (array_ && !which.empty() && !array_->select(which[0])) {
            c74::max::object_error(this->maxobj(), "array/select: %s is not a valid index", which[0].as_symbol().c_str());
        }
    }

    /** Says that there is nothing to send to. */
    void report_empty() { c74::max::object_error(this->maxobj(), "the array is empty"); }

    /** Says what is wrong with a name. @param name The name. */
    void report_bad_name(const std::string& name)
    {
        c74::max::object_error(this->maxobj(), "%s: needs a relative name with one size in brackets, at most [%d]", name.c_str(),
                               static_cast<int>(jamoma::kMaxArraySize));
    }

    /** Finds the model of the patcher (or of an enclosing one) and registers the instances below it. */
    void join_model()
    {
        if (!array_) {
            return;
        }
        const jamoma::Model* model = find_model(this->maxobj());
        const std::string prefix = model != nullptr ? model->address().str() : std::string();
        const bool first = !joined_;
        if (first) {
            joined_ = true;
            watch_.start([this] { join_model(); });
        }
        if (prefix != prefix_) {
            prefix_ = prefix;
            const std::string name = array_->name(); // with the present size
            if (!name.empty()) {
                array_->set_name(name, jamoma::Address::parse(prefix_), false);
            }
        }
        if (first && model == nullptr) {
            // As j.parameter: parameters that end up at the root (no model to initialise them) initialise themselves.
            array_->init_uninitialized();
        }
    }
};

} // namespace jamoma_max
