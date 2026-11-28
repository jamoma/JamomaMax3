// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.parameter_array.cpp
 * @brief j.parameter_array: numbered parameters made from one bracketed name (the shared body is in externals/common/array_object.hpp).
 */

#include "array_object.hpp"

/** The j.parameter_array external. */
class j_parameter_array : public jamoma_max::array_object<j_parameter_array, jamoma::Service::Parameter> {
public:
    using array_object::array_object;
};

MIN_EXTERNAL(j_parameter_array);
