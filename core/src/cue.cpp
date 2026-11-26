// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file cue.cpp
 * @brief The cue list (docs/inventory/j.cue.md).
 */

#include "jamoma/cue.hpp"

#include <algorithm>
#include <cctype>
#include <charconv>
#include <cmath>
#include <cstdlib>

#include "jamoma/data.hpp"
#include "jamoma/preset_files.hpp"

namespace jamoma {

namespace {

/** @return The root address, whose presets hold the cues. */
Address root() { return Address::parse("/"); }

/** @param text A text. @return The same without white space at both ends. */
std::string trim(const std::string& text)
{
    std::size_t a = 0, b = text.size();
    while (a < b && std::isspace(static_cast<unsigned char>(text[a])))
        ++a;
    while (b > a && std::isspace(static_cast<unsigned char>(text[b - 1])))
        --b;
    return text.substr(a, b - a);
}

/** @param address An address as stored in a cue (relative to the root). @return The absolute address. */
Address absolute_of(const Address& address) { return Address::parse("/" + address.str()); }

/** @param address An address as written in a file. @return The address relative to the root (a leading slash is removed). */
Address relative_of(const Address& address)
{
    const std::string text = address.str();
    return text.size() > 1 && text[0] == '/' ? Address::parse(text.substr(1)) : address;
}

/** @param text A word of a cue line. @return The atom it stands for (a number if it is one). */
Atom atom_of(const std::string& text)
{
    if (!text.empty()) {
        const char* first = text.c_str();
        char* end = nullptr;
        const double d = std::strtod(first, &end);
        if (end != first && *end == '\0' && std::isfinite(d)) {
            if (text.find_first_of(".eE") == std::string::npos) {
                std::int64_t i = 0;
                const auto r = std::from_chars(first, first + text.size(), i);
                if (r.ec == std::errc() && r.ptr == first + text.size())
                    return Atom(i);
            }
            return Atom(d);
        }
    }
    return Atom(text);
}

/** @param atom An atom. @return Its text as written in a cue file (symbols with white space or a comment sign are quoted). */
std::string word_of(const Atom& atom)
{
    std::string text = atom.to_string();
    if (!atom.is_symbol())
        return text;
    if (text.empty() || text.find_first_of(" \t\"#") != std::string::npos) {
        std::string quoted = "\"";
        for (char c : text) {
            if (c == '"' || c == '\\')
                quoted += '\\';
            quoted += c;
        }
        return quoted + "\"";
    }
    return text;
}

/** One word of a line and whether it was quoted. */
struct Word {
    std::string text;      /**< The word without quotes. */
    bool quoted = false;   /**< Whether it was written in quotes. */
};

/** @brief Splits a line into words, honouring quotes; a `#` outside quotes starts a comment. @param line The line. @return The words. */
std::vector<Word> words_of(const std::string& line)
{
    std::vector<Word> out;
    std::size_t i = 0;
    while (i < line.size()) {
        if (std::isspace(static_cast<unsigned char>(line[i]))) {
            ++i;
            continue;
        }
        if (line[i] == '#')
            break;
        Word w;
        if (line[i] == '"') {
            w.quoted = true;
            ++i;
            while (i < line.size() && line[i] != '"') {
                if (line[i] == '\\' && i + 1 < line.size())
                    ++i;
                w.text += line[i++];
            }
            ++i;
        } else {
            while (i < line.size() && !std::isspace(static_cast<unsigned char>(line[i])))
                w.text += line[i++];
        }
        out.push_back(std::move(w));
    }
    return out;
}

/** @param value A command value. @return Its ramp time if it ends with `ramp <number>`, else nothing. */
std::optional<double> ramp_of(const Value& value)
{
    if (value.size() >= 2 && value[value.size() - 2].is_symbol() && value[value.size() - 2].as_symbol() == "ramp" && value.back().is_number())
        return value.back().as_double();
    return std::nullopt;
}

/** @param text The text of a file. @param token The tag to replace. @param with The replacement. @return The text with every occurrence replaced. */
std::string replace_all(std::string text, const std::string& token, const std::string& with)
{
    std::size_t at = 0;
    while ((at = text.find(token, at)) != std::string::npos) {
        text.replace(at, token.size(), with);
        at += with.size();
    }
    return text;
}

} // namespace

CueList::CueList(Namespace& ns) : ns_(ns), manager_(ns, root()) {}

StoreReport CueList::store(std::string_view name, const std::vector<std::string>& keys)
{
    StoreReport report;
    if (name.empty())
        return report;
    std::vector<PresetEntry> entries;
    for (const std::string& key : keys) {
        bool ok = false;
        if (key.size() > 1 && key[0] == '/' && key.find(':') == std::string::npos) {
            const Address address = Address::parse(key);
            Value value;
            ns_.read_object(address, [&](Object& object) {
                if (const auto* data = dynamic_cast<Data*>(&object))
                    value = data->value();
            });
            if (!value.empty()) {
                entries.push_back({relative_of(address), std::move(value)});
                ok = true;
            }
        }
        if (!ok)
            report.skipped.push_back(key);
    }
    report.stored = manager_.set_entries(name, std::move(entries));
    return report;
}

RecallReport CueList::recall(std::string_view name_or_index, const Address& start)
{
    if (start.path().empty())
        return manager_.recall(name_or_index);
    RecallReport report = manager_.output(name_or_index);
    if (!report.found)
        return report;
    const auto& from = start.path();
    for (const PresetEntry& entry : report.entries) {
        const auto& path = entry.address.path();
        if (path.size() < from.size() || !std::equal(from.begin(), from.end(), path.begin()))
            continue;
        bool done = false;
        ns_.read_object(absolute_of(entry.address), [&](Object& object) {
            if (auto* data = dynamic_cast<Data*>(&object)) {
                data->command(entry.value);
                done = true;
            }
        });
        if (done)
            ++report.applied;
        else
            report.skipped.push_back(entry.address);
    }
    report.entries.clear();
    return report;
}

bool CueList::set_ramp(std::string_view name, double ms)
{
    for (const Preset& p : manager_.presets()) {
        if (p.name != name)
            continue;
        std::vector<PresetEntry> entries = p.entries;
        for (PresetEntry& e : entries) {
            if (ramp_of(e.value))
                e.value.resize(e.value.size() - 2);
            if (std::isfinite(ms) && ms > 0) {
                e.value.push_back("ramp");
                e.value.push_back(ms);
            }
        }
        const auto current = manager_.current();
        const bool was_current = current && manager_.presets().at(*current).name == name;
        return manager_.set_entries(name, std::move(entries), was_current);
    }
    return false;
}

std::optional<double> CueList::ramp(std::string_view name) const
{
    for (const Preset& p : manager_.presets()) {
        if (p.name != name)
            continue;
        for (const PresetEntry& e : p.entries)
            if (const auto r = ramp_of(e.value))
                return *r;
        return 0.0;
    }
    return std::nullopt;
}

bool CueList::set_description(std::string_view name, std::string_view text) { return manager_.set_description(name, std::string(text)); }

std::optional<std::string> CueList::description(std::string_view name) const
{
    for (const Preset& p : manager_.presets())
        if (p.name == name)
            return p.description;
    return std::nullopt;
}

std::string CueList::write_text() const
{
    const std::string rule(75, '#');
    std::string out;
    for (const Preset& p : manager_.presets()) {
        out += rule + "\nCUE " + p.name + "\n" + rule + "\n";
        if (!p.description.empty())
            out += "\t# description: " + p.description + "\n";
        for (const PresetEntry& e : p.entries) {
            out += "\t/" + e.address.str();
            for (const Atom& a : e.value)
                out += " " + word_of(a);
            out += "\n";
        }
        out += "\n";
    }
    return out;
}

std::vector<std::string> CueList::read_text(std::string_view text)
{
    std::vector<std::string> problems;
    std::vector<Preset> cues;
    Preset* current = nullptr;
    bool skipping = false;
    std::size_t line_number = 0, start = 0;
    while (start <= text.size()) {
        std::size_t end = text.find('\n', start);
        if (end == std::string_view::npos)
            end = text.size();
        std::string line(text.substr(start, end - start));
        start = end + 1;
        ++line_number;
        if (!line.empty() && line.back() == '\r')
            line.pop_back();
        const std::string where = "line " + std::to_string(line_number) + ": ";
        const std::string trimmed = trim(line);
        if (trimmed.empty())
            continue;
        if (trimmed[0] == '#') {
            const std::string key = "# description:";
            if (current && !skipping && trimmed.compare(0, key.size(), key) == 0)
                current->description = trim(trimmed.substr(key.size()));
            continue;
        }
        if (trimmed.compare(0, 4, "CUE ") == 0 || trimmed.compare(0, 4, "CUE\t") == 0) {
            std::string name = trimmed.substr(4);
            const std::size_t hash = name.find('#');
            if (hash != std::string::npos)
                name = name.substr(0, hash);
            name = trim(name);
            if (name.empty()) {
                problems.push_back(where + "a cue without a name is skipped");
                current = nullptr;
                skipping = true;
            } else if (std::any_of(cues.begin(), cues.end(), [&](const Preset& c) { return c.name == name; })) {
                problems.push_back(where + "cue " + name + " is there twice: the later one is skipped");
                current = nullptr;
                skipping = true;
            } else {
                cues.emplace_back();
                current = &cues.back();
                current->name = name;
                skipping = false;
            }
            continue;
        }
        if (skipping)
            continue;
        const std::vector<Word> words = words_of(trimmed);
        if (words.empty())
            continue;
        std::string first = words[0].text;
        std::transform(first.begin(), first.end(), first.begin(), [](unsigned char c) { return static_cast<char>(std::toupper(c)); });
        if (first == "WAIT" && !words[0].quoted) {
            problems.push_back(where + "WAIT is not supported and is skipped");
            continue;
        }
        if (words[0].quoted || words[0].text.empty() || words[0].text[0] != '/') {
            problems.push_back(where + "not understood: " + trimmed);
            continue;
        }
        if (!current) {
            problems.push_back(where + "a command before the first cue is skipped");
            continue;
        }
        PresetEntry entry;
        entry.address = relative_of(Address::parse(words[0].text));
        for (std::size_t i = 1; i < words.size(); ++i)
            entry.value.push_back(words[i].quoted ? Atom(words[i].text) : atom_of(words[i].text));
        current->entries.push_back(std::move(entry));
    }
    if (cues.empty()) {
        problems.push_back("no cue found: nothing changed");
        return problems;
    }
    manager_.replace_all(std::move(cues));
    return problems;
}

std::string CueList::write_xml() const
{
    std::vector<Preset> copy = manager_.presets();
    for (Preset& p : copy)
        for (PresetEntry& e : p.entries)
            e.address = absolute_of(e.address);
    std::string xml = write_presets_xml(copy);
    xml = replace_all(std::move(xml), " <preset name=\"", " <cue name=\"");
    return replace_all(std::move(xml), " </preset>\n", " </cue>\n");
}

std::vector<std::string> CueList::read_xml(std::string_view xml)
{
    std::string converted = replace_all(std::string(xml), "<cue ", "<preset ");
    converted = replace_all(std::move(converted), "</cue>", "</preset>");
    ReadResult result = read_presets_xml(converted);
    if (result.presets.empty()) {
        result.problems.push_back("no cue found: nothing changed");
        return result.problems;
    }
    for (Preset& p : result.presets)
        for (PresetEntry& e : p.entries)
            e.address = relative_of(e.address);
    manager_.replace_all(std::move(result.presets));
    return result.problems;
}

std::vector<std::string> CueList::apply_edit_text(std::string_view text) { return read_text(text); }

} // namespace jamoma
