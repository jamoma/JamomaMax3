// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.ui.cpp
 * @brief j.ui: the panel of a model: its address, a menu of what is below it, and its presets.
 *
 * The panel shows the address of the model it is bound to (the model of its patcher, or the one a j.view in it is bound to), or
 * `waiting for a model:address`. A click on the address opens a menu of the parameters, messages and returns below the model; a choice is sent out of
 * the outlet as `model:reference/open <address>`. The menu arrow opens the utilities and presets menu: Create New Preset (stores `preset <n>`, the next
 * free number), Update Current Preset, Delete Preset and the preset names (recall) act on the model's presets directly; the file and window items
 * (Load / Save Presets File, Edit, Open Reference / Help / Internal) are sent out of the outlet as the old messages (`preset:read`, `preset:write/again`,
 * `preset:write`, `preset:edit`, `model:reference/open`, `model:help/open`, `model:internal/open`) for a patch to route to the model. The text is drawn,
 * not edited (Min has no text field). The message `dump` answers `model:address <address>` or `model:waiting`, then `preset:count <n>`, `presets <name>...` and
 * `preset:current <name>`, on the outlet; this is what the own test reads.
 */

#include <memory>
#include <string>
#include <vector>

#include "c74_min.h"

#include "jamoma/explorer.hpp"
#include "jamoma/registry.hpp"
#include "max_address.hpp"
#include "max_context.hpp"

using namespace c74::min;

/** The j.ui external. */
class j_ui : public c74::min::object<j_ui>, public c74::min::ui_operator<300, 70> {
    // State comes before the attributes: Min runs every attribute setter with its default while constructing them.
    std::unique_ptr<jamoma::ModelExplorer> explorer_;  /**< What is below the model. */
    jamoma_max::Alive alive_;                          /**< Lets deferred calls see that the object is gone. */
    jamoma_max::ContextWatch watch_;                   /**< Follows the model coming and going. */
    std::string model_;                                /**< The address of the model the panel is bound to (empty: waiting). */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object. @param args The creation atoms (attributes). */
    explicit j_ui(const atoms& args = {}) : ui_operator::ui_operator{this, args}
    {
        if (c74::min::dummy()) {
            return; // the instance Min builds during class setup has no Max object
        }
        explorer_ = std::make_unique<jamoma::ModelExplorer>(jamoma::Registry::instance().names(), [this] {
            jamoma_max::defer_call(maxobj(), alive_.weak(), [this] { redraw(); });
        });
        jamoma_max::defer_call(maxobj(), alive_.weak(), [this] {
            bind();
            watch_.start([this] { bind(); });
        });
    }

    /** Stops watching before the explorer goes. */
    ~j_ui() override
    {
        watch_.stop();
        explorer_.reset();
    }

    jamoma_max::dump_outlet out{this, "(anything) menu choices and dump"}; /**< The outlet. */

    /** The background colour. */
    attribute<numbers> bgcolor{this, "bgcolor", {0.17, 0.18, 0.20, 1.0}, title{"Background Color"}, style::color};
    /** The border colour. */
    attribute<numbers> bordercolor{this, "bordercolor", {0.45, 0.47, 0.50, 1.0}, title{"Border Color"}, style::color};
    /** The colour of the header. */
    attribute<numbers> headercolor{this, "headercolor", {0.26, 0.28, 0.32, 1.0}, title{"Header Color"}, style::color};
    /** The colour of the text. */
    attribute<numbers> textcolor{this, "textcolor", {0.92, 0.93, 0.95, 1.0}, title{"Text Color"}, style::color};
    /** The tags of the object (accepted so that old patchers load; no effect). */
    attribute<symbol> tags_attribute{this, "tags", ""}; // not named `tags`: Min's ui_operator calls the object's tags() function
    /** The colour of the highlights. */
    attribute<numbers> highlightcolor{this, "highlightcolor", {0.35, 0.60, 0.85, 1.0}, title{"Highlight Color"}, style::color};

    /** Draws the panel. */
    message<> paint{this, "paint", MIN_FUNCTION {
        ui::target t{args};
        draw(t);
        return {};
    }};

    /** A click on the header opens a menu. */
    message<> mouseup{this, "mouseup", MIN_FUNCTION {
        event e{args};
        if (e.y() < kHeader) {
            if (e.x() > e.target().width() - kHeader) {
                open_utilities_menu(e);
            } else {
                open_nodes_menu(e);
            }
        }
        return {};
    }};

    /** Answers the state on the outlet (see the file description). */
    message<> dump{this, "dump", MIN_FUNCTION {
        report();
        return {};
    }};

    /** Class setup: nothing to add. */
    message<> maxclass_setup{this, "maxclass_setup", MIN_FUNCTION { return {}; }};

private:
    static constexpr double kHeader = 22.0; /**< The height of the header. */

    /** @return The colour of an attribute. @param values Its four numbers. */
    static c74::max::t_jrgba rgba(const numbers& values)
    {
        c74::max::t_jrgba c{0.5, 0.5, 0.5, 1.0};
        if (values.size() >= 4) {
            c = {values[0], values[1], values[2], values[3]};
        }
        return c;
    }

    /** Looks for the model again and points the explorer at it. */
    void bind()
    {
        const std::optional<std::string> now = jamoma_max::bound_model_address(maxobj());
        const std::string address = now ? *now : std::string();
        if (address != model_) {
            model_ = address;
            if (explorer_) {
                explorer_->set_model(address.empty() ? jamoma::Address() : jamoma::Address::parse(address));
            }
        }
        redraw();
    }

    /** @return The model the panel is bound to, or null. */
    jamoma::Model* model() const
    {
        if (model_.empty()) {
            return nullptr;
        }
        jamoma::Node* node = jamoma::Registry::instance().names().lookup(jamoma::Address::parse(model_));
        return node != nullptr ? dynamic_cast<jamoma::Model*>(node->object()) : nullptr;
    }

    /** Draws the panel into a target. @param t The target. */
    void draw(ui::target& t)
    {
        c74::max::t_jgraphics* g = t;
        const double w = t.width();
        const double h = t.height();
        c74::max::t_jrgba bg = rgba(bgcolor.get());
        c74::max::t_jrgba border = rgba(bordercolor.get());
        c74::max::t_jrgba header = rgba(headercolor.get());
        c74::max::t_jrgba text = rgba(textcolor.get());
        c74::max::jgraphics_set_source_jrgba(g, &bg);
        c74::max::jgraphics_rectangle(g, 0, 0, w, h);
        c74::max::jgraphics_fill(g);
        if (w >= 40 && h >= 2 * kHeader / 2) {
            c74::max::jgraphics_set_source_jrgba(g, &header);
            c74::max::jgraphics_rectangle(g, 0, 0, w, h < kHeader ? h : kHeader);
            c74::max::jgraphics_fill(g);
            c74::max::jgraphics_set_source_jrgba(g, &text);
            c74::max::jgraphics_select_font_face(g, "Arial", c74::max::JGRAPHICS_FONT_SLANT_NORMAL, c74::max::JGRAPHICS_FONT_WEIGHT_NORMAL);
            c74::max::jgraphics_set_font_size(g, 12.0);
            const std::string title = model_.empty() ? "waiting for a model:address" : model_;
            c74::max::jgraphics_move_to(g, 8.0, 15.0);
            c74::max::jgraphics_show_text(g, title.c_str());
            if (w > kHeader * 2) { // the menu arrow
                c74::max::jgraphics_move_to(g, w - 17.0, 8.0);
                c74::max::jgraphics_line_to(g, w - 7.0, 8.0);
                c74::max::jgraphics_line_to(g, w - 12.0, 15.0);
                c74::max::jgraphics_close_path(g);
                c74::max::jgraphics_fill(g);
            }
        }
        c74::max::jgraphics_set_source_jrgba(g, &border);
        c74::max::jgraphics_set_line_width(g, 1.0);
        c74::max::jgraphics_rectangle(g, 0.5, 0.5, w - 1.0, h - 1.0);
        c74::max::jgraphics_stroke(g);
    }

    /** Opens the menu of what is below the model. @param e The mouse event. */
    void open_nodes_menu(const event& e)
    {
        if (!explorer_ || model_.empty()) {
            return;
        }
        const jamoma::ModelContents c = explorer_->contents();
        std::vector<std::string> items;
        c74::max::t_jpopupmenu* menu = c74::max::jpopupmenu_create();
        const auto add = [&](const char* heading, const std::vector<std::string>& names) {
            if (names.empty()) {
                return;
            }
            c74::max::jpopupmenu_additem(menu, 0, heading, nullptr, 0, 1, nullptr);
            for (const std::string& name : names) {
                items.push_back(name);
                c74::max::jpopupmenu_additem(menu, static_cast<int>(items.size()), name.c_str(), nullptr, 0, 0, nullptr);
            }
            c74::max::jpopupmenu_addseparator(menu);
        };
        add("Parameters", c.parameters);
        add("Messages", c.messages);
        add("Returns", c.returns);
        const int choice = items.empty() ? 0 : c74::max::jpopupmenu_popup_nearbox(menu, maxobj(), e.target().view(), 0);
        c74::max::jpopupmenu_destroy(menu);
        if (choice >= 1 && choice <= static_cast<int>(items.size())) {
            send_symbol("model:reference/open", model_ + "/" + items[static_cast<std::size_t>(choice - 1)]);
        }
    }

    /** Opens the utilities and presets menu. @param e The mouse event. */
    void open_utilities_menu(const event& e)
    {
        jamoma::Model* m = model();
        if (m == nullptr) {
            return;
        }
        const std::vector<const char*> utilities = {"model:reference/open", "model:help/open", "model:internal/open", "preset:edit", "preset:read",
                                                    "preset:write/again", "preset:write"};
        const std::vector<const char*> titles = {"Open Model Reference Page", "Open Model Help Patch", "Open Model Internal", "Edit Current State",
                                                 "Load Presets File", "Save Presets File", "Save Presets File As"};
        c74::max::t_jpopupmenu* menu = c74::max::jpopupmenu_create();
        for (std::size_t i = 0; i < titles.size(); ++i) {
            c74::max::jpopupmenu_additem(menu, static_cast<int>(1 + i), titles[i], nullptr, 0, 0, nullptr);
        }
        c74::max::jpopupmenu_addseparator(menu);
        c74::max::jpopupmenu_additem(menu, 100, "Create New Preset", nullptr, 0, 0, nullptr);
        c74::max::jpopupmenu_additem(menu, 101, "Update Current Preset", nullptr, 0, m->presets().current() ? 0 : 1, nullptr);
        c74::max::jpopupmenu_additem(menu, 102, "Delete Preset", nullptr, 0, m->presets().current() ? 0 : 1, nullptr);
        const std::vector<std::string> names = m->presets().names();
        if (!names.empty()) {
            c74::max::jpopupmenu_addseparator(menu);
        }
        for (std::size_t i = 0; i < names.size(); ++i) {
            const bool current = m->presets().current() && *m->presets().current() == i;
            c74::max::jpopupmenu_additem(menu, static_cast<int>(200 + i), names[i].c_str(), nullptr, current ? 1 : 0, 0, nullptr);
        }
        const int choice = c74::max::jpopupmenu_popup_nearbox(menu, maxobj(), e.target().view(), 0);
        c74::max::jpopupmenu_destroy(menu);
        m = model(); // the menu runs its own event loop: the model may have gone or been made again meanwhile
        if (choice >= 1 && choice <= static_cast<int>(utilities.size())) {
            const std::string item = utilities[static_cast<std::size_t>(choice - 1)];
            if (item.compare(0, 7, "preset:") == 0) {
                c74::max::outlet_anything(out.max_outlet(), c74::max::gensym(item.c_str()), 0, nullptr); // no argument: the model asks for a file
            } else {
                send_symbol(item.c_str(), model_);
            }
        } else if (m == nullptr) {
            return;
        } else if (choice == 100) {
            m->presets().new_preset(m->presets().free_name("preset"));
        } else if (choice == 101 && m->presets().current()) {
            m->presets().update(std::to_string(*m->presets().current() + 1));
        } else if (choice == 102 && m->presets().current()) {
            m->presets().remove(std::to_string(*m->presets().current() + 1));
        } else if (choice >= 200 && choice < 200 + static_cast<int>(names.size())) {
            m->presets().recall(std::to_string(choice - 200 + 1));
        }
        redraw();
    }

    /** Sends `<selector> <symbol>` out of the outlet. @param selector The message. @param argument The argument. */
    void send_symbol(const char* selector, const std::string& argument)
    {
        c74::max::t_atom a;
        c74::max::atom_setsym(&a, c74::max::gensym(argument.c_str()));
        c74::max::outlet_anything(out.max_outlet(), c74::max::gensym(selector), 1, &a);
    }

    /** Answers the state of the panel (the message `dump`). */
    void report()
    {
        if (model_.empty()) {
            c74::max::outlet_anything(out.max_outlet(), c74::max::gensym("model:waiting"), 0, nullptr);
            return;
        }
        send_symbol("model:address", model_);
        jamoma::Model* m = model();
        c74::max::t_atom count;
        c74::max::atom_setlong(&count, m == nullptr ? 0 : static_cast<c74::max::t_atom_long>(m->presets().names().size()));
        c74::max::outlet_anything(out.max_outlet(), c74::max::gensym("preset:count"), 1, &count);
        if (m == nullptr || m->presets().names().empty()) {
            return;
        }
        std::vector<c74::max::t_atom> list;
        for (const std::string& name : m->presets().names()) {
            list.emplace_back();
            c74::max::atom_setsym(&list.back(), c74::max::gensym(name.c_str()));
        }
        c74::max::outlet_anything(out.max_outlet(), c74::max::gensym("presets"), static_cast<short>(list.size()), list.data());
        if (m->presets().current()) {
            send_symbol("preset:current", m->presets().names()[*m->presets().current()]);
        }
    }
};

MIN_EXTERNAL(j_ui);
