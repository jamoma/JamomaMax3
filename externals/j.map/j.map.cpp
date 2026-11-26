// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.map.cpp
 * @brief j.map: maps numbers (and, bound to two parameters, the values of one parameter onto another): y = f(x).
 *
 * Outlets from the left: the mapped values, the dump outlet (which also tells `input/going/down`, `input/going/up`, `output/going/down` and
 * `output/going/up`). The work is done by jamoma::Mapper (core/include/jamoma/mapper.hpp) and the function library
 * (core/include/jamoma/function_library.hpp); this file translates Max messages and attributes. The parameters of the current function
 * (`base`, `power/value`, ...) are set by message. `int`, `float` and `list` are handled on the thread they arrive on (main or scheduler) and the outlets
 * answer on that thread at once; the writing to the output parameter is handed to the main thread. Attributes and other messages run on the main thread.
 */

#include <algorithm>
#include <cctype>
#include <functional>
#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "c74_min.h"

#include "jamoma/function_library.hpp"
#include "jamoma/mapper.hpp"
#include "jamoma/registry.hpp"
#include "max_address.hpp"
#include "max_atoms.hpp"
#include "max_context.hpp"

using namespace c74::min;

/** The j.map external. */
class j_map : public c74::min::object<j_map> {
    // State comes before the attributes: Min runs every attribute setter with its default while constructing them.
    jamoma::Mapper mapper_{jamoma::Registry::instance().names()};  /**< The mapper. */
    std::string input_text_;                                       /**< The input address as written. */
    std::string output_text_;                                      /**< The output address as written. */
    std::vector<std::pair<std::string, atoms>> creation_;          /**< The attributes given at creation (`reset` applies them again). */
    bool ready_ = false;                                           /**< True once the patcher has loaded and the addresses may be resolved. */
    jamoma_max::Alive alive_;                                      /**< Lets deferred calls see that the object is gone. */
    jamoma_max::ContextWatch watch_;                               /**< Binds again when the model of the patcher appears, is replaced or goes. */
    jamoma_max::Settle settle_;                                    /**< Lets a burst of such changes be dealt with once. */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object. @param args The creation atoms: attributes. */
    explicit j_map(const atoms& args = {})
    {
        if (c74::min::dummy()) {
            return; // the instance Min builds during class setup has no Max object
        }
        for (const auto& a : args) {
            if (a.type() == message_type::symbol_argument && static_cast<symbol>(a).c_str()[0] == '@') {
                creation_.emplace_back(std::string(static_cast<symbol>(a).c_str() + 1), atoms{});
            } else if (!creation_.empty()) {
                creation_.back().second.push_back(a);
            }
        }
        // writing to the output parameter belongs to the main thread; the outlets are served on the thread that brought the value
        mapper_.set_send_dispatcher([this](std::function<void()> work) { jamoma_max::run_on_main(maxobj(), alive_.weak(), std::move(work)); });
        mapper_.set_return([this](const jamoma::Value& v) { report_value(v); });
        mapper_.set_threshold_callback([this](std::string_view name, bool state) { report_threshold(std::string(name), state); });
        jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
            ready_ = true;
            rebind();
            watch_.start([this] { settle_.request(maxobj(), alive_.weak(), [this] { follow(); }); });
        });
    }

    /** Unbinds before the outlets are destroyed. */
    ~j_map() override { watch_.stop(); }

    inlet<> input_inlet{this, "(number or list) values to map"};                     /**< The inlet. */
    jamoma_max::dump_outlet data_out{this, "(anything) mapped values"};              /**< Outlet 0. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump"};                       /**< Outlet 1: the dump outlet. */

    /** The address of the parameter (or return) to listen to. */
    attribute<symbol> input{this, "input", "", setter{MIN_FUNCTION {
        input_text_ = std::string(static_cast<symbol>(args[0]).c_str());
        rebind();
        return args;
    }}};

    /** The address of the parameter (or message) to send the mapped values to. */
    attribute<symbol> output{this, "output", "", setter{MIN_FUNCTION {
        output_text_ = std::string(static_cast<symbol>(args[0]).c_str());
        rebind();
        return args;
    }}};

    /** The low end of the input range (set by hand, the range of a bound parameter is no longer followed). */
    attribute<double> input_min{this, "input/min", 0.0, setter{MIN_FUNCTION {
        if (static_cast<double>(args[0]) != mapper_.settings().input_min)
            mapper_.set_input_min(args[0]);
        return atoms{mapper_.settings().input_min};
    }}};
    /** The high end of the input range. */
    attribute<double> input_max{this, "input/max", 1.0, setter{MIN_FUNCTION {
        if (static_cast<double>(args[0]) != mapper_.settings().input_max)
            mapper_.set_input_max(args[0]);
        return atoms{mapper_.settings().input_max};
    }}};
    /** The low end of the output range. */
    attribute<double> output_min{this, "output/min", 0.0, setter{MIN_FUNCTION {
        if (static_cast<double>(args[0]) != mapper_.settings().output_min)
            mapper_.set_output_min(args[0]);
        return atoms{mapper_.settings().output_min};
    }}};
    /** The high end of the output range. */
    attribute<double> output_max{this, "output/max", 1.0, setter{MIN_FUNCTION {
        if (static_cast<double>(args[0]) != mapper_.settings().output_max)
            mapper_.set_output_max(args[0]);
        return atoms{mapper_.settings().output_max};
    }}};

    /** Which item of a list is mapped (0 = all items). */
    attribute<int> input_index{this, "input/index", 0, setter{MIN_FUNCTION {
        mapper_.set_input_index(static_cast<unsigned>(std::max(0, static_cast<int>(args[0]))));
        return args;
    }}};

    /** The input counts as going down at or below this value. */
    attribute<double> input_threshold_down{this, "input/threshold/down", 0.0, setter{MIN_FUNCTION {
        mapper_.set_input_threshold_down(args[0]);
        return args;
    }}};
    /** The input counts as going up at or above this value. */
    attribute<double> input_threshold_up{this, "input/threshold/up", 1.0, setter{MIN_FUNCTION {
        mapper_.set_input_threshold_up(args[0]);
        return args;
    }}};
    /** The output counts as going down at or below this value. */
    attribute<double> output_threshold_down{this, "output/threshold/down", 0.0, setter{MIN_FUNCTION {
        mapper_.set_output_threshold_down(args[0]);
        return args;
    }}};
    /** The output counts as going up at or above this value. */
    attribute<double> output_threshold_up{this, "output/threshold/up", 1.0, setter{MIN_FUNCTION {
        mapper_.set_output_threshold_up(args[0]);
        return args;
    }}};

    /** Whether the mapping is on. */
    attribute<int> active{this, "active", 1, setter{MIN_FUNCTION {
        mapper_.set_active(static_cast<int>(args[0]) != 0);
        return args;
    }}};

    /** What happens to an input outside the input range: none, low, high or both. */
    attribute<symbol> clipmode{this, "clipmode", "none", range{"none", "low", "high", "both"}, setter{MIN_FUNCTION {
        const std::string v = static_cast<symbol>(args[0]).c_str();
        mapper_.set_clipmode(v == "low" ? jamoma::MapperClip::Low : v == "high" ? jamoma::MapperClip::High : v == "both" ? jamoma::MapperClip::Both : jamoma::MapperClip::None);
        return args;
    }}};

    /** Whether the curve is flipped. */
    attribute<int> inverse{this, "inverse", 0, setter{MIN_FUNCTION {
        mapper_.set_inverse(static_cast<int>(args[0]) != 0);
        return args;
    }}};

    /** A ramp time in milliseconds for the values sent to the output parameter. */
    attribute<int> ramp{this, "ramp", 0, setter{MIN_FUNCTION {
        mapper_.set_ramp(std::max(0, static_cast<int>(args[0])));
        return args;
    }}};

    /** The function: one of function/library (an unknown name is refused and the previous function stays). */
    attribute<symbol> function{this, "function", "", setter{MIN_FUNCTION {
        const std::string name = static_cast<symbol>(args[0]).c_str();
        if (name.empty() || name == mapper_.function())
            return atoms{symbol(mapper_.function())};
        if (!mapper_.set_function(name)) {
            c74::max::object_error(maxobj(), "%s is not a function (see function/library)", name.c_str());
            return atoms{symbol(mapper_.function())};
        }
        return args;
    }}};

    /** The names of the functions (read only). */
    attribute<symbol> function_library{this, "function/library", "", getter{MIN_GETTER_FUNCTION {
        atoms names;
        for (const auto& n : jamoma::function_names())
            names.push_back(symbol(n));
        return names;
    }}, setter{MIN_FUNCTION { return atoms{symbol("")}; }}};

    /** The parameters of the current function (read only): `none` if it has none. */
    attribute<symbol> function_parameters{this, "function/parameters", "", getter{MIN_GETTER_FUNCTION {
        atoms names;
        for (const auto& n : mapper_.function_parameters())
            names.push_back(symbol(max_name(n)));
        if (names.empty())
            names.push_back(symbol("none"));
        return names;
    }}, setter{MIN_FUNCTION { return atoms{symbol("")}; }}};

    /** The curve (read only): 100 outputs for inputs spread over the input range. */
    attribute<symbol> function_samples{this, "function/samples", "", getter{MIN_GETTER_FUNCTION {
        atoms samples;
        for (double d : mapper_.samples(100))
            samples.push_back(d);
        return samples;
    }}, setter{MIN_FUNCTION { return atoms{symbol("")}; }}};

    /** After construction: registers the last outlet as the dumpout. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        return {};
    }};

    /** A number to map. */
    message<threadsafe::yes> m_int{this, "int", MIN_FUNCTION {
        mapper_.process(jamoma_max::to_value(args));
        return {};
    }};
    /** A number to map. */
    message<threadsafe::yes> m_float{this, "float", MIN_FUNCTION {
        mapper_.process(jamoma_max::to_value(args));
        return {};
    }};
    /** A list to map: every number of it, or the item that `input/index` picks. */
    message<threadsafe::yes> m_list{this, "list", MIN_FUNCTION {
        mapper_.process(jamoma_max::to_value(args));
        return {};
    }};

    /** Applies the attributes of the creation again. */
    message<> reset{this, "reset", MIN_FUNCTION {
        for (const auto& item : creation_) {
            const atoms& values = item.second;
            c74::max::object_attr_setvalueof(maxobj(), c74::max::gensym(item.first.c_str()), static_cast<long>(values.size()),
                                             values.empty() ? nullptr : const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&values[0])));
        }
        mapper_.reset();
        return {};
    }};

    /** Answers the attributes on the dump outlet. */
    message<> dump{this, "dump", MIN_FUNCTION {
        for (const char* name : {"input", "output", "input/min", "input/max", "output/min", "output/max", "input/index", "input/threshold/down", "input/threshold/up",
                                 "output/threshold/down", "output/threshold/up", "active", "clipmode", "inverse", "ramp", "function", "function/library",
                                 "function/parameters", "function/samples"}) {
            c74::max::t_atom* av = nullptr;
            long ac = 0;
            if (c74::max::object_attr_getvalueof(maxobj(), c74::max::gensym(name), &ac, &av) == c74::max::MAX_ERR_NONE && av != nullptr) {
                c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym(name), static_cast<short>(ac), av);
                c74::max::sysmem_freeptr(av);
            }
        }
        return {};
    }};

    /** `<attribute> <value...>` sets the attribute, `<parameter> <value>` sets a parameter of the current function. */
    message<> m_anything{this, "anything", MIN_FUNCTION {
        atoms message = args;
        if (message.size() >= 2 && static_cast<symbol>(message[0]) == symbol("symbol")) {
            message.erase(message.begin());
        }
        if (message.size() < 2) {
            return {};
        }
        const std::string selector = static_cast<symbol>(message[0]).c_str();
        c74::max::t_atom* rest = const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&message[1]));
        if (c74::max::object_attr_get(maxobj(), c74::max::gensym(selector.c_str())) != nullptr) {
            c74::max::object_attr_setvalueof(maxobj(), c74::max::gensym(selector.c_str()), static_cast<long>(message.size() - 1), rest);
            return {};
        }
        for (const auto& parameter : mapper_.function_parameters()) {
            if (max_name(parameter) == selector) {
                atoms value(message.begin() + 1, message.end());
                if (!mapper_.set_function_parameter(parameter, jamoma_max::to_value(value)))
                    c74::max::object_error(maxobj(), "%s: value refused by %s", selector.c_str(), mapper_.function().c_str());
                return {};
            }
        }
        c74::max::object_error(maxobj(), "no attribute or function parameter called %s", selector.c_str());
        return {};
    }};

    /** Class setup: nothing to add; the base class registers the attributes. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION { return {}; }};

private:
    /** @param tt_name A name of the core (`powerValue`). @return The Max form: a slash before each capital (`power/value`). */
    static std::string max_name(const std::string& tt_name)
    {
        std::string out;
        for (char c : tt_name) {
            if (std::isupper(static_cast<unsigned char>(c))) {
                out += '/';
                out += static_cast<char>(std::tolower(static_cast<unsigned char>(c)));
            } else {
                out += c;
            }
        }
        return out;
    }

    /** Binds both ends to the addresses as written, resolved against the model of the patcher. */
    void rebind()
    {
        if (!ready_) {
            return;
        }
        mapper_.bind_input(input_text_.empty() ? jamoma::Address() : jamoma_max::resolve_in_patcher(maxobj(), input_text_));
        mapper_.bind_output(output_text_.empty() ? jamoma::Address() : jamoma_max::resolve_in_patcher(maxobj(), output_text_));
    }

    /** Binds again if the addresses now resolve to others than the ones bound (a model came or went). */
    void follow()
    {
        if (!ready_) {
            return;
        }
        const jamoma::Address in = input_text_.empty() ? jamoma::Address() : jamoma_max::resolve_in_patcher(maxobj(), input_text_);
        const jamoma::Address out = output_text_.empty() ? jamoma::Address() : jamoma_max::resolve_in_patcher(maxobj(), output_text_);
        if (in != mapper_.input())
            mapper_.bind_input(in);
        if (out != mapper_.output())
            mapper_.bind_output(out);
    }

    /** Outputs mapped values, on the thread that brought the input (the scheduler thread for a metro or a ramp). @param v The values. */
    void report_value(const jamoma::Value& v) { jamoma_max::output_value(data_out.max_outlet(), v); }

    /** Tells that a threshold was crossed, on the dump outlet, on the thread that brought the input. @param name The message. @param state The new state. */
    void report_threshold(const std::string& name, bool state)
    {
        c74::max::t_atom a;
        c74::max::atom_setlong(&a, state ? 1 : 0);
        c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym(name.c_str()), 1, &a);
    }
};

MIN_EXTERNAL(j_map);
