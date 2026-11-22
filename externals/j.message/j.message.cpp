// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius

/**
 * @file j.message.cpp
 * @brief j.message: a message in a Jamoma model (the shared body is in externals/common/data_object.hpp).
 */

#include "data_object.hpp"

/** The j.message external. */
class j_message : public jamoma_max::data_object<j_message, jamoma::Service::Message> {
public:
    using data_object::data_object;
};

MIN_EXTERNAL(j_message);
