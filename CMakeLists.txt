# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org

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

# Windows: dynamic C runtime (/MD) for the core and every external, so they share one heap and standard-library
# objects (std::string, std::vector) may cross the core API. (max-sdk-base uses /MT for plain externals; ours share state.)
# UNTESTED on Windows. See docs/decisions/0001-shared-state.md.
if(WIN32)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>DLL")
endif()

# Where the Max package is assembled (libraries and externals are written there); override for scratch builds such as sanitizer runs.
set(JAMOMA_PACKAGE_DIR "${CMAKE_SOURCE_DIR}/package/Jamoma" CACHE PATH "Output folder of the Max package")

enable_testing()

# Every file that a patcher of the package loads (bpatchers, js files, pictures) must be in the package.
find_package(Python3 COMPONENTS Interpreter)
if(Python3_Interpreter_FOUND)
    add_test(NAME package_references COMMAND ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/tools/package/check_references.py ${CMAKE_CURRENT_SOURCE_DIR}/package/Jamoma)
endif()

add_subdirectory(core)

include(cmake/JamomaExternal.cmake)
add_subdirectory(externals)

# Doxygen gate: fails the build on any warning (see Doxyfile).
find_package(Doxygen)
if(DOXYGEN_FOUND)
    add_custom_target(docs
        COMMAND ${DOXYGEN_EXECUTABLE} ${CMAKE_SOURCE_DIR}/Doxyfile
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMENT "Generating Doxygen documentation (warnings are errors)"
        VERBATIM)
endif()
