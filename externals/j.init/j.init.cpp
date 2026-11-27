// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.init.cpp
 * @brief j.init: sends a bang when a model starts initialising (left outlet) and when it is done (right outlet).
 *
 * Without an argument it is the model of its patcher; with a relative address (`j.init sub_model`) the model there. It follows that model
 * when it is replaced, as when a model moves below the model of the surrounding patcher while the patch loads.
 * If the model is already initialised when j.init first binds to it, the right outlet bangs at once.
 */

#include <memory>
#include <string>

#include "c74_min.h"

#include "jamoma/model.hpp"
#include "jamoma/registry.hpp"
#include "max_address.hpp"
#include "max_context.hpp"

using namespace c74::min;

/** The j.init external. */
class j_init : public c74::min::object<j_init> {
public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object and schedules the binding to the model (once the patcher has loaded). @param args An optional relative address. */
    explicit j_init(const atoms& args = {})
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
        jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
            bind(true);
            watch_.start([this] { bind(false); });
        });
    }

    /** Stops watching and listening before the outlets go. */
    ~j_init() override
    {
        watch_.stop();
        observer_.reset();
    }

    inlet<> input{this, "(anything) unused"};                     /**< The inlet. */
    outlet<> start_out{this, "(bang) initialisation starts"};     /**< Outlet 0. */
    outlet<> end_out{this, "(bang) initialisation finished"};     /**< Outlet 1. */

private:
    /** @return The model this object is about, or null while there is none. */
    jamoma::Model* wanted()
    {
        if (text_.empty()) {
            return jamoma_max::find_model(maxobj());
        }
        jamoma::Node* node = jamoma::Registry::instance().names().lookup(jamoma_max::resolve_in_patcher(maxobj(), text_));
        return node != nullptr ? dynamic_cast<jamoma::Model*>(node->object()) : nullptr;
    }

    /**
     * Listens to the model's initialisation state, if the model is another one than before.
     * @param first True for the first binding, which also reports a model that is initialised already.
     */
    void bind(bool first)
    {
        jamoma::Model* model = wanted();
        if (model == bound_ && !first) {
            return;
        }
        observer_.reset();
        bound_ = model;
        if (model == nullptr) {
            return;
        }
        quiet_ = !first; // an observer of an initialised model is told so at once: only the first binding passes that on
        observer_ = model->on_init_changed([this](bool done) {
            if (quiet_) {
                return;
            }
            if (done) {
                end_out.send("bang");
            } else {
                start_out.send("bang");
            }
        });
        quiet_ = false;
    }

    std::string text_;                     /**< The relative address of the model, or empty for the model of the patcher. */
    jamoma::Model* bound_ = nullptr;       /**< The model listened to (compared only, never followed). */
    bool quiet_ = false;                   /**< True while a report is to be dropped. */
    std::shared_ptr<void> observer_;       /**< Keeps the observer registered. */
    jamoma_max::ContextWatch watch_;       /**< Binds again when a model appears, goes or moves. */
    jamoma_max::Alive alive_;              /**< Lets the deferred call see that the object is gone. */
};

MIN_EXTERNAL(j_init);
