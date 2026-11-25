// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.node.cpp
 * @brief j.node: declares a node below the model that holds no value, so that its priority orders the initialisation of what is below it.
 *
 * The node is a core `Model` registered at `<model>/<name>` (not in the patcher-to-model map, so it is not the model of any patcher):
 * `Model::init` orders a model among its siblings by its priority and initialises what is below it at its place. It follows the model of the
 * patcher coming and going.
 */

#include <memory>
#include <string>

#include "c74_min.h"

#include "jamoma/model.hpp"
#include "jamoma/registry.hpp"
#include "max_context.hpp"

using namespace c74::min;

/** The j.node external. */
class j_node : public c74::min::object<j_node> {
    // State comes before the attributes: Min runs every attribute setter with its default while constructing them.
    std::string name_;                       /**< The name of the node. */
    std::string prefix_;                     /**< The address of the model the node sits below (empty: at the root). */
    std::unique_ptr<jamoma::Model> node_;    /**< The node. */
    jamoma_max::Alive alive_;                /**< Lets deferred calls see that the object is gone. */
    jamoma_max::ContextWatch watch_;         /**< Moves the node when the model of the patcher appears, is replaced or goes. */
    bool placing_ = false;                   /**< True while place() runs. */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object. @param args The creation atoms: the name of the node, then attributes. */
    explicit j_node(const atoms& args = {})
    {
        if (c74::min::dummy()) {
            return; // the instance Min builds during class setup has no Max object
        }
        if (!args.empty() && args[0].type() == message_type::symbol_argument) {
            const std::string first = static_cast<symbol>(args[0]).c_str();
            if (!first.empty() && first[0] != '@') {
                name_ = first;
            }
        }
        if (name_.empty()) {
            name_ = "node";
        }
        jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
            place();
            watch_.start([this] { place(); });
        });
    }

    /** Stops watching before the node goes. */
    ~j_node() override
    {
        watch_.stop();
        node_.reset();
    }

    inlet<> input{this, "(dump) report the attributes"};     /**< The inlet. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump"}; /**< Outlet 0: the dump outlet. */

    /** The description of the node. */
    attribute<symbol> description{this, "description", "", setter{MIN_FUNCTION {
        if (node_) {
            node_->set_description(std::string(static_cast<symbol>(args[0]).c_str()));
        }
        return args;
    }}};

    /** The priority of the node among its siblings, which orders the initialisation of what is below it. */
    attribute<int> priority{this, "priority", 0, setter{MIN_FUNCTION {
        if (node_) {
            node_->set_priority(static_cast<int>(args[0]));
        }
        return args;
    }}};

    /** The tags of the node (accepted so that old patchers load; no effect). */
    attribute<symbol> tags{this, "tags", ""};

    /** After construction: registers the outlet as the dumpout. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        return {};
    }};

    /** Answers the attributes on the dump outlet. */
    message<> dump{this, "dump", MIN_FUNCTION {
        const auto answer = [this](const char* name, const atoms& values) {
            c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym(name), static_cast<short>(values.size()),
                                      values.empty() ? nullptr : const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&values[0])));
        };
        answer("description", atoms{description.get()});
        answer("priority", atoms{priority.get()});
        answer("tags", atoms{tags.get()});
        return {};
    }};

    /** Class setup: nothing to add. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION { return {}; }};

private:
    /** Creates the node below the model of the patcher, or again if that model changed. */
    void place()
    {
        if (placing_) {
            return;
        }
        const jamoma::Model* model = jamoma_max::find_model(maxobj());
        const std::string prefix = model != nullptr ? model->address().str() : std::string();
        if (node_ && prefix == prefix_) {
            return;
        }
        placing_ = true;
        node_.reset();
        prefix_ = prefix;
        node_ = std::make_unique<jamoma::Model>(jamoma::Registry::instance().names(), jamoma::Address::parse(prefix + "/" + name_));
        node_->set_description(std::string(static_cast<symbol>(description.get()).c_str()));
        node_->set_priority(static_cast<int>(priority.get()));
        placing_ = false;
    }
};

MIN_EXTERNAL(j_node);
