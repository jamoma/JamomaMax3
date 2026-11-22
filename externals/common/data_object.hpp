// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file data_object.hpp
 * @brief The shared body of j.parameter, j.message and j.return: a Min object wrapping a jamoma::Data.
 *
 * The three externals are one template instantiated three times, as the old ones were one source built three ways.
 */

#pragma once

#include <stdexcept>
#include <string>

#include "c74_min.h"

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
    c74::min::message<> bang{this, "bang", MIN_FUNCTION {
        data_.command(jamoma::Value{});
        return {};
    }};

    /** An integer is a command. */
    c74::min::message<> m_int{this, "int", MIN_FUNCTION {
        data_.command(to_value(args));
        return {};
    }};

    /** A float is a command. */
    c74::min::message<> m_float{this, "float", MIN_FUNCTION {
        data_.command(to_value(args));
        return {};
    }};

    /** A list is a command. */
    c74::min::message<> m_list{this, "list", MIN_FUNCTION {
        data_.command(to_value(args));
        return {};
    }};

    /**
     * Any other message. A symbol arrives as `symbol <name>` and is treated as the message `<name>`. The plus and minus symbols
     * step the value; a message named like an attribute is an attribute message (see attribute_message()); anything else is a command.
     */
    c74::min::message<> m_anything{this, "anything", MIN_FUNCTION {
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
        } else {
            data_.command(to_value(message));
        }
        return {};
    }};

    /** Increases the value by the step size (times the argument). */
    c74::min::message<> inc{this, "inc", MIN_FUNCTION {
        data_.inc(to_value(args));
        return {};
    }};

    /** Decreases the value by the step size (times the argument). */
    c74::min::message<> dec{this, "dec", MIN_FUNCTION {
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
        for (int i = 0; i < static_cast<int>(Attr::Count); ++i) {
            dump_attribute(static_cast<Attr>(i));
        }
        return {};
    }};

    /** Sends the default value through the object (the model's init does this for every data object). */
    c74::min::message<> init{this, "init", MIN_FUNCTION {
        data_.init();
        return {};
    }};

    /**
     * Class setup: reports an ABI mismatch once and adds the list-valued attributes (Min's attribute type cannot hold a list of
     * mixed atoms, so these use the Max attribute API directly).
     */
    c74::min::message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION {
        if (!jamoma::Registry::check_abi(jamoma::kAbiVersion)) {
            c74::max::error("Jamoma: core ABI mismatch (built for abi %d, library is abi %d)", jamoma::kAbiVersion, jamoma::abi_version());
        }
        c74::max::t_class* c = args[0];
        add_attribute<Attr::Type>(c);
        add_attribute<Attr::Range>(c);
        add_attribute<Attr::Clipmode>(c);
        add_attribute<Attr::RepetitionsFilter>(c);
        add_attribute<Attr::Default>(c);
        add_attribute<Attr::Stepsize>(c);
        add_attribute<Attr::Active>(c);
        add_attribute<Attr::Priority>(c);
        add_attribute<Attr::Description>(c);
        add_attribute<Attr::Tags>(c);
        add_attribute<Attr::Dataspace>(c);
        add_attribute<Attr::Unit>(c);
        add_attribute<Attr::RampDrive>(c);
        add_attribute<Attr::RampFunction>(c);
        add_attribute<Attr::RampFunctionParameters>(c);
        add_attribute<Attr::RampStatus>(c);
        add_attribute<Attr::Value>(c);
        add_attribute<Attr::Service>(c);
        return {};
    }};

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
        for (int i = 0; i < static_cast<int>(Attr::Count); ++i) {
            if (std::string(ATTRIBUTE_NAMES[i]) == name->s_name) {
                if (message.size() == 1) {
                    dump_attribute(static_cast<Attr>(i));
                } else {
                    set_attr(static_cast<Attr>(i), to_value(rest(message)));
                }
                return;
            }
        }
    }

    /** Every attribute of a data object (the order is the order of ATTRIBUTE_NAMES). */
    enum class Attr {
        Type, Range, Clipmode, RepetitionsFilter, Default, Stepsize, Active, Priority, Description, Tags, Dataspace, Unit,
        RampDrive, RampFunction, RampFunctionParameters, RampStatus, Value, Service, Count
    };

    /** The attribute names, as patchers see them. */
    static constexpr const char* ATTRIBUTE_NAMES[static_cast<int>(Attr::Count)] = {
        "type", "range", "clipmode", "repetitions/filter", "default", "stepsize", "active", "priority", "description", "tags",
        "dataspace", "unit", "ramp/drive", "ramp/function", "ramp/function/parameters", "ramp/status", "value", "service"};

    /** @param a An atom. @return Its text. */
    static std::string text_of(const jamoma::Atom& a) { return a.is_symbol() ? a.as_symbol() : a.to_string(); }

    /** @param v A value. @return Its first atom as a string, or an empty string. */
    static std::string first_text(const jamoma::Value& v) { return v.empty() ? std::string() : text_of(v[0]); }

    /** @param a Which attribute. @return Its current value. */
    jamoma::Value get_attr(Attr a) const
    {
        switch (a) {
        case Attr::Type: return {std::string(jamoma::data_type_name(data_.type()))};
        case Attr::Range: return data_.range();
        case Attr::Clipmode: return {std::string(jamoma::clip_mode_name(data_.clipmode()))};
        case Attr::RepetitionsFilter: return {static_cast<std::int64_t>(data_.repetitions_filter() ? 1 : 0)};
        case Attr::Default: return data_.default_value();
        case Attr::Stepsize: return {data_.stepsize()};
        case Attr::Active: return {static_cast<std::int64_t>(data_.active() ? 1 : 0)};
        case Attr::Priority: return {static_cast<std::int64_t>(data_.priority())};
        case Attr::Description: return {data_.description()};
        case Attr::Tags: {
            jamoma::Value out;
            for (const std::string& t : data_.tags()) {
                out.emplace_back(t);
            }
            return out;
        }
        case Attr::Dataspace: return {data_.dataspace().empty() ? std::string("none") : data_.dataspace()};
        case Attr::Unit: return {data_.unit().empty() ? std::string("none") : data_.unit()};
        case Attr::RampDrive: return {data_.ramp_drive()};
        case Attr::RampFunction: return {data_.ramp_function()};
        case Attr::RampFunctionParameters: return jamoma::Value{};
        case Attr::RampStatus: return {static_cast<std::int64_t>(data_.ramp_running() ? 1 : 0)};
        case Attr::Value: return data_.initialized() ? data_.value() : jamoma::Value{}; // nothing until initialised, as the old object
        case Attr::Service: return {std::string(S == jamoma::Service::Parameter ? "parameter" : S == jamoma::Service::Message ? "message" : "return")};
        case Attr::Count: break;
        }
        return jamoma::Value{};
    }

    /** Sets an attribute. @param a Which attribute. @param v The new value (not empty). */
    void set_attr(Attr a, const jamoma::Value& v)
    {
        if (v.empty()) {
            return; // nothing usable was given (the Max setter drops atoms that are neither numbers nor symbols)
        }
        switch (a) {
        case Attr::Type: data_.set_type(jamoma::data_type_from_name(first_text(v))); break;
        case Attr::Range: data_.set_range(v); break;
        case Attr::Clipmode: data_.set_clipmode(jamoma::clip_mode_from_name(first_text(v))); break;
        case Attr::RepetitionsFilter: data_.set_repetitions_filter(v[0].as_int() != 0); break;
        case Attr::Default: data_.set_default(v); break;
        case Attr::Stepsize: data_.set_stepsize(v[0].as_double()); break;
        case Attr::Active: data_.set_active(v[0].as_int() != 0); break;
        case Attr::Priority: data_.set_priority(static_cast<int>(v[0].as_int())); break;
        case Attr::Description: data_.set_description(first_text(v)); break;
        case Attr::Tags: {
            std::vector<std::string> list;
            for (const jamoma::Atom& atom : v) {
                list.push_back(text_of(atom));
            }
            data_.set_tags(std::move(list));
            break;
        }
        case Attr::Dataspace: {
            const std::string name = first_text(v);
            data_.set_dataspace(name == "none" ? std::string() : name);
            break;
        }
        case Attr::Unit: {
            const std::string name = first_text(v);
            data_.set_unit(name == "none" ? std::string() : name);
            break;
        }
        case Attr::RampDrive: data_.set_ramp_drive(first_text(v)); break;
        case Attr::RampFunction: data_.set_ramp_function(first_text(v)); break;
        case Attr::Value: data_.command(v); break;
        case Attr::RampFunctionParameters:
        case Attr::RampStatus:
        case Attr::Service:
        case Attr::Count: break; // read only
        }
    }

    /** Answers `<name> <value>` on the dump outlet (the old attribute query). @param a Which attribute. */
    void dump_attribute(Attr a)
    {
        const jamoma::Value v = get_attr(a);
        const c74::min::atoms atoms = to_atoms(v);
        c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym(ATTRIBUTE_NAMES[static_cast<int>(a)]),
                                  static_cast<short>(atoms.size()),
                                  atoms.empty() ? nullptr : const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&atoms[0])));
    }

    /** The Max getter of an attribute. @tparam A Which attribute. @param o The object. @param argc Receives the count. @param argv Receives the atoms. @return A Max error code. */
    template <Attr A>
    static c74::max::t_max_err attr_getter(c74::max::t_object* o, c74::max::t_object*, long* argc, c74::max::t_atom** argv)
    {
        const jamoma::Value v = c74::min::wrapper_find_self<Derived>(o)->m_min_object.get_attr(A);
        char allocated = 0;
        c74::max::atom_alloc_array(static_cast<long>(v.size()), argc, argv, &allocated);
        for (std::size_t i = 0; i < v.size(); ++i) {
            if (v[i].is_int()) {
                c74::max::atom_setlong(*argv + i, static_cast<c74::max::t_atom_long>(v[i].as_int()));
            } else if (v[i].is_float()) {
                c74::max::atom_setfloat(*argv + i, v[i].as_double());
            } else {
                c74::max::atom_setsym(*argv + i, c74::max::gensym(v[i].as_symbol().c_str()));
            }
        }
        return c74::max::MAX_ERR_NONE;
    }

    /**
     * The Max setter of an attribute. With no arguments (a bare attribute-name message) it answers the query on the dump outlet.
     * @tparam A Which attribute. @param o The object. @param argc The count. @param argv The atoms. @return A Max error code.
     */
    template <Attr A>
    static c74::max::t_max_err attr_setter(c74::max::t_object* o, c74::max::t_object*, long argc, c74::max::t_atom* argv)
    {
        Derived& self = c74::min::wrapper_find_self<Derived>(o)->m_min_object;
        if (argc == 0) {
            self.dump_attribute(A);
            return c74::max::MAX_ERR_NONE;
        }
        jamoma::Value v;
        for (long i = 0; i < argc; ++i) {
            switch (c74::max::atom_gettype(argv + i)) {
            case c74::max::A_LONG: v.emplace_back(static_cast<std::int64_t>(c74::max::atom_getlong(argv + i))); break;
            case c74::max::A_FLOAT: v.emplace_back(c74::max::atom_getfloat(argv + i)); break;
            case c74::max::A_SYM: v.emplace_back(std::string(c74::max::atom_getsym(argv + i)->s_name)); break;
            default: break;
            }
        }
        self.set_attr(A, v);
        return c74::max::MAX_ERR_NONE;
    }

    /** Adds an attribute (a list of atoms of any length) to the class. @tparam A Which attribute. @param c The class. */
    template <Attr A>
    static void add_attribute(c74::max::t_class* c)
    {
        c74::max::t_object* attr = c74::max::attr_offset_array_new(
            ATTRIBUTE_NAMES[static_cast<int>(A)], c74::max::gensym("atom"), 256, 0,
            reinterpret_cast<c74::max::method>(&attr_getter<A>), reinterpret_cast<c74::max::method>(&attr_setter<A>), 0, 0);
        c74::max::class_addattr(c, attr);
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
        const jamoma::Model* model = find_model(this->maxobj());
        if (model != nullptr) {
            prefix_ = model->address().str();
            subscribe(name_);
        } else if (S == jamoma::Service::Parameter && !data_.initialized()) {
            // As the old object: a parameter that ends up at the root (no model to initialise it) initialises itself.
            data_.init();
        }
    }

    /** Sends a value out of the data outlet. @param v The value. */
    void output_value(const jamoma::Value& v)
    {
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
