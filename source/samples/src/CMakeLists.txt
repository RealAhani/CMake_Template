include(${CMAKE_HOME_DIRECTORY}/config.cmake)
include(src_files.cmake)
set(CMAKE_CXX_EXTENSIONS                             ${CPPEXTENTION})
set(CMAKE_CXX_STANDARD                                 ${CPPVERSION})
set(CMAKE_CXX_STANDARD_REQUIRED                    ${CPPSTANDARDREQ})
project(${PREXENAME}      VERSION ${PRVERSION}   LANGUAGES ${PRLANG})
add_executable(${PREXENAME} ${src})
configure_file("../include/osconfig.h.in"  "${CMAKE_CURRENT_BINARY_DIR}/generate/osconfig.h")
message("${CMAKE_CURRENT_BINARY_DIR}")

target_include_directories(${PREXENAME} 
PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/generate" 
PUBLIC "../include" 
PRIVATE "../../include")
# TODO 2: add option for compiling shared or static 
# Specify the path to your library (change to your actual path)
# set(MyLibrary_DIR "/path/to/my_project/build")
# Find the library
# find_library(MyLibrary_LIB MYLIBNAME PATHS ${MyLibrary_DIR})
target_precompile_headers(${PREXENAME} REUSE_FROM ${MYLIBNAME})
target_link_libraries(${PREXENAME} ${MYLIBNAME})
set_target_properties(${PREXENAME} PROPERTIES CXX_CLANG_TIDY "${CLANG_TIDY_EXE}")