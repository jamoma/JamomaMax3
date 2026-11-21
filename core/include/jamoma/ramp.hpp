// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file ramp.hpp
 * @brief The ramp engine: values that move from one value to another over time, driven by a clock.
 */

#pragma once

#include <functional>
#include <memory>
#include <string_view>
#include <vector>

#include "jamoma/export.hpp"

namespace jamoma {

/**
 * @brief The source of time and of delayed calls (a "drive"). The Max drive is implemented in the Max layer.
 *
 * A clock holds at most one pending callback: scheduling replaces the pending one. A clock must outlive everything that uses it.
 */
class JAMOMA_API Clock {
public:
    virtual ~Clock();
    /** @brief Calls a function once after a delay, replacing any pending call. @param delay_ms The delay in milliseconds. @param callback The function. */
    virtual void schedule(double delay_ms, std::function<void()> callback) = 0;
    /** @brief Cancels the pending call, if any. */
    virtual void cancel() = 0;
    /** @return The current time in milliseconds (any origin, monotonic). */
    virtual double now_ms() const = 0;
};

/**
 * @brief A linear ramp over a vector of numbers.
 *
 * start() emits the start vector at once, then one vector every kTickMs (at the next 20 ms boundary of the elapsed time, or at
 * the end of the ramp, whichever comes first); the last vector is exactly the target. A duration of zero or less emits the
 * target at once. Starting while a ramp runs replaces it; stopping cancels pending ticks. start() and stop() may be called
 * from inside the callback. A destroyed Ramp is never called back.
 */
class JAMOMA_API Ramp {
public:
    static constexpr double kTickMs = 20.0; /**< The time between ticks, in milliseconds (from the old tests). */

    /** @param clock The clock to use; it must outlive the ramp. @param on_value Called with every emitted vector. */
    Ramp(Clock& clock, std::function<void(const std::vector<double>&)> on_value);
    ~Ramp();
    Ramp(const Ramp&) = delete;            /**< A ramp is never copied. */
    Ramp& operator=(const Ramp&) = delete; /**< A ramp is never assigned. */

    /**
     * @brief Starts a ramp.
     * @param from The start vector; a vector shorter than `to` is padded with the target's elements (those jump at once).
     * @param to The target vector (its length is the length of every emitted vector).
     * @param duration_ms The duration in milliseconds.
     * @param function The function name; only `linear` exists, any other name falls back to it (see function_ok()).
     */
    void start(const std::vector<double>& from, const std::vector<double>& to, double duration_ms, std::string_view function);
    /** @brief Stops the ramp and cancels pending ticks. */
    void stop();
    /** @return True while a ramp is running. */
    bool running() const;
    /** @return False if the function of the last start() was unknown. */
    bool function_ok() const;

    struct State;                         /**< The state, shared weakly with pending clock callbacks (opaque outside the library). */

private:
    std::shared_ptr<State> state_;        /**< The state. */
};

} // namespace jamoma
