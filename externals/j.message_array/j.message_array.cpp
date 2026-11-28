// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.message_array.cpp
 * @brief j.message_array: numbered messages made from one bracketed name (the shared body is in externals/common/array_object.hpp).
 */

#include "array_object.hpp"

/** The j.message_array external. */
class j_message_array : public jamoma_max::array_object<j_message_array, jamoma::Service::Message> {
public:
    using array_object::array_object;
};

MIN_EXTERNAL(j_message_array);
