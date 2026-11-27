// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file explorer.cpp
 * @brief The model explorer (see explorer.hpp).
 */

#include "jamoma/priority.hpp"
#include "jamoma/explorer.hpp"

#include <algorithm>
#include <cstdlib>
#include <mutex>

#include "jamoma/data.hpp"
#include "jamoma/model.hpp"

namespace jamoma {

/** The state of an explorer. */
struct ModelExplorer::State {
    Namespace* ns = nullptr;                        /**< The namespace. */
    std::function<void()> on_change;                /**< What to tell. */
    mutable std::mutex mutex;                       /**< Guards the model address and the handles. */
    Address model;                                  /**< The model that is followed. */
    std::vector<std::shared_ptr<void>> handles;     /**< The namespace observers. */
    std::shared_ptr<void> preset_handle;            /**< The observer of the presets of the model. */
};

namespace {

/** The deepest level below the model that the explorer watches. */
constexpr int kDepth = 6;

/** A node found below the model. */
struct Found {
    int priority;       /**< Its priority. */
    std::string name;   /**< Its address relative to the model. */
    int instance;       /**< Its instance number. */
    Service service;    /**< Its service. */
};

/** Tells the owner of a state that something changed, if it still exists. @tparam W A weak pointer to the state. @param weak The state. */
template <class W>
void tell(const W& weak)
{
    if (const auto state = weak.lock()) {
        const std::function<void()> callback = state->on_change; // the callback may destroy the explorer
        if (callback) {
            callback();
        }
    }
}

} // namespace

ModelExplorer::ModelExplorer(Namespace& ns, std::function<void()> on_change) : state_(std::make_shared<State>())
{
    state_->ns = &ns;
    state_->on_change = std::move(on_change);
}

ModelExplorer::~ModelExplorer()
{
    std::vector<std::shared_ptr<void>> handles;
    std::shared_ptr<void> preset;
    {
        std::lock_guard<std::mutex> lock(state_->mutex);
        handles.swap(state_->handles);
        preset.swap(state_->preset_handle);
    }
}

Address ModelExplorer::model() const
{
    std::lock_guard<std::mutex> lock(state_->mutex);
    return state_->model;
}

void ModelExplorer::set_model(const Address& model)
{
    std::vector<std::shared_ptr<void>> old_handles;
    std::shared_ptr<void> old_preset;
    {
        std::lock_guard<std::mutex> lock(state_->mutex);
        old_handles.swap(state_->handles);
        old_preset.swap(state_->preset_handle);
        state_->model = model;
    }
    old_handles.clear();
    old_preset.reset();
    if (model.empty()) {
        return;
    }
    const std::weak_ptr<State> weak = state_;
    // The presets of the model: attached now if the model exists, and again whenever it appears.
    const auto attach_presets = [weak, model]() {
        const auto state = weak.lock();
        if (!state) {
            return;
        }
        Node* node = state->ns->lookup(model);
        auto* m = node != nullptr ? dynamic_cast<Model*>(node->object()) : nullptr;
        std::shared_ptr<void> handle;
        if (m != nullptr) {
            handle = m->presets().observe([weak]() { tell(weak); });
        }
        std::lock_guard<std::mutex> lock(state->mutex);
        state->preset_handle = std::move(handle);
    };
    std::vector<std::shared_ptr<void>> handles;
    handles.push_back(state_->ns->observe(model, [weak, attach_presets](const Address&, Object*, bool) {
        attach_presets();
        tell(weak);
    }));
    Address pattern = model;
    for (int depth = 1; depth <= kDepth; ++depth) {
        pattern = pattern.append(Address::parse("*"));
        handles.push_back(state_->ns->observe(pattern, [weak](const Address&, Object*, bool) { tell(weak); }));
    }
    {
        std::lock_guard<std::mutex> lock(state_->mutex);
        state_->handles = std::move(handles);
    }
    attach_presets();
}

ModelContents ModelExplorer::contents() const
{
    Address model;
    {
        std::lock_guard<std::mutex> lock(state_->mutex);
        model = state_->model;
    }
    ModelContents out;
    if (model.empty()) {
        return out;
    }
    std::vector<Found> found;
    if (!state_->ns->visit_below(model, [&found](const std::string& relative, const std::string&, const std::string& instance, Object* object) {
            if (auto* data = dynamic_cast<Data*>(object)) {
                found.push_back({data->priority(), relative, instance.empty() ? 0 : std::atoi(instance.c_str()), data->service()});
            }
        })) {
        return out;
    }
    std::stable_sort(found.begin(), found.end(), [](const Found& a, const Found& b) {
        if (a.priority != b.priority) {
            return priority_before(a.priority, b.priority);
        }
        if (a.name != b.name) {
            return a.name < b.name;
        }
        return a.instance < b.instance;
    });
    for (const Found& f : found) {
        (f.service == Service::Parameter ? out.parameters : f.service == Service::Message ? out.messages : out.returns).push_back(f.name);
    }
    Node* node = state_->ns->lookup(model);
    if (auto* m = node != nullptr ? dynamic_cast<Model*>(node->object()) : nullptr) {
        out.presets = m->presets().names();
    }
    return out;
}

} // namespace jamoma
