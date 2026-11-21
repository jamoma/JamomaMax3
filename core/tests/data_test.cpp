// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file data_test.cpp
 * @brief Unit tests for the data object (parameter, message, return).
 *
 * The expectations come from the old Jamoma code (TTData.cpp and TTDataTypedMethods.cpp, read for this milestone) and from the
 * old integration tests. Defaults per type (setType): decimal and array: value and default 0. (float), range 0. 1., step 0.1;
 * integer: 0, range 0 1, step 1; boolean: 0, range 0 1, step 1; string: the symbol none, no range; none: empty value;
 * generic: 0. Numeric types take a symbol as 0; the boolean type rejects a symbol (no change, no output).
 */

#include <catch2/catch_test_macros.hpp>

#include <cmath>
#include <cstdint>
#include <limits>
#include <vector>

#include "jamoma/data.hpp"

using jamoma::Atom;
using jamoma::ClipMode;
using jamoma::Data;
using jamoma::DataType;
using jamoma::Service;
using jamoma::Value;

namespace {

/** A data object of a given type that records every output. */
struct Fixture {
    /** @param type The data type. */
    explicit Fixture(DataType type, Service service = Service::Parameter) : data(service)
    {
        data.set_type(type);
        data.set_output([this](const Value& v) { outputs.push_back(v); });
    }
    Data data;                   /**< The object under test. */
    std::vector<Value> outputs;  /**< Everything the object has output. */
};

/** A float atom. @param v The value. @return The atom. */
Atom f(double v) { return Atom(v); }
/** An integer atom. @param v The value. @return The atom. */
Atom i(std::int64_t v) { return Atom(v); }

} // namespace

/** Decimal defaults. */
TEST_CASE("decimal defaults")
{
    Data d;
    d.set_type(DataType::Decimal);
    REQUIRE(d.value() == Value{f(0.0)});
    REQUIRE(d.default_value() == Value{f(0.0)});
    REQUIRE(d.range() == Value{f(0.0), f(1.0)});
    REQUIRE(d.stepsize() == 0.1);
    REQUIRE_FALSE(d.initialized());
}

/** Integer defaults. */
TEST_CASE("integer defaults")
{
    Data d;
    d.set_type(DataType::Integer);
    REQUIRE(d.value() == Value{i(0)});
    REQUIRE(d.range() == Value{i(0), i(1)});
    REQUIRE(d.stepsize() == 1.0);
}

/** Array, boolean, string, none and generic defaults. */
TEST_CASE("other type defaults")
{
    Data a;
    a.set_type(DataType::Array);
    REQUIRE(a.value() == Value{f(0.0)});
    Data b;
    b.set_type(DataType::Boolean);
    REQUIRE(b.value() == Value{i(0)});
    REQUIRE(b.stepsize() == 1.0);
    Data s;
    s.set_type(DataType::String);
    REQUIRE(s.value() == Value{Atom("none")});
    REQUIRE(s.range().empty());
    Data n;
    n.set_type(DataType::None);
    REQUIRE(n.value().empty());
    Data g;
    g.set_type(DataType::Generic);
    REQUIRE(g.value() == Value{f(0.0)});
}

/** Type names map both ways; an unknown name is generic. */
TEST_CASE("type names round trip and unknown is generic")
{
    for (DataType t : {DataType::None, DataType::Generic, DataType::String, DataType::Boolean, DataType::Integer, DataType::Decimal, DataType::Array}) {
        REQUIRE(jamoma::data_type_from_name(jamoma::data_type_name(t)) == t);
    }
    REQUIRE(jamoma::data_type_from_name("nonsense") == DataType::Generic);
}

/** An integer sent to a decimal comes out as a float. */
TEST_CASE("decimal converts int input")
{
    Fixture x(DataType::Decimal);
    x.data.command(Value{i(3)});
    REQUIRE(x.outputs.size() == 1);
    REQUIRE(x.outputs[0] == Value{f(3.0)});
    REQUIRE(x.data.value() == Value{f(3.0)});
}

/** A float sent to an integer is truncated. */
TEST_CASE("integer truncates float input")
{
    Fixture x(DataType::Integer);
    x.data.command(Value{f(3.75)});
    REQUIRE(x.outputs.back() == Value{i(3)});
    x.data.command(Value{f(-3.75)});
    REQUIRE(x.outputs.back() == Value{i(-3)});
}

/** A decimal or integer keeps only the first atom of a list. */
TEST_CASE("decimal keeps the first atom of a list")
{
    Fixture x(DataType::Decimal);
    x.data.command(Value{f(1.5), f(2.5), f(3.5)});
    REQUIRE(x.outputs.back() == Value{f(1.5)});
}

/** A symbol sent to a decimal or integer becomes 0 (old behaviour). */
TEST_CASE("symbol to numeric type is zero")
{
    Fixture x(DataType::Decimal);
    x.data.command(Value{f(3.0)});
    x.data.command(Value{Atom("foo")});
    REQUIRE(x.outputs.back() == Value{f(0.0)});
    Fixture y(DataType::Integer);
    y.data.command(Value{i(7)});
    y.data.command(Value{Atom("foo")});
    REQUIRE(y.outputs.back() == Value{i(0)});
}

/** A command with no value outputs the current value and changes nothing. */
TEST_CASE("bang outputs current value")
{
    Fixture x(DataType::Decimal);
    x.data.command(Value{f(2.5)});
    x.data.command(Value{});
    REQUIRE(x.outputs.size() == 2);
    REQUIRE(x.outputs[1] == Value{f(2.5)});
    REQUIRE(x.data.value() == Value{f(2.5)});
}

/** Inc and dec move by the step size times the argument; without argument by the step size. */
TEST_CASE("inc and dec use the step size")
{
    Fixture x(DataType::Decimal);
    x.data.inc(Value{i(2)});
    REQUIRE(x.outputs.back() == Value{f(0.2)});
    x.data.dec(Value{i(4)});
    REQUIRE(std::fabs(x.outputs.back()[0].as_double() - (-0.2)) < 1e-12);
    Fixture y(DataType::Decimal);
    y.data.inc(Value{});
    REQUIRE(y.outputs.back() == Value{f(0.1)});
    y.data.dec(Value{});
    REQUIRE(std::fabs(y.outputs.back()[0].as_double()) < 1e-12);
    Fixture z(DataType::Integer);
    z.data.inc(Value{});
    REQUIRE(z.outputs.back() == Value{i(1)});
}

/** The range clips with the clip mode (old test: range 3..4, mode both). */
TEST_CASE("clipmode both clips to the range")
{
    Fixture x(DataType::Decimal);
    x.data.set_range(Value{f(3.0), f(4.0)});
    x.data.set_clipmode(ClipMode::Both);
    x.data.command(Value{f(-9.5)});
    REQUIRE(x.outputs.back() == Value{f(3.0)});
    x.data.command(Value{f(4.5)});
    REQUIRE(x.outputs.back() == Value{f(4.0)});
    x.data.command(Value{f(3.5)});
    REQUIRE(x.outputs.back() == Value{f(3.5)});
}

/** An array clips every element. */
TEST_CASE("array clips every element")
{
    Fixture x(DataType::Array);
    x.data.set_range(Value{f(0.0), f(1.0)});
    x.data.set_clipmode(ClipMode::Both);
    x.data.command(Value{f(-1.0), f(0.5), f(2.0)});
    REQUIRE(x.outputs.back() == Value{f(0.0), f(0.5), f(1.0)});
}

/** Old behaviour: an array takes the length of the list it is sent. */
TEST_CASE("array takes the length of the new list")
{
    Fixture x(DataType::Array);
    x.data.command(Value{i(1), i(2), i(3)});
    REQUIRE(x.data.value() == Value{f(1.0), f(2.0), f(3.0)});
    x.data.command(Value{i(5)});
    REQUIRE(x.data.value() == Value{f(5.0)});
}

/** The repetition filter drops a value equal to the current one once initialised; off it repeats. */
TEST_CASE("repetition filter drops equal value")
{
    Fixture on(DataType::Decimal);
    on.data.set_repetitions_filter(true);
    on.data.command(Value{f(3.14)});
    on.data.command(Value{f(3.14)});
    on.data.command(Value{f(3.14)});
    REQUIRE(on.outputs.size() == 1);
    on.data.command(Value{f(2.0)});
    REQUIRE(on.outputs.size() == 2);

    Fixture off(DataType::Decimal);
    off.data.set_repetitions_filter(false);
    off.data.command(Value{f(3.14)});
    off.data.command(Value{f(3.14)});
    REQUIRE(off.outputs.size() == 2);
}

/** The first value is always output, even if equal to the initial value. */
TEST_CASE("first value passes the repetition filter")
{
    Fixture x(DataType::Decimal);
    x.data.set_repetitions_filter(true);
    x.data.command(Value{f(0.0)});
    REQUIRE(x.outputs.size() == 1);
    REQUIRE(x.data.initialized());
}

/** Old quirk: the filter compares the unclipped new value with the previous (clipped) one. */
TEST_CASE("repetition filter compares before clipping")
{
    Fixture x(DataType::Decimal);
    x.data.set_repetitions_filter(true);
    x.data.set_range(Value{f(0.0), f(1.0)});
    x.data.set_clipmode(ClipMode::Both);
    x.data.command(Value{f(5.0)});
    x.data.command(Value{f(5.0)});
    REQUIRE(x.outputs.size() == 2);
    REQUIRE(x.outputs[1] == Value{f(1.0)});
}

/** Integers: the filter compares the truncated value. */
TEST_CASE("repetition filter on integers compares truncated values")
{
    Fixture x(DataType::Integer);
    x.data.set_repetitions_filter(true);
    x.data.command(Value{f(3.2)});
    x.data.command(Value{f(3.9)});
    REQUIRE(x.outputs.size() == 1);
}

/** An inactive object ignores commands. */
TEST_CASE("inactive ignores command")
{
    Fixture x(DataType::Decimal);
    x.data.set_active(false);
    x.data.command(Value{f(2.0)});
    REQUIRE(x.outputs.empty());
    REQUIRE(x.data.value() == Value{f(0.0)});
    x.data.set_active(true);
    x.data.command(Value{f(2.0)});
    REQUIRE(x.outputs.size() == 1);
}

/** A command issued from inside the output callback of the same object is dropped, not recursed. */
TEST_CASE("reentrant command from output is dropped")
{
    Data d;
    d.set_type(DataType::Decimal);
    int calls = 0;
    d.set_output([&](const Value&) {
        ++calls;
        d.command(Value{f(9.0)});
    });
    d.command(Value{f(1.0)});
    REQUIRE(calls == 1);
    REQUIRE(d.value() == Value{f(1.0)});
}

/** The output callback runs without the object's lock: it may read the object. */
TEST_CASE("output callback may read the object")
{
    Data d;
    d.set_type(DataType::Decimal);
    Value seen;
    d.set_output([&](const Value&) { seen = d.value(); });
    d.command(Value{f(4.0)});
    REQUIRE(seen == Value{f(4.0)});
}

/** Boolean: nonzero is 1; a symbol is rejected silently; a list of two leaves the value and outputs it. */
TEST_CASE("boolean maps nonzero to one and rejects symbols")
{
    Fixture x(DataType::Boolean);
    x.data.command(Value{i(5)});
    REQUIRE(x.outputs.back() == Value{i(1)});
    x.data.command(Value{f(0.0)});
    REQUIRE(x.outputs.back() == Value{i(0)});
    const std::size_t before = x.outputs.size();
    x.data.command(Value{Atom("foo")});
    REQUIRE(x.outputs.size() == before);
    x.data.command(Value{i(1)});
    x.data.command(Value{i(0), i(1)});
    REQUIRE(x.outputs.back() == Value{i(1)});
}

/** String: only the first atom counts; a number becomes its text. */
TEST_CASE("string keeps the first atom only")
{
    Fixture x(DataType::String);
    x.data.command(Value{Atom("a"), Atom("b")});
    REQUIRE(x.data.value() == Value{Atom("a")});
    x.data.command(Value{i(3)});
    REQUIRE(x.data.value() == Value{Atom("3")});
}

/** String: the range is a list of allowed symbols; a value outside is ignored but the current one is output. */
TEST_CASE("string range is an enumeration")
{
    Fixture x(DataType::String);
    x.data.set_range(Value{Atom("a"), Atom("b")});
    x.data.command(Value{Atom("b")});
    REQUIRE(x.data.value() == Value{Atom("b")});
    x.data.command(Value{Atom("c")});
    REQUIRE(x.data.value() == Value{Atom("b")});
    REQUIRE(x.outputs.back() == Value{Atom("b")});
}

/** String: the repetition filter compares the input with the current value. */
TEST_CASE("string repetition filter")
{
    Fixture x(DataType::String);
    x.data.set_repetitions_filter(true);
    x.data.command(Value{Atom("a")});
    x.data.command(Value{Atom("a")});
    REQUIRE(x.outputs.size() == 1);
}

/** Generic: any list is accepted as it is. */
TEST_CASE("generic accepts any list")
{
    Fixture x(DataType::Generic);
    x.data.command(Value{i(1), Atom("x"), f(2.5)});
    REQUIRE(x.data.value() == Value{i(1), Atom("x"), f(2.5)});
    REQUIRE(x.outputs.back() == Value{i(1), Atom("x"), f(2.5)});
}

/** None: every command outputs an empty value. */
TEST_CASE("none outputs an empty value")
{
    Fixture x(DataType::None);
    x.data.command(Value{f(3.0)});
    REQUIRE(x.outputs.size() == 1);
    REQUIRE(x.outputs[0].empty());
}

/** Init sends the default through the normal pipeline (so it is clipped) and sets initialised. */
TEST_CASE("init outputs the default through the pipeline")
{
    Fixture x(DataType::Decimal);
    x.data.set_default(Value{f(0.5)});
    REQUIRE_FALSE(x.data.initialized());
    x.data.init();
    REQUIRE(x.outputs.size() == 1);
    REQUIRE(x.outputs[0] == Value{f(0.5)});
    REQUIRE(x.data.initialized());

    Fixture y(DataType::Decimal);
    y.data.set_range(Value{f(0.0), f(1.0)});
    y.data.set_clipmode(ClipMode::Both);
    y.data.set_default(Value{f(5.0)});
    y.data.init();
    REQUIRE(y.outputs.back() == Value{f(1.0)});
}

/** Init resets the initialised flag before it sends the default. */
TEST_CASE("init clears initialised first")
{
    Fixture x(DataType::Decimal);
    x.data.set_repetitions_filter(true);
    x.data.set_default(Value{f(0.5)});
    x.data.command(Value{f(0.5)});
    REQUIRE(x.outputs.size() == 1);
    x.data.init();
    REQUIRE(x.outputs.size() == 2);
}

/** Changing the type resets the value and the untouched defaults; an explicit step size is kept. */
TEST_CASE("type change resets value and untouched defaults")
{
    Data d;
    d.set_type(DataType::Decimal);
    d.command(Value{f(0.7)});
    d.set_type(DataType::Integer);
    REQUIRE(d.value() == Value{i(0)});
    REQUIRE(d.stepsize() == 1.0);
    REQUIRE(d.range() == Value{i(0), i(1)});

    Data e;
    e.set_type(DataType::Decimal);
    e.set_stepsize(0.5);
    e.set_type(DataType::Integer);
    REQUIRE(e.stepsize() == 0.5);
}

/** Review Focus 5: range and clip mode may be set in either order. */
TEST_CASE("range then clipmode equals clipmode then range")
{
    Data a;
    a.set_type(DataType::Decimal);
    a.set_range(Value{f(3.0), f(4.0)});
    a.set_clipmode(ClipMode::Both);
    Data b;
    b.set_type(DataType::Decimal);
    b.set_clipmode(ClipMode::Both);
    b.set_range(Value{f(3.0), f(4.0)});
    Value out_a;
    Value out_b;
    a.set_output([&](const Value& v) { out_a = v; });
    b.set_output([&](const Value& v) { out_b = v; });
    a.command(Value{f(9.0)});
    b.command(Value{f(9.0)});
    REQUIRE(out_a == out_b);
    REQUIRE(out_a == Value{f(4.0)});
}

/** Review Focus 3: NaN sent to an integer is 0 and never undefined behaviour. */
TEST_CASE("nan to integer is zero")
{
    Fixture x(DataType::Integer);
    x.data.command(Value{f(std::nan(""))});
    REQUIRE(x.outputs.back() == Value{i(0)});
}

/** Review Focus 3: the largest 64-bit integer survives the integer type. */
TEST_CASE("int64 max survives the integer type")
{
    Fixture x(DataType::Integer);
    x.data.command(Value{i(std::numeric_limits<std::int64_t>::max())});
    REQUIRE(x.outputs.back() == Value{i(std::numeric_limits<std::int64_t>::max())});
}

/** Review Focus 3: infinity sent to a decimal with both clipping lands on the bound. */
TEST_CASE("infinity is clipped to the bound")
{
    Fixture x(DataType::Decimal);
    x.data.set_range(Value{f(0.0), f(1.0)});
    x.data.set_clipmode(ClipMode::Both);
    x.data.command(Value{f(std::numeric_limits<double>::infinity())});
    REQUIRE(x.outputs.back() == Value{f(1.0)});
}

/** Review Focus 3: a range with low above high is accepted and the bounds are swapped. */
TEST_CASE("range with low above high does not crash")
{
    Fixture x(DataType::Decimal);
    x.data.set_range(Value{f(10.0), f(0.0)});
    x.data.set_clipmode(ClipMode::Both);
    x.data.command(Value{f(5.0)});
    REQUIRE(x.outputs.back() == Value{f(5.0)});
    x.data.command(Value{f(15.0)});
    REQUIRE(x.outputs.back() == Value{f(10.0)});
}

/** Review Focus 3: a range with fewer than two bounds means no clipping. */
TEST_CASE("range with one bound means no clipping")
{
    Fixture x(DataType::Decimal);
    x.data.set_range(Value{f(3.0)});
    x.data.set_clipmode(ClipMode::Both);
    x.data.command(Value{f(50.0)});
    REQUIRE(x.outputs.back() == Value{f(50.0)});
}

/** The service, description, tags and priority are stored. */
TEST_CASE("descriptive attributes are stored")
{
    Data d(Service::Return);
    d.set_description("hello");
    d.set_tags({"a", "b"});
    d.set_priority(3);
    REQUIRE(d.service() == Service::Return);
    REQUIRE(d.description() == "hello");
    REQUIRE(d.tags().size() == 2);
    REQUIRE(d.priority() == 3);
}
