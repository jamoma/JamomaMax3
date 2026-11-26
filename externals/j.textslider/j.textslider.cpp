// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.textslider.cpp
 * @brief j.textslider: a slider that shows a text and, while the mouse is over it, its value.
 *
 * One inlet, one outlet (the value). The arithmetic is jamoma/slider.hpp, the behaviour that of the old object (docs/inventory/j.textslider.md):
 * `int` and `float` give a value that is output as it is and drawn limited to the range, `set` the same without output, `bang` outputs it.
 * A click jumps to the position (`clickjump`), a drag moves it (Command: whole numbers; Shift: fine), Control and a double click give
 * `defaultvalue`. Values are accepted on any thread and output on it; drawing happens on the main thread.
 *
 * Colours follow the Max theme: a colour attribute that has its default takes the theme's colour for that part (track and border
 * `live_control_bg`, bar `live_selection`, text `live_control_fg`, knob `live_value_bar`), and those theme colours are adjusted where needed so that
 * the text can be read (jamoma/readable_colours.hpp). A colour the user sets is used as it is.
 */

#include <atomic>
#include <cmath>
#include <string>

#include "c74_min.h"

#include "jamoma/readable_colours.hpp"
#include "jamoma/slider.hpp"
#include "max_attributes.hpp"
#include "max_context.hpp"

using namespace c74::min;
using namespace c74::min::ui;

/** The j.textslider external. */
class j_textslider : public c74::min::object<j_textslider>, public c74::min::ui_operator<160, 20> {
    // State comes before the attributes: Min runs every attribute setter with its default while constructing them.
    std::atomic<double> value_{0.0};   /**< The value last given (not limited to the range). */
    std::atomic<bool> over_{false};    /**< Whether the mouse is over the box. */
    double anchor_ = 0.0;              /**< The value the drag moves. */
    double last_x_ = 0.0, last_y_ = 0.0;  /**< Where the pointer was at the last drag step. */
    jamoma_max::Alive alive_;          /**< Lets deferred calls see that the object is gone. */
    jamoma_max::Settle settle_;        /**< Redraws once for a burst of values. */

public:
    /** The reference pages are written by hand (docs/refpages); Min must not generate stubs next to them. */
    const c74::min::flags class_flags { c74::min::documentation_flags::do_not_generate };

    /** Creates the object. @param args The creation atoms (attributes). */
    explicit j_textslider(const atoms& args = {}) : ui_operator::ui_operator{this, args} {}

    inlet<> input{this, "(int, float) the value; set, bang"};       /**< The inlet. */
    outlet<> out{this, "(float) the value"};                        /**< Outlet 0. */

    // The default of every colour means "follow the Max theme" (see theme_colour); any other value is the user's and is used as it is.
    /** The background colour. */
    attribute<numbers> bgcolor{this, "bgcolor", {0.172, 0.172, 0.172, 1.0}, title{"Background Color"}, style::color,
        setter{MIN_FUNCTION { return jamoma_max::values_or_default(args, {0.172, 0.172, 0.172, 1.0}); }}};
    /** The colour of the bar. */
    attribute<numbers> fgcolor{this, "fgcolor", {0.199, 0.347, 0.529, 1.0}, title{"Foreground Color"}, style::color,
        setter{MIN_FUNCTION { return jamoma_max::values_or_default(args, {0.199, 0.347, 0.529, 1.0}); }}};
    /** The border colour. */
    attribute<numbers> bordercolor{this, "bordercolor", {0.35, 0.35, 0.35, 1.0}, title{"Border Color"}, style::color,
        setter{MIN_FUNCTION { return jamoma_max::values_or_default(args, {0.35, 0.35, 0.35, 1.0}); }}};
    /** The colour of the text. */
    attribute<numbers> textcolor{this, "textcolor", {0.85, 0.85, 0.85, 1.0}, title{"Text Color"}, style::color,
        setter{MIN_FUNCTION { return jamoma_max::values_or_default(args, {0.85, 0.85, 0.85, 1.0}); }}};
    /** The colour of the line at the end of the bar. */
    attribute<numbers> knobcolor{this, "knobcolor", {0.594, 0.721, 0.928, 1.0}, title{"Knob Color"}, style::color,
        setter{MIN_FUNCTION { return jamoma_max::values_or_default(args, {0.594, 0.721, 0.928, 1.0}); }}};

    /** The range, `low high`; the ends are swapped if the second is smaller. */
    attribute<numbers> range_attribute{this, "range", {0.0, 1.0}, title{"Range"}, setter{MIN_FUNCTION {
        double low = args.empty() ? 0.0 : static_cast<double>(args[0]);
        double high = args.size() < 2 ? 1.0 : static_cast<double>(args[1]);
        if (high < low) {
            std::swap(low, high);
        }
        refresh();
        return {low, high};
    }}};

    /** Where the text starts: pixels from the left and from the top. */
    attribute<numbers> textpos{this, "textpos", {10.0, 4.0}, title{"Text position"},
        setter{MIN_FUNCTION { return jamoma_max::values_or_default(args, {10.0, 4.0}); }}};

    /** The text shown. */
    attribute<symbol> text_attribute{this, "text", "textslider", title{"Displayed Text"}}; // not named text: Min's ui_operator calls the object's text()

    /** The unit shown after the value. */
    attribute<symbol> unit{this, "unit", "", title{"Displayed Unit"}};

    /** Which movement of the mouse moves the value: horizontal, vertical or both (the larger one). */
    attribute<symbol> tracking{this, "tracking", "horizontal", title{"Mouse Tracking"}, range{"horizontal", "vertical", "both"}};

    /** Whether a click jumps to the value under the pointer. */
    attribute<int> clickjump{this, "clickjump", 1, title{"Jump to Value on Mouse Down"}, style::onoff};

    /** Whether the value is shown while the mouse is over the box. */
    attribute<int> showvalue{this, "showvalue", 1, title{"Shows Value while editing & hovering"}, style::onoff};

    /** The value of Control and a double click. */
    attribute<double> defaultvalue{this, "defaultvalue", 0.0, title{"Default value"}};

    /** A number: kept, output and drawn. */
    message<threadsafe::yes> m_int{this, "int", MIN_FUNCTION {
        give(static_cast<double>(args[0]));
        return {};
    }};
    /** A number: kept, output and drawn. */
    message<threadsafe::yes> m_float{this, "float", MIN_FUNCTION {
        give(static_cast<double>(args[0]));
        return {};
    }};

    /** `set <number>`: the same without output. */
    message<threadsafe::yes> m_set{this, "set", MIN_FUNCTION {
        if (!args.empty()) {
            value_ = static_cast<double>(args[0]);
            refresh();
        }
        return {};
    }};

    /** Outputs the value. */
    message<threadsafe::yes> m_bang{this, "bang", MIN_FUNCTION {
        out.send(value_.load());
        return {};
    }};

    /** Draws the slider. */
    message<> paint{this, "paint", MIN_FUNCTION {
        ui::target t{args};
        draw(t);
        return {};
    }};

    /** A click: jumps to the position if clickjump is on, and starts a drag. */
    message<> mousedown{this, "mousedown", MIN_FUNCTION {
        event e{args};
        last_x_ = e.x();
        last_y_ = e.y();
        if (static_cast<int>(clickjump.get()) != 0) {
            double v = jamoma::slider_value_at(e.x(), e.target().width(), low(), high());
            if (e.is_command_key_down()) {
                v = std::trunc(v);
            }
            give(v);
        }
        anchor_ = std::min(std::max(value_.load(), low()), high());
        return {};
    }};

    /** A drag moves the value. */
    message<> mousedrag{this, "mousedrag", MIN_FUNCTION {
        event e{args};
        const double dx = e.x() - last_x_, dy = e.y() - last_y_;
        last_x_ = e.x();
        last_y_ = e.y();
        const std::string mode = static_cast<symbol>(tracking.get()).c_str();
        const double move = mode == "vertical" ? -dy : (mode == "both" && std::fabs(dy) > std::fabs(dx)) ? -dy : dx;
        const double fineness = e.is_command_key_down() ? 0.8 : e.is_shift_key_down() ? 50.0 : 1.0;
        anchor_ = jamoma::slider_drag(anchor_, move, e.target().width(), low(), high(), fineness);
        give(e.is_command_key_down() ? std::trunc(anchor_) : anchor_);
        return {};
    }};

    /** Control and a double click give the default value. */
    message<> mousedoubleclick{this, "mousedoubleclick", MIN_FUNCTION {
        event e{args};
        if ((e.modifiers() & c74::max::eControlKey) != 0) {
            anchor_ = static_cast<double>(defaultvalue.get());
            give(anchor_);
        }
        return {};
    }};

    /** The pointer arrives: the value is shown. */
    message<> mouseenter{this, "mouseenter", MIN_FUNCTION {
        over_ = true;
        redraw();
        return {};
    }};

    /** The pointer leaves: the text is shown. */
    message<> mouseleave{this, "mouseleave", MIN_FUNCTION {
        over_ = false;
        redraw();
        return {};
    }};

private:
    /** @return The low end of the range. */
    double low() { return range_attribute.get().empty() ? 0.0 : range_attribute.get()[0]; }
    /** @return The high end of the range. */
    double high() { return range_attribute.get().size() < 2 ? 1.0 : range_attribute.get()[1]; }

    /** Keeps a value, outputs it and redraws. @param v The value. */
    void give(double v)
    {
        value_ = v;
        out.send(v);
        refresh();
    }

    /** Asks for a redraw on the main thread (once for a burst of values). */
    void refresh()
    {
        if (c74::min::dummy() || maxobj() == nullptr) {
            return;
        }
        settle_.request(maxobj(), alive_.weak(), [this] { redraw(); });
    }

    /** @param g The graphics context. @param c A colour. */
    static void colour(c74::max::t_jgraphics* g, const jamoma::Rgba& c) { c74::max::jgraphics_set_source_rgba(g, c.r, c.g, c.b, c.a); }

    /**
     * The colour of one part: the attribute if the user set it, else the colour of that part in the current Max theme (the default of the
     * attribute if the theme has none).
     * @param value The attribute. @param fallback Its default. @param theme The name of the theme colour.
     * @param[out] follows Set to true if the theme colour is used. @return The colour.
     */
    static jamoma::Rgba theme_colour(const numbers& value, const jamoma::Rgba& fallback, const char* theme, bool& follows)
    {
        const jamoma::Rgba given{value.size() > 0 ? value[0] : fallback.r, value.size() > 1 ? value[1] : fallback.g,
                                 value.size() > 2 ? value[2] : fallback.b, value.size() > 3 ? value[3] : fallback.a};
        const bool is_default = std::fabs(given.r - fallback.r) < 1e-4 && std::fabs(given.g - fallback.g) < 1e-4
                                && std::fabs(given.b - fallback.b) < 1e-4 && std::fabs(given.a - fallback.a) < 1e-4;
        follows = false;
        if (!is_default) {
            return given;
        }
        c74::max::t_jrgba on{}, off{};
        if (c74::max::jcolor_getcolor(c74::max::gensym(theme), &on, &off) != 0) {
            return given;
        }
        follows = true;
        return {on.red, on.green, on.blue, on.alpha};
    }

    /** @return The colours to draw with now: the theme's or the user's, with the theme colours adjusted so that the text can be read. */
    jamoma::SliderColours drawing_colours()
    {
        jamoma::SliderColours c;
        jamoma::Adjustable follows;
        bool track = false, border = false;
        c.track = theme_colour(bgcolor.get(), {0.172, 0.172, 0.172, 1.0}, "live_control_bg", track);
        c.bar = theme_colour(fgcolor.get(), {0.199, 0.347, 0.529, 1.0}, "live_selection", follows.bar);
        c.text = theme_colour(textcolor.get(), {0.85, 0.85, 0.85, 1.0}, "live_control_fg", follows.text);
        c.knob = theme_colour(knobcolor.get(), {0.594, 0.721, 0.928, 1.0}, "live_value_bar", follows.knob);
        c.border = theme_colour(bordercolor.get(), {0.35, 0.35, 0.35, 1.0}, "live_control_bg", border);
        return jamoma::readable_colours(c, follows);
    }

    /** Draws the slider into a target. @param t The target. */
    void draw(ui::target& t)
    {
        c74::max::t_jgraphics* g = t;
        const double w = t.width(), h = t.height();
        const jamoma::SliderColours colours = drawing_colours();
        colour(g, colours.track);
        c74::max::jgraphics_rectangle(g, 0, 0, w, h);
        c74::max::jgraphics_fill(g);
        colour(g, colours.border);
        c74::max::jgraphics_set_line_width(g, 2.0);
        c74::max::jgraphics_rectangle(g, 0, 0, w, h);
        c74::max::jgraphics_stroke(g);
        const double place = jamoma::slider_normalised(value_.load(), low(), high());
        if (place > 0.0 && w > 3.0 && h > 2.0) {
            const double position = (w - 3.0) * place + 1.0;
            colour(g, colours.bar);
            c74::max::jgraphics_rectangle(g, 1.0, 1.0, position, h - 2.0);
            c74::max::jgraphics_fill(g);
            colour(g, colours.knob);
            c74::max::jgraphics_set_line_width(g, 2.0);
            c74::max::jgraphics_move_to(g, position, 1.0);
            c74::max::jgraphics_line_to(g, position, h - 1.0);
            c74::max::jgraphics_stroke(g);
        }
        const std::string shown = over_ && static_cast<int>(showvalue.get()) != 0
            ? jamoma::slider_value_text(value_.load(), static_cast<symbol>(unit.get()).c_str())
            : std::string(static_cast<symbol>(text_attribute.get()).c_str());
        const numbers at = textpos.get();
        colour(g, colours.text);
        c74::max::jgraphics_save(g);
        c74::max::jgraphics_clip(g, 0, 0, w, h);
        c74::max::jgraphics_select_font_face(g, "Arial", c74::max::JGRAPHICS_FONT_SLANT_NORMAL, c74::max::JGRAPHICS_FONT_WEIGHT_NORMAL);
        c74::max::jgraphics_set_font_size(g, 10.0);
        c74::max::jgraphics_move_to(g, at.empty() ? 10.0 : at[0], (at.size() < 2 ? 4.0 : at[1]) + 10.0);
        c74::max::jgraphics_show_text(g, shown.c_str());
        c74::max::jgraphics_restore(g);
    }
};

MIN_EXTERNAL(j_textslider);
