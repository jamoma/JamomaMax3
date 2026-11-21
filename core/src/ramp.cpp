// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file ramp.cpp
 * @brief Implementation of the ramp engine.
 */

#include "jamoma/ramp.hpp"

#include <algorithm>
#include <cmath>
#include <mutex>

namespace jamoma {

Clock::~Clock() = default;

/** The state of a ramp; clock callbacks hold it only weakly. */
struct Ramp::State {
    /** @param c The clock. @param f The value callback. */
    State(Clock& c, std::function<void(const std::vector<double>&)> f) : clock(c), on_value(std::move(f)) {}

    Clock& clock;                                              /**< The clock. */
    std::function<void(const std::vector<double>&)> on_value;  /**< Receives every emitted vector. */
    std::vector<double> from;                                  /**< The start vector (padded to the length of `to`). */
    std::vector<double> to;                                    /**< The target vector. */
    double duration = 0.0;                                     /**< The duration in milliseconds. */
    double start_time = 0.0;                                   /**< The clock time at the start. */
    bool running = false;                                      /**< Whether a ramp is running. */
    bool function_ok = true;                                   /**< Whether the last function name was known. */
    unsigned long generation = 0;                              /**< Incremented by start and stop; stale callbacks compare against it. */
    mutable std::mutex mutex;                                  /**< Guards the fields above; never held while on_value or the clock is called. */
};

namespace {

/** Schedules the next tick of the ramp of generation `gen`. @param state The state. @param gen The generation. */
void schedule_next(const std::shared_ptr<Ramp::State>& state, unsigned long gen);

/** Handles a tick of generation `gen`. @param state The state. @param gen The generation. */
void tick(const std::shared_ptr<Ramp::State>& state, unsigned long gen)
{
    std::vector<double> value;
    bool last = false;
    {
        std::lock_guard<std::mutex> lock(state->mutex);
        if (gen != state->generation || !state->running) {
            return;
        }
        const double elapsed = state->clock.now_ms() - state->start_time;
        if (elapsed + 1e-9 >= state->duration) {
            state->running = false;
            ++state->generation;
            value = state->to;
            last = true;
        } else {
            const double position = elapsed / state->duration;
            value.resize(state->to.size());
            for (std::size_t i = 0; i < value.size(); ++i) {
                value[i] = state->from[i] + (state->to[i] - state->from[i]) * position;
            }
        }
    }
    state->on_value(value);
    if (!last) {
        bool again;
        {
            std::lock_guard<std::mutex> lock(state->mutex);
            again = gen == state->generation && state->running;
        }
        if (again) {
            schedule_next(state, gen);
        }
    }
}

void schedule_next(const std::shared_ptr<Ramp::State>& state, unsigned long gen)
{
    double delay;
    {
        std::lock_guard<std::mutex> lock(state->mutex);
        const double elapsed = state->clock.now_ms() - state->start_time;
        const double boundary = (std::floor(elapsed / Ramp::kTickMs + 1e-9) + 1.0) * Ramp::kTickMs;
        delay = std::max(0.0, std::min(boundary, state->duration) - elapsed);
    }
    std::weak_ptr<Ramp::State> weak = state;
    state->clock.schedule(delay, [weak, gen]() {
        if (auto locked = weak.lock()) {
            tick(locked, gen);
        }
    });
}

} // namespace

Ramp::Ramp(Clock& clock, std::function<void(const std::vector<double>&)> on_value)
    : state_(std::make_shared<State>(clock, std::move(on_value)))
{
}

Ramp::~Ramp()
{
    stop();
}

void Ramp::start(const std::vector<double>& from, const std::vector<double>& to, double duration_ms, std::string_view function)
{
    stop();
    State& s = *state_;
    std::vector<double> first;
    unsigned long gen = 0;
    bool immediate = false;
    {
        std::lock_guard<std::mutex> lock(s.mutex);
        s.function_ok = (function == "linear");
        s.to = to;
        s.from = from;
        s.from.resize(to.size());
        for (std::size_t i = from.size(); i < to.size(); ++i) {
            s.from[i] = to[i];
        }
        s.duration = duration_ms;
        if (!(duration_ms > 0.0)) {
            immediate = true;
            first = s.to;
        } else {
            s.running = true;
            s.start_time = s.clock.now_ms();
            gen = ++s.generation;
            first = s.from;
        }
    }
    s.on_value(first);
    if (immediate) {
        return;
    }
    bool again;
    {
        std::lock_guard<std::mutex> lock(s.mutex);
        again = gen == s.generation && s.running;
    }
    if (again) {
        schedule_next(state_, gen);
    }
}

void Ramp::stop()
{
    State& s = *state_;
    {
        std::lock_guard<std::mutex> lock(s.mutex);
        ++s.generation;
        s.running = false;
    }
    s.clock.cancel();
}

bool Ramp::running() const
{
    std::lock_guard<std::mutex> lock(state_->mutex);
    return state_->running;
}

bool Ramp::function_ok() const
{
    std::lock_guard<std::mutex> lock(state_->mutex);
    return state_->function_ok;
}

} // namespace jamoma
