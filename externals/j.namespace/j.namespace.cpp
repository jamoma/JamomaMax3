// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.namespace.cpp
 * @brief j.namespace: lists what is below an address of the namespace, formatted for a menu, a table or a coll, and keeps a selection of the items.
 *
 * Outlets from the left: the result, its size, the dump outlet. The work is done by jamoma::explore and jamoma::Selection
 * (core/include/jamoma/explore.hpp); this file translates Max messages and attributes. Everything runs on the main thread. Attributes: `address`,
 * `output` (descendants, children, brothers, attributes), `format` (none, umenu, umenu_prefix, jit.cellblock, coll), `relative`, `update`, `sort`,
 * `depth`, `namespace`; messages: `bang`/`explore`, an address, `select`, `select/all`, `select/none`, `selection/refresh`, `dump`. Filters are not built.
 */

#include <memory>
#include <string>
#include <vector>

#include "c74_min.h"

#include "jamoma/explore.hpp"
#include "jamoma/registry.hpp"
#include "max_address.hpp"
#include "max_atoms.hpp"
#include "max_context.hpp"
#include "max_queries.hpp"

using namespace c74::min;

/** The j.namespace external. */
class j_namespace : public c74::min::object<j_namespace> {
    // State comes before the attributes: Min runs every attribute setter with its default while constructing them.
    std::string address_text_;                         /**< The address as written. */
    jamoma::ExploreOptions options_;                   /**< Which items, in which order, how deep. */
    jamoma::ExploreFilters filters_;                   /**< The filters the listed nodes have to pass. */
    jamoma::ExploreFormat format_ = jamoma::ExploreFormat::None;  /**< How the result is told. */
    bool relative_ = false;                            /**< Whether relative addresses are taken relative to the model of the patcher. */
    bool update_ = true;                               /**< Whether a change of the namespace is explored again. */
    std::string selection_name_ = "none";              /**< The name of the shared selection. */
    std::shared_ptr<jamoma::Selection> selection_ = jamoma::Selection::named("none"); /**< The selection. */
    bool ready_ = false;                               /**< True once the patcher has loaded. */
    bool have_last_ = false;                           /**< Whether last_items_ holds what was sent last. */
    std::vector<std::string> last_items_;              /**< The items of the last result (an unchanged one is not sent again by an update). */
    jamoma::Address explored_;                         /**< The address that was explored last (the one the items belong to). */
    std::vector<std::shared_ptr<void>> watches_;       /**< The observers of the namespace. */
    jamoma_max::Alive alive_;                          /**< Lets deferred calls see that the object is gone. */
    jamoma_max::ContextWatch context_watch_;           /**< Explores again when the model of the patcher appears, is replaced or goes (relative addresses). */
    jamoma_max::Settle settle_;                        /**< Lets a burst of changes be dealt with once. */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object. @param args The creation atoms: an optional name of a shared selection, then attributes. */
    explicit j_namespace(const atoms& args = {})
    {
        if (c74::min::dummy()) {
            return; // the instance Min builds during class setup has no Max object
        }
        if (!args.empty() && args[0].type() == message_type::symbol_argument) {
            const std::string first = static_cast<symbol>(args[0]).c_str();
            if (!first.empty() && first[0] != '@') {
                set_selection(first);
            }
        }
        jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
            ready_ = true;
            start();
            context_watch_.start([this] { settle_.request(maxobj(), alive_.weak(), [this] { changed(false); }); });
        });
    }

    /** Stops watching before the outlets are destroyed. */
    ~j_namespace() override
    {
        context_watch_.stop();
        watches_.clear();
    }

    inlet<> input{this, "(anything) an address to explore, or a message"};          /**< The inlet. */
    jamoma_max::dump_outlet data_out{this, "(anything) the result of the exploration"}; /**< Outlet 0. */
    jamoma_max::dump_outlet size_out{this, "(int) the size of the result, after the result"}; /**< Outlet 1. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump"};                       /**< Outlet 2: the dump outlet. */

    /** The address to explore. */
    attribute<symbol> address{this, "address", "", setter{MIN_FUNCTION {
        address_text_ = std::string(static_cast<symbol>(args[0]).c_str());
        start();
        return args;
    }}};

    /** Which items are listed. */
    attribute<symbol> output{this, "output", "descendants", range{"descendants", "children", "brothers", "attributes"}, setter{MIN_FUNCTION {
        const std::string v = static_cast<symbol>(args[0]).c_str();
        options_.output = v == "children" ? jamoma::ExploreOutput::Children
                          : v == "brothers" ? jamoma::ExploreOutput::Brothers
                          : v == "attributes" ? jamoma::ExploreOutput::Attributes : jamoma::ExploreOutput::Descendants;
        start();
        return args;
    }}};

    /** How the result is told to the object after the outlet. */
    attribute<symbol> format{this, "format", "none", range{"none", "umenu", "umenu_prefix", "jit.cellblock", "coll"}, setter{MIN_FUNCTION {
        const std::string v = static_cast<symbol>(args[0]).c_str();
        format_ = v == "umenu" ? jamoma::ExploreFormat::Umenu
                  : v == "umenu_prefix" ? jamoma::ExploreFormat::UmenuPrefix
                  : v == "jit.cellblock" ? jamoma::ExploreFormat::JitCellblock
                  : v == "coll" ? jamoma::ExploreFormat::Coll : jamoma::ExploreFormat::None;
        return args;
    }}};

    /** Whether a relative address is taken relative to the model of the patcher. */
    attribute<int> relative{this, "relative", 0, style::onoff, setter{MIN_FUNCTION {
        relative_ = static_cast<int>(args[0]) != 0;
        start();
        return args;
    }}};

    /** Whether the result is sent again when the namespace changes. */
    attribute<int> update{this, "update", 1, style::onoff, setter{MIN_FUNCTION {
        update_ = static_cast<int>(args[0]) != 0;
        start();
        return args;
    }}};

    /** The order of the items. */
    attribute<symbol> sort{this, "sort", "alphabetic", range{"none", "alphabetic", "priority"}, setter{MIN_FUNCTION {
        const std::string v = static_cast<symbol>(args[0]).c_str();
        options_.sort = v == "none" ? jamoma::ExploreSort::None : v == "priority" ? jamoma::ExploreSort::Priority : jamoma::ExploreSort::Alphabetic;
        return args;
    }}};

    /** How many levels below the address are listed (0 = all). */
    attribute<int> depth{this, "depth", 0, setter{MIN_FUNCTION {
        const int d = static_cast<int>(args[0]);
        options_.depth = d > 0 ? static_cast<unsigned>(d) : 0u;
        start();
        return atoms{d > 0 ? d : 0};
    }}};

    /** The name of the selection that is shared with other objects (`none`: a selection of its own). */
    attribute<symbol> selection_attr{this, "namespace", "none", setter{MIN_FUNCTION {
        set_selection(std::string(static_cast<symbol>(args[0]).c_str()));
        return args;
    }}};

    /** After construction: registers the last outlet as the dumpout. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        return {};
    }};

    /** Explores and outputs the result. */
    message<> bang{this, "bang", MIN_FUNCTION {
        explore_and_output(true);
        return {};
    }};

    /** The same as bang. */
    message<> explore_message{this, "explore", MIN_FUNCTION {
        explore_and_output(true);
        return {};
    }};

    /** `select <item> [0|1]` switches or sets one item, `select 0 1 1 ...` sets every item; the selection is then told. */
    message<> select{this, "select", MIN_FUNCTION {
        if (args.empty()) {
            return {};
        }
        if (args[0].type() == message_type::symbol_argument) {
            const std::string item = static_cast<symbol>(args[0]).c_str();
            const std::string key = !item.empty() && item[0] == '/' ? item : jamoma::item_key(options_.output, explored_, item);
            if (args.size() >= 2 && args[1].type() != message_type::symbol_argument) {
                selection_->set(key, static_cast<int>(args[1]) != 0);
            } else {
                selection_->toggle(key);
            }
        } else if (args.size() == last_items_.size()) {
            for (std::size_t i = 0; i < args.size(); ++i) {
                selection_->set(jamoma::item_key(options_.output, explored_, last_items_[i]), static_cast<int>(args[i]) == 1);
            }
        } else {
            c74::max::object_error(maxobj(), "select needs an item, or one number for every item");
            return {};
        }
        output_selection();
        return {};
    }};

    /** Selects every listed item. */
    message<> selectall{this, "select/all", MIN_FUNCTION {
        for (const std::string& item : last_items_) {
            selection_->set(jamoma::item_key(options_.output, explored_, item), true);
        }
        output_selection();
        return {};
    }};

    /** Deselects every listed item. */
    message<> selectnone{this, "select/none", MIN_FUNCTION {
        for (const std::string& item : last_items_) {
            selection_->set(jamoma::item_key(options_.output, explored_, item), false);
        }
        output_selection();
        return {};
    }};

    /** `filter/set <name> <condition> <value> ...` makes or changes a filter and puts it in use; the next exploration applies it. */
    message<> filter_set{this, "filter/set", MIN_FUNCTION {
        if (!filters_.set(jamoma_max::to_value(args))) {
            c74::max::object_error(maxobj(), "filter/set needs a name and pairs of object, attribute, value, part, parent, name, instance or mode and a value");
        } else {
            clear_selection();
        }
        options_.filters = &filters_;
        return {};
    }};

    /** `filter/remove <name>` forgets one filter; without a name, every filter in use. */
    message<> filter_remove{this, "filter/remove", MIN_FUNCTION {
        filters_.remove(jamoma_max::to_value(args));
        clear_selection();
        return {};
    }};

    /** `filter/info <name>` answers the conditions of a filter on the dump outlet. */
    message<> filter_info{this, "filter/info", MIN_FUNCTION {
        if (args.empty()) {
            return {};
        }
        const auto info = filters_.info(jamoma_max::to_value(args).at(0).to_string());
        if (info) {
            const atoms values = jamoma_max::to_atoms(*info);
            c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym("filter/info"), static_cast<short>(values.size()),
                                      const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&values[0])));
        }
        return {};
    }};

    /** Tells the selection again. */
    message<> selection_refresh{this, "selection/refresh", MIN_FUNCTION {
        output_selection();
        return {};
    }};

    /** Answers the attributes on the dump outlet. */
    message<> dump{this, "dump", MIN_FUNCTION {
        const auto answer = [this](const char* name, const atoms& values) {
            c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym(name), static_cast<short>(values.size()),
                                      values.empty() ? nullptr : const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&values[0])));
        };
        answer("address", atoms{symbol(address_text_)});
        answer("output", atoms{output.get()});
        answer("format", atoms{format.get()});
        answer("relative", atoms{relative_ ? 1 : 0});
        answer("update", atoms{update_ ? 1 : 0});
        answer("sort", atoms{sort.get()});
        answer("depth", atoms{static_cast<int>(options_.depth)});
        answer("filter/list", jamoma_max::to_atoms(filters_.list()));
        answer("namespace", atoms{symbol(selection_name_)});
        return {};
    }};

    /** A symbol is a new address to explore (a relative one needs the attribute `relative`). */
    message<> m_anything{this, "anything", MIN_FUNCTION {
        atoms message = args;
        if (message.size() >= 2 && static_cast<symbol>(message[0]) == symbol("symbol")) {
            message.erase(message.begin());
        }
        if (message.empty()) {
            return {};
        }
        const std::string text = static_cast<symbol>(message[0]).c_str();
        if (message.size() >= 2 && c74::max::object_attr_get(maxobj(), c74::max::gensym(text.c_str())) != nullptr) {
            // `<attribute> <value...>` sets the attribute (a class with an anything method does not get this for free)
            c74::max::object_attr_setvalueof(maxobj(), c74::max::gensym(text.c_str()), static_cast<long>(message.size() - 1),
                                             const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&message[1])));
            return {};
        }
        if (text.empty() || text[0] != '/') {
            if (!relative_) {
                c74::max::object_error(maxobj(), "set the attribute relative to 1 before sending a relative address");
                return {};
            }
        }
        address_text_ = text;
        explore_and_output(true);
        return {};
    }};

    /** Class setup: adds `filter/list`, a list of names that Min's attribute types cannot hold. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION {
        jamoma_max::answer_queries<j_namespace>(args[0], {"address", "output", "format", "relative", "update", "sort", "depth", "namespace"});
        jamoma_max::answer_get_messages(args[0], {"address", "output", "format", "relative", "update", "sort", "depth", "namespace", "filter/list"});
        c74::max::t_class* c = args[0];
        c74::max::class_addattr(c, c74::max::attr_offset_array_new("filter/list", c74::max::gensym("symbol"), 256, 0,
                                                                   reinterpret_cast<c74::max::method>(&filter_list_getter),
                                                                   reinterpret_cast<c74::max::method>(&filter_list_setter), 0, 0));
        return {};
    }};

private:
    /** The getter of `filter/list`: the names of the filters in use. @param o The object. @param argc Receives the count. @param argv Receives the atoms. @return A Max error code. */
    static c74::max::t_max_err filter_list_getter(c74::max::t_object* o, c74::max::t_object*, long* argc, c74::max::t_atom** argv)
    {
        const jamoma::Value names = c74::min::wrapper_find_self<j_namespace>(o)->m_min_object.filters_.list();
        char allocated = 0;
        c74::max::atom_alloc_array(static_cast<long>(names.size()), argc, argv, &allocated);
        for (std::size_t i = 0; i < names.size(); ++i) {
            c74::max::atom_setsym(*argv + i, c74::max::gensym(names[i].to_string().c_str()));
        }
        return c74::max::MAX_ERR_NONE;
    }

    /** The setter of `filter/list`: the filters to use, in order. @param o The object. @param argc The count. @param argv The atoms. @return A Max error code. */
    static c74::max::t_max_err filter_list_setter(c74::max::t_object* o, c74::max::t_object*, long argc, c74::max::t_atom* argv)
    {
        if (argc == 0) { // a query
            jamoma_max::reply_to_query(o, c74::max::gensym("filter/list"));
            return c74::max::MAX_ERR_NONE;
        }
        j_namespace& self = c74::min::wrapper_find_self<j_namespace>(o)->m_min_object;
        jamoma::Value names;
        for (long i = 0; i < argc; ++i) {
            if (c74::max::atom_gettype(argv + i) == c74::max::A_SYM) {
                names.emplace_back(std::string(c74::max::atom_getsym(argv + i)->s_name));
            }
        }
        self.filters_.set_list(names);
        self.options_.filters = &self.filters_;
        if (self.ready_) {
            self.clear_selection();
        }
        return c74::max::MAX_ERR_NONE;
    }

    /** Takes up a shared selection by name. @param name The name. */
    void set_selection(const std::string& name)
    {
        selection_name_ = name.empty() ? "none" : name;
        selection_ = jamoma::Selection::named(selection_name_);
    }

    /** Unticks what is ticked at or below the explored address, as the old object did when a filter changed. */
    void clear_selection()
    {
        const std::string base = explored_.str();
        if (explored_.path().empty()) {
            selection_->clear();
            return;
        }
        for (const std::string& key : selection_->selected()) {
            if (key.starts_with(base) && (key.size() == base.size() || key[base.size()] == '/' || key[base.size()] == '.' || key[base.size()] == ':')) {
                selection_->set(key, false);
            }
        }
    }

    /** @return The address to explore as an address of the namespace (empty if the text is a relative address that cannot be resolved). */
    jamoma::Address resolved() const
    {
        if (address_text_.empty()) {
            return jamoma::Address();
        }
        if (!relative_ && !jamoma::Address::parse(address_text_).absolute()) {
            return jamoma::Address();
        }
        return jamoma_max::resolve_in_patcher(const_cast<j_namespace*>(this)->maxobj(), address_text_);
    }

    /** Starts (again) after the address or an attribute changed: watches the namespace and explores once. */
    void start()
    {
        if (!ready_) {
            return;
        }
        watch();
        if (!address_text_.empty()) {
            explore_and_output(true);
        }
    }

    /** Watches the namespace below the address (to a depth of 6 levels), if update is on. */
    void watch()
    {
        watches_.clear();
        if (!update_) {
            return;
        }
        const jamoma::Address base = options_.output == jamoma::ExploreOutput::Brothers ? resolved().parent() : resolved();
        if (resolved().empty()) {
            return;
        }
        jamoma::Namespace& ns = jamoma::Registry::instance().names();
        jamoma::Address pattern = base;
        watches_.push_back(ns.observe(pattern, [this](const jamoma::Address&, jamoma::Object*, bool) { schedule(); }));
        for (int level = 1; level <= 6; ++level) {
            pattern = pattern.append(jamoma::Address::parse("*"));
            watches_.push_back(ns.observe(pattern, [this](const jamoma::Address&, jamoma::Object*, bool) { schedule(); }));
        }
    }

    /** Asks for an update on the main thread, once for a burst of changes. */
    void schedule() { settle_.request(maxobj(), alive_.weak(), [this] { changed(true); }); }

    /** The namespace (or the model of the patcher) changed. @param from_namespace True if the namespace changed (the observers stay), false if the model of the patcher did. */
    void changed(bool from_namespace)
    {
        if (!ready_ || address_text_.empty() || !update_) {
            return;
        }
        if (!from_namespace) {
            watch();
        }
        explore_and_output(false);
    }

    /**
     * Explores and tells the result: the messages of the format, the size, and (with a shared selection) which items are selected.
     * @param always True for a message of the user (the result is sent even if it is the same as the last one), false for an update.
     */
    void explore_and_output(bool always)
    {
        if (!ready_) {
            return;
        }
        const jamoma::Address address = resolved();
        const jamoma::ExploreResult result = jamoma::explore(jamoma::Registry::instance().names(), address, options_);
        if (!always && have_last_ && last_items_ == result.items && explored_ == address && !result.items.empty()) {
            return;
        }
        have_last_ = true;
        last_items_ = result.items;
        explored_ = address;
        for (const auto& m : jamoma::format_items(format_, options_.output, address, result.items)) {
            emit(data_out.max_outlet(), m);
        }
        c74::max::outlet_int(size_out.max_outlet(), static_cast<c74::max::t_atom_long>(result.items.size()));
        output_selection();
    }

    /** Tells which of the listed items are selected, if the object has a shared selection (a name other than none). */
    void output_selection()
    {
        if (selection_name_ == "none") {
            return;
        }
        std::vector<bool> flags;
        for (const std::string& item : last_items_) {
            flags.push_back(selection_->is_selected(jamoma::item_key(options_.output, explored_, item)));
        }
        for (const auto& m : jamoma::format_selection(format_, flags)) {
            emit(data_out.max_outlet(), m);
        }
    }

    /** Sends one message out of an outlet. @param outlet The outlet. @param m The message. */
    static void emit(c74::max::t_outlet* outlet, const jamoma::OutMessage& m)
    {
        const c74::min::atoms atoms = jamoma_max::to_atoms(m.args);
        auto* raw = atoms.empty() ? nullptr : const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&atoms[0]));
        if (!m.selector.empty()) {
            c74::max::outlet_anything(outlet, c74::max::gensym(m.selector.c_str()), static_cast<short>(atoms.size()), raw);
        } else if (!atoms.empty()) {
            jamoma_max::output_value(outlet, m.args);
        }
    }
};

MIN_EXTERNAL(j_namespace);
