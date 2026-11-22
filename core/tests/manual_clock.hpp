// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file manual_clock.hpp
 * @brief A clock for tests that advances only when told to.
 */

#pragma once

#include <functional>

#include "jamoma/ramp.hpp"

/** A jamoma::Clock with one pending callback that fires when the test advances time. */
class ManualClock : public jamoma::Clock {
public:
    /** @brief Schedules the one pending callback, replacing any earlier one. @param delay_ms The delay. @param callback The function to call. */
    void schedule(double delay_ms, std::function<void()> callback) override
    {
        pending_ = std::move(callback);
        due_ = now_ + delay_ms;
        has_pending_ = true;
    }
    /** @brief Removes the pending callback. */
    void cancel() override
    {
        has_pending_ = false;
        pending_ = nullptr;
    }
    /** @return The current time in milliseconds. */
    double now_ms() const override { return now_; }
    /** @return True if a callback is pending. */
    bool has_pending() const { return has_pending_; }

    /** @brief Advances time, firing every callback that falls due on the way (including ones scheduled by callbacks). @param ms How far to advance. */
    void advance(double ms)
    {
        const double target = now_ + ms;
        while (has_pending_ && due_ <= target) {
            now_ = due_;
            auto callback = std::move(pending_);
            has_pending_ = false;
            callback();
        }
        now_ = target;
    }

private:
    double now_ = 0.0;                    /**< The current time. */
    double due_ = 0.0;                    /**< When the pending callback is due. */
    bool has_pending_ = false;            /**< Whether a callback is pending. */
    std::function<void()> pending_;       /**< The pending callback. */
};
