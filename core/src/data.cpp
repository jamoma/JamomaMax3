// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file data.cpp
 * @brief Implementation of the data object (a port of the old TTData typed methods).
 */

#include "jamoma/data.hpp"

#include <atomic>
#include <mutex>

namespace jamoma {

namespace {

/** A float atom. @param v The value. @return The atom. */
Atom flt(double v) { return Atom(v); }
/** An integer atom. @param v The value. @return The atom. */
Atom integer(std::int64_t v) { return Atom(v); }

} // namespace

DataType data_type_from_name(std::string_view name)
{
    if (name == "none") return DataType::None;
    if (name == "string") return DataType::String;
    if (name == "boolean") return DataType::Boolean;
    if (name == "integer") return DataType::Integer;
    if (name == "decimal") return DataType::Decimal;
    if (name == "array") return DataType::Array;
    return DataType::Generic;
}

std::string_view data_type_name(DataType type)
{
    switch (type) {
    case DataType::None: return "none";
    case DataType::String: return "string";
    case DataType::Boolean: return "boolean";
    case DataType::Integer: return "integer";
    case DataType::Decimal: return "decimal";
    case DataType::Array: return "array";
    case DataType::Generic: break;
    }
    return "generic";
}

/** The state of a data object. */
struct Data::Impl {
    /** @param s The service. */
    explicit Impl(Service s) : service(s) { apply_type_defaults(); }

    Service service;                       /**< The role. */
    DataType type = DataType::Generic;     /**< The type. */
    Value range{flt(0.0), flt(1.0)};       /**< The range. */
    bool range_explicit = false;           /**< Whether the range was set by the user. */
    ClipMode clipmode = ClipMode::None;    /**< The clip mode. */
    bool repetitions_filter = false;       /**< The repetition filter. */
    Value default_value;                   /**< The default value. */
    double stepsize = 0.1;                 /**< The step size. */
    bool stepsize_explicit = false;        /**< Whether the step size was set by the user. */
    bool active = true;                    /**< Whether commands are accepted. */
    int priority = 0;                      /**< The initialisation priority. */
    std::string description = "none";      /**< The description. */
    std::vector<std::string> tags{"none"}; /**< The tags. */
    Value value;                           /**< The current value. */
    bool initialized = false;              /**< Whether a value has been output. */
    std::function<void(const Value&)> output; /**< The output function. */
    mutable std::mutex mutex;              /**< Guards the state. */
    std::atomic<bool> sending{false};      /**< The re-entrancy guard. */

    /** Resets value, default, step size and range to the defaults of the current type (as the old setType). */
    void apply_type_defaults()
    {
        switch (type) {
        case DataType::Integer:
            value = default_value = Value{integer(0)};
            if (!stepsize_explicit) stepsize = 1.0;
            if (!range_explicit) range = Value{integer(0), integer(1)};
            break;
        case DataType::Decimal:
        case DataType::Array:
        case DataType::Generic:
            value = default_value = Value{flt(0.0)};
            if (!stepsize_explicit) stepsize = 0.1;
            if (!range_explicit) range = Value{flt(0.0), flt(1.0)};
            break;
        case DataType::Boolean:
            value = default_value = Value{integer(0)};
            if (!stepsize_explicit) stepsize = 1.0;
            if (!range_explicit) range = Value{integer(0), integer(1)};
            break;
        case DataType::String:
            value = default_value = Value{Atom("none")};
            if (!range_explicit) range.clear();
            break;
        case DataType::None:
            value.clear();
            default_value.clear();
            if (!range_explicit) range.clear();
            break;
        }
    }

    /**
     * Applies the clip mode to every numeric atom, if the range has two numeric bounds.
     * @param v The value to clip in place.
     */
    void apply_clip(Value& v) const
    {
        if (clipmode == ClipMode::None || range.size() < 2 || !range[0].is_number() || !range[1].is_number()) {
            return;
        }
        const double low = range[0].as_double();
        const double high = range[1].as_double();
        for (Atom& atom : v) {
            if (!atom.is_number()) {
                continue;
            }
            const double clipped = clip(atom.as_double(), low, high, clipmode);
            atom = atom.is_int() ? Atom(Atom(clipped).as_int()) : Atom(clipped);
        }
    }

    /**
     * Runs a message through the pipeline of the current type (the lock is held).
     * @param input The message.
     * @param out Receives the value to output.
     * @return True if the value is to be output.
     */
    bool process(const Value& input, Value& out)
    {
        switch (type) {
        case DataType::None:
            initialized = true;
            out.clear();
            return true;

        case DataType::Generic: {
            const Value& a = input;
            if (repetitions_filter && initialized && value == a) {
                return false;
            }
            if (!a.empty()) {
                value = a;
                apply_clip(value);
            }
            initialized = true;
            out = value;
            return true;
        }

        case DataType::Boolean: {
            if (!input.empty() && !input[0].is_number()) {
                return false; // the boolean type rejects a symbol silently
            }
            if (repetitions_filter && initialized && input.size() == 1) {
                if (Value{integer(input[0].as_double() != 0.0 ? 1 : 0)} == value) {
                    return false;
                }
            }
            if (input.size() == 1) {
                value = Value{integer(input[0].as_double() != 0.0 ? 1 : 0)};
            }
            initialized = true;
            out = value;
            return true;
        }

        case DataType::String: {
            Value a;
            if (!input.empty()) {
                a.push_back(input[0]);
            }
            if (repetitions_filter && initialized && value == a) {
                return false;
            }
            if (!a.empty()) {
                const Atom symbol = a[0].is_symbol() ? a[0] : Atom(a[0].to_string());
                bool found = true;
                if (!range.empty()) {
                    found = false;
                    for (const Atom& allowed : range) {
                        if (allowed.to_string() == symbol.as_symbol()) {
                            found = true;
                            break;
                        }
                    }
                }
                if (found) {
                    value = Value{symbol};
                }
            }
            initialized = true;
            out = value;
            return true;
        }

        case DataType::Integer:
        case DataType::Decimal:
        case DataType::Array: {
            Value a = parse_command(input, true).values; // unit and ramp are handled in later tasks
            if (type != DataType::Array && a.size() > 1) {
                a.resize(1);
            }
            if (type == DataType::Decimal && !a.empty()) {
                a = Value{flt(a[0].as_double())};
            } else if (type == DataType::Integer && !a.empty()) {
                a = Value{integer(a[0].as_int())};
            } else if (type == DataType::Array) {
                for (Atom& atom : a) {
                    atom = flt(atom.as_double());
                }
            }
            if (!a.empty()) {
                const Value previous = value;
                value = a;
                if (repetitions_filter && initialized && value == previous) {
                    return false; // compared before clipping, as the old object did
                }
                apply_clip(value);
                if (type == DataType::Integer) {
                    for (Atom& atom : value) {
                        atom = integer(atom.as_int());
                    }
                }
                initialized = true;
            }
            initialized = true;
            out = value;
            return true;
        }
        }
        return false;
    }
};

Data::Data(Service service) : impl_(std::make_unique<Impl>(service)) {}

Data::~Data() = default;

Service Data::service() const noexcept { return impl_->service; }

void Data::set_type(DataType type)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->type = type;
    impl_->apply_type_defaults();
}

DataType Data::type() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->type;
}

void Data::set_range(const Value& range)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->range = range;
    impl_->range_explicit = true;
}

Value Data::range() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->range;
}

void Data::set_clipmode(ClipMode mode)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->clipmode = mode;
}

ClipMode Data::clipmode() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->clipmode;
}

void Data::set_repetitions_filter(bool on)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->repetitions_filter = on;
}

bool Data::repetitions_filter() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->repetitions_filter;
}

void Data::set_default(const Value& value)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->default_value = value;
}

Value Data::default_value() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->default_value;
}

void Data::set_stepsize(double step)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->stepsize = step;
    impl_->stepsize_explicit = true;
}

double Data::stepsize() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->stepsize;
}

void Data::set_active(bool on)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->active = on;
}

bool Data::active() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->active;
}

void Data::set_priority(int priority)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->priority = priority;
}

int Data::priority() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->priority;
}

void Data::set_description(std::string text)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->description = std::move(text);
}

std::string Data::description() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->description;
}

void Data::set_tags(std::vector<std::string> tags)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->tags = std::move(tags);
}

std::vector<std::string> Data::tags() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->tags;
}

Value Data::value() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->value;
}

bool Data::initialized() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->initialized;
}

void Data::set_output(std::function<void(const Value&)> output)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->output = std::move(output);
}

void Data::command(const Value& input)
{
    Impl& s = *impl_;
    if (s.sending.exchange(true)) {
        return; // another command is in progress (possibly this thread's own output callback): dropped
    }
    struct Release {
        std::atomic<bool>& flag; /**< The guard to clear. */
        ~Release() { flag.store(false); }
    } release{s.sending};

    Value out;
    bool emit = false;
    std::function<void(const Value&)> callback;
    {
        std::lock_guard<std::mutex> lock(s.mutex);
        if (!s.active) {
            return;
        }
        emit = s.process(input, out);
        callback = s.output;
    }
    if (emit && callback) {
        callback(out);
    }
}

void Data::inc(const Value& args)
{
    Value message;
    {
        std::lock_guard<std::mutex> lock(impl_->mutex);
        if (impl_->type == DataType::String) {
            return;
        }
        double amount = 1.0;
        bool with_ramp = false;
        if ((args.size() == 1 || args.size() == 3) && args[0].is_number()) {
            amount = args[0].as_double();
            with_ramp = args.size() == 3 && args[1].is_symbol() && args[1].as_symbol() == "ramp";
        }
        for (const Atom& atom : impl_->value) {
            message.push_back(flt(atom.as_double() + amount * impl_->stepsize));
        }
        if (with_ramp) {
            message.push_back(args[1]);
            if (args[2].is_number()) {
                message.push_back(args[2]);
            }
        }
    }
    command(message);
}

void Data::dec(const Value& args)
{
    Value message;
    {
        std::lock_guard<std::mutex> lock(impl_->mutex);
        if (impl_->type == DataType::String) {
            return;
        }
        double amount = 1.0;
        bool with_ramp = false;
        if ((args.size() == 1 || args.size() == 3) && args[0].is_number()) {
            amount = args[0].as_double();
            with_ramp = args.size() == 3 && args[1].is_symbol() && args[1].as_symbol() == "ramp";
        }
        for (const Atom& atom : impl_->value) {
            message.push_back(flt(atom.as_double() - amount * impl_->stepsize));
        }
        if (with_ramp) {
            message.push_back(args[1]);
            if (args[2].is_number()) {
                message.push_back(args[2]);
            }
        }
    }
    command(message);
}

void Data::init()
{
    Value default_message;
    {
        std::lock_guard<std::mutex> lock(impl_->mutex);
        impl_->initialized = false;
        const Value& d = impl_->default_value;
        bool usable = !d.empty() && impl_->type != DataType::None;
        if (usable && (impl_->type == DataType::Integer || impl_->type == DataType::Decimal || impl_->type == DataType::Boolean)) {
            usable = d[0].is_number();
        }
        if (usable) {
            default_message = d;
        }
    }
    if (!default_message.empty()) {
        command(default_message);
    }
}

} // namespace jamoma
