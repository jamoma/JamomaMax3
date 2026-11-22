// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file model.cpp
 * @brief The model and the patcher-to-model map.
 */

#include "jamoma/model.hpp"

#include <algorithm>
#include <cstdlib>

#include "jamoma/data.hpp"

namespace jamoma {

/** The state of a model. */
struct Model::Impl {
    Namespace* ns = nullptr;                                         /**< The namespace. */
    Subscription subscription;                                       /**< The registration of the model. */
    std::string description;                                         /**< The description. */
    int priority = 0;                                                /**< The priority. */
    bool initialized = false;                                        /**< Whether init has finished. */
    unsigned next_id = 1;                                            /**< The id for the next observer. */
    std::vector<std::pair<unsigned, std::function<void(bool)>>> observers; /**< The observers. */

    /** Calls every observer. @param done The state to report. */
    void notify(bool done)
    {
        const auto copy = observers; // an observer may unregister itself
        for (const auto& entry : copy) {
            const bool still_there = std::any_of(observers.begin(), observers.end(),
                                                 [&entry](const auto& o) { return o.first == entry.first; });
            if (still_there) {
                entry.second(done);
            }
        }
    }
};

namespace {

/** One child found for the walk, with what the ordering needs. */
struct Child {
    int priority;         /**< The priority of the child. */
    std::string name;     /**< Its name. */
    int instance;         /**< Its instance number (0 for none). */
    Address address;      /**< Its address, to find it again. */
};

/**
 * Initialises the children of an address.
 * @param ns The namespace. @param parent The address of the parent node. @param self The model that is initialising (not recursed into).
 */
void init_children(Namespace& ns, const Address& parent, const Model* self)
{
    Node* node = ns.lookup(parent);
    if (node == nullptr) {
        return;
    }
    std::vector<Child> children;
    for (Node* kid : node->children()) {
        int priority = 0;
        if (auto* data = dynamic_cast<Data*>(kid->object())) {
            priority = data->priority();
        } else if (auto* model = dynamic_cast<Model*>(kid->object())) {
            priority = model->priority();
        }
        children.push_back({priority, kid->name(), kid->instance().empty() ? 0 : std::atoi(kid->instance().c_str()), kid->address()});
    }
    std::stable_sort(children.begin(), children.end(), [](const Child& a, const Child& b) {
        if (a.priority != b.priority) {
            return a.priority < b.priority;
        }
        if (a.name != b.name) {
            return a.name < b.name;
        }
        return a.instance < b.instance;
    });
    for (const Child& child : children) {
        Node* now = ns.lookup(child.address); // found again: it may have gone
        if (now == nullptr) {
            continue;
        }
        Object* object = now->object();
        if (object == nullptr) {
            init_children(ns, child.address, self);
        } else if (auto* data = dynamic_cast<Data*>(object)) {
            if (data->service() == Service::Parameter) {
                data->init();
            }
        } else if (auto* model = dynamic_cast<Model*>(object)) {
            if (model != self) {
                model->init();
            }
        }
    }
}

} // namespace

Model::Model(Namespace& ns, const Address& address) : impl_(std::make_shared<Impl>())
{
    impl_->ns = &ns;
    impl_->subscription = ns.subscribe(address, *this);
}

Model::~Model() = default;

const Address& Model::address() const noexcept { return impl_->subscription.address(); }
void Model::set_description(std::string text) { impl_->description = std::move(text); }
std::string Model::description() const { return impl_->description; }
void Model::set_priority(int priority) { impl_->priority = priority; }
int Model::priority() const { return impl_->priority; }
bool Model::initialized() const { return impl_->initialized; }

void Model::init()
{
    const std::shared_ptr<Impl> keep = impl_; // an observer or a parameter's output may free the owner of this model
    keep->initialized = false;
    keep->notify(false);
    init_children(*keep->ns, keep->subscription.address(), this);
    keep->initialized = true;
    keep->notify(true);
}

std::shared_ptr<void> Model::on_init_changed(std::function<void(bool)> callback)
{
    const unsigned id = impl_->next_id++;
    impl_->observers.emplace_back(id, callback);
    std::weak_ptr<Impl> weak = impl_;
    std::shared_ptr<void> handle(nullptr, [weak, id](void*) {
        if (auto impl = weak.lock()) {
            auto& list = impl->observers;
            list.erase(std::remove_if(list.begin(), list.end(), [id](const auto& o) { return o.first == id; }), list.end());
        }
    });
    if (impl_->initialized) {
        callback(true);
    }
    return handle;
}

/** The observers of a context map. */
struct ContextMap::Observers {
    /** One observer. */
    struct Entry {
        unsigned id;                                                         /**< Identifies the observer for removal. */
        std::function<void(const void*, Model*, bool)> callback;             /**< What to call. */
    };
    std::mutex mutex;                 /**< Guards the entries (never held while a callback runs). */
    std::vector<Entry> entries;       /**< The observers. */
    unsigned next_id = 1;             /**< The id of the next observer. */

    /** Tells every observer. @param patcher The patcher. @param model The model. @param added Added or removed. */
    void notify(const void* patcher, Model* model, bool added)
    {
        std::vector<std::function<void(const void*, Model*, bool)>> calls;
        {
            std::lock_guard<std::mutex> lock(mutex);
            for (const Entry& e : entries) {
                calls.push_back(e.callback);
            }
        }
        for (const auto& call : calls) {
            call(patcher, model, added);
        }
    }
};

ContextMap::ContextMap() : observers_(std::make_shared<Observers>()) {}

void ContextMap::add(const void* patcher, Model* model)
{
    {
        std::lock_guard<std::mutex> lock(mutex_);
        entries_.emplace_back(patcher, model);
    }
    observers_->notify(patcher, model, true);
}

void ContextMap::remove(const void* patcher, Model* model)
{
    bool removed = false;
    {
        std::lock_guard<std::mutex> lock(mutex_);
        const auto it = std::find(entries_.begin(), entries_.end(), std::make_pair(patcher, model));
        if (it != entries_.end()) {
            entries_.erase(it);
            removed = true;
        }
    }
    if (removed) {
        observers_->notify(patcher, model, false);
    }
}

std::shared_ptr<void> ContextMap::observe(std::function<void(const void*, Model*, bool)> callback)
{
    unsigned id;
    {
        std::lock_guard<std::mutex> lock(observers_->mutex);
        id = observers_->next_id++;
        observers_->entries.push_back({id, std::move(callback)});
    }
    static int token = 0;
    std::weak_ptr<Observers> weak = observers_;
    return std::shared_ptr<void>(&token, [weak, id](void*) {
        if (auto observers = weak.lock()) {
            std::lock_guard<std::mutex> lock(observers->mutex);
            auto& list = observers->entries;
            list.erase(std::remove_if(list.begin(), list.end(), [id](const Observers::Entry& e) { return e.id == id; }), list.end());
        }
    });
}

Model* ContextMap::find(const void* patcher) const
{
    std::lock_guard<std::mutex> lock(mutex_);
    for (const auto& entry : entries_) {
        if (entry.first == patcher) {
            return entry.second;
        }
    }
    return nullptr;
}

} // namespace jamoma
