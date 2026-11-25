// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.view.cpp
 * @brief j.view: declares the patcher as the view of a model and sends messages to the parameters of that model.
 *
 * The model is named by the first argument (an absolute address, or one relative to the model of the patcher that contains the view);
 * without an argument the view binds to the model of the same class in the containing patcher (`qmetro.view` and `qmetro.model`).
 * The binding follows models coming and going: the view says `model:address <address>` on its dump outlet while it is bound and
 * `model:waiting` while it is not. A message `<parameter> <value...>` is sent to that parameter of the model and echoed out of the left outlet.
 */

#include <memory>
#include <string>

#include "c74_min.h"

#include "jamoma/data.hpp"
#include "jamoma/registry.hpp"
#include "max_atoms.hpp"
#include "max_context.hpp"

using namespace c74::min;

/** The j.view external. */
class j_view : public c74::min::object<j_view> {
    // State comes before the attributes: Min runs every attribute setter with its default while constructing them.
    std::string argument_;                  /**< The model address as given (may be empty). */
    const void* patcher_ = nullptr;         /**< The patcher of the view. */
    jamoma_max::Alive alive_;               /**< Lets deferred calls see that the object is gone. */

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
        if (patcher_ != nullptr) {
            jamoma::Registry::instance().views().remove(patcher_);
        }
    }

    inlet<> input{this, "(anything) <parameter> <value> sends the value to a parameter of the model"}; /**< The inlet. */
    outlet<> echo_out{this, "(anything) the messages sent to the model"};                              /**< Outlet 0. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump"};                                         /**< Outlet 1: the dump outlet. */

    /** The alias of the view (accepted so that old patchers load; it has no effect yet). */
    attribute<symbol> alias{this, "alias", ""};
    /** The description of the view. */
    attribute<symbol> description{this, "description", ""};
    /** The tags of the view. */
    attribute<symbol> tags{this, "tags", ""};
    /** Whether the view reports activity (accepted so that old patchers load; it has no effect yet). */
    attribute<int> activity{this, "activity", 0};

    /** After construction: registers the dump outlet and the view. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        patcher_ = jamoma_max::patcher_of(maxobj());
        jamoma::Registry::instance().views().add(patcher_, argument_);
        return {};
    }};

    /** Answers `model:address <address>` while bound, else `model:waiting`, on the dump outlet. */
    message<> dump{this, "dump", MIN_FUNCTION {
        report_binding();
        return {};
    }};

    /** Answers like dump. */
    message<> model_address{this, "model:address", MIN_FUNCTION {
        report_binding();
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

    /** Class setup: nothing to add. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION { return {}; }};

private:
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
