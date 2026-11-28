// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.remote_array.cpp
 * @brief j.remote_array: a j.remote for every instance of a bracketed name, such as `function/parameters.[2]`.
 *
 * A value in the left inlet goes to the selected instances (the right inlet or `array/select` selects: a number from 1, or `*`), `array <list>` is cut into one
 * part per instance, `set` and `setArray` are the same without output here. For every change of a node the number of the instance comes out of the third
 * outlet, then the value out of the second, and later (from the low-priority queue) `set <value>`, or `setlist <list>` in array format, out of the left one.
 * Behaviour: docs/inventory/j.array.md. `highlight` is accepted and has no effect.
 */

#include <deque>
#include <memory>
#include <string>
#include <utility>

#include "c74_min.h"

#include "jamoma/registry.hpp"
#include "jamoma/remote_array.hpp"
#include "max_address.hpp"
#include "max_atoms.hpp"
#include "max_context.hpp"
#include "max_queries.hpp"

using namespace c74::min;

/** The j.remote_array external. */
class j_remote_array : public c74::min::object<j_remote_array> {
    // State comes before the attributes: Min runs every attribute setter with its default while constructing them.
    std::unique_ptr<jamoma::RemoteArray> array_;               /**< The remotes (reset first in the destructor, before the outlets go). */
    std::string text_;                                         /**< The bracketed name as written. */
    bool ready_ = false;                                       /**< True once the patcher has loaded and names may be resolved. */
    std::deque<std::pair<bool, jamoma::Value>> for_ui_;        /**< What still has to leave the `set` outlet: whether it is a list, and the value. */
    jamoma_max::Alive alive_;                                  /**< Lets deferred calls see that the object is gone. */
    jamoma_max::ContextWatch watch_;                           /**< Binds again when the model of the patcher appears, is replaced or goes. */
    jamoma_max::Settle settle_;                                /**< Lets a burst of such changes be dealt with once, when it is over. */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object. @param args The creation atoms: an optional bracketed name, then attributes. */
    explicit j_remote_array(const atoms& args = {})
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
        array_ = std::make_unique<jamoma::RemoteArray>(jamoma::Registry::instance().names(),
                                                       [this](std::size_t index, const jamoma::Value& v) { show(index, v); });
        jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
            ready_ = true;
            bind();
            watch_.start([this] {
                settle_.request(maxobj(), alive_.weak(), [this] {
                    if (array_) {
                        array_->rebind();
                    }
                });
            });
        });
    }

    /** Unbinds before the outlets are destroyed. */
    ~j_remote_array() override
    {
        watch_.stop();
        array_.reset();
    }

    inlet<> input{this, "(anything) value from the UI object"};                                    /**< Inlet 0. */
    inlet<> index_in{this, "(int or *) the instance to address, * for all"};                       /**< Inlet 1. */
    jamoma_max::dump_outlet set_out{this, "(set <value>) what a UI object should show"};           /**< Outlet 0: `set` or `setlist`. */
    jamoma_max::dump_outlet value_out{this, "(anything) the value"};                               /**< Outlet 1: the value. */
    jamoma_max::dump_outlet index_out{this, "(int) the instance"};                                 /**< Outlet 2: the number of the instance. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump"};                                     /**< Outlet 3: the dump outlet. */

    /** The bracketed name, relative to the model or view of the patcher, or absolute. */
    attribute<symbol> address{this, "address", "", setter{MIN_FUNCTION {
        const std::string name = static_cast<symbol>(args[0]).c_str();
        if (array_ && !name.empty()) {
            jamoma_max::run_on_main(maxobj(), alive_.weak(), [this, name] {
                if (name != text_ || (ready_ && array_ && array_->name() != name)) {
                    text_ = name;
                    bind();
                }
            });
        }
        return args;
    }}, getter{MIN_GETTER_FUNCTION {
        return atoms{symbol(text_)}; // also when it came as the argument
    }}};

    /** The unit the UI object works in (empty: the node's own). */
    attribute<symbol> unit{this, "unit", "", setter{MIN_FUNCTION {
        if (array_) {
            array_->set_unit(static_cast<symbol>(args[0]).c_str());
        }
        return args;
    }}};

    /** Whether the remotes work at all. */
    attribute<int> active{this, "active", 1, style::onoff, setter{MIN_FUNCTION {
        if (array_) {
            array_->set_active(static_cast<int>(args[0]) != 0);
        }
        return args;
    }}};

    /** Whether changes of the nodes are kept from the UI object. */
    attribute<int> freeze{this, "freeze", 0, style::onoff, setter{MIN_FUNCTION {
        if (array_) {
            array_->set_freeze(static_cast<int>(args[0]) != 0);
        }
        return args;
    }}};

    /** What the outlets carry: the value of the instance that changed (`single`), or the values of all (`array`). */
    attribute<symbol> format{this, "format", "single", range{"single", "array"}, setter{MIN_FUNCTION {
        if (array_) {
            array_->set_format(static_cast<symbol>(args[0]) == symbol("array") ? jamoma::ArrayFormat::Array : jamoma::ArrayFormat::Single);
        }
        return args;
    }}};

    /** Accepted so that old patchers load; it has no effect. */
    attribute<int> highlight{this, "highlight", 1, style::onoff};

    /** After construction: registers the last outlet as the dumpout. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        return {};
    }};

    /** A bang makes the selected nodes output their values. */
    message<threadsafe::yes> bang{this, "bang", MIN_FUNCTION {
        if (inlet == 0) {
            send(jamoma::Value{}, false);
        }
        return {};
    }};

    /** An integer goes to the nodes, or in the right inlet selects. */
    message<threadsafe::yes> m_int{this, "int", MIN_FUNCTION {
        value_or_index(args, inlet);
        return {};
    }};

    /** A float goes to the nodes, or in the right inlet selects. */
    message<threadsafe::yes> m_float{this, "float", MIN_FUNCTION {
        value_or_index(args, inlet);
        return {};
    }};

    /** A list goes to the nodes; in the right inlet its first item selects. */
    message<threadsafe::yes> m_list{this, "list", MIN_FUNCTION {
        value_or_index(args, inlet);
        return {};
    }};

    /** Cuts a list into one part for each instance. */
    message<threadsafe::yes> m_array{this, "array", MIN_FUNCTION {
        send_array(jamoma_max::to_value(args), false);
        return {};
    }};

    /** Selects the instance that values go to (as the right inlet). */
    message<threadsafe::yes> array_select{this, "array/select", MIN_FUNCTION {
        select(jamoma_max::to_value(args));
        return {};
    }};

    /** Changes the number of instances. */
    message<threadsafe::yes> array_resize{this, "array/resize", MIN_FUNCTION {
        if (args.empty()) {
            return {};
        }
        if (args[0].type() != message_type::int_argument && args[0].type() != message_type::float_argument) {
            c74::max::object_error(maxobj(), "array/resize needs a number (the array is left as it is)");
            return {};
        }
        const long size = static_cast<long>(args[0]);
        jamoma_max::run_on_main(maxobj(), alive_.weak(), [this, size] {
            if (!array_) {
                return;
            }
            const bool possible = size >= 0 && static_cast<std::size_t>(size) <= jamoma::kMaxArraySize;
            if (!ready_) { // not bound yet (a loadbang): the name as written takes the size
                const auto name = jamoma::parse_array_name(text_);
                if (possible && name) {
                    text_ = name->with_size(static_cast<std::size_t>(size));
                    return;
                }
            }
            if (!possible || !array_->resize(static_cast<std::size_t>(size))) {
                c74::max::object_error(maxobj(), "array/resize: %ld is not possible (a size from 0 to %d, once the array has a name)", size,
                                       static_cast<int>(jamoma::kMaxArraySize));
            }
        });
        return {};
    }};

    /** Answers the address and the format on the dump outlet. */
    message<> dump{this, "dump", MIN_FUNCTION {
        c74::max::t_atom a;
        c74::max::atom_setsym(&a, c74::max::gensym(array_ && !array_->name().empty() ? array_->name().c_str() : text_.c_str()));
        c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym("address"), 1, &a);
        c74::max::atom_setsym(&a, c74::max::gensym(array_ && array_->format() == jamoma::ArrayFormat::Array ? "array" : "single"));
        c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym("format"), 1, &a);
        return {};
    }};

    /**
     * Any other message: in the right inlet it selects (`*`); in the left one `set` and `setArray` send without output here, and any other
     * message is sent to the selected nodes as it is.
     */
    message<threadsafe::yes> m_anything{this, "anything", MIN_FUNCTION {
        atoms message = args;
        if (message.size() >= 2 && static_cast<symbol>(message[0]) == symbol("symbol")) {
            message.erase(message.begin());
        }
        if (message.empty()) {
            return {};
        }
        if (inlet == 1) {
            select(jamoma_max::to_value(message));
            return {};
        }
        const std::string selector = static_cast<symbol>(message[0]).c_str();
        const atoms rest(message.begin() + 1, message.end());
        if (selector == "set") {
            if (!rest.empty()) {
                send(jamoma_max::to_value(rest), true);
            }
        } else if (selector == "setArray") {
            send_array(jamoma_max::to_value(rest), true);
        } else {
            send(jamoma_max::to_value(message), false);
        }
        return {};
    }};

    /** Class setup: every attribute answers when its name is sent without a value, and to `get<name>`, as the old objects did. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION {
        jamoma_max::answer_queries<j_remote_array>(args[0], {"address", "unit", "active", "freeze", "format", "highlight"});
        jamoma_max::answer_get_messages(args[0], {"address", "unit", "active", "freeze", "format", "highlight"});
        return {};
    }};

private:
    /** Gives the array the name as written (once the patcher has loaded). */
    void bind()
    {
        if (!ready_ || !array_ || text_.empty()) {
            return;
        }
        if (!array_->set_name(text_, [this](const std::string& name) { return jamoma_max::resolve_in_patcher(maxobj(), name); })) {
            c74::max::object_error(maxobj(), "%s: needs a name with one size in brackets, at most [%d]", text_.c_str(),
                                   static_cast<int>(jamoma::kMaxArraySize));
        }
    }

    /** A number or list: a value in the left inlet, the instance in the right one. @param args The atoms. @param inlet The inlet. */
    void value_or_index(const atoms& args, int inlet)
    {
        if (inlet == 1) {
            select(jamoma_max::to_value(args));
        } else {
            send(jamoma_max::to_value(args), false);
        }
    }

    /** Selects an instance (on the main thread, so that it keeps its place among the values). @param which The number, or `*`, as the first item. */
    void select(const jamoma::Value& which)
    {
        jamoma_max::run_on_main(maxobj(), alive_.weak(), [this, which] {
            if (array_ && !which.empty() && !array_->select(which[0])) {
                c74::max::object_error(maxobj(), "array/select: %s is not a valid index", which[0].as_symbol().c_str());
            }
        });
    }

    /** Sends to the selected nodes on the main thread. @param v The value (empty for a bang). @param silent Whether nothing is shown here. */
    void send(const jamoma::Value& v, bool silent)
    {
        jamoma_max::run_on_main(maxobj(), alive_.weak(), [this, v, silent] {
            if (array_ && !(silent ? array_->set(v) : array_->from_ui(v))) {
                c74::max::object_error(maxobj(), "the array is empty");
            }
        });
    }

    /** Sends a list in parts on the main thread. @param v The list. @param silent Whether nothing is shown here. */
    void send_array(const jamoma::Value& v, bool silent)
    {
        jamoma_max::run_on_main(maxobj(), alive_.weak(), [this, v, silent] {
            if (array_ && !(silent ? array_->set_array(v) : array_->array(v))) {
                c74::max::object_error(maxobj(), "array: the length of the list has to be a multiple of the size (%d)", static_cast<int>(array_->size()));
            }
        });
    }

    /** Shows a value, on the main thread. @param index The instance. @param v The value. */
    void show(std::size_t index, const jamoma::Value& v)
    {
        jamoma_max::run_on_main(maxobj(), alive_.weak(), [this, index, v] { output(index, v); });
    }

    /**
     * The index, then the value, and a place in the queue of the `set` outlet. Nothing follows the index if what it set off removed the
     * instance or freed the object.
     * @param index The instance. @param v The value.
     */
    void output(std::size_t index, const jamoma::Value& v)
    {
        if (!array_) {
            return;
        }
        const std::weak_ptr<int> alive = alive_.weak();
        const std::uint64_t instance = array_->identity(index);
        c74::max::outlet_int(index_out.max_outlet(), static_cast<c74::max::t_atom_long>(index));
        if (alive.expired() || !array_ || array_->identity(index) != instance) {
            return;
        }
        const bool list = array_->format() == jamoma::ArrayFormat::Array;
        const bool queued = !for_ui_.empty();
        for_ui_.emplace_back(list, v);
        if (!queued) {
            jamoma_max::defer_call(maxobj(), alive_.weak(), [this] { flush(); });
        }
        jamoma_max::output_value(value_out.max_outlet(), v);
    }

    /** Sends what is queued out of the `set` outlet, in order (`set bang` for a bang). */
    void flush()
    {
        const std::weak_ptr<int> alive = alive_.weak();
        while (!alive.expired() && !for_ui_.empty()) {
            const auto [list, value] = std::move(for_ui_.front());
            for_ui_.pop_front();
            std::vector<c74::max::t_atom> out;
            for (const jamoma::Atom& a : value) {
                out.emplace_back();
                if (a.is_int()) {
                    c74::max::atom_setlong(&out.back(), static_cast<c74::max::t_atom_long>(a.as_int()));
                } else if (a.is_float()) {
                    c74::max::atom_setfloat(&out.back(), a.as_double());
                } else {
                    c74::max::atom_setsym(&out.back(), c74::max::gensym(a.as_symbol().c_str()));
                }
            }
            if (out.empty()) {
                out.emplace_back();
                c74::max::atom_setsym(&out.back(), c74::max::gensym("bang"));
            }
            c74::max::outlet_anything(set_out.max_outlet(), c74::max::gensym(list ? "setlist" : "set"), static_cast<short>(out.size()), out.data());
        }
    }
};

MIN_EXTERNAL(j_remote_array);
