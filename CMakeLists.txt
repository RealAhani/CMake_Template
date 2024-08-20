include(config.cmake)
set(CMAKE_CXX_COMPILER ${CPPCOMPILER})
# set(CMAKE_CXX_FLAGS_DEBUG_INIT "-Wall")
# set(CMAKE_CXX_FLAGS_RELEASE_INIT "-Wall")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(MYDEBUG_SETTING OFF)
if(MYDEBUG_SETTING)
message("============================================ Debuging is ON: Warning all is enabled ============================================")
if(NOT ${CPPCOMPILER} STREQUAL "MSVC")
set(CUSTOME_FLAGS ${DEBUG_COMPILER_FLAGS_GCC_CLANG})
else()
set(CUSTOME_FLAGS ${DEBUG_COMPILER_FLAGS_MSVC})
endif(NOT ${CPPCOMPILER} STREQUAL "MSVC")
else()
message("============================================ Debuging is OFF ============================================")
set(CUSTOME_FLAGS ${RELEASE_COMPILER_FLAGS})
endif(MYDEBUG_SETTING)

add_compile_options(${CUSTOME_FLAGS})





#if you want to enable wall set this flag in cammand line to TRUE

cmake_minimum_required(VERSION                                  3.25)
project(${SULOTIONNAME}    VERSION ${PRVERSION}  LANGUAGES ${PRLANG})
set(CMAKE_CXX_EXTENSIONS                             ${CPPEXTENTION})
set(CMAKE_CXX_STANDARD                                 ${CPPVERSION})
set(CMAKE_CXX_STANDARD_REQUIRED                    ${CPPSTANDARDREQ})

message("--------------------------------------------- General info: ---------------------------------------------")
message("---------------------------------------------------------------------------------------------------------------")
message("--------------------------------------------- OS: ${MYOS} ---------------------------------------------")
message("--------------------------------------------- ${CPPCOMPILER} COMPILER ---------------------------------------------")
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