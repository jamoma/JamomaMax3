// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file function_library.cpp
 * @brief The functions of the library (formulas of docs/inventory/j.map.md).
 */

#include "jamoma/function_library.hpp"

#include <algorithm>
#include <cmath>
#include <functional>
#include <utility>

namespace jamoma {

namespace {

constexpr double kPi = 3.14159265358979323846;       /**< Pi. */
constexpr double kBaseMin = 1e-6;                    /**< The lowest base of exponential and logarithm (the old range started at epsilon). */
constexpr double kBaseMax = 100000.0;                /**< The highest base. */

/** @brief Returns the number held by the first atom of a value. @param v The value. @param out The number. @return False if it is empty or not a number. */
bool number_of(const Value& v, double& out) {
    if (v.size() != 1 || !v[0].is_number())
        return false;
    out = v[0].as_double();
    return std::isfinite(out);
}

/** @brief A function without parameters, made from a formula. */
class Plain final : public Function {
public:
    /** @param name The name. @param formula The curve. */
    Plain(std::string name, std::function<double(double)> formula) : Function(std::move(name)), formula_(std::move(formula)) {}

private:
    /** @brief The curve. @param x The input. @return The output. */
    double calculate(double x) override { return formula_(x); }
    std::function<double(double)> formula_; /**< The formula. */
};

/** @brief exponential and logarithm: one parameter, the base. */
class Based final : public Function {
public:
    /** @param name The name (exponential or logarithm). */
    explicit Based(std::string name) : Function(std::move(name)), exponential_(this->name() == "exponential") { set("base", {std::exp(1.0)}); }
    std::vector<std::string> parameter_names() const override { return {"base"}; }
    Value get(std::string_view parameter) const override { return parameter == "base" ? Value{base_} : Value{}; }
    bool set(std::string_view parameter, const Value& value) override {
        double b = 0;
        if (parameter != "base" || !number_of(value, b))
            return false;
        base_ = std::clamp(b, kBaseMin, kBaseMax);
        return true;
    }

private:
    /** @brief The curve; a base of exactly 1 is the identity. @param x The input. @return The output. */
    double calculate(double x) override {
        if (base_ == 1.0)
            return x;
        if (exponential_)
            return (std::exp(std::log(base_) * x) - 1.0) / (base_ - 1.0);
        return std::log(x * (base_ - 1.0) + 1.0) / std::log(base_);
    }
    bool exponential_;  /**< True for exponential, false for logarithm. */
    double base_ = 1.0; /**< The base. */
};

/** @brief power: the exponent (as 2^powerValue) and the symmetry. */
class Power final : public Function {
public:
    Power() : Function("power") {}
    std::vector<std::string> parameter_names() const override { return {"powerValue", "symmetry"}; }
    Value get(std::string_view parameter) const override {
        if (parameter == "powerValue")
            return {power_value_};
        if (parameter == "symmetry")
            return {symmetry_};
        return {};
    }
    bool set(std::string_view parameter, const Value& value) override {
        if (parameter == "powerValue") {
            double v = 0;
            if (!number_of(value, v))
                return false;
            power_value_ = v;
            return true;
        }
        if (parameter == "symmetry" && value.size() == 1 && value[0].is_symbol()) {
            const std::string s = value[0].as_symbol();
            if (s != "none" && s != "point" && s != "axis")
                return false;
            symmetry_ = s;
            return true;
        }
        return false;
    }

private:
    /** @brief The curve. @param x The input. @return The output. */
    double calculate(double x) override {
        const double k = std::pow(2.0, power_value_);
        if (symmetry_ == "point") {
            const double y = 2.0 * x - 1.0;
            return 0.5 * ((y < 0 ? -1.0 : 1.0) * std::pow(std::fabs(y), k) + 1.0);
        }
        if (symmetry_ == "axis")
            return std::pow(std::fabs(2.0 * x - 1.0), k);
        return std::pow(x, k);
    }
    double power_value_ = 1.0;        /**< The exponent is 2^power_value. */
    std::string symmetry_ = "none";   /**< none, point or axis. */
};

/** @brief tanh: offset and width. */
class Tanh final : public Function {
public:
    Tanh() : Function("tanh") { update(); }
    std::vector<std::string> parameter_names() const override { return {"offset", "width"}; }
    Value get(std::string_view parameter) const override {
        if (parameter == "offset")
            return {offset_};
        if (parameter == "width")
            return {width_};
        return {};
    }
    bool set(std::string_view parameter, const Value& value) override {
        double v = 0;
        if ((parameter != "offset" && parameter != "width") || !number_of(value, v))
            return false;
        (parameter == "offset" ? offset_ : width_) = v;
        update();
        return true;
    }

private:
    /** @brief Recomputes the constants of the curve. */
    void update() {
        b_ = 0.5 * (offset_ + 1.0);
        a_ = width_ <= 0 ? std::log(7.0) : std::log(7.0) / width_;
        const double f0 = std::tanh(a_ * -b_);
        const double f1 = std::tanh(a_ * (1.0 - b_));
        alpha_ = 1.0 / (f1 - f0);
        beta_ = f0;
    }
    /** @brief The curve. @param x The input. @return The output. */
    double calculate(double x) override { return alpha_ * (std::tanh(a_ * (x - b_)) - beta_); }
    double offset_ = 0.0, width_ = 0.5;  /**< The parameters. */
    double a_ = 0, b_ = 0, alpha_ = 1, beta_ = 0; /**< The constants of the curve. */
};

/** @brief lowpass: a one-pole filter over the sequence of inputs. */
class Lowpass final : public Function {
public:
    Lowpass() : Function("lowpass") {}
    std::vector<std::string> parameter_names() const override { return {"coefficient"}; }
    Value get(std::string_view parameter) const override { return parameter == "coefficient" ? Value{coefficient_} : Value{}; }
    bool set(std::string_view parameter, const Value& value) override {
        double c = 0;
        if (parameter != "coefficient" || !number_of(value, c))
            return false;
        coefficient_ = c;
        return true;
    }
    void reset() override { state_ = 0.0; }

private:
    /** @brief The filter. @param x The input. @return The output. */
    double calculate(double x) override {
        state_ = state_ * coefficient_ + x * (1.0 - coefficient_);
        if (std::fabs(state_) < 1e-30)
            state_ = 0.0;
        return state_;
    }
    double coefficient_ = 0.75; /**< The feedback coefficient. */
    double state_ = 0.0;        /**< The last output. */
};

/** @brief freehand: a curve through points, every segment shaped by a function. */
class FreeHand final : public Function {
public:
    FreeHand() : Function("freehand") {}
    std::vector<std::string> parameter_names() const override { return {"curveList"}; }
    Value get(std::string_view parameter) const override {
        if (parameter != "curveList")
            return {};
        Value out;
        for (std::size_t i = 0; i < points_.size(); ++i) {
            out.push_back(points_[i].x);
            out.push_back(points_[i].y);
            if (i == 0) { // the first point carries an implicit exponential of base 1, as in the old getter
                out.push_back("exponential");
                out.push_back("base");
                out.push_back(1.0);
                continue;
            }
            const Function& f = *points_[i].segment;
            out.push_back(f.name());
            for (const auto& p : f.parameter_names()) {
                out.push_back(p);
                for (const auto& a : f.get(p))
                    out.push_back(a);
            }
        }
        return out;
    }
    bool set(std::string_view parameter, const Value& value) override {
        if (parameter != "curveList")
            return false;
        std::vector<Point> parsed;
        std::size_t i = 0;
        while (i < value.size()) {
            if (i + 1 >= value.size() || !value[i].is_number() || !value[i + 1].is_number())
                return false;
            Point p;
            p.x = value[i].as_double();
            p.y = value[i + 1].as_double();
            if (!std::isfinite(p.x) || !std::isfinite(p.y))
                return false;
            i += 2;
            std::string name = "linear";
            if (i < value.size() && value[i].is_symbol()) {
                name = value[i].as_symbol();
                ++i;
            }
            p.segment = Function::create(name);
            if (!p.segment || name == "freehand")
                return false;
            while (i < value.size() && value[i].is_symbol()) { // attribute name and its value
                if (i + 1 >= value.size() || !p.segment->set(value[i].as_symbol(), Value{value[i + 1]}))
                    return false;
                i += 2;
            }
            parsed.push_back(std::move(p));
        }
        points_ = std::move(parsed);
        return true;
    }
    void reset() override {
        for (auto& p : points_)
            p.segment->reset();
    }

private:
    /** One point of the curve and the function that shapes the segment ending at it. */
    struct Point {
        double x = 0;                       /**< Position. */
        double y = 0;                       /**< Height. */
        std::unique_ptr<Function> segment;  /**< The function of the segment that ends here (unused for the first point). */
    };
    /** @brief The curve. @param x The input. @return The output. */
    double calculate(double x) override {
        if (points_.empty())
            return x;
        if (x < points_[0].x)
            return points_[0].y;
        for (std::size_t i = 1; i < points_.size(); ++i) {
            if (x < points_[i].x) {
                const double x0 = points_[i - 1].x, y0 = points_[i - 1].y, x1 = points_[i].x, y1 = points_[i].y;
                return (y1 - y0) * points_[i].segment->apply((x - x0) / (x1 - x0)) + y0;
            }
        }
        return points_.back().y;
    }
    std::vector<Point> points_; /**< The points, in the order given. */
};

} // namespace

Function::~Function() = default;

std::vector<std::string> Function::parameter_names() const { return {}; }
Value Function::get(std::string_view) const { return {}; }
bool Function::set(std::string_view, const Value&) { return false; }
void Function::reset() {}

double Function::apply(double x) {
    if (std::isnan(x))
        x = 0.0;
    x = std::clamp(x, 0.0, 1.0);
    const double y = calculate(x);
    return std::isfinite(y) ? y : 0.0;
}

std::vector<std::string> function_names() {
    return {"cosine", "crossFadeIn", "crossFadeOut", "exponential", "freehand", "linear", "logarithm", "lowpass", "power", "smoothPolynomial", "tanh"};
}

std::unique_ptr<Function> Function::create(std::string_view name) {
    if (name == "linear")
        return std::make_unique<Plain>("linear", [](double x) { return x; });
    if (name == "cosine")
        return std::make_unique<Plain>("cosine", [](double x) { return -0.5 * std::cos(x * kPi) + 0.5; });
    if (name == "crossFadeIn")
        return std::make_unique<Plain>("crossFadeIn", [](double x) { return std::sin(x * kPi * 0.5); });
    if (name == "crossFadeOut")
        return std::make_unique<Plain>("crossFadeOut", [](double x) { return 1.0 - std::sin((1.0 - x) * kPi * 0.5); });
    if (name == "smoothPolynomial")
        return std::make_unique<Plain>("smoothPolynomial", [](double x) { return x * x * x * (x * (6 * x - 15) + 10); });
    if (name == "exponential" || name == "logarithm")
        return std::make_unique<Based>(std::string(name));
    if (name == "power")
        return std::make_unique<Power>();
    if (name == "tanh")
        return std::make_unique<Tanh>();
    if (name == "lowpass")
        return std::make_unique<Lowpass>();
    if (name == "freehand")
        return std::make_unique<FreeHand>();
    return nullptr;
}

} // namespace jamoma
