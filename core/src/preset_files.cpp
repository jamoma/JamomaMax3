// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file preset_files.cpp
 * @brief Reading and writing presets as text and XML (see preset_files.hpp).
 */

#include "jamoma/preset_files.hpp"

#include <cctype>
#include <cstdint>
#include <cstdlib>

namespace jamoma {

namespace {

/** @param c A character. @return True for a space, tab or carriage return (not a newline). */
bool is_blank(char c) { return c == ' ' || c == '\t' || c == '\r'; }

/** @param text A text. @return The text without blanks at both ends. */
std::string_view trim(std::string_view text)
{
    while (!text.empty() && (is_blank(text.front()) || text.front() == '\n')) {
        text.remove_prefix(1);
    }
    while (!text.empty() && (is_blank(text.back()) || text.back() == '\n')) {
        text.remove_suffix(1);
    }
    return text;
}

/**
 * Splits text into words; text in double quotes (with `\"` and `\\`) is one word.
 * @param text The text. @param quoted Set per word to true if it was quoted. @return The words.
 */
std::vector<std::string> split_words(std::string_view text, std::vector<bool>& quoted)
{
    std::vector<std::string> words;
    std::size_t i = 0;
    while (i < text.size()) {
        if (is_blank(text[i]) || text[i] == '\n') {
            ++i;
            continue;
        }
        std::string word;
        if (text[i] == '"') {
            ++i;
            while (i < text.size() && text[i] != '"') {
                if (text[i] == '\\' && i + 1 < text.size()) {
                    ++i;
                }
                word += text[i++];
            }
            if (i < text.size()) {
                ++i;
            }
            quoted.push_back(true);
        } else {
            while (i < text.size() && !is_blank(text[i]) && text[i] != '\n') {
                word += text[i++];
            }
            quoted.push_back(false);
        }
        words.push_back(std::move(word));
    }
    return words;
}

/** @param word A word. @return The atom it stands for: an integer, a number, else a symbol. */
Atom to_atom(const std::string& word)
{
    const char* begin = word.c_str();
    char* end = nullptr;
    bool digit = false;
    for (char c : word) {
        digit = digit || (c >= '0' && c <= '9');
    }
    if (digit && (std::isdigit(static_cast<unsigned char>(word[0])) || word[0] == '-' || word[0] == '+' || word[0] == '.')) {
        bool integer = true;
        for (std::size_t i = 0; i < word.size(); ++i) {
            const char c = word[i];
            integer = integer && ((c >= '0' && c <= '9') || (i == 0 && (c == '-' || c == '+')));
        }
        if (integer && word.size() < 19) {
            return Atom(static_cast<std::int64_t>(std::strtoll(begin, nullptr, 10)));
        }
        const double d = std::strtod(begin, &end);
        if (end != nullptr && *end == '\0') {
            return Atom(d);
        }
    }
    return Atom(word);
}

/** @param value A value. @return The words of the value, in the text form (quoted where a word needs it). */
std::string value_text(const Value& value)
{
    std::string out;
    for (std::size_t i = 0; i < value.size(); ++i) {
        if (i != 0) {
            out += ' ';
        }
        const std::string word = value[i].to_string();
        const bool needs_quotes = value[i].is_symbol() && (word.empty() || word.find_first_of(" \t\n\"") != std::string::npos || to_atom(word).is_number());
        if (needs_quotes) {
            out += '"';
            for (char c : word) {
                if (c == '"' || c == '\\') {
                    out += '\\';
                }
                out += c;
            }
            out += '"';
        } else {
            out += word;
        }
    }
    return out;
}

/** @param text A text. @return The text in double quotes with the quotes and backslashes escaped. */
std::string quote(const std::string& text)
{
    std::string out = "\"";
    for (char c : text) {
        if (c == '"' || c == '\\') {
            out += '\\';
        }
        out += c;
    }
    return out + '"';
}

/** @param words Words with their quoting flags. @param from The first word to use. @return The atoms of the words (a quoted word is always a symbol). */
Value atoms_from(const std::vector<std::string>& words, const std::vector<bool>& quoted, std::size_t from)
{
    Value value;
    for (std::size_t i = from; i < words.size(); ++i) {
        value.push_back(quoted[i] ? Atom(words[i]) : to_atom(words[i]));
    }
    return value;
}

} // namespace

ReadResult read_presets_text(std::string_view text)
{
    ReadResult result;
    Preset* current = nullptr;
    std::size_t line_number = 0;
    std::size_t pos = 0;
    while (pos < text.size()) {
        std::size_t end = text.find('\n', pos);
        if (end == std::string_view::npos) {
            end = text.size();
        }
        const std::string_view line = trim(text.substr(pos, end - pos));
        pos = end + 1;
        ++line_number;
        if (line.empty()) {
            continue;
        }
        const std::string where = "line " + std::to_string(line_number) + ": ";
        if (line.front() == '#') {
            if (current != nullptr) {
                current->flags.emplace_back(line);
            }
            continue;
        }
        std::vector<bool> quoted;
        if (line.size() >= 2 && line[0] == '-' && is_blank(line[1])) {
            const std::vector<std::string> words = split_words(line.substr(2), quoted);
            if (words.empty()) {
                result.problems.push_back(where + "an empty flag");
            } else if (words[0] == "preset") {
                result.presets.emplace_back();
                current = &result.presets.back();
                current->name = words.size() > 1 ? words[1] : std::string();
                if (words.size() < 2) {
                    result.problems.push_back(where + "a preset without a name");
                }
            } else if (current == nullptr) {
                result.problems.push_back(where + "a flag before the first preset");
            } else if (words[0] == "description") {
                current->description = words.size() > 1 ? words[1] : std::string();
            } else {
                current->flags.emplace_back(trim(line.substr(2)));
            }
            continue;
        }
        const std::vector<std::string> words = split_words(line, quoted);
        if (current == nullptr) {
            result.problems.push_back(where + "a command before the first preset");
        } else if (words[0] == "WAIT") {
            result.problems.push_back(where + "WAIT is not supported");
        } else if (words.size() < 2) {
            result.problems.push_back(where + "a command without a value: " + words[0]);
        } else {
            current->entries.push_back({Address::parse(words[0]), atoms_from(words, quoted, 1)});
        }
    }
    return result;
}

std::string write_presets_text(const std::vector<Preset>& presets)
{
    std::string out;
    for (const Preset& p : presets) {
        out += "\n- preset " + quote(p.name) + "\n";
        if (!p.description.empty()) {
            out += "- description " + quote(p.description) + "\n";
        }
        for (const std::string& flag : p.flags) {
            out += (flag.empty() || flag[0] == '#') ? flag : "- " + flag;
            out += '\n';
        }
        for (const PresetEntry& e : p.entries) {
            out += e.address.str() + " " + value_text(e.value) + "\n";
        }
    }
    return out;
}

namespace {

/** @param text Text. @param attribute True inside an attribute (quotes are escaped too). @return The text with the XML special characters escaped. */
std::string escape(const std::string& text, bool attribute)
{
    std::string out;
    for (char c : text) {
        switch (c) {
        case '&': out += "&amp;"; break;
        case '<': out += "&lt;"; break;
        case '>': out += "&gt;"; break;
        case '"': out += attribute ? "&quot;" : "\""; break;
        default: out += c;
        }
    }
    return out;
}

/** @param text Text with entities. @return The text with `&amp;`, `&lt;`, `&gt;`, `&quot;`, `&apos;` and numeric references replaced. */
std::string unescape(std::string_view text)
{
    std::string out;
    for (std::size_t i = 0; i < text.size(); ++i) {
        if (text[i] != '&') {
            out += text[i];
            continue;
        }
        const std::size_t semi = text.find(';', i);
        if (semi == std::string_view::npos || semi - i > 10) {
            out += text[i];
            continue;
        }
        const std::string_view name = text.substr(i + 1, semi - i - 1);
        if (name == "amp") out += '&';
        else if (name == "lt") out += '<';
        else if (name == "gt") out += '>';
        else if (name == "quot") out += '"';
        else if (name == "apos") out += '\'';
        else if (!name.empty() && name[0] == '#') {
            const long code = name.size() > 1 && (name[1] == 'x' || name[1] == 'X') ? std::strtol(std::string(name.substr(2)).c_str(), nullptr, 16)
                                                                                     : std::strtol(std::string(name.substr(1)).c_str(), nullptr, 10);
            if (code > 0 && code < 128) {
                out += static_cast<char>(code);
            } else if (code >= 128 && code < 0x800) {
                out += static_cast<char>(0xC0 | (code >> 6));
                out += static_cast<char>(0x80 | (code & 0x3F));
            } else if (code >= 0x800 && code < 0x10000) {
                out += static_cast<char>(0xE0 | (code >> 12));
                out += static_cast<char>(0x80 | ((code >> 6) & 0x3F));
                out += static_cast<char>(0x80 | (code & 0x3F));
            } else {
                out += text.substr(i, semi - i + 1);
            }
        } else {
            out += text.substr(i, semi - i + 1);
        }
        i = semi;
    }
    return out;
}

/** A parsed tag. */
struct Tag {
    std::string name;                                        /**< The element name. */
    std::vector<std::pair<std::string, std::string>> attrs;  /**< The attributes with their values (unescaped). */
    bool closing = false;                                    /**< `</name>`. */
    bool self_closing = false;                               /**< `<name/>`. */
    bool ok = true;                                          /**< False if the tag was damaged. */

    /** @param key An attribute name. @return Its value or an empty string. */
    std::string attr(const std::string& key) const
    {
        for (const auto& a : attrs) {
            if (a.first == key) {
                return a.second;
            }
        }
        return {};
    }
    /** @param key An attribute name. @return True if there is one. */
    bool has(const std::string& key) const
    {
        for (const auto& a : attrs) {
            if (a.first == key) {
                return true;
            }
        }
        return false;
    }
};

/** @param body The text between `<` and `>`. @return The parsed tag. */
Tag parse_tag(std::string_view body)
{
    Tag tag;
    std::size_t i = 0;
    if (!body.empty() && body[0] == '/') {
        tag.closing = true;
        ++i;
    }
    while (i < body.size() && !std::isspace(static_cast<unsigned char>(body[i])) && body[i] != '/') {
        tag.name += body[i++];
    }
    while (i < body.size()) {
        while (i < body.size() && std::isspace(static_cast<unsigned char>(body[i]))) {
            ++i;
        }
        if (i >= body.size()) {
            break;
        }
        if (body[i] == '/') {
            tag.self_closing = true;
            ++i;
            continue;
        }
        std::string key;
        while (i < body.size() && body[i] != '=' && !std::isspace(static_cast<unsigned char>(body[i])) && body[i] != '/') {
            key += body[i++];
        }
        while (i < body.size() && std::isspace(static_cast<unsigned char>(body[i]))) {
            ++i;
        }
        if (i >= body.size() || body[i] != '=') {
            tag.ok = false;
            continue;
        }
        ++i;
        while (i < body.size() && std::isspace(static_cast<unsigned char>(body[i]))) {
            ++i;
        }
        if (i >= body.size() || (body[i] != '"' && body[i] != '\'')) {
            tag.ok = false;
            break;
        }
        const char quote_char = body[i++];
        const std::size_t close = body.find(quote_char, i);
        if (close == std::string_view::npos) {
            tag.ok = false;
            break;
        }
        tag.attrs.emplace_back(key, unescape(body.substr(i, close - i)));
        i = close + 1;
    }
    return tag;
}

} // namespace

std::string write_presets_xml(const std::vector<Preset>& presets)
{
    std::string out = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n"
                      "<jamoma version=\"0.6\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://jamoma.org/ file:jamoma.xsd\">\n";
    for (const Preset& p : presets) {
        out += " <preset name=\"" + escape(p.name, true) + "\">\n";
        if (!p.description.empty()) {
            out += "  <flag name=\"description\">" + escape(p.description, false) + "</flag>\n";
        }
        for (const std::string& flag : p.flags) {
            if (!flag.empty() && flag[0] == '#') {
                std::string comment = flag.substr(1);
                if (!comment.empty() && comment[0] == ' ') {
                    comment.erase(0, 1);
                }
                std::string safe;
                for (char c : comment) {
                    safe += (c == '-' && !safe.empty() && safe.back() == '-') ? ' ' : c;
                }
                out += "  <!--" + safe + "-->\n";
            } else {
                const std::size_t space = flag.find(' ');
                out += "  <flag name=\"" + escape(flag.substr(0, space), true) + "\">" +
                       escape(space == std::string::npos ? std::string() : flag.substr(space + 1), false) + "</flag>\n";
            }
        }
        for (const PresetEntry& e : p.entries) {
            Value value = e.value;
            std::string ramp;
            if (value.size() >= 2 && value[value.size() - 2].is_symbol() && value[value.size() - 2].as_symbol() == "ramp") {
                ramp = value.back().to_string();
                value.resize(value.size() - 2);
            }
            out += "  <command address=\"" + escape(e.address.str(), true) + "\"" + (ramp.empty() ? "" : " ramp=\"" + escape(ramp, true) + "\"") + ">" +
                   escape(value_text(value), false) + "</command>\n";
        }
        out += " </preset>\n";
    }
    return out + "</jamoma>\n";
}

ReadResult read_presets_xml(std::string_view text)
{
    ReadResult result;
    if (trim(text).empty()) {
        result.problems.push_back("the file is empty");
        return result;
    }
    std::vector<std::string> open;       // names of the open elements
    std::vector<std::string> scripts;    // address prefixes of the open <script> elements
    Preset* current = nullptr;
    Tag pending;                         // the command or flag whose text is being read
    std::string pending_text;
    bool in_leaf = false;
    bool saw_root = false;
    std::size_t i = 0;
    while (i < text.size()) {
        if (text[i] != '<') {
            const std::size_t next = text.find('<', i);
            const std::size_t stop = next == std::string_view::npos ? text.size() : next;
            if (in_leaf) {
                pending_text += text.substr(i, stop - i);
            }
            i = stop;
            continue;
        }
        if (text.compare(i, 4, "<!--") == 0) {
            const std::size_t close = text.find("-->", i + 4);
            if (close == std::string_view::npos) {
                result.problems.push_back("a comment that never ends");
                i = text.size();
                break;
            }
            if (current != nullptr) {
                std::string_view comment = trim(text.substr(i + 4, close - i - 4));
                current->flags.push_back("# " + std::string(comment));
            }
            i = close + 3;
            continue;
        }
        if (text.compare(i, 2, "<?") == 0) {
            const std::size_t close = text.find("?>", i + 2);
            i = close == std::string_view::npos ? text.size() : close + 2;
            continue;
        }
        const std::size_t close = text.find('>', i + 1);
        if (close == std::string_view::npos) {
            result.problems.push_back("the file ends inside a tag");
            i = text.size();
            break;
        }
        const Tag tag = parse_tag(text.substr(i + 1, close - i - 1));
        i = close + 1;
        if (!tag.ok || tag.name.empty()) {
            result.problems.push_back("a damaged tag");
            continue;
        }
        if (tag.closing) {
            if (!open.empty() && open.back() == tag.name) {
                open.pop_back();
            } else {
                result.problems.push_back("the closing tag </" + tag.name + "> has no matching opening tag");
                continue;
            }
            if (in_leaf && (tag.name == "command" || tag.name == "flag")) {
                in_leaf = false;
                if (current != nullptr) {
                    if (tag.name == "flag") {
                        const std::string name = pending.attr("name");
                        const std::string body = std::string(trim(unescape(pending_text)));
                        if (name == "description") {
                            current->description = body;
                        } else {
                            current->flags.push_back(body.empty() ? name : name + " " + body);
                        }
                    } else {
                        std::vector<bool> quoted;
                        const std::vector<std::string> words = split_words(unescape(pending_text), quoted);
                        Value value = atoms_from(words, quoted, 0);
                        if (pending.has("unit") && !pending.attr("unit").empty()) {
                            value.emplace_back(pending.attr("unit"));
                        }
                        if (pending.has("ramp") && !pending.attr("ramp").empty()) {
                            value.emplace_back("ramp");
                            value.push_back(to_atom(pending.attr("ramp")));
                        }
                        std::string address = pending.attr("address");
                        if (!scripts.empty() && !scripts.back().empty()) {
                            address = scripts.back() + "/" + address;
                        }
                        if (value.empty() || address.empty()) {
                            result.problems.push_back("a command without " + std::string(address.empty() ? "an address" : "a value"));
                        } else {
                            current->entries.push_back({Address::parse(address), std::move(value)});
                        }
                    }
                }
            } else if (tag.name == "script" && !scripts.empty()) {
                scripts.pop_back();
            } else if (tag.name == "preset") {
                current = nullptr;
            }
            continue;
        }
        if (tag.name == "jamoma") {
            saw_root = true;
            const std::string version = tag.attr("version");
            if (!version.empty() && version.compare(0, 2, "0.") != 0) {
                result.problems.push_back("the file has version " + version + "; only 0.x is known, reading it as 0.6");
            }
        } else if (tag.name == "preset") {
            result.presets.emplace_back();
            current = &result.presets.back();
            current->name = tag.attr("name");
        } else if (tag.name == "script") {
            const std::string parent = scripts.empty() ? std::string() : scripts.back();
            const std::string address = tag.attr("address");
            scripts.push_back(parent.empty() ? address : parent + "/" + address);
        } else if ((tag.name == "command" || tag.name == "flag") && current != nullptr) {
            pending = tag;
            pending_text.clear();
            in_leaf = !tag.self_closing;
            if (tag.self_closing && tag.name == "flag") {
                current->flags.push_back(tag.attr("name"));
            }
        } else if (!saw_root) {
            result.problems.push_back("the file does not start with <jamoma>");
            saw_root = true;
        }
        if (!tag.self_closing) {
            open.push_back(tag.name);
        } else if (tag.name == "preset") {
            current = nullptr;
        } else if (tag.name == "script" && !scripts.empty()) {
            scripts.pop_back();
        }
    }
    if (!open.empty()) {
        result.problems.push_back("the file ends before <" + open.back() + "> is closed");
    }
    return result;
}

} // namespace jamoma
