# LIB
include(${CMAKE_HOME_DIRECTORY}/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/src/src_files.cmake)
# include(CTest)
set(CMAKE_CXX_EXTENSIONS ${CPPEXTENTION})
set(CMAKE_CXX_STANDARD ${CPPVERSION})
set(CMAKE_CXX_STANDARD_REQUIRED ${CPPSTANDARDREQ})
project(${MYLIBNAME} VERSION ${PRVERSION} LANGUAGES ${PRLANG})
#if You want u can change it to SHARED
add_library(${MYLIBNAME} ${MYLIB_TYPE} ${mysrc_lib})
configure_file("./include/osconfig.h.in" "${CMAKE_CURRENT_BINARY_DIR}/generate/osconfig.h")

target_include_directories(${MYLIBNAME} PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/generate" PUBLIC "./include")
target_precompile_headers(${MYLIBNAME} PUBLIC "./include/pch/pch.hh")
target_compile_options(${MYLIBNAME} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:${CUSTOME_FLAGS}>)
if(STATIC_ANALYZER)
  set_target_properties(${MYLIBNAME} PROPERTIES CXX_CLANG_TIDY "${CLANG_TIDY_EXE}")
endif()

if(ENABLE_SANITIZER)
  link_directories(
    ${CLANG_SANITIZER_PATH}/clang_rt.asan_dynamic-x86_64.lib
    ${CLANG_SANITIZER_PATH}/clang_rt.asan_dynamic_runtime_thunk-x86_64.lib
  )
  if(${CPPCOMPILER} STREQUAL "clang++" OR ${CPPCOMPILER} STREQUAL "g++")
    message("--------------------------------------------- SANITIZER IS ON IN LIB WITH: ${SANITIZERS}")
    target_compile_options(${MYLIBNAME} PRIVATE -fsanitize=${SANITIZERS} -fno-omit-frame-pointer)
    target_link_libraries(
      ${MYLIBNAME} clang_rt.asan_dynamic-x86_64 clang_rt.asan_dynamic_runtime_thunk-x86_64
    )
  else()
    #this is for msvc
    message("--------------------------------------------- SANITIZER IS ON IN LIB WITH: ${SANITIZERS}")
    target_compile_options(${MYLIBNAME} PRIVATE /fsanitize=${SANITIZERS} /Zi /MD)
    target_link_libraries(
      ${MYLIBNAME} clang_rt.asan_dynamic-x86_64 clang_rt.asan_dynamic_runtime_thunk-x86_64
    )
  endif()
endif()
