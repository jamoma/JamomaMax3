# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius

# The core library: Max-free C++20, shared by every external through one copy of the binary.
add_library(jamoma_core SHARED
    src/version.cpp
    src/registry.cpp)
add_library(jamoma::core ALIAS jamoma_core)
target_include_directories(jamoma_core PUBLIC include)
target_compile_definitions(jamoma_core PRIVATE JAMOMA_CORE_BUILDING)

# Unit tests (Catch2, no Max needed).
include(FetchContent)
FetchContent_Declare(Catch2
    GIT_REPOSITORY https://github.com/catchorg/Catch2.git
    GIT_TAG v3.8.1)
FetchContent_MakeAvailable(Catch2)
list(APPEND CMAKE_MODULE_PATH ${catch2_SOURCE_DIR}/extras)
include(Catch)

add_executable(jamoma_core_tests
    tests/version_test.cpp
    tests/registry_test.cpp)
target_link_libraries(jamoma_core_tests PRIVATE jamoma::core Catch2::Catch2WithMain)
# PRE_TEST: discover at ctest time, because the Xcode generator signs the binary only after post-build steps run.
catch_discover_tests(jamoma_core_tests DISCOVERY_MODE PRE_TEST)
