// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file mapper.cpp
 * @brief The mapper (law and bindings: docs/inventory/j.map.md).
 */

#include "jamoma/mapper.hpp"

#include <algorithm>
#include <cmath>
#include <mutex>
#include <optional>
#include <utility>

#include "jamoma/data.hpp"
#include "jamoma/function_library.hpp"
#include "jamoma/receiver.hpp"
#include "jamoma/sender.hpp"

namespace jamoma {

/** The state of a mapper; callbacks of the namespace and of the bound parameters hold it weakly. */
struct Mapper::Impl {
    /** One end of the mapper that is bound to a parameter: the address, whether its range is followed, and the observers. */
    struct End {
        Address address;                 /**< The bound parameter (empty if none). */
        Address last;                    /**< The last parameter this end was bound to (kept while it is unbound). */
        bool follow = true;              /**< Whether the range of the parameter sets the limits. */
        std::shared_ptr<void> created;   /**< Observer of the namespace: the parameter may appear later. */
        std::shared_ptr<void> range;     /**< Observer of the range of the parameter. */
    };

    /** @param n The namespace. */
    explicit Impl(Namespace& n) : ns(n), sender(n), function(Function::create("linear")) {}

    Namespace& ns;                                        /**< The namespace. */
    mutable std::mutex mutex;                             /**< Guards everything below except the callbacks' own calls. */
    MapperSettings settings;                              /**< The settings. */
    std::unique_ptr<Function> function;                   /**< The function. */
    End in;                                               /**< The binding of the input. */
    End out;                                              /**< The binding of the output. */
    std::function<void(const Value&)> on_return;          /**< The return function. */
    std::function<void(std::string_view, bool)> on_threshold; /**< Told when a threshold is crossed. */
    std::function<void(std::function<void()>)> dispatcher;   /**< Runs the writing to the output parameter (empty: at once). */
    bool in_down = false;                                 /**< Whether the input is below the lower input threshold. */
    bool in_up = false;                                   /**< Whether the input is above the upper input threshold. */
    bool out_down = false;                                /**< Whether the output is below the lower output threshold. */
    bool out_up = false;                                  /**< Whether the output is above the upper output threshold. */
    std::unique_ptr<Receiver> receiver;                   /**< Follows the input parameter. */
    Sender sender;                                        /**< Writes to the output parameter. */

    /** @brief The law, with the lock held. @param x The input. @return The output (finite). */
    double map_locked(double x)
    {
        const MapperSettings& s = settings;
        if (std::isnan(x))
            return s.output_min;
        const double lo = std::min(s.input_min, s.input_max), hi = std::max(s.input_min, s.input_max);
        if (s.clipmode == MapperClip::Low || s.clipmode == MapperClip::Both)
            x = std::max(x, lo);
        if (s.clipmode == MapperClip::High || s.clipmode == MapperClip::Both)
            x = std::min(x, hi);
        const double a = s.input_min == s.input_max ? 1.0 : 1.0 / (s.input_max - s.input_min);
        const double t = a * x - a * s.input_min;
        double f = function->apply(t);
        if (s.inverse)
            f = 1.0 - f;
        const double y = s.output_min + (s.output_max - s.output_min) * f;
        return std::isfinite(y) ? y : s.output_min;
    }

    /** @brief Maps a value: every number, or only the item that `input_index` picks out of a list; the lock must be held. @param in The input. @return The output. */
    Value map_value_locked(const Value& in)
    {
        Value out;
        const unsigned index = settings.input_index;
        if (index > 0 && index <= in.size()) {
            const Atom& a = in[index - 1];
            out.push_back(a.is_number() ? Atom(map_locked(a.as_double())) : a);
            return out;
        }
        out.reserve(in.size());
        for (const Atom& a : in)
            out.push_back(a.is_number() ? Atom(map_locked(a.as_double())) : a);
        return out;
    }
};

namespace {

/** @brief What arrives at the input (see Mapper::process). @param impl The state. @param in The input value. */
void process_value(const std::shared_ptr<Mapper::Impl>& impl, const Value& in)
{
    Value mapped;
    Value command;
    std::function<void(const Value&)> on_return;
    std::function<void(std::string_view, bool)> on_threshold;
    std::vector<std::pair<const char*, bool>> events;
    std::function<void(std::function<void()>)> dispatcher;
    bool send = false;
    {
        std::lock_guard<std::mutex> lock(impl->mutex);
        if (!impl->settings.active)
            return;
        mapped = impl->map_value_locked(in);
        on_return = impl->on_return;
        on_threshold = impl->on_threshold;
        dispatcher = impl->dispatcher;
        send = !impl->out.address.empty();
        command = mapped;
        if (impl->settings.ramp > 0) {
            command.push_back("ramp");
            command.push_back(impl->settings.ramp);
        }
        // the thresholds: the first number of the input and of the output
        const auto first = [](const Value& v) -> std::optional<double> {
            for (const Atom& a : v)
                if (a.is_number())
                    return a.as_double();
            return std::nullopt;
        };
        const auto check = [&](const std::optional<double>& value, double down, double up, bool& is_down, bool& is_up, const char* down_name, const char* up_name) {
            if (!value)
                return;
            const bool now_down = *value <= down, now_up = *value >= up;
            if (now_down != is_down) {
                is_down = now_down;
                events.emplace_back(down_name, now_down);
            }
            if (now_up != is_up) {
                is_up = now_up;
                events.emplace_back(up_name, now_up);
            }
        };
        const MapperSettings& s = impl->settings;
        check(first(in), s.input_threshold_down, s.input_threshold_up, impl->in_down, impl->in_up, "input/going/down", "input/going/up");
        check(first(mapped), s.output_threshold_down, s.output_threshold_up, impl->out_down, impl->out_up, "output/going/down", "output/going/up");
    }
    if (send) {
        auto work = [weak = std::weak_ptr<Mapper::Impl>(impl), command] {
            if (auto self = weak.lock())
                self->sender.send(command);
        };
        if (dispatcher)
            dispatcher(std::move(work));
        else
            work();
    }
    if (on_return)
        on_return(mapped);
    if (on_threshold)
        for (const auto& e : events)
            on_threshold(e.first, e.second);
}

/** @param v A candidate limit. @return True if it may be used (finite). */
bool usable(double v) { return std::isfinite(v); }

/**
 * @brief Reads the range of the parameter at an address and watches it.
 * @param impl The mapper's state.
 * @param is_input True for the input end, false for the output end.
 */
void take_range(const std::shared_ptr<Mapper::Impl>& impl, bool is_input)
{
    Address address;
    {
        std::lock_guard<std::mutex> lock(impl->mutex);
        address = (is_input ? impl->in : impl->out).address;
    }
    if (address.empty())
        return;
    std::weak_ptr<Mapper::Impl> weak = impl;
    auto apply = [weak, is_input](const Value& range) {
        auto self = weak.lock();
        if (!self || range.size() != 2 || !range[0].is_number() || !range[1].is_number() || !usable(range[0].as_double()) || !usable(range[1].as_double()))
            return;
        std::lock_guard<std::mutex> lock(self->mutex);
        Mapper::Impl::End& end = is_input ? self->in : self->out;
        double& lo = is_input ? self->settings.input_min : self->settings.output_min;
        double& hi = is_input ? self->settings.input_max : self->settings.output_max;
        // The old rule: a limit set by hand stays (unless it is still the default 0 or 1); a followed end takes the range.
        if (end.follow || lo == 0.0)
            lo = range[0].as_double();
        if (end.follow || hi == 1.0)
            hi = range[1].as_double();
        (is_input ? self->settings.input_threshold_down : self->settings.output_threshold_down) = lo;
        (is_input ? self->settings.input_threshold_up : self->settings.output_threshold_up) = hi;
    };
    std::shared_ptr<void> handle;
    impl->ns.read_object(address, [&](Object& object) {
        if (auto* data = dynamic_cast<Data*>(&object)) {
            apply(data->range());
            handle = data->observe("range", [weak, is_input](const Value& range) {
                auto self = weak.lock();
                if (!self)
                    return;
                {
                    std::lock_guard<std::mutex> lock(self->mutex);
                    if (!(is_input ? self->in : self->out).follow)
                        return;
                }
                if (range.size() == 2 && range[0].is_number() && range[1].is_number() && usable(range[0].as_double()) && usable(range[1].as_double())) {
                    std::lock_guard<std::mutex> lock(self->mutex);
                    (is_input ? self->settings.input_min : self->settings.output_min) = range[0].as_double();
                    (is_input ? self->settings.input_max : self->settings.output_max) = range[1].as_double();
                    (is_input ? self->settings.input_threshold_down : self->settings.output_threshold_down) = range[0].as_double();
                    (is_input ? self->settings.input_threshold_up : self->settings.output_threshold_up) = range[1].as_double();
                }
            });
        }
    });
    std::lock_guard<std::mutex> lock(impl->mutex);
    (is_input ? impl->in : impl->out).range = handle;
}

/** @brief Binds one end (not named bind: std::bind would be found through the shared_ptr argument).  @param impl The state. @param is_input Which end. @param address The parameter (empty = unbind). */
void bind_end(const std::shared_ptr<Mapper::Impl>& impl, bool is_input, const Address& address)
{
    {
        std::lock_guard<std::mutex> lock(impl->mutex);
        Mapper::Impl::End& end = is_input ? impl->in : impl->out;
        end.address = address;
        if (!address.empty()) {
            // limits set by hand stay until the end is turned to another parameter
            if (!end.last.empty() && !(end.last == address))
                end.follow = true;
            end.last = address;
        }
        end.range.reset();
        end.created.reset();
    }
    if (is_input)
        impl->receiver->set_address(address);
    else
        impl->sender.set_address(address);
    if (address.empty())
        return;
    std::weak_ptr<Mapper::Impl> weak = impl;
    auto created = impl->ns.observe(address, [weak, is_input](const Address&, Object*, bool was_created) {
        if (!was_created)
            return;
        if (auto self = weak.lock())
            take_range(self, is_input);
    });
    {
        std::lock_guard<std::mutex> lock(impl->mutex);
        (is_input ? impl->in : impl->out).created = created;
    }
    take_range(impl, is_input);
}

} // namespace

Mapper::Mapper(Namespace& ns) : impl_(std::make_shared<Impl>(ns))
{
    std::weak_ptr<Impl> weak = impl_;
    impl_->receiver = std::make_unique<Receiver>(ns, [](const Address&) {}, [weak](const Value& v) {
        if (auto self = weak.lock())
            process_value(self, v);
    });
}

Mapper::~Mapper()
{
    impl_->receiver.reset();
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->in = {};
    impl_->out = {};
    impl_->on_return = nullptr;
    impl_->on_threshold = nullptr;
    impl_->dispatcher = nullptr;
}

MapperSettings Mapper::settings() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->settings;
}

/** @brief Sets a limit by hand if usable, and stops following the range of that end. @param impl State. @param is_input End. @param field The limit. @param v The value. */
static void set_limit(Mapper::Impl& impl, bool is_input, double MapperSettings::*field, double v)
{
    if (!usable(v))
        return;
    std::lock_guard<std::mutex> lock(impl.mutex);
    impl.settings.*field = v;
    (is_input ? impl.in : impl.out).follow = false;
    (is_input ? impl.in : impl.out).range.reset();
}

void Mapper::set_input_min(double v) { set_limit(*impl_, true, &MapperSettings::input_min, v); }
void Mapper::set_input_max(double v) { set_limit(*impl_, true, &MapperSettings::input_max, v); }
void Mapper::set_output_min(double v) { set_limit(*impl_, false, &MapperSettings::output_min, v); }
void Mapper::set_output_max(double v) { set_limit(*impl_, false, &MapperSettings::output_max, v); }

void Mapper::set_clipmode(MapperClip mode)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->settings.clipmode = mode;
}

void Mapper::set_input_index(unsigned index)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->settings.input_index = index;
}

/** @brief Sets a threshold if usable. @param impl State. @param field The threshold. @param v The value. */
static void set_threshold(Mapper::Impl& impl, double MapperSettings::*field, double v)
{
    if (!usable(v))
        return;
    std::lock_guard<std::mutex> lock(impl.mutex);
    impl.settings.*field = v;
}

void Mapper::set_input_threshold_down(double v) { set_threshold(*impl_, &MapperSettings::input_threshold_down, v); }
void Mapper::set_input_threshold_up(double v) { set_threshold(*impl_, &MapperSettings::input_threshold_up, v); }
void Mapper::set_output_threshold_down(double v) { set_threshold(*impl_, &MapperSettings::output_threshold_down, v); }
void Mapper::set_output_threshold_up(double v) { set_threshold(*impl_, &MapperSettings::output_threshold_up, v); }

void Mapper::set_send_dispatcher(std::function<void(std::function<void()>)> dispatcher)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->dispatcher = std::move(dispatcher);
}

void Mapper::set_threshold_callback(std::function<void(std::string_view, bool)> callback)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->on_threshold = std::move(callback);
}

void Mapper::set_inverse(bool on)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->settings.inverse = on;
}

void Mapper::set_active(bool on)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->settings.active = on;
}

void Mapper::set_ramp(double ms)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->settings.ramp = usable(ms) && ms > 0 ? ms : 0.0;
}

bool Mapper::set_function(std::string_view name)
{
    auto f = Function::create(name);
    if (!f)
        return false;
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->function = std::move(f);
    return true;
}

std::string Mapper::function() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->function->name();
}

bool Mapper::set_function_parameter(std::string_view parameter, const Value& value)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->function->set(parameter, value);
}

Value Mapper::function_parameter(std::string_view parameter) const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->function->get(parameter);
}

std::vector<std::string> Mapper::function_parameters() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->function->parameter_names();
}

double Mapper::map(double x)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->map_locked(x);
}

Value Mapper::map(const Value& in)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->map_value_locked(in);
}

std::vector<double> Mapper::samples(std::size_t count) const
{
    std::vector<double> out;
    std::lock_guard<std::mutex> lock(impl_->mutex);
    auto copy = Function::create(impl_->function->name());
    for (const auto& p : impl_->function->parameter_names())
        static_cast<void>(copy->set(p, impl_->function->get(p)));
    Impl scratch(impl_->ns);
    scratch.settings = impl_->settings;
    scratch.function = std::move(copy);
    const double step = count ? (impl_->settings.input_max - impl_->settings.input_min) / static_cast<double>(count) : 0.0;
    out.reserve(count);
    for (std::size_t i = 0; i < count; ++i)
        out.push_back(scratch.map_locked(impl_->settings.input_min + static_cast<double>(i) * step));
    return out;
}

void Mapper::reset()
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->function->reset();
}

void Mapper::bind_input(const Address& address) { bind_end(impl_, true, address); }
void Mapper::bind_output(const Address& address) { bind_end(impl_, false, address); }

Address Mapper::input() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->in.address;
}

Address Mapper::output() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->out.address;
}

void Mapper::set_return(std::function<void(const Value&)> callback)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->on_return = std::move(callback);
}

void Mapper::process(const Value& in) { process_value(impl_, in); }

} // namespace jamoma
