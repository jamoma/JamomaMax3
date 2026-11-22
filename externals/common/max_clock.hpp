// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file max_clock.hpp
 * @brief The Max ramp drive: a jamoma::Clock backed by a Max scheduler clock.
 */

#pragma once

#include <functional>
#include <mutex>

#include "c74_min.h"

#include "jamoma/ramp.hpp"

namespace jamoma_max {

/**
 * @brief A core clock that fires from Max's scheduler. Create and destroy it on the main thread.
 *
 * Holds one pending callback; the callback runs on the scheduler thread (or the main thread, as Max decides).
 */
class MaxClock : public jamoma::Clock {
public:
    /** Creates the Max clock. */
    MaxClock()
    {
        clock_ = c74::max::clock_new(this, reinterpret_cast<c74::max::method>(&MaxClock::trampoline));
    }

    /** Cancels any pending call and frees the Max clock. */
    ~MaxClock() override
    {
        if (clock_ != nullptr) {
            c74::max::clock_unset(clock_);
            c74::max::object_free(clock_);
        }
    }

    MaxClock(const MaxClock&) = delete;            /**< A clock is never copied. */
    MaxClock& operator=(const MaxClock&) = delete; /**< A clock is never assigned. */

    /** @brief Schedules the call, replacing a pending one. @param delay_ms The delay in milliseconds. @param callback The function to call. */
    void schedule(double delay_ms, std::function<void()> callback) override
    {
        {
            std::lock_guard<std::mutex> lock(mutex_);
            callback_ = std::move(callback);
        }
        c74::max::clock_unset(clock_);
        c74::max::clock_fdelay(clock_, delay_ms);
    }

    /** @brief Cancels the pending call. */
    void cancel() override
    {
        c74::max::clock_unset(clock_);
        std::lock_guard<std::mutex> lock(mutex_);
        callback_ = nullptr;
    }

    /** @return The scheduler time in milliseconds. */
    double now_ms() const override
    {
        double time = 0.0;
        c74::max::clock_getftime(&time);
        return time;
    }

private:
    /** The function Max calls when the clock fires. @param self The MaxClock that was scheduled. */
    static void trampoline(MaxClock* self)
    {
        std::function<void()> callback;
        {
            std::lock_guard<std::mutex> lock(self->mutex_);
            callback = std::move(self->callback_);
            self->callback_ = nullptr;
        }
        if (callback) {
            callback();
        }
    }

    c74::max::t_clock* clock_ = nullptr;   /**< The Max clock. */
    std::mutex mutex_;                     /**< Guards the pending callback. */
    std::function<void()> callback_;       /**< The pending callback. */
};

} // namespace jamoma_max
