// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file preset_files_test.cpp
 * @brief Unit tests for reading and writing presets as text and XML files, including files that are damaged or very large.
 */

#include <catch2/catch_test_macros.hpp>

#include <chrono>
#include <fstream>
#include <sstream>
#include <string>

#include "jamoma/preset_files.hpp"

using jamoma::Preset;
using jamoma::ReadResult;

namespace {

/** @param name A file in the test data folder. @return Its content. */
std::string data_file(const std::string& name)
{
    std::ifstream in(std::string(JAMOMA_TEST_DATA) + "/" + name, std::ios::binary);
    std::stringstream buffer;
    buffer << in.rdbuf();
    return buffer.str();
}

/** @return A list of presets with a bit of everything. */
std::vector<Preset> sample()
{
    Preset a;
    a.name = "default";
    a.description = "something about this preset";
    a.flags = {"# a comment"};
    a.entries.push_back({jamoma::Address::parse("data/active"), {0}});
    a.entries.push_back({jamoma::Address::parse("time"), {100.5}});
    a.entries.push_back({jamoma::Address::parse("name"), {"hello", 3, 0.25}});
    Preset b;
    b.name = "second";
    b.entries.push_back({jamoma::Address::parse("time"), {200, "ramp", 500}});
    return {a, b};
}

/** Checks that two preset lists are equal in what the files carry. */
void require_same(const std::vector<Preset>& x, const std::vector<Preset>& y)
{
    REQUIRE(x.size() == y.size());
    for (std::size_t i = 0; i < x.size(); ++i) {
        REQUIRE(x[i].name == y[i].name);
        REQUIRE(x[i].description == y[i].description);
        REQUIRE(x[i].flags == y[i].flags);
        REQUIRE(x[i].entries.size() == y[i].entries.size());
        for (std::size_t k = 0; k < x[i].entries.size(); ++k) {
            REQUIRE(x[i].entries[k].address.str() == y[i].entries[k].address.str());
            REQUIRE(jamoma::to_string(x[i].entries[k].value) == jamoma::to_string(y[i].entries[k].value));
        }
    }
}

} // namespace

/** The old sample file: preset "default" with a description, comments, and three commands. */
TEST_CASE("text reads the qmetro file")
{
    const ReadResult r = jamoma::read_presets_text(data_file("qmetro.model.presets.txt"));
    REQUIRE(r.problems.empty());
    REQUIRE(r.presets.size() == 1);
    REQUIRE(r.presets[0].name == "default");
    REQUIRE(r.presets[0].description == "something about this preset");
    REQUIRE(r.presets[0].entries.size() == 3);
    REQUIRE(r.presets[0].entries[0].address.str() == "data/active");
    REQUIRE(r.presets[0].entries[2].address.str() == "time");
    REQUIRE(r.presets[0].entries[2].value.at(0).as_double() == 100.0);
}

/** Writing and reading again gives the same presets. */
TEST_CASE("text round trip")
{
    const auto presets = sample();
    const ReadResult r = jamoma::read_presets_text(jamoma::write_presets_text(presets));
    REQUIRE(r.problems.empty());
    require_same(r.presets, presets);
}

/** The same for XML. */
TEST_CASE("xml round trip")
{
    const auto presets = sample();
    const ReadResult r = jamoma::read_presets_xml(jamoma::write_presets_xml(presets));
    REQUIRE(r.problems.empty());
    require_same(r.presets, presets);
}

/** A file written like the old writer (ISO-8859-1 declaration, `%f` numbers, comments in quotes, a ramp attribute). */
TEST_CASE("xml reads the sample written like the old writer")
{
    const ReadResult r = jamoma::read_presets_xml(data_file("old-writer-sample.xml"));
    REQUIRE(r.problems.empty());
    REQUIRE(r.presets.size() == 2);
    REQUIRE(r.presets[0].name == "default");
    REQUIRE(r.presets[0].entries.size() == 4);
    REQUIRE(r.presets[0].entries[0].address.str() == "p.1");
    REQUIRE(jamoma::to_string(r.presets[0].entries[3].value) == "0 0 0");
    REQUIRE(r.presets[0].flags == std::vector<std::string>{"# \"edit a comment\""});
    REQUIRE(jamoma::to_string(r.presets[1].entries[3].value) == "1 2.5 ramp 500");
}

/** An empty file has no presets and is not a problem for the text form; an empty XML file is one. */
TEST_CASE("empty file")
{
    REQUIRE(jamoma::read_presets_text("").presets.empty());
    REQUIRE(jamoma::read_presets_text("").problems.empty());
    REQUIRE(jamoma::read_presets_xml("").presets.empty());
    REQUIRE_FALSE(jamoma::read_presets_xml("").problems.empty());
}

/** A file cut short gives what was complete and a problem. */
TEST_CASE("truncated xml")
{
    const std::string whole = jamoma::write_presets_xml(sample());
    for (std::size_t cut : {whole.size() / 4, whole.size() / 2, whole.size() - 20}) {
        const ReadResult r = jamoma::read_presets_xml(whole.substr(0, cut));
        REQUIRE_FALSE(r.problems.empty());
    }
    REQUIRE(jamoma::read_presets_xml(whole.substr(0, whole.size() / 2)).presets.size() >= 1);
}

/** A command line with no value, and a command before any preset, are reported and skipped. */
TEST_CASE("line without value")
{
    const ReadResult r = jamoma::read_presets_text("- preset \"p\"\ntime\nlevel 3\n");
    REQUIRE(r.problems.size() == 1);
    REQUIRE(r.presets.size() == 1);
    REQUIRE(r.presets[0].entries.size() == 1);
    const ReadResult early = jamoma::read_presets_text("level 3\n- preset \"p\"\n");
    REQUIRE(early.problems.size() == 1);
    REQUIRE(early.presets.size() == 1);
}

/** A file from a newer version is read as far as it can be, with a problem. */
TEST_CASE("unknown version")
{
    const ReadResult r = jamoma::read_presets_xml("<jamoma version=\"9.0\"><preset name=\"p\"><command address=\"a\">1</command></preset></jamoma>");
    REQUIRE_FALSE(r.problems.empty());
    REQUIRE(r.presets.size() == 1);
    REQUIRE(r.presets[0].entries.size() == 1);
}

/** Quotes, markup characters and non-ASCII text in names and values survive both forms. */
TEST_CASE("names with quotes and non ascii")
{
    Preset p;
    p.name = "say \"hi\" <&> blått";
    p.description = "ø \"x\" & y";
    p.entries.push_back({jamoma::Address::parse("a"), {"two words", "ä"}});
    const std::vector<Preset> presets{p};
    const ReadResult t = jamoma::read_presets_text(jamoma::write_presets_text(presets));
    REQUIRE(t.problems.empty());
    require_same(t.presets, presets);
    const ReadResult x = jamoma::read_presets_xml(jamoma::write_presets_xml(presets));
    REQUIRE(x.problems.empty());
    require_same(x.presets, presets);
}

/** A hundred thousand entries are read in a time that does not grow with the square of the size. */
TEST_CASE("very large file is read in linear time")
{
    Preset p;
    p.name = "big";
    for (int i = 0; i < 100000; ++i) {
        p.entries.push_back({jamoma::Address::parse("p" + std::to_string(i)), {i, 0.5}});
    }
    const std::vector<Preset> presets{p};
    const std::string text = jamoma::write_presets_text(presets);
    const std::string xml = jamoma::write_presets_xml(presets);
    const auto start = std::chrono::steady_clock::now();
    REQUIRE(jamoma::read_presets_text(text).presets.at(0).entries.size() == 100000);
    REQUIRE(jamoma::read_presets_xml(xml).presets.at(0).entries.size() == 100000);
    const auto seconds = std::chrono::duration<double>(std::chrono::steady_clock::now() - start).count();
    REQUIRE(seconds < 20.0);
}

/** Deeply nested or garbage input does not crash. */
TEST_CASE("garbage does not throw")
{
    std::string nested;
    for (int i = 0; i < 50000; ++i) {
        nested += "<script address=\"a\">";
    }
    REQUIRE_NOTHROW(jamoma::read_presets_xml(nested));
    REQUIRE_NOTHROW(jamoma::read_presets_xml("<<<>>>&&&\"\"<!-- <jamoma"));
    REQUIRE_NOTHROW(jamoma::read_presets_text(std::string("\0\xff\xfe - preset \"", 14)));
}
