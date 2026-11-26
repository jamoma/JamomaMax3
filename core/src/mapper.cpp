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
    End in, out;                                          /**< The bindings. */
    std::function<void(const Value&)> on_return;          /**< The return function. */
    std::unique_ptr<Receiver> receiver;                   /**< Follows the input parameter. */
    Sender sender;                                        /**< Writes to the output parameter. */

    /** @brief The law, with the lock held. @param x The input. @return The output. */
    double map_locked(double x)
    {
        const MapperSettings& s = settings;
        const double lo_out = std::min(s.output_min, s.output_max), hi_out = std::max(s.output_min, s.output_max);
        if (std::isnan(x))
            return std::clamp(s.output_min, lo_out, hi_out);
        x = std::clamp(x, std::min(s.input_min, s.input_max), std::max(s.input_min, s.input_max));
        const double a = s.input_min == s.input_max ? 1.0 : 1.0 / (s.input_max - s.input_min);
        const double t = a * x - a * s.input_min;
        double f = function->apply(t);
        if (s.inverse)
            f = 1.0 - f;
        return std::clamp(s.output_min + (s.output_max - s.output_min) * f, lo_out, hi_out);
    }
};

namespace {

/** @brief What arrives at the input (see Mapper::process). @param impl The state. @param in The input value. */
void process_value(const std::shared_ptr<Mapper::Impl>& impl, const Value& in)
{
    Value mapped;
    Value command;
    std::function<void(const Value&)> on_return;
    bool send = false;
    {
        std::lock_guard<std::mutex> lock(impl->mutex);
        if (!impl->settings.active)
            return;
        mapped.reserve(in.size());
        for (const Atom& a : in)
            mapped.push_back(a.is_number() ? Atom(impl->map_locked(a.as_double())) : a);
        on_return = impl->on_return;
        send = !impl->out.address.empty();
        command = mapped;
        if (impl->settings.ramp > 0) {
            command.push_back("ramp");
            command.push_back(impl->settings.ramp);
        }
    }
    if (send)
        impl->sender.send(command);
    if (on_return)
        on_return(mapped);
}

/** @param v A candidate limit. @return True if it may be used (finite). */
bool usable(double v) { return std::isfinite(v); }

/**
 * @brief Reads the range of the parameter at an address and watches it.
 * @param impl The mapper's state.
 * @param is_input True for the input end, false for the output end.
 * @param on_creation True if the parameter has just appeared (an explicit limit is then kept unless it is still the default 0 or 1).
 */
void take_range(const std::shared_ptr<Mapper::Impl>& impl, bool is_input, bool on_creation)
{
    Address address;
    {
        std::lock_guard<std::mutex> lock(impl->mutex);
        address = (is_input ? impl->in : impl->out).address;
    }
    if (address.empty())
        return;
    std::weak_ptr<Mapper::Impl> weak = impl;
    auto apply = [weak, is_input, on_creation](const Value& range) {
        auto self = weak.lock();
        if (!self || range.size() != 2 || !range[0].is_number() || !range[1].is_number() || !usable(range[0].as_double()) || !usable(range[1].as_double()))
            return;
        std::lock_guard<std::mutex> lock(self->mutex);
        Mapper::Impl::End& end = is_input ? self->in : self->out;
        double& lo = is_input ? self->settings.input_min : self->settings.output_min;
        double& hi = is_input ? self->settings.input_max : self->settings.output_max;
        if (end.follow || !on_creation) { // a limit set by hand is not followed; at creation the old rule keeps non-default hand-set limits
            if (end.follow || lo == 0.0)
                lo = range[0].as_double();
            if (end.follow || hi == 1.0)
                hi = range[1].as_double();
        }
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
        end.follow = true;
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
            take_range(self, is_input, true);
    });
    {
        std::lock_guard<std::mutex> lock(impl->mutex);
        (is_input ? impl->in : impl->out).created = created;
    }
    take_range(impl, is_input, false);
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
    Value out;
    out.reserve(in.size());
    std::lock_guard<std::mutex> lock(impl_->mutex);
    for (const Atom& a : in)
        out.push_back(a.is_number() ? Atom(impl_->map_locked(a.as_double())) : a);
    return out;
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
