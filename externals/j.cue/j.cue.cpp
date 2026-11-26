// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.cue.cpp
 * @brief j.cue: stores the state of chosen parameters of several models under names and recalls it.
 *
 * Outlets from the left: the lines of a recalled or output cue (`<address> <value...>`), the dump outlet (`names`, `read`, `error`, answers of
 * `get`). The addresses that `new` stores are those of a selection, shared by name with `j.namespace` (the argument or `@namespace`). The work is
 * done by jamoma::CueList (core/include/jamoma/cue.hpp); this file translates Max messages and attributes. Everything runs on the main thread.
 */

#include <algorithm>
#include <cstdlib>
#include <fstream>
#include <memory>
#include <optional>
#include <sstream>
#include <string>
#include <vector>

#include "c74_min.h"

#include "jamoma/cue.hpp"
#include "jamoma/explore.hpp"
#include "jamoma/registry.hpp"
#include "max_address.hpp"
#include "max_atoms.hpp"
#include "max_context.hpp"
#include "max_editor.hpp"
#include "max_files.hpp"

using namespace c74::min;

/** The j.cue external. */
class j_cue : public c74::min::object<j_cue> {
    // State comes before the attributes: Min runs every attribute setter with its default while constructing them.
    jamoma::CueList cues_{jamoma::Registry::instance().names()};   /**< The cues. */
    std::string selection_name_ = "none";                          /**< The name of the shared selection. */
    std::shared_ptr<jamoma::Selection> selection_ = jamoma::Selection::named("none"); /**< The selection. */
    std::string last_file_;                                        /**< The file read or written last. */
    std::shared_ptr<void> names_watch_;                            /**< Tells the dump outlet when the cues change. */
    std::vector<std::string> last_names_;                          /**< The names told last. */
    jamoma_max::Alive alive_;                                      /**< Lets deferred calls see that the object is gone. */
    jamoma_max::TextEditor editor_;                                /**< The editor window. */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object. @param args The creation atoms: an optional name of a shared selection, then attributes. */
    explicit j_cue(const atoms& args = {})
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
        names_watch_ = cues_.cues().observe([this] { report_names(false); });
    }

    /** Stops watching before the outlets are destroyed. */
    ~j_cue() override { names_watch_.reset(); }

    inlet<> input{this, "(anything) messages to the cue list"};                      /**< The inlet. */
    jamoma_max::dump_outlet line_out{this, "(anything) the lines of a cue"};         /**< Outlet 0. */
    jamoma_max::dump_outlet dump_out{this, "(anything) dump"};                       /**< Outlet 1: the dump outlet. */

    /** @return The editor window (the Max method edclose reaches it). */
    jamoma_max::TextEditor& editor() { return editor_; }

    /** The name of the selection shared with `j.namespace` (`none`: an own one). */
    attribute<symbol> selection_attr{this, "namespace", "none", setter{MIN_FUNCTION {
        set_selection(std::string(static_cast<symbol>(args[0]).c_str()));
        return args;
    }}};

    /** The parent node the cues store from, and relative recall addresses are taken from. */
    attribute<symbol> address{this, "address", "", setter{MIN_FUNCTION {
        const std::string text = static_cast<symbol>(args[0]).c_str();
        cues_.set_address(text.empty() ? jamoma::Address() : jamoma::Address::parse(text));
        return args;
    }}};

    /** The names of the cues, in order (read only). */
    attribute<symbol> names{this, "names", "", getter{MIN_GETTER_FUNCTION {
        atoms out;
        for (const auto& n : cues_.cues().names())
            out.push_back(symbol(n));
        if (out.empty())
            out.push_back(symbol("")); // an attribute without any value makes Max abort when it is read
        return out;
    }}, setter{MIN_FUNCTION { return atoms{symbol("")}; }}};

    /** The name of the current cue (read only). */
    attribute<symbol> current{this, "current", "", getter{MIN_GETTER_FUNCTION {
        const auto i = cues_.cues().current();
        return atoms{symbol(i ? cues_.cues().presets().at(*i).name : std::string())};
    }}, setter{MIN_FUNCTION { return atoms{symbol("")}; }}};

    /** The position of the current cue, counted from 1 (0: none; read only). */
    attribute<int> current_position{this, "current/position", 0, getter{MIN_GETTER_FUNCTION {
        const auto i = cues_.cues().current();
        return atoms{i ? static_cast<int>(*i) + 1 : 0};
    }}, setter{MIN_FUNCTION { return atoms{0}; }}};

    /** The description of the current cue. */
    attribute<symbol> current_description{this, "current/description", "", getter{MIN_GETTER_FUNCTION {
        const auto n = current_name();
        return atoms{symbol(n ? cues_.description(*n).value_or("") : std::string())};
    }}, setter{MIN_FUNCTION {
        if (const auto n = current_name()) {
            cues_.set_description(*n, text_of(args, 0));
        }
        return args;
    }}};

    /** The ramp time of the current cue in milliseconds. */
    attribute<int> current_ramp{this, "current/ramp", 0, getter{MIN_GETTER_FUNCTION {
        const auto n = current_name();
        return atoms{n ? static_cast<int>(cues_.ramp(*n).value_or(0.0)) : 0};
    }}, setter{MIN_FUNCTION {
        if (const auto n = current_name()) {
            cues_.set_ramp(*n, static_cast<double>(args[0]));
        }
        return args;
    }}};

    /** After construction: registers the last outlet as the dumpout. */
    message<> setup{this, "setup", MIN_FUNCTION {
        c74::max::object_obex_store(maxobj(), c74::max::gensym("dumpout"), reinterpret_cast<c74::max::t_object*>(dump_out.max_outlet()));
        return {};
    }};

    /** `new [<position>] <name>`: stores the selected parameters as a cue. */
    message<> m_new{this, "new", MIN_FUNCTION {
        std::optional<std::size_t> position;
        std::size_t name_at = 0;
        if (args.size() >= 2 && args[0].type() != message_type::symbol_argument) {
            const int p = static_cast<int>(args[0]);
            position = p >= 1 ? static_cast<std::size_t>(p - 1) : 0;
            name_at = 1;
        }
        if (args.size() <= name_at) {
            c74::max::object_error(maxobj(), "new needs a name");
            return {};
        }
        const std::vector<std::string> keys = selection_->selected();
        if (keys.empty()) {
            c74::max::object_warn(maxobj(), "new: nothing is selected, so the cue is empty (see namespace/select and j.namespace)");
        }
        const jamoma::StoreReport report = cues_.store(word_of(args[name_at]), keys, position);
        for (const std::string& s : report.skipped) {
            c74::max::object_warn(maxobj(), "new: %s is not a parameter below the address, or has no value", s.c_str());
        }
        return {};
    }};

    /** `update [<name or position>]`: refreshes the values of the lines of a cue (the current one if none is named). */
    message<> m_update{this, "update", MIN_FUNCTION {
        const std::string key = args.empty() ? current_name().value_or("") : word_of(args[0]);
        if (!cues_.update(key)) {
            c74::max::object_error(maxobj(), "update: no such cue");
        }
        return {};
    }};

    /** `append <name> <address> <value...>`: adds a line to a cue, making the cue if there is none. */
    message<> m_append{this, "append", MIN_FUNCTION {
        if (args.size() < 2 || !cues_.append(word_of(args[0]), jamoma_max::to_value(atoms(args.begin() + 1, args.end())))) {
            c74::max::object_error(maxobj(), "append needs a cue name and a line that starts with an absolute address");
        }
        return {};
    }};

    /** `recall <name or position> [<address>]`: sends the lines of a cue to their parameters and out of the left outlet. */
    message<> m_recall{this, "recall", MIN_FUNCTION {
        if (args.empty()) {
            c74::max::object_error(maxobj(), "recall needs a cue");
            return {};
        }
        const jamoma::Address start = args.size() >= 2 ? jamoma::Address::parse(word_of(args[1])) : jamoma::Address();
        recall_and_output(word_of(args[0]), start);
        return {};
    }};

    /** Recalls the cue after the current one. */
    message<> m_next{this, "recall/next", MIN_FUNCTION {
        step(1);
        return {};
    }};

    /** Recalls the cue before the current one. */
    message<> m_previous{this, "recall/previous", MIN_FUNCTION {
        step(-1);
        return {};
    }};

    /** `output <name or position>`: sends the lines of a cue out of the left outlet without applying them. */
    message<> m_output{this, "output", MIN_FUNCTION {
        const jamoma::RecallReport report = cues_.cues().output(args.empty() ? current_name().value_or("") : word_of(args[0]));
        if (!report.found) {
            c74::max::object_error(maxobj(), "output: no such cue");
            return {};
        }
        output_lines(report.entries);
        return {};
    }};

    /** `interpolate <a> <b> <position 0..1>`: sends the blend of two cues. */
    message<> m_interpolate{this, "interpolate", MIN_FUNCTION {
        if (args.size() < 3 || !cues_.cues().interpolate(word_of(args[0]), word_of(args[1]), static_cast<double>(args[2])).found) {
            c74::max::object_error(maxobj(), "interpolate needs two cues that exist and a position");
        }
        return {};
    }};

    /** `mix <cue> <factor> ...`: sends the weighted mix of cues. */
    message<> m_mix{this, "mix", MIN_FUNCTION {
        std::vector<std::pair<std::string, double>> parts;
        for (std::size_t i = 0; i + 1 < args.size(); i += 2) {
            parts.emplace_back(word_of(args[i]), static_cast<double>(args[i + 1]));
        }
        if (parts.empty() || !cues_.cues().mix(parts).found) {
            c74::max::object_error(maxobj(), "mix needs pairs of a cue that exists and a factor");
        }
        return {};
    }};

    /** `move <name or position> <new position>` (positions from 1). */
    message<> m_move{this, "move", MIN_FUNCTION {
        const int p = args.size() >= 2 ? static_cast<int>(args[1]) : 0;
        if (p < 1 || !cues_.cues().move(word_of(args[0]), static_cast<std::size_t>(p - 1))) {
            c74::max::object_error(maxobj(), "move needs a cue and a position that exists");
        }
        return {};
    }};

    /** `delete <name or position>`. */
    message<> m_delete{this, "delete", MIN_FUNCTION {
        if (args.empty() || !cues_.cues().remove(word_of(args[0]))) {
            c74::max::object_error(maxobj(), "delete: no such cue");
        }
        return {};
    }};

    /** `order <name>...`: puts the named cues first, in this order. */
    message<> m_order{this, "order", MIN_FUNCTION {
        std::size_t at = 0;
        for (const atom& a : args) {
            if (cues_.cues().move(word_of(a), at)) {
                ++at;
            } else {
                c74::max::object_error(maxobj(), "order: no cue called %s", word_of(a).c_str());
            }
        }
        return {};
    }};

    /** `rename <name or position> <new name>`. */
    message<> m_rename{this, "rename", MIN_FUNCTION {
        if (args.size() < 2 || !cues_.cues().rename(word_of(args[0]), word_of(args[1]))) {
            c74::max::object_error(maxobj(), "rename needs an existing cue and a new name");
        }
        return {};
    }};

    /** `copy <name or position> <new name> [<position>]`. */
    message<> m_copy{this, "copy", MIN_FUNCTION {
        std::optional<std::size_t> position;
        if (args.size() >= 3 && static_cast<int>(args[2]) >= 1) {
            position = static_cast<std::size_t>(static_cast<int>(args[2]) - 1);
        }
        if (args.size() < 2 || !cues_.cues().copy(word_of(args[0]), word_of(args[1]), position)) {
            c74::max::object_error(maxobj(), "copy needs an existing cue and a new name");
        }
        return {};
    }};

    /** Removes every cue. */
    message<> m_clear{this, "clear", MIN_FUNCTION {
        cues_.cues().clear();
        return {};
    }};

    /** `optimize <name>...`: removes from each cue the lines that repeat what the cues before it left. */
    message<> m_optimize{this, "optimize", MIN_FUNCTION {
        std::vector<std::string> list;
        for (const atom& a : args) {
            list.push_back(word_of(a));
        }
        cues_.optimize(list);
        return {};
    }};

    /** `get <name|description|ramp> <cue>`: answers `<attribute> <cue> <value>` on the dump outlet. */
    message<> m_get{this, "get", MIN_FUNCTION {
        if (args.size() < 2) {
            c74::max::object_error(maxobj(), "get needs an attribute and a cue");
            return {};
        }
        const std::string what = word_of(args[0]), cue = word_of(args[1]);
        const auto description = cues_.description(cue);
        if (!description) {
            c74::max::object_error(maxobj(), "get: %s cue doesn't exist", cue.c_str());
            return {};
        }
        atoms answer{symbol(cue)};
        if (what == "description") {
            answer.push_back(symbol(*description));
        } else if (what == "ramp") {
            answer.push_back(static_cast<int>(cues_.ramp(cue).value_or(0.0)));
        } else if (what == "name") {
            answer.push_back(symbol(cue));
        } else {
            c74::max::object_error(maxobj(), "get: %s attribute doesn't exist", what.c_str());
            return {};
        }
        send(dump_out.max_outlet(), what, answer);
        return {};
    }};

    /** `set <name|description|ramp> <cue> <value...>`. */
    message<> m_set{this, "set", MIN_FUNCTION {
        if (args.size() < 3) {
            c74::max::object_error(maxobj(), "set needs an attribute, a cue and a value");
            return {};
        }
        const std::string what = word_of(args[0]), cue = word_of(args[1]);
        bool ok = false;
        if (what == "description") {
            ok = cues_.set_description(cue, text_of(args, 2));
        } else if (what == "ramp") {
            ok = cues_.set_ramp(cue, static_cast<double>(args[2]));
        } else if (what == "name") {
            ok = cues_.cues().rename(cue, word_of(args[2]));
        }
        if (!ok) {
            c74::max::object_error(maxobj(), "set: cannot set %s of %s", what.c_str(), cue.c_str());
        }
        return {};
    }};

    /** `namespace/select <address>...`: adds addresses to the selection. */
    message<> m_select{this, "namespace/select", MIN_FUNCTION {
        for (const atom& a : args) {
            selection_->set(absolute(word_of(a)), true);
        }
        return {};
    }};

    /** `namespace/unselect <address>...`: removes addresses from the selection. */
    message<> m_unselect{this, "namespace/unselect", MIN_FUNCTION {
        for (const atom& a : args) {
            selection_->set(absolute(word_of(a)), false);
        }
        return {};
    }};

    /** `namespace/grab <cue>`: selects exactly the addresses of a cue. */
    message<> m_grab{this, "namespace/grab", MIN_FUNCTION {
        const jamoma::RecallReport report = cues_.cues().output(args.empty() ? "" : word_of(args[0]));
        if (!report.found) {
            c74::max::object_error(maxobj(), "namespace/grab: no such cue");
            return {};
        }
        selection_->clear();
        for (const auto& entry : report.entries) {
            selection_->set("/" + entry.address.str(), true);
        }
        return {};
    }};

    /** `read [<file>]`: replaces the cues by those of a file (text, or XML if the name ends in `.xml`). */
    message<> m_read{this, "read", MIN_FUNCTION {
        read_file(args.empty() ? jamoma_max::ask_for_file(false, "") : jamoma_max::find_file(word_of(args[0])), args);
        return {};
    }};

    /** Reads the file used last again. */
    message<> m_read_again{this, "read/again", MIN_FUNCTION {
        read_file(last_file_, args);
        return {};
    }};

    /** `write [<file>]`: writes the cues to a file (text, or XML if the name ends in `.xml`). */
    message<> m_write{this, "write", MIN_FUNCTION {
        write_file(args.empty() ? jamoma_max::ask_for_file(true, "cues.txt") : jamoma_max::target_file(patcher(), word_of(args[0])));
        return {};
    }};

    /** Writes the file used last again. */
    message<> m_write_again{this, "write/again", MIN_FUNCTION {
        write_file(last_file_);
        return {};
    }};

    /** Opens the editor window on the cues. */
    message<> m_edit{this, "edit", MIN_FUNCTION {
        open_editor();
        return {};
    }};

    /** A double click on the object opens the editor window. */
    message<> m_dblclick{this, "dblclick", MIN_FUNCTION {
        open_editor();
        return {};
    }};

    /** `edit/apply <text>`: what closing the editor window does, for a patch or a test: words joined by spaces, the two characters `\n` a line break. */
    message<> m_edit_apply{this, "edit/apply", MIN_FUNCTION {
        std::string text = text_of(args, 0);
        for (std::size_t at = text.find("\\n"); at != std::string::npos; at = text.find("\\n", at + 1)) {
            text.replace(at, 2, "\n");
        }
        apply_text(text);
        return {};
    }};

    /** Answers the attributes on the dump outlet. */
    message<> dump{this, "dump", MIN_FUNCTION {
        for (const char* name : {"namespace", "address", "names", "current", "current/position", "current/description", "current/ramp"}) {
            c74::max::t_atom* av = nullptr;
            long ac = 0;
            if (c74::max::object_attr_getvalueof(maxobj(), c74::max::gensym(name), &ac, &av) == c74::max::MAX_ERR_NONE && av != nullptr) {
                c74::max::outlet_anything(dump_out.max_outlet(), c74::max::gensym(name), static_cast<short>(ac), av);
                c74::max::sysmem_freeptr(av);
            }
        }
        return {};
    }};

    /** Class setup: nothing to add; the base class registers the attributes. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION { return {}; }};

private:
    /** @return The patcher of the object. */
    const void* patcher() { return jamoma_max::patcher_of(maxobj()); }

    /** @param a An atom. @return Its text (numbers as written). */
    static std::string word_of(const atom& a)
    {
        const jamoma::Value v = jamoma_max::to_value(atoms{a});
        return v.empty() ? std::string() : v[0].to_string();
    }

    /** @param args Atoms. @param from The first to take. @return Their texts joined by spaces. */
    static std::string text_of(const atoms& args, std::size_t from)
    {
        std::string text;
        for (std::size_t i = from; i < args.size(); ++i) {
            text += (text.empty() ? "" : " ") + word_of(args[i]);
        }
        return text;
    }

    /** @return The name of the current cue, if there is one. */
    std::optional<std::string> current_name() const
    {
        const auto i = cues_.cues().current();
        if (!i) {
            return std::nullopt;
        }
        return cues_.cues().presets().at(*i).name;
    }

    /** @param text An address as written. @return The absolute address (a relative one is taken from the `address` attribute). */
    std::string absolute(const std::string& text) const
    {
        const jamoma::Address a = jamoma::Address::parse(text);
        return a.absolute() ? text : "/" + (cues_.address().path().empty() ? a.str() : cues_.address().append(a).str().substr(1));
    }

    /** Takes up a shared selection. @param name Its name. */
    void set_selection(const std::string& name)
    {
        selection_name_ = name.empty() ? "none" : name;
        selection_ = jamoma::Selection::named(selection_name_);
    }

    /** Sends a message out of an outlet. @param outlet The outlet. @param selector The selector. @param values The arguments. */
    static void send(c74::max::t_outlet* outlet, const std::string& selector, const atoms& values)
    {
        c74::max::outlet_anything(outlet, c74::max::gensym(selector.c_str()), static_cast<short>(values.size()),
                                  values.empty() ? nullptr : const_cast<c74::max::t_atom*>(static_cast<const c74::max::t_atom*>(&values[0])));
    }

    /** Outputs lines `<address> <value...>` out of the left outlet. @param entries The lines (addresses relative to the root). */
    void output_lines(const std::vector<jamoma::PresetEntry>& entries)
    {
        for (const auto& entry : entries) {
            send(line_out.max_outlet(), "/" + entry.address.str(), jamoma_max::to_atoms(entry.value));
        }
    }

    /** Recalls a cue and outputs its lines. @param key The name or position. @param start Only the lines below this address. */
    void recall_and_output(const std::string& key, const jamoma::Address& start)
    {
        const jamoma::RecallReport lines = cues_.cues().output(key);
        if (!lines.found) {
            c74::max::object_error(maxobj(), "recall: no cue called %s", key.c_str());
            return;
        }
        const jamoma::Address from = !start.path().empty() && !start.absolute() ? cues_.address().append(start) : start;
        std::vector<jamoma::PresetEntry> wanted;
        for (const auto& entry : lines.entries) {
            const auto& path = entry.address.path();
            const auto& prefix = from.path();
            if (path.size() >= prefix.size() && std::equal(prefix.begin(), prefix.end(), path.begin())) {
                wanted.push_back(entry);
            }
        }
        output_lines(wanted);
        const jamoma::RecallReport report = cues_.recall(key, start);
        for (const auto& skipped : report.skipped) {
            c74::max::object_warn(maxobj(), "recall: /%s does not exist (any more)", skipped.str().c_str());
        }
    }

    /** Recalls the next or the previous cue. @param direction 1 or -1. */
    void step(int direction)
    {
        const auto i = cues_.cues().current();
        const long wanted = i ? static_cast<long>(*i) + direction : (direction > 0 ? 0 : -1);
        if (wanted < 0 || wanted >= static_cast<long>(cues_.cues().presets().size())) {
            return;
        }
        recall_and_output(cues_.cues().presets().at(static_cast<std::size_t>(wanted)).name, jamoma::Address());
    }

    /** Tells the names of the cues on the dump outlet. @param always Whether to tell them even if they did not change. */
    void report_names(bool always)
    {
        const std::vector<std::string> now = cues_.cues().names();
        if (!always && now == last_names_) {
            return;
        }
        last_names_ = now;
        atoms out;
        for (const auto& n : now) {
            out.push_back(symbol(n));
        }
        send(dump_out.max_outlet(), "names", out);
    }

    /** Replaces the cues by those of a text; problems go to the console. @param text The text. */
    void apply_text(const std::string& text)
    {
        for (const auto& p : cues_.apply_edit_text(text)) {
            c74::max::object_warn(maxobj(), "cues: %s", p.c_str());
        }
    }

    /** Opens the editor window on the text of the cues. */
    void open_editor()
    {
        editor_.open(maxobj(), "cues", cues_.edit_text(), [this](const std::string& text) { apply_text(text); });
    }

    /** Reads cues from a file. @param path The native path (empty: no file). @param message The arguments of the read message, echoed on success. */
    void read_file(const std::string& path, const atoms& message)
    {
        std::ifstream in(path, std::ios::binary);
        if (path.empty() || !in) {
            c74::max::object_error(maxobj(), "read: cannot open the file");
            send(dump_out.max_outlet(), "error", {});
            return;
        }
        std::stringstream text;
        text << in.rdbuf();
        const bool xml = path.size() > 4 && path.compare(path.size() - 4, 4, ".xml") == 0;
        const std::vector<std::string> problems = xml ? cues_.read_xml(text.str()) : cues_.read_text(text.str());
        for (const auto& p : problems) {
            c74::max::object_warn(maxobj(), "read %s: %s", path.c_str(), p.c_str());
        }
        if (!problems.empty() && problems.back().find("nothing changed") != std::string::npos) {
            send(dump_out.max_outlet(), "error", {});
            return;
        }
        last_file_ = path;
        send(dump_out.max_outlet(), "read", message);
    }

    /** Writes the cues to a file. @param path The native path (empty: report that there is no file). */
    void write_file(const std::string& path)
    {
        std::ofstream out;
        if (!path.empty()) {
            out.open(path, std::ios::binary | std::ios::trunc);
        }
        if (!out) {
            c74::max::object_error(maxobj(), "write: cannot write the file (save the patcher first, or give a full path)");
            send(dump_out.max_outlet(), "error", {});
            return;
        }
        const bool xml = path.size() > 4 && path.compare(path.size() - 4, 4, ".xml") == 0;
        out << (xml ? cues_.write_xml() : cues_.write_text());
        last_file_ = path;
    }
};

/** Class setup, called by Max: the Min wrapper, then the method Min does not offer (the editor window sends it when it closes). @param r Max's class registry. */
void ext_main(void* r)
{
    c74::min::wrap_as_max_external<j_cue>("j_cue", __FILE__, r);
    jamoma_max::add_edclose_method<j_cue>("j.cue");
}
