unset(STATIC_ANALYZERS CACHE)
unset(STATIC_ANALYZER CACHE)
include(config.cmake)
set(STATIC_ANALYZERS "${STATIC_ANALYZER}" CACHE STRING "Turn ON or OFF for activ/deactive static analyzers (cppcheck and clang-tidy)")

set(CMAKE_CXX_COMPILER ${CPPCOMPILER})

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
message("----------------------------------------------------------------${CMAKE_CXX_COMPILER_ARCHITECTURE_ID}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "$<0:>${CMAKE_BINARY_DIR}/bin/bin") # .exe and .dll
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "$<0:>${CMAKE_BINARY_DIR}/bin/lib") # .so and .dylib
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "$<0:>${CMAKE_BINARY_DIR}/bin/lib") # .lib and .a
#TODO:N1 ADD new build type for "RelWithDebInfo" and "MinSizeRel" maybe need change blew condition for appending these

# option(MYDEBUG_SETTING OFF)
# option(STATIC_ANALYZERS OFF)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
message("============================================ Debuging is ON: Warning all is enabled ============================================")
# set(BUILD_TYPE "Debug")
if(NOT ${CPPCOMPILER} STREQUAL "MSVC")
set(CUSTOME_FLAGS ${DEBUG_COMPILER_FLAGS_GCC_CLANG})
if(${CPPCOMPILER} STREQUAL "g++")
set(CUSTOME_FLAGS ${DEBUG_COMPILER_FLAGS_GCC_CLANG}${DEBUG_COMPILER_EXTRA_FLAGS_GCC})
endif(${CPPCOMPILER} STREQUAL "g++")
else()
set(CUSTOME_FLAGS ${DEBUG_COMPILER_FLAGS_MSVC})
endif(NOT ${CPPCOMPILER} STREQUAL "MSVC")
else()
message("============================================ Debuging is OFF: Release Mode with Full O3 ============================================")
# set(BUILD_TYPE "Release")
if(NOT ${CPPCOMPILER} STREQUAL "MSVC")
set(CUSTOME_FLAGS ${RELEASE_COMPILER_FLAGS_GCC_CLANG})
else()
set(CUSTOME_FLAGS ${RELEASE_COMPILER_FLAGS_MSVC})
endif(NOT ${CPPCOMPILER} STREQUAL "MSVC")
endif()

add_compile_options(${CUSTOME_FLAGS})


cmake_minimum_required(VERSION                                  3.25)

#this build config is RELEASE OR DEBUG should set before project
# set (CMAKE_BUILD_TYPE ${BUILD_TYPE} CACHE STRING "Choose the type of build.")
message("============================================ ${CMAKE_BUILD_TYPE} ============================================")

project(${SULOTIONNAME}    VERSION ${PRVERSION}  LANGUAGES ${PRLANG})
set(CMAKE_CXX_EXTENSIONS                             ${CPPEXTENTION})
set(CMAKE_CXX_STANDARD                                 ${CPPVERSION})
set(CMAKE_CXX_STANDARD_REQUIRED                    ${CPPSTANDARDREQ})

message("--------------------------------------------- General info: ---------------------------------------------")
if(STATIC_ANALYZERS STREQUAL "ON")
find_program(CMAKE_CXX_CPPCHECK NAMES cppcheck)
if(CMAKE_CXX_CPPCHECK)
message("--------------------------------------------- CPP-Check:  ON ---------------------------------------------")
list(APPEND CMAKE_CXX_CPPCHECK "--enable=all")
endif()
find_program(CLANG_TIDY_EXE NAMES "clang-tidy" REQUIRED)
if(CLANG_TIDY_EXE)
message("--------------------------------------------- CLANG-TIDY: ON ---------------------------------------------")
endif()
else()
message("--------------------------------------------- CPP-Check:  OFF ---------------------------------------------")
message("--------------------------------------------- CLANG-TIDY: OFF ---------------------------------------------")
endif()

find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
set(CMAKE_CXX_COMPILER_LAUNCHER ccache CACHE STRING "C++ compiler launcher")
message("--------------------------------------------- CCACHE: ON ---------------------------------------------")
# set(CMAKE_CXX_COMPILER_LAUNCHER CCACHE_FOUND)   
set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
endif()

message("---------------------------------------------------------------------------------------------------------------")
# set(CMAKE_GENERATOR_PLATFORM "x86" CACHE STRING "Platform")
message("--------------------------------------------- OS: ${MYOS} ---------------------------------------------")
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
message("--------------------------------------------- Arch: 64-bit ---------------------------------------------")
else()
message( "--------------------------------------------- Arch: 32-bit ---------------------------------------------")
endif()
message("--------------------------------------------- COMPILER: ${CPPCOMPILER} ---------------------------------------------")
message("--------------------------------------------- BUILD TYPE: ${CMAKE_BUILD_TYPE}  --------------------------------------------")
message("--------------------------------------------- is_Debugging: ${MYDEBUG_SETTING} ---------------------------------------------")
message("--------------------------------------------- Compiler Flags: ${CUSTOME_FLAGS} ---------------------------------------------")
message("--------------------------------------------- CXX Version: ${CPPVERSION} ---------------------------------------------")
message("--------------------------------------------- Sulotion name : ${SULOTIONNAME} ---------------------------------------------")
message("--------------------------------------------- Library name : ${MYLIBNAME} ---------------------------------------------")
message("--------------------------------------------- Exe name : ${PREXENAME} ---------------------------------------------")
message("--------------------------------------------- Version: ${PRVERSION} ---------------------------------------------")


if(${MYOS} STREQUAL ${WINDOWS})
message("============================================ OPERATING SYS :WINDOWS ============================================")
set(CURRENTOS 1)
add_subdirectory("source/src")
add_subdirectory("source/samples/src")

elseif(${MYOS} STREQUAL ${LINUXOS})
message("============================================ OPERATING SYS :Linux ============================================")
set(CURRENTOS 2)
add_subdirectory("source/src")
add_subdirectory("source/samples/src")

elseif(${MYOS} STREQUAL ${MACOS})
message("============================================ OPERATING SYS :MacOSX ============================================")
set(CURRENTOS 3)
add_subdirectory("source/src")
add_subdirectory("source/samples/src")

endif()