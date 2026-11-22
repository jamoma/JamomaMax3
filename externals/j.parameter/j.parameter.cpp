// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.parameter.cpp
 * @brief j.parameter: a parameter in a Jamoma model (the shared body is in externals/common/data_object.hpp).
 */

#include "data_object.hpp"

/** The j.parameter external. */
class j_parameter : public jamoma_max::data_object<j_parameter, jamoma::Service::Parameter> {
public:
    using data_object::data_object;
};

MIN_EXTERNAL(j_parameter);
