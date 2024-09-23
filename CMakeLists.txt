include(config.cmake)
set(CMAKE_CXX_COMPILER ${CPPCOMPILER})
# set(CMAKE_CXX_FLAGS_DEBUG_INIT "-Wall")
# set(CMAKE_CXX_FLAGS_RELEASE_INIT "-Wall")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

#TODO:N1 ADD new build type for "RelWithDebInfo" and "MinSizeRel" maybe need change blew condition for appending these
option(MYDEBUG_SETTING OFF)
if(MYDEBUG_SETTING)
message("============================================ Debuging is ON: Warning all is enabled ============================================")
set(BUILD_TYPE "Debug")
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
set(BUILD_TYPE "Release")
if(NOT ${CPPCOMPILER} STREQUAL "MSVC")
set(CUSTOME_FLAGS ${RELEASE_COMPILER_FLAGS_GCC_CLANG})
else()
set(CUSTOME_FLAGS ${RELEASE_COMPILER_FLAGS_MSVC})
endif(NOT ${CPPCOMPILER} STREQUAL "MSVC")
endif(MYDEBUG_SETTING)

add_compile_options(${CUSTOME_FLAGS})


cmake_minimum_required(VERSION                                  3.25)

#this build config is RELEASE OR DEBUG should set before project

set (CMAKE_BUILD_TYPE ${BUILD_TYPE} CACHE STRING "Choose the type of build.")

project(${SULOTIONNAME}    VERSION ${PRVERSION}  LANGUAGES ${PRLANG})
set(CMAKE_CXX_EXTENSIONS                             ${CPPEXTENTION})
set(CMAKE_CXX_STANDARD                                 ${CPPVERSION})
set(CMAKE_CXX_STANDARD_REQUIRED                    ${CPPSTANDARDREQ})

message("--------------------------------------------- General info: ---------------------------------------------")
find_program(CMAKE_CXX_CPPCHECK NAMES cppcheck)
if(CMAKE_CXX_CPPCHECK)
message("--------------------------------------------- CPP-Check:  ON ---------------------------------------------")
list(APPEND CMAKE_CXX_CPPCHECK "--enable=all")
endif()

find_program(CLANG_TIDY_EXE NAMES "clang-tidy" REQUIRED)
if(CLANG_TIDY_EXE)
message("--------------------------------------------- CLANG-TIDY: ON ---------------------------------------------")
endif()

message("---------------------------------------------------------------------------------------------------------------")
message("--------------------------------------------- OS: ${MYOS} ---------------------------------------------")
message("--------------------------------------------- ${CPPCOMPILER} COMPILER ---------------------------------------------")
message("--------------------------------------------- BUILD TYPE: ${BUILD_TYPE}  --------------------------------------------")
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