# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius

cmake_minimum_required(VERSION 3.25)
project(JamomaMax3 VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)

# Apple Silicon kills unsigned binaries, and the Xcode generator leaves universal
# (lipo-merged) products unsigned, so sign every product ad hoc.
if(APPLE)
    set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "-")
    set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED "YES")
endif()

enable_testing()

add_subdirectory(core)

include(cmake/JamomaExternal.cmake)
add_subdirectory(externals)
add_subdirectory(spikes/shared-state)

# Doxygen gate: fails the build on any warning (see Doxyfile).
find_package(Doxygen)
if(DOXYGEN_FOUND)
    add_custom_target(docs
        COMMAND ${DOXYGEN_EXECUTABLE} ${CMAKE_SOURCE_DIR}/Doxyfile
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMENT "Generating Doxygen documentation (warnings are errors)"
        VERBATIM)
endif()
