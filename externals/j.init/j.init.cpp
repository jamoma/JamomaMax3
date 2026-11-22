// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.init.cpp
 * @brief j.init: sends a bang when the model of its patcher starts initialising (left outlet) and when it is done (right outlet).
 *
 * If the model is already initialised when j.init binds to it, the right outlet bangs at once.
 */

#include <memory>

#include "c74_min.h"

#include "jamoma/model.hpp"
#include "max_context.hpp"

using namespace c74::min;

/** The j.init external. */
class j_init : public c74::min::object<j_init> {
public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object and schedules the binding to the model (once the patcher has loaded). @param args Unused. */
    explicit j_init(const atoms& args = {})
    {
        if (c74::min::dummy()) {
            return; // the instance Min builds during class setup has no Max object
        }
        jamoma_max::defer_call(maxobj(), alive_.weak(), [this] { bind(); });
        (void)args;
    }

    inlet<> input{this, "(anything) unused"};                     /**< The inlet. */
    outlet<> start_out{this, "(bang) initialisation starts"};     /**< Outlet 0. */
    outlet<> end_out{this, "(bang) initialisation finished"};     /**< Outlet 1. */

private:
    /** Finds the model and listens to its initialisation state. */
    void bind()
    {
        if (jamoma::Model* model = jamoma_max::find_model(maxobj())) {
            observer_ = model->on_init_changed([this](bool done) {
                if (done) {
                    end_out.send("bang");
                } else {
                    start_out.send("bang");
                }
            });
        }
    }

    std::shared_ptr<void> observer_;   /**< Keeps the observer registered. */
    jamoma_max::Alive alive_;          /**< Lets the deferred call see that the object is gone. */
};

MIN_EXTERNAL(j_init);
