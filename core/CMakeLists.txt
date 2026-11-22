# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

# The core library: Max-free C++20, shared by every external through one copy of the binary.
add_library(jamoma_core SHARED
    src/version.cpp
    src/registry.cpp
    src/atom.cpp
    src/address.cpp
    src/namespace.cpp
    src/clip.cpp
    src/command.cpp
    src/data.cpp
    src/dataspace.cpp
    src/ramp.cpp
    src/model.cpp
    src/preset.cpp
    src/preset_files.cpp
    src/remote.cpp
    src/receiver.cpp
    src/sender.cpp)
add_library(jamoma::core ALIAS jamoma_core)
target_include_directories(jamoma_core PUBLIC include)
target_compile_definitions(jamoma_core PRIVATE JAMOMA_CORE_BUILDING)
# The shared library goes into the Max package, where every external finds it through its rpath.
set_target_properties(jamoma_core PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY "$<1:${JAMOMA_PACKAGE_DIR}/support>"
    RUNTIME_OUTPUT_DIRECTORY "$<1:${JAMOMA_PACKAGE_DIR}/support>")

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
    tests/registry_test.cpp
    tests/atom_test.cpp
    tests/address_test.cpp
    tests/namespace_test.cpp
    tests/clip_test.cpp
    tests/command_test.cpp
    tests/data_test.cpp
    tests/dataspace_test.cpp
    tests/ramp_test.cpp
    tests/model_test.cpp
    tests/preset_test.cpp
    tests/preset_files_test.cpp
    tests/remote_test.cpp
    tests/receiver_test.cpp
    tests/sender_test.cpp)
target_link_libraries(jamoma_core_tests PRIVATE jamoma::core Catch2::Catch2WithMain)
target_compile_definitions(jamoma_core_tests PRIVATE JAMOMA_TEST_DATA="${CMAKE_CURRENT_SOURCE_DIR}/tests/data")
# The registry must outlive static destruction (its own executable, checked through its exit code).
add_executable(registry_exit_test tests/registry_exit_test.cpp)
target_link_libraries(registry_exit_test PRIVATE jamoma::core)
add_test(NAME registry_outlives_static_destruction COMMAND registry_exit_test)

# PRE_TEST: discover at ctest time, because the Xcode generator signs the binary only after post-build steps run.
# DL_PATHS: on Windows the test executable finds jamoma_core.dll only through PATH (there is no rpath).
catch_discover_tests(jamoma_core_tests DISCOVERY_MODE PRE_TEST
    DL_PATHS "${JAMOMA_PACKAGE_DIR}/support")
