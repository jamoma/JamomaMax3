// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file data_array.cpp
 * @brief The array of data objects.
 */

#include "jamoma/data_array.hpp"

#include <algorithm>
#include <atomic>
#include <mutex>
#include <utility>
#include <vector>

namespace jamoma {

namespace {

/** One instance. The order of the members is the order of their lives: the registration goes first, the clock last. */
struct Instance {
    std::unique_ptr<Clock> clock;          /**< The clock of the ramps, or null. */
    Data data;                             /**< The data object. */
    Subscription subscription;             /**< The registration in the namespace. */
    std::atomic<bool> alive{true};         /**< False once the instance has been removed. */
    const std::uint64_t id = next_id();    /**< Tells instances apart. */

    /** @return A number no instance has had. */
    static std::uint64_t next_id()
    {
        static std::atomic<std::uint64_t> last{0};
        return ++last;
    }

    /** @param service The role. */
    explicit Instance(Service service) : data(service) {}
};

using Instances = std::vector<std::shared_ptr<Instance>>; /**< Instances in index order (the first is index 1). */
using Settings = std::vector<std::pair<std::string, Value>>; /**< Names and values, in the order they were first set. */

/** Remembers a value under a name. @param list The list. @param name The name. @param value The value. */
void remember(Settings& list, std::string_view name, const Value& value)
{
    for (auto& entry : list) {
        if (entry.first == name) {
            entry.second = value;
            return;
        }
    }
    list.emplace_back(std::string(name), value);
}

} // namespace

/** The state of an array. */
struct DataArray::Impl {
    /** @param n The namespace. @param s The role. */
    Impl(Namespace& n, Service s) : ns(n), service(s) {}

    Namespace& ns;                          /**< The namespace. */
    const Service service;                  /**< The role of the instances. */
    mutable std::mutex mutex;               /**< Guards everything below that is not atomic; never held while an instance or the output is called. */
    std::optional<ArrayName> name;          /**< The name, once set. */
    Address prefix;                         /**< What the name is below. */
    Instances items;                        /**< The instances. */
    Instances retired;                      /**< Removed instances that may still be on the call stack. */
    ArraySelection selection;               /**< Where values go. */
    std::size_t watched = 1;                /**< With all selected: the instance that output last. */
    ArrayFormat format = ArrayFormat::Single; /**< What is output. */
    Output output;                          /**< Where it goes. */
    ClockMaker clock_maker;                 /**< Makes the clocks. */
    Settings attributes;                    /**< The attributes set, for later instances. */
    Settings parameters;                    /**< The ramp function parameters set, for later instances. */
    std::atomic<int> outputting{0};         /**< How many output calls are running. */
    std::atomic<int> restructuring{0};      /**< How many structure changes are running. */

    /** @return A copy of the list of instances. */
    Instances snapshot() const
    {
        std::lock_guard<std::mutex> lock(mutex);
        return items;
    }

    /** @return The selected instances, in order. */
    Instances targets() const
    {
        std::lock_guard<std::mutex> lock(mutex);
        Instances result;
        for (std::size_t i : selection.targets(items.size())) {
            result.push_back(items[i - 1]);
        }
        return result;
    }

    /** @return The number of the instance that answers queries (the lock is held). */
    std::size_t watched_index() const
    {
        return selection.index() != 0 ? selection.index() : watched;
    }

    /** Applies the remembered settings. @param data An instance. */
    void configure(Data& data) const
    {
        Settings a;
        Settings p;
        {
            std::lock_guard<std::mutex> lock(mutex);
            a = attributes;
            p = parameters;
        }
        for (const auto& [n, v] : a) {
            data.set_attribute(n, v);
        }
        for (const auto& [n, v] : p) {
            data.set_function_parameter(n, v);
        }
    }

    /** @return The instance that answers queries, or a detached one with the remembered settings if the array is empty. */
    std::shared_ptr<Instance> answering() const
    {
        {
            std::lock_guard<std::mutex> lock(mutex);
            const std::size_t i = watched_index();
            if (i >= 1 && i <= items.size()) {
                return items[i - 1];
            }
        }
        auto probe = std::make_shared<Instance>(service);
        configure(probe->data);
        return probe;
    }

    /** @return The values of all instances (see DataArray::collected). */
    Value collected() const
    {
        Value all;
        for (const auto& item : snapshot()) {
            Value v = item->data.value();
            if (v.empty()) {
                v = item->data.default_value();
            }
            if (v.empty()) {
                v = Value{item->data.type() == DataType::String ? Atom("none") : Atom(0)};
            }
            all.insert(all.end(), v.begin(), v.end());
        }
        return all;
    }

    /** Calls the output. @param index The instance. @param value The value of that instance (replaced by all values in Array format). */
    void emit(std::size_t index, const Value& value)
    {
        Output call;
        bool all = false;
        {
            std::lock_guard<std::mutex> lock(mutex);
            call = output;
            all = format == ArrayFormat::Array;
        }
        if (!call) {
            return;
        }
        struct Count {
            std::atomic<int>& n;                         /**< The counter. */
            explicit Count(std::atomic<int>& c) : n(c) { ++n; } /**< @param c The counter. */
            ~Count() { --n; }                            /**< Counts down. */
        } count(outputting);
        call(index, all ? collected() : value);
    }

    /** Removes an instance: it is unregistered and cut off, and kept until nothing can be inside it. @param item The instance. */
    void retire(const std::shared_ptr<Instance>& item)
    {
        item->alive = false;
        item->subscription = Subscription();
        item->data.set_output(nullptr);
        item->data.set_clock(nullptr);
        std::lock_guard<std::mutex> lock(mutex);
        retired.push_back(item);
    }

    /** Destroys the removed instances, unless an output call is running (one of them could be making it). */
    void purge()
    {
        Instances gone;
        if (outputting == 0) {
            std::lock_guard<std::mutex> lock(mutex);
            gone.swap(retired);
        }
    }

    /** Registers an instance (it may be removed by what the registration sets off). @param item The instance. @param index Its number. */
    void subscribe(Instance& item, std::size_t index)
    {
        std::string address;
        {
            std::lock_guard<std::mutex> lock(mutex);
            address = prefix.str() + (prefix.str().ends_with('/') ? "" : "/") + name->instance(index);
        }
        item.subscription = Subscription();
        Subscription subscription = ns.subscribe(Address::parse(address), item.data);
        if (item.alive) {
            item.subscription = std::move(subscription);
        }
    }

    /** Builds one instance, not yet registered. @param self This state. @param index Its number. @return The instance. */
    std::shared_ptr<Instance> make(const std::shared_ptr<Impl>& self, std::size_t index)
    {
        auto item = std::make_shared<Instance>(service);
        ClockMaker maker;
        {
            std::lock_guard<std::mutex> lock(mutex);
            maker = clock_maker;
        }
        if (maker) {
            item->clock = maker();
            item->data.set_clock(item->clock.get());
        }
        configure(item->data);
        item->data.set_output([weak = std::weak_ptr<Impl>(self), of = std::weak_ptr<Instance>(item), index](const Value& v) {
            const auto state = weak.lock();
            const auto from = of.lock();
            if (!state || !from || !from->alive) {
                return;
            }
            {
                std::lock_guard<std::mutex> lock(state->mutex);
                if (state->selection.index() == 0) {
                    state->watched = index;
                }
                if (state->format == ArrayFormat::Array && state->restructuring != 0) {
                    return; // the whole list is output once, when the change is done
                }
            }
            state->emit(index, v);
        });
        return item;
    }

    /**
     * Brings the number of instances to the size in the name, which what a registration sets off may change meanwhile.
     * @param self This state. @param init_new Whether new instances are initialised.
     */
    void fit(const std::shared_ptr<Impl>& self, bool init_new)
    {
        Instances made;
        for (;;) {
            std::shared_ptr<Instance> surplus;
            std::size_t index = 0;
            {
                std::lock_guard<std::mutex> lock(mutex);
                if (items.size() > name->size) {
                    surplus = items.back();
                    items.pop_back();
                } else if (items.size() < name->size) {
                    index = items.size() + 1;
                } else {
                    selection.resized(items.size());
                    if (watched > items.size()) {
                        watched = 1;
                    }
                    break;
                }
            }
            if (surplus) {
                retire(surplus);
                continue;
            }
            auto item = make(self, index);
            {
                std::lock_guard<std::mutex> lock(mutex);
                items.push_back(item);
            }
            subscribe(*item, index);
            made.push_back(std::move(item));
        }
        if (init_new && service != Service::Message) {
            for (const auto& item : made) {
                if (item->alive) {
                    item->data.init();
                }
            }
        }
    }

    /** Outputs the whole list after a change, in Array format. */
    void emit_after_change()
    {
        std::size_t index = 0;
        {
            std::lock_guard<std::mutex> lock(mutex);
            if (format != ArrayFormat::Array || items.empty()) {
                return;
            }
            index = watched_index();
        }
        emit(index, Value{});
    }
};

DataArray::DataArray(Namespace& ns, Service service) : impl_(std::make_shared<Impl>(ns, service)) {}

DataArray::~DataArray()
{
    for (const auto& item : impl_->snapshot()) {
        impl_->retire(item);
    }
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->items.clear();
    impl_->output = nullptr;
    impl_->clock_maker = nullptr;
}

void DataArray::set_clock_maker(ClockMaker maker)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->clock_maker = std::move(maker);
}

void DataArray::set_output(Output output)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->output = std::move(output);
}

bool DataArray::set_name(const std::string& name, const Address& prefix, bool init_new)
{
    const std::optional<ArrayName> parsed = parse_array_name(name);
    const Address as_address = Address::parse(name);
    if (!parsed || as_address.absolute() || !as_address.directory().empty()) {
        return false;
    }
    const std::shared_ptr<Impl> self = impl_; // the output may destroy the array
    self->purge();
    bool built = false;
    bool keep = false;
    bool moved = false;
    bool changed = true;
    {
        std::lock_guard<std::mutex> lock(self->mutex);
        built = self->name.has_value();
        keep = built && self->name->same_shape(*parsed);
        moved = keep && self->prefix.str() != prefix.str();
        changed = !keep || self->items.size() != parsed->size;
    }
    ++self->restructuring;
    if (!keep) {
        Instances old;
        {
            std::lock_guard<std::mutex> lock(self->mutex);
            old.swap(self->items);
            self->selection = ArraySelection();
            self->watched = 1;
        }
        for (const auto& item : old) {
            self->retire(item);
        }
    }
    {
        std::lock_guard<std::mutex> lock(self->mutex);
        self->name = *parsed;
        self->prefix = prefix;
    }
    if (moved) {
        const Instances items = self->snapshot();
        for (std::size_t i = 0; i < items.size(); ++i) {
            if (items[i]->alive) {
                self->subscribe(*items[i], i + 1);
            }
        }
    }
    self->fit(self, init_new);
    --self->restructuring;
    if (built && changed) {
        self->emit_after_change();
    }
    return true;
}

bool DataArray::resize(std::size_t size, bool init_new)
{
    const std::shared_ptr<Impl> self = impl_;
    bool changed = false;
    {
        std::lock_guard<std::mutex> lock(self->mutex);
        if (!self->name || size > kMaxArraySize) {
            return false;
        }
        changed = self->items.size() != size;
        self->name->size = size;
    }
    self->purge();
    ++self->restructuring;
    self->fit(self, init_new);
    --self->restructuring;
    if (changed) {
        self->emit_after_change();
    }
    return true;
}

std::size_t DataArray::size() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->items.size();
}

std::string DataArray::name() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->name ? impl_->name->with_size(impl_->items.size()) : std::string();
}

std::uint64_t DataArray::identity(std::size_t index) const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return index >= 1 && index <= impl_->items.size() ? impl_->items[index - 1]->id : 0;
}

bool DataArray::select(const Atom& which)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->selection.select(which, impl_->items.size());
}

std::size_t DataArray::selected() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->selection.index();
}

bool DataArray::command(const Value& input)
{
    const std::shared_ptr<Impl> self = impl_;
    const Instances targets = self->targets();
    for (const auto& item : targets) {
        if (item->alive) {
            item->data.command(input);
        }
    }
    return !targets.empty();
}

bool DataArray::inc(const Value& args)
{
    const std::shared_ptr<Impl> self = impl_;
    const Instances targets = self->targets();
    for (const auto& item : targets) {
        if (item->alive) {
            item->data.inc(args);
        }
    }
    return !targets.empty();
}

bool DataArray::dec(const Value& args)
{
    const std::shared_ptr<Impl> self = impl_;
    const Instances targets = self->targets();
    for (const auto& item : targets) {
        if (item->alive) {
            item->data.dec(args);
        }
    }
    return !targets.empty();
}

bool DataArray::array(const Value& list)
{
    const std::shared_ptr<Impl> self = impl_;
    const Instances items = self->snapshot();
    const auto parts = split_array(list, items.size());
    if (!parts) {
        return false;
    }
    for (std::size_t i = 0; i < items.size(); ++i) {
        if (items[i]->alive) {
            items[i]->data.command((*parts)[i]);
        }
    }
    return true;
}

bool DataArray::set_attribute(std::string_view name, const Value& value)
{
    const std::shared_ptr<Impl> self = impl_;
    {
        Data probe(self->service);
        self->configure(probe);
        if (!probe.set_attribute(name, value)) {
            return false;
        }
    }
    if (name != "value") { // a value is a command, not a setting
        std::lock_guard<std::mutex> lock(self->mutex);
        remember(self->attributes, name, value);
    }
    for (const auto& item : self->snapshot()) {
        if (item->alive) {
            item->data.set_attribute(name, value);
        }
    }
    return true;
}

std::optional<Value> DataArray::get_attribute(std::string_view name) const
{
    return impl_->answering()->data.get_attribute(name);
}

bool DataArray::has_function_parameter(std::string_view name) const
{
    return impl_->answering()->data.has_function_parameter(name);
}

Value DataArray::function_parameter(std::string_view name) const
{
    return impl_->answering()->data.function_parameter(name);
}

bool DataArray::set_function_parameter(std::string_view name, const Value& value)
{
    {
        Data probe(impl_->service);
        impl_->configure(probe);
        if (!probe.set_function_parameter(name, value)) {
            return false;
        }
    }
    {
        std::lock_guard<std::mutex> lock(impl_->mutex);
        remember(impl_->parameters, name, value);
    }
    for (const auto& item : impl_->snapshot()) {
        item->data.set_function_parameter(name, value);
    }
    return true;
}

void DataArray::set_format(ArrayFormat format)
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    impl_->format = format;
}

ArrayFormat DataArray::format() const
{
    std::lock_guard<std::mutex> lock(impl_->mutex);
    return impl_->format;
}

Value DataArray::collected() const
{
    return impl_->collected();
}

void DataArray::init()
{
    const std::shared_ptr<Impl> self = impl_;
    if (self->service == Service::Message) {
        return;
    }
    for (const auto& item : self->snapshot()) {
        if (item->alive) {
            item->data.init();
        }
    }
}

void DataArray::init_uninitialized()
{
    const std::shared_ptr<Impl> self = impl_;
    if (self->service != Service::Parameter) {
        return;
    }
    for (const auto& item : self->snapshot()) {
        if (item->alive && !item->data.initialized()) {
            item->data.init();
        }
    }
}

} // namespace jamoma
