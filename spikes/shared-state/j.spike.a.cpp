// SPDX-License-Identifier: BSD-3-Clause
// SPDX-FileCopyrightText: 2026 Trond Lossius
// THROWAWAY SPIKE: reports which registry this external sees.

#include "c74_min.h"

#include <cstdio>

#include "jamoma/registry.hpp"

using namespace c74::min;

class j_spike_a : public object<j_spike_a> {
public:
    inlet<> in{this, "(bang) report"};
    outlet<> out{this, "(list) <name> <registry id as hex> <loader attached 0|1>"};

    message<> bang{this, "bang", MIN_FUNCTION {
        static bool warned = false;
        auto& registry = jamoma::Registry::instance();
        if (!registry.loader_attached() && !warned) {
            warned = true;
            cwarn << "Jamoma: loader not attached" << endl;
        }
        char hex[32];
        std::snprintf(hex, sizeof hex, "%016llx", static_cast<unsigned long long>(registry.instance_id()));
        out.send(atoms{symbol{"a"}, symbol{hex}, registry.loader_attached() ? 1 : 0});
        return {};
    }};
};

MIN_EXTERNAL(j_spike_a);
