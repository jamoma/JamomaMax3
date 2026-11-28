# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 The Jamoma Group, http://jamoma.org
#
# jamoma_add_external(NAME <j.name> SOURCES <files...> [EXTENSION])
#
# Builds a Min-API external named exactly <NAME>, links it to jamoma::core and writes it
# into the Max package: package/Jamoma/externals (package/Jamoma/extensions with EXTENSION).
# Min-API's own CMake script is not used: it defaults to x86_64 and forces a macOS 10.11
# deployment target that current Xcode rejects. This file uses max-sdk-base directly.

set(JAMOMA_MIN_API_DIR "${CMAKE_SOURCE_DIR}/third_party/min-api")
set(JAMOMA_C74_SUPPORT "${JAMOMA_MIN_API_DIR}/max-sdk-base/c74support")

# Max resolves its own API symbols when it loads an external; tell the linker not to demand them.
if(APPLE)
    file(STRINGS "${JAMOMA_MIN_API_DIR}/max-sdk-base/script/max-linker-flags.txt" _jamoma_raw_flags)
    string(REPLACE "'" "" _jamoma_raw_flags "${_jamoma_raw_flags}")
    separate_arguments(JAMOMA_MAX_LINK_FLAGS UNIX_COMMAND "${_jamoma_raw_flags}")
endif()

function(jamoma_add_external)
    cmake_parse_arguments(JE "EXTENSION" "NAME" "SOURCES" ${ARGN})
    if(NOT JE_NAME OR NOT JE_SOURCES)
        message(FATAL_ERROR "jamoma_add_external needs NAME and SOURCES")
    endif()
    string(REPLACE "." "_" target "${JE_NAME}")
    add_library(${target} MODULE ${JE_SOURCES})

    target_include_directories(${target} SYSTEM PRIVATE
        "${JAMOMA_C74_SUPPORT}"
        "${JAMOMA_C74_SUPPORT}/max-includes"
        "${JAMOMA_C74_SUPPORT}/msp-includes"
        "${JAMOMA_C74_SUPPORT}/jit-includes"
        "${JAMOMA_MIN_API_DIR}/include")
    target_include_directories(${target} PRIVATE "${CMAKE_SOURCE_DIR}/externals/common")
    target_compile_definitions(${target} PRIVATE C74_MIN_API)
    target_compile_features(${target} PRIVATE cxx_std_17)
    target_link_libraries(${target} PRIVATE jamoma::core)

    if(JE_EXTENSION)
        set(outdir "${JAMOMA_PACKAGE_DIR}/extensions")
    else()
        set(outdir "${JAMOMA_PACKAGE_DIR}/externals")
    endif()
    # $<1:...> keeps multi-config generators from adding a Debug/Release subfolder.
    set_target_properties(${target} PROPERTIES
        PREFIX ""
        OUTPUT_NAME "${JE_NAME}"
        LIBRARY_OUTPUT_DIRECTORY "$<1:${outdir}>")

    if(APPLE)
        find_library(JAMOMA_MSP_LIB MaxAudioAPI REQUIRED PATHS "${JAMOMA_C74_SUPPORT}/msp-includes" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        find_library(JAMOMA_JIT_LIB JitterAPI REQUIRED PATHS "${JAMOMA_C74_SUPPORT}/jit-includes" NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        target_link_libraries(${target} PRIVATE "${JAMOMA_MSP_LIB}" "${JAMOMA_JIT_LIB}")
        target_link_options(${target} PRIVATE ${JAMOMA_MAX_LINK_FLAGS})
        # The binary is in <name>.mxo/Contents/MacOS, so the package root is four levels up.
        # An identifier may not contain an underscore (j.parameter_array).
        string(REPLACE "_" "-" JE_BUNDLE_NAME "${JE_NAME}")
        set_target_properties(${target} PROPERTIES
            BUNDLE ON
            BUNDLE_EXTENSION "mxo"
            XCODE_ATTRIBUTE_WRAPPER_EXTENSION "mxo"
            XCODE_ATTRIBUTE_PRODUCT_NAME "${JE_NAME}"
            XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "no.trondlossius.jamoma.${JE_BUNDLE_NAME}"
            MACOSX_BUNDLE_GUI_IDENTIFIER "no.trondlossius.jamoma.${JE_BUNDLE_NAME}"
            MACOSX_BUNDLE_INFO_PLIST "${CMAKE_SOURCE_DIR}/cmake/Info.plist.in"
            BUILD_WITH_INSTALL_RPATH ON
            INSTALL_RPATH "@loader_path/../../../../support")
        add_custom_command(TARGET ${target} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy
                "${CMAKE_SOURCE_DIR}/third_party/min-api/max-sdk-base/script/PkgInfo"
                "$<TARGET_BUNDLE_DIR:${target}>/Contents/PkgInfo"
            COMMAND codesign -s - -f --deep "$<TARGET_BUNDLE_DIR:${target}>"
            VERBATIM)
    endif()
    if(WIN32)
        # Windows branch: built in CI, never loaded in Max; mirrors max-sdk-base's settings.
        target_compile_definitions(${target} PRIVATE MAXAPI_USE_MSCRT WIN_VERSION _USE_MATH_DEFINES NOMINMAX)
        target_compile_options(${target} PRIVATE /MP /Zc:__cplusplus /permissive-)
        target_link_libraries(${target} PRIVATE
            "${JAMOMA_C74_SUPPORT}/max-includes/x64/MaxAPI.lib"
            "${JAMOMA_C74_SUPPORT}/msp-includes/x64/MaxAudio.lib"
            "${JAMOMA_C74_SUPPORT}/jit-includes/x64/jitlib.lib")
        set_target_properties(${target} PROPERTIES
            SUFFIX ".mxe64"
            RUNTIME_OUTPUT_DIRECTORY "$<1:${outdir}>")
        # A DLL is found next to the module that needs it, not in ../support, so put the core DLL beside every
        # external. Windows maps a DLL name once per process, so every external shares the first copy loaded
        # (the loader's, from extensions/). See docs/decisions/0001-shared-state.md.
        add_custom_command(TARGET ${target} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_if_different "$<TARGET_FILE:jamoma_core>" "${outdir}/"
            VERBATIM)
    endif()
endfunction()
