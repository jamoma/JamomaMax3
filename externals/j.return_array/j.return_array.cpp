// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.return_array.cpp
 * @brief j.return_array: numbered returns made from one bracketed name (the shared body is in externals/common/array_object.hpp).
 */

#include "array_object.hpp"

/** The j.return_array external. */
class j_return_array : public jamoma_max::array_object<j_return_array, jamoma::Service::Return> {
public:
    using array_object::array_object;
};

MIN_EXTERNAL(j_return_array);
