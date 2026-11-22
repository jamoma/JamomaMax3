// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

/**
 * @file j.return.cpp
 * @brief j.return: a return in a Jamoma model (the shared body is in externals/common/data_object.hpp).
 */

#include "data_object.hpp"

/** The j.return external. */
class j_return : public jamoma_max::data_object<j_return, jamoma::Service::Return> {
public:
    using data_object::data_object;
};

MIN_EXTERNAL(j_return);
