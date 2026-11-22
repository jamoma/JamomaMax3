// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.model.cpp
 * @brief j.model: declares the patcher as a model. The data objects of the patcher register below its address.
 *
 * The model is named by its first argument, else by the file name of its patcher (dots become underscores, since a dot starts an
 * instance in an address). It initialises itself once the patcher has loaded (two deferred hops, so every data object of the
 * patcher has found its model first) and again whenever it gets the `init` message. Presets, aliases and the dump message of
 * the old j.model are later milestones.
 */

#include <memory>
#include <string>

#include "c74_min.h"

#include "jamoma/model.hpp"
#include "jamoma/registry.hpp"
#include "max_context.hpp"

using namespace c74::min;

/** The j.model external. */
class j_model : public c74::min::object<j_model> {
    // These come before the attributes: Min constructs the attributes in declaration order and calls each setter with its
    // default, and the setters use model_ (the same trap as in data_object, which crashed Max once).
    std::string name_;                         /**< The name of the model. */
    const void* patcher_ = nullptr;            /**< The patcher the model governs. */
    std::unique_ptr<jamoma::Model> model_;     /**< The model. */
    jamoma_max::Alive alive_;                  /**< Lets deferred calls see that the object is gone. */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /**
     * Creates the object.
     * @param args The creation atoms: an optional name, then attributes.
     */
    explicit j_model(const atoms& args = {})
    {
        if (!args.empty() && args[0].type() == message_type::symbol_argument) {
            const std::string first = static_cast<symbol>(args[0]).c_str();
            if (!first.empty() && first[0] != '@') {
                name_ = first;
            }
        }
    }

    ~j_model() override
    {
        if (model_) {
            jamoma::Registry::instance().contexts().remove(patcher_, model_.get());
        }
    }

    /** The description of the model. */
    attribute<symbol> description{this, "description", "", setter{MIN_FUNCTION {
        if (model_) {
            model_->set_description(std::string(static_cast<symbol>(args[0]).c_str()));
        }
        return args;
    }}};

    /** The priority of the model (used when a parent model initialises). */
    attribute<int> priority{this, "priority", 0, setter{MIN_FUNCTION {
        if (model_) {
            model_->set_priority(static_cast<int>(args[0]));
        }
        return args;
    }}};

    /** The amenities the model provides (accepted so that patchers that set it load; it has no effect yet). */
    attribute<symbol> amenities{this, "amenities", "all"};

    inlet<> input{this, "(anything) messages to the model"};              /**< The inlet. */
    outlet<> results_out{this, "(anything) results (presets, later milestone)"}; /**< Outlet 0 (unused so far). */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump"};              /**< Outlet 1: the dump outlet. */

    /** Initialises the model: sends the default value through every parameter below it. */
    message<> init{this, "init", MIN_FUNCTION {
        if (model_) {
            model_->init();
        }
        return {};
    }};

    /** Answers `<attribute> <value>` on the dump outlet for the model's attributes. */
    message<> dump{this, "dump", MIN_FUNCTION {
        const auto answer = [this](const char* name, const atoms& values) {
            c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym(name), static_cast<short>(values.size()),
                                      values.empty() ? nullptr : const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&values[0])));
        };
        answer("description", atoms{description.get()});
        answer("priority", atoms{priority.get()});
        answer("amenities", atoms{amenities.get()});
        return {};
    }};

    /** After construction: creates the model, registers it for its patcher and schedules the first initialisation. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        patcher_ = jamoma_max::patcher_of(maxobj());
        if (name_.empty()) {
            name_ = patcher_name();
        }
        model_ = std::make_unique<jamoma::Model>(jamoma::Registry::instance().names(), jamoma::Address::parse("/" + name_));
        model_->set_description(std::string(static_cast<symbol>(description.get()).c_str()));
        model_->set_priority(static_cast<int>(priority.get()));
        jamoma::Registry::instance().contexts().add(patcher_, model_.get());
        jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
            jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
                if (model_) {
                    model_->init();
                }
            });
        });
        return {};
    }};

private:
    /** @return A name taken from the patcher's file name, without extensions, with dots replaced. */
    std::string patcher_name() const
    {
        std::string text = "model";
        if (patcher_ != nullptr) {
            c74::max::t_symbol* s = c74::max::jpatcher_get_name(const_cast<c74::max::t_object*>(static_cast<const c74::max::t_object*>(patcher_)));
            if (s != nullptr && s->s_name != nullptr && *s->s_name != '\0') {
                text = s->s_name;
            }
        }
        const std::string suffix = ".maxpat";
        if (text.size() > suffix.size() && text.compare(text.size() - suffix.size(), suffix.size(), suffix) == 0) {
            text.erase(text.size() - suffix.size());
        }
        for (char& c : text) {
            if (c == '.' || c == ' ' || c == '/') {
                c = '_';
            }
        }
        return text;
    }

};

MIN_EXTERNAL(j_model);
