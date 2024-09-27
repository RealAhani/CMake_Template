include(${CMAKE_HOME_DIRECTORY}/config.cmake)
include(src_files.cmake)
set(CMAKE_CXX_EXTENSIONS                             ${CPPEXTENTION})
set(CMAKE_CXX_STANDARD                                 ${CPPVERSION})
set(CMAKE_CXX_STANDARD_REQUIRED                    ${CPPSTANDARDREQ})
project(${PREXENAME}      VERSION ${PRVERSION}   LANGUAGES ${PRLANG})
if(SHOW_CONSOLE)
add_executable(${PREXENAME} ${src})
else()
add_executable(${PREXENAME} WIN32 ${src})
endif()

# if(${CPPCOMPILER} STREQUAL "clang++" OR ${CPPCOMPILER} STREQUAL "g++")
# message("ie kirrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr")
# if(ENABLE_SANITIZER)
# # target_compile_options(${PREXENAME} PUBLIC )
# # target_link_options(${PREXENAME} PUBLIC -fsanitize=address,undefined)
# # set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address,undefined")
# # set(CMAKE_LINKER_FLAGS "${CMAKE_LINKER_FLAGS} -fsanitize=address,undefined")
# endif()
# endif()

configure_file("../include/osconfig.h.in"  "${CMAKE_CURRENT_BINARY_DIR}/generate/osconfig.h")
message("${CMAKE_CURRENT_BINARY_DIR}")

if(INTERNAL_MYLIB_USAGE)
target_include_directories(${PREXENAME} 
PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/generate" 
PUBLIC "../include" 
PRIVATE "../../include")
target_precompile_headers(${PREXENAME} REUSE_FROM ${MYLIBNAME})
target_link_libraries(${PREXENAME} ${MYLIBNAME} ${LIB_LINKAGE_VAR})
else()
target_include_directories(${PREXENAME} 
PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/generate" 
PUBLIC "../include")
target_link_libraries(${PREXENAME} ${LIB_LINKAGE_VAR})
endif()

# Specify the path to your library (change to your actual path)
# set(MyLibrary_DIR "/path/to/my_project/build")
# Find the library
# find_library(MyLibrary_LIB MYLIBNAME PATHS ${MyLibrary_DIR})
set_target_properties(${PREXENAME} PROPERTIES CXX_CLANG_TIDY "${CLANG_TIDY_EXE}")