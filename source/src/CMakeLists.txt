include(${CMAKE_HOME_DIRECTORY}/config.cmake)
include(src_files.cmake)
set(CMAKE_CXX_EXTENSIONS                             ${CPPEXTENTION})
set(CMAKE_CXX_STANDARD                                 ${CPPVERSION})
set(CMAKE_CXX_STANDARD_REQUIRED                    ${CPPSTANDARDREQ})
project(${MYLIBNAME}       VERSION ${PRVERSION}     LANGUAGES ${PRLANG})
#if You want u can change it to SHARED
add_library(${MYLIBNAME} ${MYLIB_TYPE} ${src})
configure_file("../include/osconfig.h.in"  "${CMAKE_CURRENT_BINARY_DIR}/generate/osconfig.h")

# if(${CPPCOMPILER} STREQUAL "clang++" OR ${CPPCOMPILER} STREQUAL "g++")
# message("ie kirrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr")
# if(ENABLE_SANITIZER)
# # target_compile_options(${PREXENAME} PUBLIC )
# # # target_link_options(${MYLIBNAME} PUBLIC -fsanitize=address,undefined)
# #     set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address,undefined")
# #     set(CMAKE_LINKER_FLAGS "${CMAKE_LINKER_FLAGS} -fsanitize=address,undefined")
# endif()
# endif()

target_include_directories(${MYLIBNAME} 
PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/generate" 
PUBLIC "../include")
target_precompile_headers(${MYLIBNAME} PUBLIC "../include/pch/pch.hpp")
set_target_properties(${MYLIBNAME} PROPERTIES CXX_CLANG_TIDY "${CLANG_TIDY_EXE}")