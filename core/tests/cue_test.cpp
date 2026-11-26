// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file cue_test.cpp
 * @brief Unit tests for the cue list of j.cue (docs/inventory/j.cue.md).
 */

#include <catch2/catch_approx.hpp>
#include <catch2/catch_test_macros.hpp>

#include <atomic>
#include <chrono>
#include <future>
#include <memory>
#include <string>
#include <thread>
#include <vector>

#include "jamoma/cue.hpp"
#include "jamoma/data.hpp"

using Catch::Approx;
using jamoma::Address;
using jamoma::CueList;
using jamoma::Value;

namespace {

/** A namespace with decimal parameters /a/freq, /a/q and /b/gain. */
struct Rig {
    jamoma::Namespace ns;                                 /**< The namespace. */
    std::vector<std::unique_ptr<jamoma::Data>> data;      /**< The parameters. */
    std::vector<jamoma::Subscription> subscriptions;      /**< Their registrations. */

    /** @brief Adds a parameter. @param address Where. @param value Its first value. @return The parameter. */
    jamoma::Data& add(const char* address, double value)
    {
        auto d = std::make_unique<jamoma::Data>(jamoma::Service::Parameter);
        d->set_type(jamoma::DataType::Decimal);
        d->set_range({-1000.0, 1000.0});
        subscriptions.push_back(ns.subscribe(Address::parse(address), *d));
        d->command({value});
        data.push_back(std::move(d));
        return *data.back();
    }
    Rig()
    {
        add("/a/freq", 100.0);
        add("/a/q", 1.5);
        add("/b/gain", -6.0);
    }
    /** @param i Index of the parameter. @return Its value as a number. */
    double at(std::size_t i) const { return data[i]->value().at(0).as_double(); }
};

} // namespace

/** Store and recall round trip. */
TEST_CASE("cue_store_and_recall_round_trip", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    const auto stored = cues.store("one", {"/a/freq", "/b/gain"});
    CHECK(stored.stored);
    CHECK(stored.skipped.empty());
    r.data[0]->command({300.0});
    r.data[1]->command({9.0});
    r.data[2]->command({0.0});
    const auto report = cues.recall("one");
    CHECK(report.found);
    CHECK(report.applied == 2);
    CHECK(r.at(0) == Approx(100.0));
    CHECK(r.at(1) == Approx(9.0)); // /a/q was not in the cue
    CHECK(r.at(2) == Approx(-6.0));
    CHECK(cues.cues().names() == std::vector<std::string>{"one"});
}

/** Store skips what cannot be stored and says so. */
TEST_CASE("cue_store_skips_what_cannot_be_stored_and_says_so", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    const auto s = cues.store("x", {"/a/freq", "/nothing/here", "/a/freq:range", "/a"});
    CHECK(s.stored);
    CHECK(s.skipped == std::vector<std::string>{"/nothing/here", "/a/freq:range", "/a"});
    CHECK(cues.cues().presets().at(0).entries.size() == 1);
    CHECK_FALSE(cues.store("", {"/a/freq"}).stored);
}

/** Store again replaces and keeps the place. */
TEST_CASE("cue_store_again_replaces_and_keeps_the_place", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.store("one", {"/a/freq"});
    cues.store("two", {"/a/q"});
    r.data[0]->command({7.0});
    cues.store("one", {"/a/freq"});
    CHECK(cues.cues().names() == std::vector<std::string>{"one", "two"});
    r.data[0]->command({0.0});
    cues.recall("one");
    CHECK(r.at(0) == Approx(7.0));
}

/** Recall from an address runs only lines below it. */
TEST_CASE("cue_recall_from_an_address_runs_only_lines_below_it", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.store("all", {"/a/freq", "/a/q", "/b/gain"});
    r.data[0]->command({0.0});
    r.data[1]->command({0.0});
    r.data[2]->command({0.0});
    const auto report = cues.recall("all", Address::parse("/a"));
    CHECK(report.applied == 2);
    CHECK(r.at(2) == Approx(0.0));
    CHECK(cues.recall("all", Address::parse("/zzz")).applied == 0);
    CHECK_FALSE(cues.recall("missing").found);
}

/** Recall skips missing nodes and reports them. */
TEST_CASE("cue_recall_skips_missing_nodes_and_reports_them", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.store("all", {"/a/freq", "/b/gain"});
    r.subscriptions.erase(r.subscriptions.begin() + 2); // /b/gain goes away
    r.data[0]->command({0.0});
    const auto report = cues.recall("all");
    CHECK(report.found);
    CHECK(report.applied == 1);
    REQUIRE(report.skipped.size() == 1);
    CHECK(report.skipped[0].str() == "b/gain");
    CHECK(r.at(0) == Approx(100.0));
}

/** Recall while nodes are deleted. */
TEST_CASE("cue_recall_while_nodes_are_deleted", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.store("all", {"/a/freq", "/a/q", "/b/gain"});
    std::atomic<bool> stop{false};
    std::thread churn([&] {
        jamoma::Data d(jamoma::Service::Parameter);
        d.set_type(jamoma::DataType::Decimal);
        while (!stop) {
            auto s = r.ns.subscribe(Address::parse("/a/temp"), d);
        }
    });
    for (int i = 0; i < 2000; ++i)
        REQUIRE(cues.recall("all").applied == 3);
    stop = true;
    churn.join();
}

/** Ramp and description. */
TEST_CASE("cue_ramp_and_description", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.store("one", {"/a/freq", "/a/q"});
    CHECK(cues.ramp("one") == 0.0);
    REQUIRE(cues.set_ramp("one", 250.0));
    CHECK(cues.ramp("one") == 250.0);
    for (const auto& e : cues.cues().presets().at(0).entries) {
        REQUIRE(e.value.size() == 3);
        CHECK(e.value[1].as_symbol() == "ramp");
    }
    REQUIRE(cues.set_ramp("one", 100.0)); // replaced, not added
    CHECK(cues.cues().presets().at(0).entries.at(0).value.size() == 3);
    REQUIRE(cues.set_ramp("one", 0.0));
    CHECK(cues.cues().presets().at(0).entries.at(0).value.size() == 1);
    CHECK_FALSE(cues.set_ramp("nothing", 5.0));
    CHECK_FALSE(cues.ramp("nothing").has_value());
    REQUIRE(cues.set_description("one", "the first"));
    CHECK(cues.description("one") == std::string("the first"));
    CHECK_FALSE(cues.description("nothing").has_value());
}

/** Text matches the old sample and round trips. */
TEST_CASE("cue_text_matches_the_old_sample_and_round_trips", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    const char* old_file =
        "###########################################################################\n"
        "CUE Remove_Alias\t# (fold)\n"
        "###########################################################################\n"
        "\n"
        "# Module /a\n"
        "\t/a/freq 440.5\n"
        "\t/a/q 2   # a trailing comment\n"
        "# (end)\n"
        "\n"
        "CUE second\n"
        "    /b/gain -3.\n"
        "    /b/note \"two words\"\n";
    const auto problems = cues.read_text(old_file);
    CHECK(problems.empty());
    REQUIRE(cues.cues().names() == std::vector<std::string>{"Remove_Alias", "second"});
    CHECK(cues.cues().presets().at(0).entries.at(0).address.str() == "a/freq");
    CHECK(cues.cues().presets().at(0).entries.at(0).value.at(0).as_double() == Approx(440.5));
    CHECK(cues.cues().presets().at(0).entries.at(1).value.at(0).as_double() == Approx(2.0));
    CHECK(cues.cues().presets().at(1).entries.at(1).value.at(0).as_symbol() == "two words");
    const std::string written = cues.write_text();
    CueList again(r.ns);
    CHECK(again.read_text(written).empty());
    CHECK(again.write_text() == written);
    CHECK(written.find("CUE Remove_Alias") != std::string::npos);
    CHECK(written.find("/a/freq 440.5") != std::string::npos);
}

/** Text keeps the description. */
TEST_CASE("cue_text_keeps_the_description", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.store("one", {"/a/freq"});
    cues.set_description("one", "a note");
    CueList again(r.ns);
    again.read_text(cues.write_text());
    CHECK(again.description("one") == std::string("a note"));
}

/** Write xml then read is identical. */
TEST_CASE("cue_write_xml_then_read_is_identical", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.store("one", {"/a/freq", "/b/gain"});
    cues.set_description("one", "d");
    cues.store("two", {"/a/q"});
    cues.set_ramp("two", 500.0);
    const std::string xml = cues.write_xml();
    CHECK(xml.find("<cue name=\"one\">") != std::string::npos);
    CHECK(xml.find("<preset") == std::string::npos);
    CueList again(r.ns);
    CHECK(again.read_xml(xml).empty());
    CHECK(again.write_xml() == xml);
    CHECK(again.cues().names() == std::vector<std::string>{"one", "two"});
    CHECK(again.ramp("two") == 500.0);
}

/** Read damaged files keep what they can. */
TEST_CASE("cue_read_damaged_files_keep_what_they_can", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.store("keep", {"/a/freq"});
    SECTION("empty text and empty xml")
    {
        CHECK_FALSE(cues.read_text("").empty()); // a file without cues is reported and changes nothing
        CHECK(cues.cues().names() == std::vector<std::string>{"keep"});
        CHECK_FALSE(cues.read_xml("").empty());
        CHECK(cues.cues().names() == std::vector<std::string>{"keep"});
    }
    SECTION("truncated xml keeps the cues before the cut")
    {
        CueList good(r.ns);
        good.store("one", {"/a/freq"});
        good.store("two", {"/a/q"});
        const std::string xml = good.write_xml();
        const std::string cut = xml.substr(0, xml.find("<cue name=\"two\">") + 10);
        const auto problems = cues.read_xml(cut);
        CHECK_FALSE(problems.empty());
        CHECK(cues.cues().names().front() == "one");
    }
    SECTION("garbage and a line before the first cue")
    {
        const auto problems = cues.read_text("/a/freq 1\nnot a command\nCUE ok\n/a/q 3\nwait 100\n");
        CHECK(problems.size() >= 2);
        CHECK(cues.cues().names() == std::vector<std::string>{"ok"});
        CHECK(cues.cues().presets().at(0).entries.size() == 1);
    }
    SECTION("a version that is not known, and binary noise")
    {
        const std::string noise("\x00\xff\xfe<cue\x01", 8);
        CHECK_NOTHROW(cues.read_xml(noise));
        CHECK_NOTHROW(cues.read_text(noise));
        CHECK_NOTHROW(cues.read_xml("<jamoma version=\"9.9\"><cue name=\"v\"><command address=\"/a/q\">1</command></cue></jamoma>"));
    }
}

/** Recall reports an unknown parameter at recall not at read. */
TEST_CASE("cue_recall_reports_an_unknown_parameter_at_recall_not_at_read", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    CHECK(cues.read_text("CUE c\n/a/freq 5\n/zzz/nothing 1\n").empty());
    const auto report = cues.recall("c");
    CHECK(report.applied == 1);
    CHECK(report.skipped.size() == 1);
}

/** Many cues stay fast. */
TEST_CASE("cue_many_cues_stay_fast", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    const auto t0 = std::chrono::steady_clock::now();
    for (int i = 0; i < 10000; ++i)
        cues.store("cue " + std::to_string(i), {"/a/freq"});
    const auto text = cues.write_text();
    CueList again(r.ns);
    CHECK(again.read_text(text).empty());
    CHECK(again.cues().names().size() == 10000);
    const auto elapsed = std::chrono::duration<double>(std::chrono::steady_clock::now() - t0).count();
#if defined(__has_feature)
#if __has_feature(thread_sanitizer)
    CHECK(elapsed < 120.0); // ThreadSanitizer slows this down about tenfold; the limit is for the plain build
#else
    CHECK(elapsed < 10.0);
#endif
#else
    CHECK(elapsed < 10.0);
#endif
}

/** Edit text round trip and an empty edit changes nothing. */
TEST_CASE("cue_edit_text_round_trip_and_an_empty_edit_changes_nothing", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.store("one", {"/a/freq"});
    std::string text = cues.edit_text();
    text += "\nCUE added\n/a/q 4\n";
    CHECK(cues.apply_edit_text(text).empty());
    CHECK(cues.cues().names() == std::vector<std::string>{"one", "added"});
    CHECK(cues.apply_edit_text("   \n# only a comment\n").size() == 1);
    CHECK(cues.cues().names().size() == 2); // nothing changed
}

/** Rename to an existing name fails. */
TEST_CASE("cue_rename_to_an_existing_name_fails", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.store("one", {"/a/freq"});
    cues.store("two", {"/a/q"});
    CHECK_FALSE(cues.cues().rename("one", "two"));
    CHECK(cues.cues().names() == std::vector<std::string>{"one", "two"});
}

/** New at a position moves the cue there. */
TEST_CASE("cue_new_at_a_position_moves_the_cue_there", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.store("a", {"/a/freq"});
    cues.store("b", {"/a/q"});
    CHECK(cues.store("c", {"/b/gain"}, 0).stored); // position 0 is the first place (the Max message counts from 1)
    CHECK(cues.cues().names() == std::vector<std::string>{"c", "a", "b"});
    CHECK(cues.cues().current() == std::optional<std::size_t>(0));
}

/** Update refreshes the values of the lines of a cue. */
TEST_CASE("cue_update_refreshes_the_values_of_the_lines_of_a_cue", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.store("one", {"/a/freq", "/b/gain"});
    cues.set_ramp("one", 100.0);
    cues.store("two", {"/a/q"});
    r.data[0]->command({5.0});
    r.data[2]->command({-1.0});
    CHECK(cues.update("one"));
    const auto& entries = cues.cues().presets().at(0).entries;
    CHECK(entries.at(0).value.at(0).as_double() == Approx(5.0));
    CHECK(entries.at(1).value.at(0).as_double() == Approx(-1.0));
    CHECK(entries.at(0).value.at(1).as_symbol() == "ramp"); // the ramp of every line stays
    CHECK(cues.cues().presets().at(1).entries.at(0).value.at(0).as_double() == Approx(1.5)); // another cue is not touched
    r.data[1]->command({77.0});
    CHECK(cues.update("2")); // by position, counted from 1
    CHECK(cues.cues().presets().at(1).entries.at(0).value.at(0).as_double() == Approx(77.0));
    CHECK_FALSE(cues.update("nothing"));
    CHECK_FALSE(cues.update("0"));
    CHECK_FALSE(cues.update("3"));
}

/** Append adds a line and makes the cue if needed. */
TEST_CASE("cue_append_adds_a_line_and_makes_the_cue_if_needed", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    CHECK(cues.append("made", Value{"/a/freq", 42.0}));
    REQUIRE(cues.cues().names() == std::vector<std::string>{"made"});
    CHECK(cues.append("made", Value{"/a/q", 3.5, "ramp", 200}));
    CHECK(cues.cues().presets().at(0).entries.size() == 2);
    CHECK(cues.cues().presets().at(0).entries.at(0).address.str() == "a/freq");
    CHECK_FALSE(cues.append("made", Value{"not/an/address", 1.0}));
    CHECK_FALSE(cues.append("made", Value{}));
    cues.recall("made");
    CHECK(r.at(0) == Approx(42.0));
    CHECK(r.at(1) == Approx(3.5));
}

/** Optimize removes values that repeat the state before. */
TEST_CASE("cue_optimize_removes_values_that_repeat_the_state_before", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.append("one", Value{"/a/freq", 1.0});
    cues.append("one", Value{"/a/q", 2.0});
    cues.append("two", Value{"/a/freq", 1.0});   // repeats cue one
    cues.append("two", Value{"/a/q", 3.0});
    cues.append("three", Value{"/a/freq", 9.0});
    cues.append("three", Value{"/a/q", 3.0});     // repeats cue two (q = 3)
    cues.optimize({"one", "two", "three"});
    CHECK(cues.cues().presets().at(0).entries.size() == 2);       // the first cue stays as it is
    REQUIRE(cues.cues().presets().at(1).entries.size() == 1);
    CHECK(cues.cues().presets().at(1).entries.at(0).address.str() == "a/q");
    REQUIRE(cues.cues().presets().at(2).entries.size() == 1);
    CHECK(cues.cues().presets().at(2).entries.at(0).address.str() == "a/freq");
    cues.optimize({"one", "missing", "three"}); // a name that does not exist is skipped, nothing crashes
}

/** Recall next and previous follow the current cue. */
TEST_CASE("cue_recall_next_and_previous_follow_the_current_cue", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.append("a", Value{"/a/freq", 1.0});
    cues.append("b", Value{"/a/freq", 2.0});
    cues.append("c", Value{"/a/freq", 3.0});
    cues.recall("a");
    CHECK(cues.recall_next().found);
    CHECK(r.at(0) == Approx(2.0));
    CHECK(cues.recall_next().found);
    CHECK(r.at(0) == Approx(3.0));
    CHECK_FALSE(cues.recall_next().found);   // after the last: nothing, and the current cue stays
    CHECK(r.at(0) == Approx(3.0));
    CHECK(cues.recall_previous().found);
    CHECK(r.at(0) == Approx(2.0));
    cues.recall("a");
    CHECK_FALSE(cues.recall_previous().found);
}

/** Recall next without a current cue starts at the first. */
TEST_CASE("cue_recall_next_without_a_current_cue_starts_at_the_first", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.read_text("CUE a\n/a/freq 7\nCUE b\n/a/freq 8\n");
    CHECK_FALSE(cues.cues().current().has_value());
    CHECK(cues.recall_next().found);
    CHECK(r.at(0) == Approx(7.0));
}

/** Address is the parent the cue stores from and recalls relative to. */
TEST_CASE("cue_address_is_the_parent_the_cue_stores_from_and_recalls_relative_to", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.set_address(Address::parse("/a"));
    CHECK(cues.address().str() == "/a");
    const auto s = cues.store("p", {"/a/freq", "/a/q", "/b/gain"});
    CHECK(s.stored);
    CHECK(s.skipped == std::vector<std::string>{"/b/gain"}); // not below the address
    r.data[0]->command({0.0});
    r.data[1]->command({0.0});
    CHECK(cues.recall("p", Address::parse("freq")).applied == 1); // a relative start is taken from the address
    CHECK(r.at(0) == Approx(100.0));
    CHECK(r.at(1) == Approx(0.0));
}

/** A recall that starts at an address may lead to nodes being made or removed by what it recalls (review finding: it hung). */
TEST_CASE("cue_recall_from_an_address_may_change_the_namespace", "[cue]")
{
    struct State {
        jamoma::Namespace ns;
        jamoma::Data load{jamoma::Service::Parameter};
        jamoma::Data made{jamoma::Service::Parameter};
        jamoma::Subscription load_sub, made_sub;
        std::promise<std::size_t> applied;
    };
    auto state = std::make_shared<State>(); // shared: a thread that hangs keeps it alive
    state->load.set_type(jamoma::DataType::Decimal);
    state->load_sub = state->ns.subscribe(Address::parse("/a/load"), state->load);
    state->load.command({1.0});
    auto done = state->applied.get_future();
    std::thread([state] {
        CueList cues(state->ns);
        cues.store("c", {"/a/load"});
        state->load.set_output([s = state.get()](const jamoma::Value&) {
            s->made_sub = s->ns.subscribe(Address::parse("/a/made"), s->made);
        });
        const auto report = cues.recall("c", Address::parse("/a"));
        state->load.set_output(nullptr);
        state->applied.set_value(report.applied);
    }).detach();
    REQUIRE(done.wait_for(std::chrono::seconds(5)) == std::future_status::ready);
    CHECK(done.get() == 1);
}

/** Names with a comment sign survive writing and reading, and a line CUE without a name does not join the cue before it (review findings). */
TEST_CASE("cue_names_with_a_comment_sign_round_trip", "[cue]")
{
    Rig r;
    CueList cues(r.ns);
    cues.store("scene #2", {"/a/freq"});
    cues.store("a \"quoted\" one", {"/a/q"});
    cues.store("two\nlines", {"/a/q"});
    CueList again(r.ns);
    CHECK(again.read_text(cues.write_text()).empty());
    CHECK(again.cues().names() == std::vector<std::string>{"scene #2", "a \"quoted\" one", "two lines"});

    CueList hand(r.ns);
    const auto problems = hand.read_text("CUE first # a comment\n\t/a/freq 1\nCUE   \n\t/a/q 2\n");
    CHECK(problems.size() == 1);
    REQUIRE(hand.cues().names() == std::vector<std::string>{"first"});
    CHECK(hand.cues().presets().at(0).entries.size() == 1);
}
