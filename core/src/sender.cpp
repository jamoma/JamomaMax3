// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file sender.cpp
 * @brief The sender (see sender.hpp).
 */

#include "jamoma/sender.hpp"

#include <string>

#include "jamoma/model.hpp"

namespace jamoma {

Sender::Sender(Namespace& ns) : ns_(ns) {}

void Sender::set_address(const Address& address) { address_ = address; }

Address Sender::address() const { return address_; }

bool Sender::send(const Value& value)
{
    if (address_.empty() || sending_.exchange(true)) {
        return false;
    }
    struct Release {
        std::atomic<bool>& flag; /**< The guard to clear. */
        ~Release() { flag.store(false); }
    } release{sending_};

    const std::string attribute = address_.attribute().empty() ? "value" : address_.attribute();
    bool reached = false;
    for (Node* node : ns_.find(address_)) {
        Object* object = node->object();
        if (auto* data = dynamic_cast<Data*>(object)) {
            if (attribute == "value") {
                data->command(value);
                reached = true;
            } else if (data->set_attribute(attribute, value)) {
                reached = true;
            }
        } else if (auto* model = dynamic_cast<Model*>(object)) {
            if (attribute == "value" && !value.empty() && value[0].is_symbol()) {
                Node* member = ns_.lookup(model->address().append(Address::parse(value[0].as_symbol())));
                if (member != nullptr) {
                    if (auto* target = dynamic_cast<Data*>(member->object())) {
                        target->command(Value(value.begin() + 1, value.end()));
                        reached = true;
                    }
                }
            }
        }
    }
    return reached;
}

} // namespace jamoma
