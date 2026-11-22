// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.model.cpp
 * @brief j.model: declares the patcher as a model. The data objects of the patcher register below its address.
 *
 * The model is named by its first argument, else by the file name of its patcher (dots become underscores, since a dot starts an
 * instance in an address). It initialises itself once the patcher has loaded (two deferred hops, so every data object of the
 * patcher has found its model first) and again whenever it gets the `init` message. The presets of the model are the `preset:...`
 * messages; after the first initialisation the file `<patcher name>.presets.txt` (for `qmetro.model.maxpat`: `qmetro.model.presets.txt`)
 * is read if it is in the Max search path, and the preset called `default` is recalled if there is one.
 */

#include <cstdio>
#include <cstdlib>
#include <fstream>
#include <optional>
#include <memory>
#include <sstream>
#include <string>
#include <vector>

#include "c74_min.h"

#include "jamoma/model.hpp"
#include "jamoma/preset_files.hpp"
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
    std::string last_file_;                    /**< The presets file used last. */
    bool placing_ = false;                     /**< True while place() runs. */
    std::string prefix_;                       /**< The address of the parent model the model sits below (empty: at the root). */
    jamoma_max::Alive alive_;                  /**< Lets deferred calls see that the object is gone. */
    jamoma_max::ContextWatch watch_;           /**< Moves the model below its parent model when that one appears later, is replaced or goes. */

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
        read_file(w.empty() ? ask_for_file(false) : find_file(w[0]));
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
        write_file(w.empty() ? ask_for_file(true) : target_file(w[0]));
        return {};
    }};

    /** `preset:write/again`: writes to the file used last. */
    message<> preset_write_again{this, "preset:write/again", MIN_FUNCTION {
        write_file(last_file_);
        return {};
    }};

    /** After construction: creates the model, registers it for its patcher and schedules the first initialisation. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        patcher_ = jamoma_max::patcher_of(maxobj());
        if (name_.empty()) {
            const std::optional<std::string> cls = jamoma_max::patcher_class(patcher_);
            name_ = cls ? *cls : patcher_name();
        }
        place();
        jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
            jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
                if (model_) {
                    model_->init();
                    load_default_presets();
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

    /** @return The native path of a file the user named for reading: as given if absolute, else found in the Max search path (empty if not found). @param name The name. */
    std::string find_file(const std::string& name) const
    {
        if (!name.empty() && (name[0] == '/' || name.find(':') != std::string::npos)) {
            return name;
        }
        char file[c74::max::MAX_FILENAME_CHARS];
        std::snprintf(file, sizeof file, "%s", name.c_str());
        short vol = 0;
        c74::max::t_fourcc type = 0;
        if (c74::max::locatefile_extended(file, &vol, &type, nullptr, 0) != 0) {
            return {};
        }
        char full[c74::max::MAX_PATH_CHARS];
        c74::max::path_toabsolutesystempath(vol, file, full);
        return full;
    }

    /** @return The native path of a file the user named for writing: as given if absolute, else in the folder of the patcher (empty if that is unknown). @param name The name. */
    std::string target_file(const std::string& name) const
    {
        if (!name.empty() && (name[0] == '/' || name.find(':') != std::string::npos)) {
            return name;
        }
        c74::max::t_symbol* path = patcher_ == nullptr ? nullptr
            : c74::max::object_attr_getsym(const_cast<c74::max::t_object*>(static_cast<const c74::max::t_object*>(patcher_)), c74::max::gensym("filepath"));
        std::string folder = path != nullptr && path->s_name != nullptr ? path->s_name : "";
        const std::size_t slash = folder.find_last_of("/\\");
        if (slash == std::string::npos) {
            return {};
        }
        return folder.substr(0, slash + 1) + name;
    }

    /** Asks for a file with the system dialog. @param saving True for a save dialog. @return The native path, or empty if cancelled. */
    std::string ask_for_file(bool saving)
    {
        char file[c74::max::MAX_FILENAME_CHARS] = "";
        short vol = 0;
        c74::max::t_fourcc type = 0;
        if (saving) {
            std::snprintf(file, sizeof file, "%s.presets.txt", name_.c_str());
            short binary = 0;
            if (c74::max::saveas_dialog(file, &vol, &binary) != 0) {
                return {};
            }
        } else if (c74::max::open_dialog(file, &vol, &type, nullptr, 0) != 0) {
            return {};
        }
        char full[c74::max::MAX_PATH_CHARS];
        c74::max::path_toabsolutesystempath(vol, file, full);
        return full;
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
        jamoma::ReadResult result = jamoma::read_presets_text(text.str());
        for (const std::string& problem : result.problems) {
            c74::max::object_warn(maxobj(), "preset:read %s: %s", path.c_str(), problem.c_str());
        }
        if (result.presets.empty() || !model_) {
            c74::max::object_error(maxobj(), "preset:read: %s holds no presets; nothing changed", path.c_str());
            return;
        }
        model_->presets().replace_all(std::move(result.presets));
        last_file_ = path;
        presets = symbol(path);
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
        const std::string path = find_file(stem + ".presets.txt");
        if (path.empty()) {
            return;
        }
        read_file(path);
        model_->presets().recall("default");
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
     */
    void place()
    {
        if (placing_) {
            return; // our own add and remove call back through the watch
        }
        const std::string prefix = wanted_prefix();
        if (model_ && prefix == prefix_) {
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
        jamoma::Registry::instance().contexts().add(patcher_, model_.get());
        placing_ = false;
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

MIN_EXTERNAL(j_model);
