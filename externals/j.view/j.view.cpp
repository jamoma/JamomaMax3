// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.view.cpp
 * @brief j.view: declares the patcher as the view of a model and sends messages to the parameters of that model.
 *
 * The model is named by the first argument (an absolute address, or one relative to the model of the patcher that contains the view);
 * without an argument the view binds to the model of the same class in the containing patcher (`qmetro.view` and `qmetro.model`).
 * The message `model:address <address>` names another model later on. The binding follows models coming and going: the view says `model:address <address>` on its dump outlet while it is bound and
 * `model:waiting` while it is not. A message `<parameter> <value...>` is sent to that parameter of the model and echoed out of the left outlet.
 * The left outlet also reports `<name> <value>` for every change seen by a named `j.remote` (a second argument) in the view, and for every
 * parameter and return placed in the view patcher.
 */

#include <memory>
#include <string>

#include "c74_min.h"

#include "jamoma/data.hpp"
#include "jamoma/registry.hpp"
#include "max_atoms.hpp"
#include "max_context.hpp"
#include "max_queries.hpp"

using namespace c74::min;

/** The j.view external. */
class j_view : public c74::min::object<j_view> {
    // State comes before the attributes: Min runs every attribute setter with its default while constructing them.
    std::string argument_;                  /**< The model address as given (may be empty). */
    const void* patcher_ = nullptr;         /**< The patcher of the view. */
    jamoma_max::Alive alive_;               /**< Lets deferred calls see that the object is gone. */
    std::shared_ptr<void> listening_;       /**< Hears what the named remotes, parameters and returns of the view report. */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object. @param args The creation atoms: an optional model address, then attributes. */
    explicit j_view(const atoms& args = {})
    {
        if (c74::min::dummy()) {
            return; // the instance Min builds during class setup has no Max object
        }
        if (!args.empty() && args[0].type() == message_type::symbol_argument) {
            const std::string first = static_cast<symbol>(args[0]).c_str();
            // `j.model` is what the old qmetro view writes where it means "the model of this class": no argument
            if (!first.empty() && first[0] != '@' && first != "j.model") {
                argument_ = first;
            }
        }
    }

    /** Takes the view out of the map. */
    ~j_view() override
    {
        listening_.reset();
        if (patcher_ != nullptr) {
            jamoma::Registry::instance().views().remove(patcher_);
        }
    }

    inlet<> input{this, "(anything) <parameter> <value> sends the value to a parameter of the model"}; /**< The inlet. */
    outlet<> echo_out{this, "(anything) the messages sent to the model"};                              /**< Outlet 0: the messages sent to the model, and the values of the named remotes, parameters and returns of the view. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump"};                                         /**< Outlet 1: the dump outlet. */

    /** The alias of the view (accepted so that old patchers load; it has no effect yet). */
    attribute<symbol> alias{this, "alias", ""};
    /** The description of the view. */
    attribute<symbol> description{this, "description", ""};
    /** The tags of the view. */
    attribute<symbol> tags{this, "tags", ""};
    /** Whether the view reports activity (accepted so that old patchers load; it has no effect yet). */
    attribute<int> activity{this, "activity", 0, style::onoff};

    /** After construction: registers the dump outlet and the view. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        patcher_ = jamoma_max::patcher_of(maxobj());
        jamoma::Registry::instance().views().add(patcher_, argument_);
        listening_ = jamoma::Registry::instance().views().listen(patcher_, [this](const std::string& name, const jamoma::Value& v) {
            if (c74::max::systhread_ismainthread()) {
                report_value(name, v);
            } else {
                jamoma_max::defer_call(maxobj(), alive_.weak(), [this, name, v] { report_value(name, v); });
            }
        });
        return {};
    }};

    /** Answers `model:address <address>` while bound, else `model:waiting`, on the dump outlet. */
    message<> dump{this, "dump", MIN_FUNCTION {
        report_binding();
        return {};
    }};

    /**
     * `model:address <address>` binds the view to another model (absolute, or relative to the model of the containing patcher); everything in
     * the view that follows its model binds again. Without an argument it answers like dump.
     */
    message<> model_address{this, "model:address", MIN_FUNCTION {
        if (args.empty()) {
            report_binding();
            return {};
        }
        if (args[0].type() != message_type::symbol_argument || patcher_ == nullptr) {
            c74::max::object_warn(maxobj(), "j.view: model:address takes the address of a model");
            return {};
        }
        argument_ = static_cast<symbol>(args[0]).c_str();
        jamoma::Registry::instance().views().set_argument(patcher_, argument_);
        return {};
    }};

    /** `<parameter> <value...>`: sends the value to the parameter of the model and echoes the message. */
    message<> m_anything{this, "anything", MIN_FUNCTION {
        atoms message = args;
        if (message.size() >= 2 && static_cast<symbol>(message[0]) == symbol("symbol")) {
            message.erase(message.begin());
        }
        const std::string name = static_cast<symbol>(message[0]).c_str();
        const jamoma::Value value = jamoma_max::to_value(atoms(message.begin() + 1, message.end()));
        const std::optional<std::string> model = jamoma_max::view_model_address(patcher_);
        if (!model) {
            c74::max::object_warn(maxobj(), "j.view is waiting for its model; %s was not sent", name.c_str());
            return {};
        }
        jamoma::Node* node = jamoma::Registry::instance().names().lookup(jamoma::Address::parse(*model + "/" + name));
        auto* data = node != nullptr ? dynamic_cast<jamoma::Data*>(node->object()) : nullptr;
        if (data == nullptr) {
            c74::max::object_warn(maxobj(), "j.view: the model %s has no parameter %s", model->c_str(), name.c_str());
            return {};
        }
        data->command(value);
        echo_out.send(message);
        return {};
    }};

    /** Class setup: every attribute answers when its name is sent without a value, and to `get<name>`, as the old objects did. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION {
        jamoma_max::answer_queries<j_view>(args[0], {"alias", "description", "tags", "activity"});
        jamoma_max::answer_get_messages(args[0], {"alias", "description", "tags", "activity"});
        return {};
    }};

private:
    /** Sends `<name> <value>` out of the left outlet (main thread). @param name Who it comes from. @param v The value. */
    void report_value(const std::string& name, const jamoma::Value& v)
    {
        atoms out{symbol(name)};
        for (const c74::min::atom& a : jamoma_max::to_atoms(v)) {
            out.push_back(a);
        }
        echo_out.send(out);
    }

    /** Sends the state of the binding to the dump outlet. */
    void report_binding()
    {
        const std::optional<std::string> model = jamoma_max::view_model_address(patcher_);
        if (model) {
            c74::max::t_atom a;
            c74::max::atom_setsym(&a, c74::max::gensym(model->c_str()));
            c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym("model:address"), 1, &a);
        } else {
            c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym("model:waiting"), 0, nullptr);
        }
    }
};

MIN_EXTERNAL(j_view);
