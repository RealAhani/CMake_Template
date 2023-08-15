include(config.cmake)

#if you want to enable wall set this flag in cammand line to TRUE
option(WALL OFF)
if(WALL)
set(CMAKE_CXX_FLAGS_DEBUG_INIT "-Wall")
set(CMAKE_CXX_FLAGS_RELEASE_INIT "-Wall")
message("Warning all is enabled")
endif(WALL)
#if you want to enable wall set this flag in cammand line to TRUE

cmake_minimum_required(VERSION                                  3.25)
project(${SULOTIONNAME}    VERSION ${PRVERSION}  LANGUAGES ${PRLANG})
set(CMAKE_CXX_EXTENSIONS                             ${CPPEXTENTION})
set(CMAKE_CXX_STANDARD                                 ${CPPVERSION})
set(CMAKE_CXX_STANDARD_REQUIRED                    ${CPPSTANDARDREQ})


if(${MYOS} STREQUAL ${WINDOWS})
set(CURRENTOS 1)

add_subdirectory("source/src")
add_subdirectory("source/samples/src")

message("================= OPERATING SYS :WINDOWS =================")
elseif(${MYOS} STREQUAL ${LINUXOS})
set(CURRENTOS 2)

add_subdirectory("source/src")
add_subdirectory("source/samples/src")

message("================= OPERATING SYS :NOT-SUPPORT =================")
elseif(${MYOS} STREQUAL ${MACOS})
set(CURRENTOS 3)

add_subdirectory("source/src")
add_subdirectory("source/samples/src")

message("================= OPERATING SYS :NOT-SUPPORT =================")
endif()