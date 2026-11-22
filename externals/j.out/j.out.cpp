// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.out.cpp
 * @brief j.out (data): the way a model sends data out. Values pass through, and the last one is visible in the namespace.
 *
 * The object registers a node `data/out.<instance>` in its model (a `Data` of type generic that holds the last value, so `j.receive` can
 * follow it). Attributes `mute` (nothing passes), `freeze` (the last value is output again instead of the new one), `mix` and `gain`
 * (stored only: they act on audio, which is not built yet). See docs/inventory/j.in-j.out.md for what is and is not done.
 */

#include <atomic>
#include <memory>
#include <mutex>
#include <string>

#include "c74_min.h"

#include "jamoma/data.hpp"
#include "jamoma/registry.hpp"
#include "max_address.hpp"

using namespace c74::min;

/** The j.out external. */
class j_out : public c74::min::object<j_out> {
    // State comes before the attributes: Min runs every attribute setter with its default while constructing them.
    jamoma::Data node_{jamoma::Service::Return};   /**< The node in the namespace: holds the last value. */
    jamoma::Subscription subscription_;            /**< Its registration. */
    std::string instance_ = "1";                   /**< The instance (the creation argument). */
    mutable std::mutex mutex_;                     /**< Guards `last_`. */
    jamoma::Value last_;                           /**< The last value that was not frozen out. */
    jamoma_max::Alive alive_;                      /**< Lets deferred calls see that the object is gone. */
    std::atomic<int> mute_{0};                     /**< Copy of the mute attribute that pass() reads (values arrive on any thread). */
    std::atomic<int> freeze_{0};                   /**< Copy of the freeze attribute that pass() reads. */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object. @param args The creation atoms: an optional instance number, then attributes. */
    explicit j_out(const atoms& args = {})
    {
        if (c74::min::dummy()) {
            return; // the instance Min builds during class setup has no Max object
        }
        if (!args.empty() && args[0].type() != message_type::symbol_argument) {
            instance_ = std::to_string(static_cast<int>(args[0]));
        }
        jamoma_max::defer_call(maxobj(), alive_.weak(), [this] { join_model(); });
    }

    /** Unsubscribes before the members go. */
    ~j_out() override { subscription_ = jamoma::Subscription(); }

    inlet<> input{this, "(anything) data to send out of the model"};   /**< The inlet. */
    jamoma_max::dump_outlet data_out{this, "(anything) the data"};     /**< Outlet 0. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump"};         /**< Outlet 1: the dump outlet. */

    /** When on, nothing passes. */
    attribute<int> mute{this, "mute", 0, setter{MIN_FUNCTION {
        mute_.store(static_cast<int>(args[0]));
        return args;
    }}};
    /** When on, the last value is output again instead of the new one. */
    attribute<int> freeze{this, "freeze", 0, setter{MIN_FUNCTION {
        freeze_.store(static_cast<int>(args[0]));
        return args;
    }}};
    attribute<double> mix{this, "mix", 100.0};       /**< Stored only (audio). */
    attribute<double> gain{this, "gain", 100.0};     /**< Stored only (audio). */

    /** After construction: registers the dump outlet. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        return {};
    }};

    /** A bang passes. */
    message<threadsafe::yes> bang{this, "bang", MIN_FUNCTION {
        pass(jamoma::Value{});
        return {};
    }};
    /** An integer passes. */
    message<threadsafe::yes> m_int{this, "int", MIN_FUNCTION {
        pass(jamoma_max::to_value(args));
        return {};
    }};
    /** A float passes. */
    message<threadsafe::yes> m_float{this, "float", MIN_FUNCTION {
        pass(jamoma_max::to_value(args));
        return {};
    }};
    /** A list passes. */
    message<threadsafe::yes> m_list{this, "list", MIN_FUNCTION {
        pass(jamoma_max::to_value(args));
        return {};
    }};
    /** Any other message passes, or sets an attribute by name (`mute 1`). */
    message<threadsafe::yes> m_anything{this, "anything", MIN_FUNCTION {
        atoms message = args;
        if (message.size() >= 2 && static_cast<symbol>(message[0]) == symbol("symbol")) {
            message.erase(message.begin());
        }
        const std::string selector = static_cast<symbol>(message[0]).c_str();
        if (message.size() >= 2 && (selector == "mute" || selector == "freeze" || selector == "mix" || selector == "gain")) {
            // Setting a Min attribute is for the main thread (its setter and Max's notifications run there).
            const double number = static_cast<double>(message[1]);
            jamoma_max::run_on_main(maxobj(), alive_.weak(), [this, selector, number] {
                if (selector == "mute") {
                    mute = static_cast<int>(number);
                } else if (selector == "freeze") {
                    freeze = static_cast<int>(number);
                } else if (selector == "mix") {
                    mix = number;
                } else {
                    gain = number;
                }
            });
        } else {
            pass(jamoma_max::to_value(message));
        }
        return {};
    }};

    /** Class setup: nothing to add. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION { return {}; }};

private:
    /** Registers the node below the model of the patcher (or at the root without one). */
    void join_model()
    {
        const jamoma::Model* model = jamoma_max::find_model(maxobj());
        const std::string prefix = model != nullptr ? model->address().str() : std::string();
        subscription_ = jamoma::Subscription();
        subscription_ = jamoma::Registry::instance().names().subscribe(jamoma::Address::parse(prefix + "/data/out." + instance_), node_);
    }

    /** Sends a value out of the model unless muted; a frozen output repeats the last value. @param in The incoming value. */
    void pass(const jamoma::Value& in)
    {
        if (mute_.load() != 0) {
            return;
        }
        jamoma::Value out = in;
        {
            std::lock_guard<std::mutex> lock(mutex_);
            if (freeze_.load() != 0) {
                out = last_;
            } else {
                last_ = in;
            }
        }
        jamoma_max::output_value(data_out.max_outlet(), out);
        if (!out.empty()) {
            node_.command(out);
        }
    }
};

MIN_EXTERNAL(j_out);
