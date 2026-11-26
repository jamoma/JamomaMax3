// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file max_editor.hpp
 * @brief A text editor window of Max (the `jed` object) for an external: show a text, get the edited text back when the window is closed.
 *
 * Max tells the owner of an editor that it was closed with the method `edclose(char** text, long size)`, which Min does not offer, so a
 * class that uses a TextEditor adds that one method after Min has registered it (add_edclose_method). Everything runs on the main thread.
 */

#pragma once

#include <functional>
#include <string>
#include <utility>

#include "c74_min.h"

namespace jamoma_max {

/** One editor window of an object. */
class TextEditor {
public:
    TextEditor() = default;
    ~TextEditor() { close(); }
    TextEditor(const TextEditor&) = delete;            /**< An editor is never copied. */
    TextEditor& operator=(const TextEditor&) = delete; /**< An editor is never assigned. */

    /**
     * @brief Opens the window, or brings it to the front if it is open already.
     * @param owner The Max object that gets the edclose message (the box object of the external).
     * @param title The title of the window.
     * @param text The text to edit.
     * @param on_close Called with the text when the window is closed (not after close() or the destruction of the editor).
     * @return True if a window was opened, false if the one that was open was brought to the front.
     */
    bool open(c74::max::t_object* owner, const std::string& title, const std::string& text, std::function<void(const std::string&)> on_close)
    {
        if (editor_ != nullptr) {
            c74::max::object_attr_setchar(editor_, c74::max::gensym("visible"), 1);
            return false;
        }
        editor_ = static_cast<c74::max::t_object*>(c74::max::object_new(c74::max::CLASS_NOBOX, c74::max::gensym("jed"), owner, 0));
        if (editor_ == nullptr) {
            return false;
        }
        on_close_ = std::move(on_close);
        c74::max::object_attr_setchar(editor_, c74::max::gensym("scratch"), 1);
        c74::max::object_attr_setsym(editor_, c74::max::gensym("title"), c74::max::gensym(title.c_str()));
        c74::max::object_method(editor_, c74::max::gensym("settext"), text.c_str(), c74::max::gensym("utf-8"));
        return true;
    }

    /** @return True while a window is open. */
    bool is_open() const noexcept { return editor_ != nullptr; }

    /** @brief Closes the window without telling anyone (used when the object goes away). */
    void close()
    {
        on_close_ = nullptr;
        if (editor_ != nullptr) {
            c74::max::t_object* e = editor_;
            editor_ = nullptr;
            c74::max::object_free(e);
        }
    }

    /**
     * @brief What the edclose message of Max calls: the window is gone, hand the text on.
     * @param text Max's pointer to the text (may be null).
     * @param size The size of the text.
     */
    void closed(char** text, long size)
    {
        editor_ = nullptr;
        auto callback = std::move(on_close_);
        on_close_ = nullptr;
        if (callback && text != nullptr && *text != nullptr) {
            callback(std::string(*text, static_cast<std::size_t>(size < 0 ? 0 : size)));
        }
    }

private:
    c74::max::t_object* editor_ = nullptr;               /**< The jed object, or null. */
    std::function<void(const std::string&)> on_close_;   /**< What to do with the edited text. */
};

/** The Max method that hands the edited text to the editor of the Min object. @tparam T The Min class (it has `jamoma_max::TextEditor& editor()`). @param self The Max object. @param text The text. @param size Its size. */
template <class T>
void edclose_thunk(c74::max::t_object* self, char** text, long size)
{
    reinterpret_cast<c74::min::minwrap<T>*>(self)->m_min_object.editor().closed(text, size);
}

/**
 * @brief Adds the `edclose` method to a Min class that has been registered; call it from ext_main after wrap_as_max_external.
 * @tparam T The Min class.
 * @param max_class_name The name the class has in Max (for example "j.model").
 */
template <class T>
void add_edclose_method(const char* max_class_name)
{
    c74::max::t_class* c = c74::max::class_findbyname(c74::max::gensym("box"), c74::max::gensym(max_class_name));
    if (c != nullptr) {
        c74::max::class_addmethod(c, reinterpret_cast<c74::max::method>(&edclose_thunk<T>), "edclose", c74::max::A_CANT, 0);
    }
}

} // namespace jamoma_max
