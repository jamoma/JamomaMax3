// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.model.cpp
 * @brief j.model: declares the patcher as a model. The data objects of the patcher register below its address.
 *
 * The model is named by its first argument, else by the first argument its patcher was loaded with (bpatcher or abstraction), else by the file name of its patcher (dots become underscores, since a dot starts an
 * instance in an address). It initialises itself once the patcher has loaded (two deferred hops, so every data object of the
 * patcher has found its model first) and again whenever it gets the `init` message. The presets of the model are the `preset:...`
 * messages; after the first initialisation the file `<patcher name>.presets.txt` (for `qmetro.model.maxpat`: `qmetro.model.presets.txt`)
 * is read if it is in the Max search path, and the preset called `default` is recalled if there is one.
 */

#include <cstdio>
#include <cstdlib>
#include <fstream>
#include <map>
#include <set>
#include <optional>
#include <memory>
#include <sstream>
#include <string>
#include <vector>

#include "c74_min.h"

#include "jamoma/data.hpp"
#include "jamoma/explorer.hpp"
#include "jamoma/model.hpp"
#include "jamoma/preset_files.hpp"
#include "jamoma/receiver.hpp"
#include "jamoma/registry.hpp"
#include "max_atoms.hpp"
#include "max_context.hpp"
#include "max_editor.hpp"
#include "max_files.hpp"

using namespace c74::min;

/** The j.model external. */
class j_model : public c74::min::object<j_model> {
    // These come before the attributes: Min constructs the attributes in declaration order and calls each setter with its
    // default, and the setters use model_ (the same trap as in data_object, which crashed Max once).
    std::string name_;                         /**< The name of the model. */
    bool name_from_patcher_ = false;           /**< True if the name was taken from the patcher (no argument): it is read again once the patcher has loaded. */
    const void* patcher_ = nullptr;            /**< The patcher the model governs. */
    jamoma::Data active_data_{jamoma::Service::Parameter}; /**< The parameter `data/active` of the `data` amenity (declared before the model and its subscription, which go first). */
    std::unique_ptr<jamoma::Model> model_;     /**< The model. */
    jamoma::Subscription active_sub_;          /**< The registration of `data/active` below the model. */
    std::string amenities_text_ = "all";       /**< The amenities as set (the `data` amenity provides `data/active`). */
    std::shared_ptr<void> init_watch_;         /**< Recalls the default preset whenever the model has been initialised (a parent model may do it). */
    bool in_default_ = false;                  /**< True while the default preset is recalled (it must not start itself again). */
    std::string last_file_;                    /**< The presets file used last. */
    jamoma_max::TextEditor editor_;            /**< The editor window of `preset:edit`. */
    bool placing_ = false;                     /**< True while place() runs. */
    std::string prefix_;                       /**< The address of the parent model the model sits below (empty: at the root). */
    jamoma_max::Alive alive_;                  /**< Lets deferred calls see that the object is gone. */
    jamoma_max::ContextWatch watch_;           /**< Moves the model below its parent model when that one appears later, is replaced or goes. */
    std::unique_ptr<jamoma::ModelExplorer> explorer_;                        /**< Tells when parameters below the model come or go. */
    std::map<std::string, std::unique_ptr<jamoma::Receiver>> watches_;      /**< One receiver per parameter below the model, by its address relative to the model. */
    std::string watched_root_;                                              /**< The address of the model the watches belong to. */

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
        watch_.stop();
        explorer_.reset();
        watches_.clear();
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

    /** The alias of the model (accepted so that old patchers load; it has no effect yet). */
    attribute<symbol> alias{this, "alias", ""};
    /** Whether the model reports its activity (accepted so that old patchers load; it has no effect yet). */
    attribute<int> activity{this, "activity", 0};
    /** The tags of the model (accepted so that old patchers load; it has no effect yet). */
    attribute<symbol> tags{this, "tags", ""};
    /** The file the presets were last read from or written to (set by the preset messages). */
    attribute<symbol> presets{this, "presets", ""};

    /** The amenities the model provides (accepted so that patchers that set it load; it has no effect yet). */
    attribute<symbol> amenities{this, "amenities", "all", setter{MIN_FUNCTION {
        amenities_text_ = std::string(static_cast<symbol>(args[0]).c_str());
        if (model_) {
            make_amenities();
        }
        return args;
    }}};

    inlet<> input{this, "(anything) messages to the model"};              /**< The inlet. */
    jamoma_max::dump_outlet results_out{this, "(anything) parameter changes: the name of the parameter and its value"}; /**< Outlet 0: every change of a parameter below the model, with the name (relative to the model) in front. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump"};              /**< Outlet 1: the dump outlet. */

    /** @return The text editor window of the model (the Max method edclose reaches it). */
    jamoma_max::TextEditor& editor() { return editor_; }

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

    /** `preset:new [<position>] <name>`: stores the present state of the parameters as a preset (an existing name is stored again in place). */
    message<> preset_new{this, "preset:new", MIN_FUNCTION {
        std::vector<std::string> w = words(args);
        std::optional<std::size_t> position;
        if (w.size() >= 2 && is_number(w[0])) {
            const long p = std::atol(w[0].c_str());
            position = p >= 1 ? static_cast<std::size_t>(p - 1) : 0;
            w.erase(w.begin());
        }
        if (w.empty() || !model_ || !model_->presets().new_preset(w[0], position)) {
            c74::max::object_error(maxobj(), "preset:new needs a name");
        }
        return {};
    }};

    /** `preset:update [<name or position>]`: stores the present state into an existing preset (the current one if none is named). */
    message<> preset_update{this, "preset:update", MIN_FUNCTION {
        const std::vector<std::string> w = words(args);
        std::string key = w.empty() ? current_key() : w[0];
        if (!model_ || key.empty() || !model_->presets().update(key)) {
            c74::max::object_error(maxobj(), "preset:update: no such preset");
        }
        return {};
    }};

    /** `preset <name or position>`: recalls a preset. */
    message<> preset_recall{this, "preset", MIN_FUNCTION {
        const std::vector<std::string> w = words(args);
        if (w.empty() || !model_) {
            c74::max::object_error(maxobj(), "preset needs a name or a position");
            return {};
        }
        const jamoma::RecallReport report = model_->presets().recall(w[0]);
        if (!report.found) {
            c74::max::object_error(maxobj(), "preset %s: no such preset", w[0].c_str());
        } else if (!report.skipped.empty()) {
            c74::max::object_warn(maxobj(), "preset %s: %d entries skipped because their parameter does not exist (first: %s)", w[0].c_str(),
                                  static_cast<int>(report.skipped.size()), report.skipped[0].str().c_str());
        }
        return {};
    }};

    /** `preset:delete <name or position>`. */
    message<> preset_delete{this, "preset:delete", MIN_FUNCTION {
        const std::vector<std::string> w = words(args);
        if (w.empty() || !model_ || !model_->presets().remove(w[0])) {
            c74::max::object_error(maxobj(), "preset:delete: no such preset");
        }
        return {};
    }};

    /** `preset:clear`: removes every preset. */
    message<> preset_clear{this, "preset:clear", MIN_FUNCTION {
        if (model_) {
            model_->presets().clear();
        }
        return {};
    }};

    /** `preset:names`: answers `preset:names <name>...` on the dump outlet. */
    message<> preset_names{this, "preset:names", MIN_FUNCTION {
        std::vector<c74::max::t_atom> list;
        if (model_) {
            for (const std::string& name : model_->presets().names()) {
                list.emplace_back();
                c74::max::atom_setsym(&list.back(), c74::max::gensym(name.c_str()));
            }
        }
        c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym("preset:names"), static_cast<short>(list.size()), list.empty() ? nullptr : list.data());
        return {};
    }};

    /** `preset:move <name or position> <new position>` (positions from 1). */
    message<> preset_move{this, "preset:move", MIN_FUNCTION {
        const std::vector<std::string> w = words(args);
        const long p = w.size() >= 2 ? std::atol(w[1].c_str()) : 0;
        if (w.size() < 2 || p < 1 || !model_ || !model_->presets().move(w[0], static_cast<std::size_t>(p - 1))) {
            c74::max::object_error(maxobj(), "preset:move needs a preset and a position that exists");
        }
        return {};
    }};

    /** `preset:copy <name or position> <new name> [<position>]`. */
    message<> preset_copy{this, "preset:copy", MIN_FUNCTION {
        const std::vector<std::string> w = words(args);
        std::optional<std::size_t> position;
        if (w.size() >= 3) {
            const long p = std::atol(w[2].c_str());
            position = p >= 1 ? static_cast<std::size_t>(p - 1) : 0;
        }
        if (w.size() < 2 || !model_ || !model_->presets().copy(w[0], w[1], position)) {
            c74::max::object_error(maxobj(), "preset:copy needs an existing preset and a new name");
        }
        return {};
    }};

    /** `preset:rename <name or position> <new name>`. */
    message<> preset_rename{this, "preset:rename", MIN_FUNCTION {
        const std::vector<std::string> w = words(args);
        if (w.size() < 2 || !model_ || !model_->presets().rename(w[0], w[1])) {
            c74::max::object_error(maxobj(), "preset:rename needs an existing preset and a new name");
        }
        return {};
    }};

    /** `preset:interpolate <a> <b> <position 0..1>`: sends the blend of two presets. */
    message<> preset_interpolate{this, "preset:interpolate", MIN_FUNCTION {
        const std::vector<std::string> w = words(args);
        if (w.size() < 3 || !model_ || !model_->presets().interpolate(w[0], w[1], std::atof(w[2].c_str())).found) {
            c74::max::object_error(maxobj(), "preset:interpolate needs two presets that exist and a position");
        }
        return {};
    }};

    /** `preset:mix <preset> <factor> ...`: sends the weighted mix of presets. */
    message<> preset_mix{this, "preset:mix", MIN_FUNCTION {
        const std::vector<std::string> w = words(args);
        std::vector<std::pair<std::string, double>> weighted;
        for (std::size_t i = 0; i + 1 < w.size(); i += 2) {
            weighted.emplace_back(w[i], std::atof(w[i + 1].c_str()));
        }
        if (w.size() % 2 != 0 || w.empty() || !model_ || !model_->presets().mix(weighted).found) {
            c74::max::object_error(maxobj(), "preset:mix needs pairs of a preset that exists and a factor");
        }
        return {};
    }};

    /** `preset:read [<file>]`: replaces the presets by those of a text file (a dialog if there is no file). */
    message<> preset_read{this, "preset:read", MIN_FUNCTION {
        const std::vector<std::string> w = words(args);
        const std::weak_ptr<int> alive = alive_.weak(); // a file dialog runs its own event loop: this object may be deleted meanwhile
        const auto file = w.empty() ? jamoma_max::ask_for_file(false, "") : jamoma_max::find_file(w[0]);
        if (!alive.expired()) {
            read_file(file);
        }
        return {};
    }};

    /** `preset:read/again`: reads the file used last. */
    message<> preset_read_again{this, "preset:read/again", MIN_FUNCTION {
        read_file(last_file_);
        return {};
    }};

    /** `preset:write [<file>]`: writes the presets to a text file (a dialog if there is no file). */
    message<> preset_write{this, "preset:write", MIN_FUNCTION {
        const std::vector<std::string> w = words(args);
        const std::weak_ptr<int> alive = alive_.weak(); // as in preset:read
        const auto file = w.empty() ? jamoma_max::ask_for_file(true, name_ + ".presets.txt") : jamoma_max::target_file(patcher_, w[0]);
        if (!alive.expired()) {
            write_file(file);
        }
        return {};
    }};

    /** `preset:write/again`: writes to the file used last. */
    message<> preset_write_again{this, "preset:write/again", MIN_FUNCTION {
        write_file(last_file_);
        return {};
    }};

    /** `preset:edit`: opens a text editor window with the presets in the text form of the presets file; closing it replaces the presets by the edited text. */
    message<> preset_edit{this, "preset:edit", MIN_FUNCTION {
        if (!model_) {
            return {};
        }
        editor_.open(maxobj(), name_ + " presets", jamoma::write_presets_text(model_->presets().presets()),
                     [this](const std::string& text) { apply_presets_text(text, "preset:edit"); });
        return {};
    }};

    /**
     * `preset:edit/apply <text>`: what closing the editor window does, for a patch or a test: the words are joined with spaces and the two
     * characters `\n` stand for a line break.
     */
    message<> preset_edit_apply{this, "preset:edit/apply", MIN_FUNCTION {
        std::string text;
        for (const std::string& w : words(args)) {
            text += (text.empty() ? "" : " ") + w;
        }
        for (std::size_t at = text.find("\\n"); at != std::string::npos; at = text.find("\\n", at + 1)) {
            text.replace(at, 2, "\n");
        }
        apply_presets_text(text, "preset:edit/apply");
        return {};
    }};

    /**
     * `<name> <value...>`: sends the value to the parameter or message of that name below the model (the name is relative to the model, as in
     * the output). A name that is no parameter or message, and a return, is ignored. The messages above are tried first.
     */
    message<> anything{this, "anything", MIN_FUNCTION {
        if (!model_ || args.empty()) {
            return {};
        }
        atoms message = args;
        if (message.size() >= 2 && static_cast<symbol>(message[0]) == symbol("symbol")) {
            message.erase(message.begin());
        }
        if (message[0].type() != message_type::symbol_argument) {
            return {};
        }
        const std::string name = static_cast<symbol>(message[0]).c_str();
        const atoms rest(message.begin() + 1, message.end());
        jamoma::Node* node = jamoma::Registry::instance().names().lookup(model_->address().append(jamoma::Address::parse(name)));
        auto* data = node != nullptr ? dynamic_cast<jamoma::Data*>(node->object()) : nullptr;
        if (data != nullptr && data->service() != jamoma::Service::Return) {
            data->command(jamoma_max::to_value(rest));
        }
        return {};
    }};

    /** After construction: creates the model, registers it for its patcher and schedules the first initialisation. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        patcher_ = jamoma_max::patcher_of(maxobj());
        explorer_ = std::make_unique<jamoma::ModelExplorer>(jamoma::Registry::instance().names(), [this] {
            if (c74::max::systhread_ismainthread()) {
                sync_watches();
            } else {
                jamoma_max::defer_call(maxobj(), alive_.weak(), [this] { sync_watches(); });
            }
        });
        if (name_.empty()) {
            name_from_patcher_ = true;
            name_ = name_from_patcher();
        }
        place();
        jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
            jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
                // A subpatcher has no name while it loads (`p child` is named afterwards): take it again now, and move the model if it changed.
                if (name_from_patcher_ && name_from_patcher() != name_) {
                    name_ = name_from_patcher();
                    place(true);
                }
                if (model_) {
                    model_->init();
                    load_default_presets();
                    recall_default();
                    init_watch_ = model_->on_init_changed([this](bool done) {
                        if (done && !in_default_) {
                            in_default_ = true;
                            recall_default();
                            in_default_ = false;
                        }
                    });
                }
            });
        });
        watch_.start([this] { place(); });
        return {};
    }};

private:
    /** @return The atoms as words (numbers in their text form). @param a The atoms. */
    static std::vector<std::string> words(const atoms& a)
    {
        std::vector<std::string> out;
        for (const atom& x : a) {
            if (x.type() == message_type::int_argument) {
                out.push_back(std::to_string(static_cast<long long>(static_cast<int>(x))));
            } else if (x.type() == message_type::float_argument) {
                std::ostringstream text;
                text << static_cast<double>(x);
                out.push_back(text.str());
            } else {
                out.emplace_back(static_cast<symbol>(x).c_str());
            }
        }
        return out;
    }

    /** @return True if the text is a whole number. @param text The text. */
    static bool is_number(const std::string& text)
    {
        return !text.empty() && text.find_first_not_of("0123456789") == std::string::npos;
    }

    /** @return The 1-based position of the current preset as text, or empty. */
    std::string current_key() const
    {
        if (model_ && model_->presets().current()) {
            return std::to_string(*model_->presets().current() + 1);
        }
        return {};
    }

    /** Reads presets from a text file; on any problem nothing changes and the console says why. @param path The native path (empty: report that there is no file). */
    void read_file(const std::string& path)
    {
        if (path.empty()) {
            c74::max::object_error(maxobj(), "preset:read: no file");
            return;
        }
        std::ifstream in(path, std::ios::binary);
        if (!in) {
            c74::max::object_error(maxobj(), "preset:read: cannot open %s", path.c_str());
            return;
        }
        std::stringstream text;
        text << in.rdbuf();
        if (apply_presets_text(text.str(), "preset:read " + path)) {
            last_file_ = path;
            presets = symbol(path);
        }
    }

    /**
     * Replaces the presets by those of a text; on any problem nothing changes and the console says why.
     * @param text The text of a presets file. @param label What to call the source in console messages. @return True if presets were read.
     */
    bool apply_presets_text(const std::string& text, const std::string& label)
    {
        jamoma::ReadResult result = jamoma::read_presets_text(text);
        for (const std::string& problem : result.problems) {
            c74::max::object_warn(maxobj(), "%s: %s", label.c_str(), problem.c_str());
        }
        if (result.presets.empty() || !model_) {
            c74::max::object_error(maxobj(), "%s: no presets in the text; nothing changed", label.c_str());
            return false;
        }
        model_->presets().replace_all(std::move(result.presets));
        return true;
    }

    /** Writes the presets to a text file. @param path The native path (empty: report that there is no file). */
    void write_file(const std::string& path)
    {
        if (path.empty()) {
            c74::max::object_error(maxobj(), "preset:write: no file (save the patcher first, or give a full path)");
            return;
        }
        std::ofstream out(path, std::ios::binary | std::ios::trunc);
        if (!out || !model_) {
            c74::max::object_error(maxobj(), "preset:write: cannot write %s", path.c_str());
            return;
        }
        out << jamoma::write_presets_text(model_->presets().presets());
        last_file_ = path;
        presets = symbol(path);
    }

    /** Reads `<patcher name>.presets.txt` from the Max search path, if it is there, and recalls the preset `default`. */
    void load_default_presets()
    {
        if (patcher_ == nullptr || !model_) {
            return;
        }
        c74::max::t_symbol* s = c74::max::jpatcher_get_name(const_cast<c74::max::t_object*>(static_cast<const c74::max::t_object*>(patcher_)));
        std::string stem = s != nullptr && s->s_name != nullptr ? s->s_name : "";
        const std::string suffix = ".maxpat";
        if (stem.size() > suffix.size() && stem.compare(stem.size() - suffix.size(), suffix.size(), suffix) == 0) {
            stem.erase(stem.size() - suffix.size());
        }
        if (stem.empty()) {
            return;
        }
        const std::string named = std::string(static_cast<symbol>(presets.get()).c_str());
        const std::string path = jamoma_max::find_file(named.empty() ? stem + ".presets.txt" : named);
        if (path.empty()) {
            return;
        }
        read_file(path);
    }

    /** Recalls the preset `default` if there is one (after every initialisation: a model that a parent model initialises again gets it again). */
    void recall_default()
    {
        if (model_ && !model_->presets().names().empty()) {
            model_->presets().recall("default");
        }
    }

    /** Provides what the amenities promise: the `data` (or `all`) amenity gives the parameter `data/active` (1 = the model is on; presets store it). */
    void make_amenities()
    {
        active_sub_ = jamoma::Subscription();
        const bool data = amenities_text_.find("all") != std::string::npos || amenities_text_.find("data") != std::string::npos;
        if (!data || !model_) {
            return;
        }
        active_data_.set_type(jamoma::DataType::Integer);
        active_data_.set_attribute("range", {0, 1});
        active_data_.set_attribute("default", {1});
        active_data_.set_attribute("description", {"Activates or deactivates the model"});
        active_sub_ = jamoma::Registry::instance().names().subscribe(model_->address().append(jamoma::Address::parse("data/active")), active_data_);
        active_data_.command({1}); // set_type reset the value to 0
    }

    /** @return The address the model belongs at: below the model of the nearest enclosing patcher, else at the root. */
    std::string wanted_prefix() const
    {
        for (const void* p = jamoma_max::parent_patcher(patcher_); p != nullptr; p = jamoma_max::parent_patcher(p)) {
            if (const jamoma::Model* parent = jamoma::Registry::instance().contexts().find(p)) {
                return parent->address().str();
            }
        }
        return {};
    }

    /**
     * Creates the model, or makes it again if the model it should sit below has appeared, been replaced or gone. The data objects of
     * the patcher find the new model through the context map's observers.
     * @param force True to make the model again even if it sits where it should (its name has changed).
     */
    void place(bool force = false)
    {
        if (placing_) {
            return; // our own add and remove call back through the watch
        }
        const std::string prefix = wanted_prefix();
        if (model_ && prefix == prefix_ && !force) {
            return;
        }
        placing_ = true;
        std::string description = model_ ? model_->description() : std::string(static_cast<symbol>(this->description.get()).c_str());
        int priority_value = model_ ? model_->priority() : static_cast<int>(this->priority.get());
        std::vector<jamoma::Preset> kept;
        if (model_) {
            kept = model_->presets().presets();
        }
        if (model_) {
            active_sub_ = jamoma::Subscription();
            init_watch_.reset();
            jamoma::Registry::instance().contexts().remove(patcher_, model_.get());
            model_.reset();
        }
        prefix_ = prefix;
        model_ = std::make_unique<jamoma::Model>(jamoma::Registry::instance().names(), jamoma::Address::parse(prefix + "/" + name_));
        model_->set_description(description);
        model_->set_priority(priority_value);
        if (!kept.empty()) {
            model_->presets().replace_all(std::move(kept));
        }
        make_amenities();
        jamoma::Registry::instance().contexts().add(patcher_, model_.get());
        placing_ = false;
        if (explorer_) {
            explorer_->set_model(model_->address());
            sync_watches();
        }
    }

    /**
     * Makes the watches match the parameters below the model: a receiver for each one that is new, none for one that has gone. A receiver
     * only reports changes made after it was bound (it is inactive while it binds), so nothing is output for a value that is already there.
     */
    void sync_watches()
    {
        if (!model_ || !explorer_) {
            watches_.clear();
            return;
        }
        const jamoma::Address root = model_->address();
        if (root.str() != watched_root_) {
            watches_.clear();
            watched_root_ = root.str();
        }
        const std::vector<std::string> names = explorer_->contents().parameters;
        const std::set<std::string> wanted(names.begin(), names.end());
        for (auto it = watches_.begin(); it != watches_.end();) {
            it = wanted.count(it->first) != 0 ? std::next(it) : watches_.erase(it);
        }
        for (const std::string& name : wanted) {
            if (watches_.count(name) != 0) {
                continue;
            }
            auto receiver = std::make_unique<jamoma::Receiver>(
                jamoma::Registry::instance().names(), [](const jamoma::Address&) {},
                [this, name](const jamoma::Value& v) { report_change(name, v); });
            receiver->set_active(false);
            receiver->set_address(root.append(jamoma::Address::parse(name)));
            receiver->set_active(true);
            watches_[name] = std::move(receiver);
        }
    }

    /** Outputs `<name> <value>` on the left outlet (on the main thread: another thread defers). @param name The parameter, relative to the model. @param v The new value. */
    void report_change(const std::string& name, const jamoma::Value& v)
    {
        if (c74::max::systhread_ismainthread()) {
            output_change(name, v);
        } else {
            jamoma_max::defer_call(maxobj(), alive_.weak(), [this, name, v] { output_change(name, v); });
        }
    }

    /** Sends the name and the value out. @param name The parameter. @param v The value. */
    void output_change(const std::string& name, const jamoma::Value& v)
    {
        const c74::min::atoms atoms = jamoma_max::to_atoms(v);
        auto* raw = atoms.empty() ? nullptr : const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&atoms[0]));
        c74::max::outlet_anything(results_out.max_outlet(), c74::max::gensym(name.c_str()), static_cast<short>(atoms.size()), raw);
    }

    /** @return The name the patcher gives the model: its `.model` class if it has one, else its name (`model` while it has none). */
    std::string name_from_patcher() const
    {
        if (std::optional<std::string> argument = jamoma_max::patcher_argument(patcher_)) {
            argument->erase(0, argument->find_first_not_of('/'));
            if (!argument->empty()) {
                return *argument;
            }
        }
        const std::optional<std::string> cls = jamoma_max::patcher_class(patcher_);
        return cls ? *cls : patcher_name();
    }

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

/** Class setup, called by Max: the Min wrapper, then the method Min does not offer (the editor window of preset:edit sends it when it closes). @param r Max's class registry. */
void ext_main(void* r)
{
    c74::min::wrap_as_max_external<j_model>("j_model", __FILE__, r);
    jamoma_max::add_edclose_method<j_model>("j.model");
}
