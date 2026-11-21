// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file data.cpp
 * @brief Implementation of the data object (a port of the old TTData typed methods).
 */

#include "jamoma/data.hpp"

#include <atomic>
#include <mutex>
#include <optional>

#include "jamoma/dataspace.hpp"

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
struct Data::Impl : std::enable_shared_from_this<Data::Impl> {
    /** @param s The service. */
    explicit Impl(Service s) : service(s) { apply_type_defaults(); }

    Service service;                       /**< The role. */
    DataType type = DataType::Generic;     /**< The type. */
    Value range{flt(0.0), flt(1.0)};       /**< The range. */
    bool range_explicit = false;           /**< Whether the range was set by the user. */
    ClipMode clipmode = ClipMode::None;    /**< The clip mode. */
    bool repetitions_filter = false;       /**< The repetition filter. */
    std::string dataspace;                 /**< The dataspace name, or empty. */
    std::string unit;                      /**< The unit of the value, or empty for the neutral unit. */
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
    Clock* clock = nullptr;                /**< The clock that drives ramps, or null. */
    std::string ramp_drive = "none";       /**< The ramp drive: none, max or system. */
    bool ramp_drive_explicit = false;      /**< Whether the drive was set by the user. */
    std::string ramp_function = "linear";  /**< The ramp function name. */
    std::unique_ptr<Ramp> ramp;            /**< The ramp engine, created on the first ramp. */
    std::string ramp_unit;                 /**< The unit of the values of the running ramp; empty means the object's unit. */

    /** A ramp to start once the command has been processed and its lock and guard released. */
    struct RampPlan {
        std::vector<double> from;          /**< The start vector, in the ramp's unit. */
        std::vector<double> to;            /**< The target vector, in the ramp's unit. */
        double duration_ms = 0.0;          /**< The duration. */
        std::string function;              /**< The function name. */
    };

    /** @return The unit the value is kept in: the one set, else the neutral unit of a valid dataspace, else empty. */
    std::string effective_unit() const
    {
        if (!unit.empty()) {
            return unit;
        }
        const Dataspace* space = Dataspace::find(dataspace);
        return space != nullptr ? space->default_unit() : std::string();
    }

    /** Resets value, default, step size and range to the defaults of the current type (as the old setType). */
    void apply_type_defaults()
    {
        if (!ramp_drive_explicit) {
            ramp_drive = (type == DataType::Integer || type == DataType::Decimal || type == DataType::Array) ? "max" : "none";
        }
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

    /** @return True if a numeric command with a ramp time can start a ramp now. */
    bool ramp_available() const
    {
        return clock != nullptr && (ramp_drive == "max" || ramp_drive == "system");
    }

    /**
     * Plans a ramp from the current value to the command's values (in the command's unit, if it has a valid one).
     * @param command The parsed command.
     * @param a The target values.
     * @return The plan; also records the ramp's unit.
     */
    RampPlan make_plan(const Command& command, const Value& a)
    {
        RampPlan plan;
        for (const Atom& atom : a) {
            plan.to.push_back(atom.as_double());
        }
        Value start = value;
        ramp_unit.clear();
        const Dataspace* space = Dataspace::find(dataspace);
        const std::string own_unit = effective_unit();
        if (!command.unit.empty() && space != nullptr && space->has_unit(command.unit) && space->has_unit(own_unit)) {
            ramp_unit = command.unit;
            start = *space->convert(value, own_unit, command.unit);
        }
        for (const Atom& atom : start) {
            plan.from.push_back(atom.as_double());
        }
        plan.duration_ms = *command.ramp_ms;
        plan.function = ramp_function;
        return plan;
    }

    /**
     * Casts a numeric value to the type, applies the repetition filter, the clip mode and integer truncation, and stores it.
     * @param a The new value (empty means only output the current value).
     * @param out Receives the value to output.
     * @return True if the value is to be output (false if the repetition filter dropped it).
     */
    bool numeric_store(Value a, Value& out)
    {
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
            value = std::move(a);
            if (repetitions_filter && initialized && value == previous) {
                return false; // compared before clipping, as the old object did
            }
            apply_clip(value);
            if (type == DataType::Integer) {
                for (Atom& atom : value) {
                    atom = integer(atom.as_int());
                }
            }
        }
        initialized = true;
        out = value;
        return true;
    }

    /** @return The ramp engine, created on first use. */
    Ramp* ensure_ramp()
    {
        if (!ramp) {
            std::weak_ptr<Impl> weak = weak_from_this();
            ramp = std::make_unique<Ramp>(*clock, [weak](const std::vector<double>& v) {
                if (auto state = weak.lock()) {
                    state->apply_ramp_value(v);
                }
            });
        }
        return ramp.get();
    }

    /** Handles one value emitted by the ramp: unit conversion, filter, clip, store, output. @param v The ramp's vector. */
    void apply_ramp_value(const std::vector<double>& v)
    {
        if (sending.exchange(true)) {
            return;
        }
        struct Release {
            std::atomic<bool>& flag; /**< The guard to clear. */
            ~Release() { flag.store(false); }
        } release{sending};
        Value out;
        std::function<void(const Value&)> callback;
        {
            std::lock_guard<std::mutex> lock(mutex);
            if (!active) {
                return;
            }
            Value a;
            for (double d : v) {
                a.push_back(flt(d));
            }
            if (!ramp_unit.empty()) {
                const Dataspace* space = Dataspace::find(dataspace);
                const std::string own_unit = effective_unit();
                if (space != nullptr && space->has_unit(ramp_unit) && space->has_unit(own_unit)) {
                    a = *space->convert(a, ramp_unit, own_unit);
                }
            }
            if (!numeric_store(std::move(a), out)) {
                return;
            }
            callback = output;
        }
        if (callback) {
            callback(out);
        }
    }

    /**
     * Runs a message through the pipeline of the current type (the lock is held).
     * @param input The message.
     * @param out Receives the value to output.
     * @param plan Receives a ramp to start, if the message asks for one (then nothing is output now).
     * @return True if the value is to be output.
     */
    bool process(const Value& input, Value& out, std::optional<RampPlan>& plan)
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
            const Command command = parse_command(input, true);
            if (ramp) {
                ramp->stop(); // any command stops a running ramp, as the old object did
            }
            Value a = command.values;
            if (type != DataType::Array && a.size() > 1) {
                a.resize(1);
            }
            if (command.ramp_ms.has_value() && *command.ramp_ms > 0.0 && ramp_available() && !a.empty()) {
                plan = make_plan(command, a);
                return false;
            }
            if (!command.unit.empty() && !a.empty()) {
                const Dataspace* space = Dataspace::find(dataspace);
                const std::string own_unit = effective_unit();
                if (space != nullptr && space->has_unit(command.unit) && space->has_unit(own_unit)) {
                    a = *space->convert(a, command.unit, own_unit);
                } // an unknown unit, or a unit without a dataspace, is ignored
            }
            return numeric_store(std::move(a), out);
        }
        }
        return false;
    }
};

Data::Data(Service service) : impl_(std::make_shared<Impl>(service)) {}

Data::~Data()
{
    // Stop the ramp so that no tick is pending; the clock must still be alive (it outlives this object).
    std::lock_guard<std::mutex> lock(impl_->mutex);
    if (impl_->ramp) {
        impl_->ramp->stop();
    }
}

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

void Data::set_dataspace(std::string name)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->dataspace = std::move(name);
}

std::string Data::dataspace() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->dataspace;
}

void Data::set_unit(std::string unit)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->unit = std::move(unit);
}

std::string Data::unit() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->effective_unit();
}

void Data::set_clock(Clock* clock)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    if (impl_->ramp) {
        impl_->ramp->stop();
        impl_->ramp.reset();
    }
    impl_->clock = clock;
}

void Data::set_ramp_drive(std::string drive)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->ramp_drive = std::move(drive);
    impl_->ramp_drive_explicit = true;
}

std::string Data::ramp_drive() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->ramp_drive;
}

void Data::set_ramp_function(std::string function)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->ramp_function = std::move(function);
}

std::string Data::ramp_function() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->ramp_function;
}

bool Data::ramp_running() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->ramp && impl_->ramp->running();
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
    std::optional<Impl::RampPlan> plan;
    Ramp* ramp = nullptr;
    {
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
            emit = s.process(input, out, plan);
            callback = s.output;
            if (plan) {
                ramp = s.ensure_ramp();
            }
        }
        if (emit && callback) {
            callback(out);
        }
    } // the guard is released here, so the ramp's first value can pass through it
    if (plan && ramp != nullptr) {
        ramp->start(plan->from, plan->to, plan->duration_ms, plan->function);
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
