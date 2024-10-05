# EXE
include(${CMAKE_HOME_DIRECTORY}/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/src/src_files.cmake)
# include(CTest)
if(SHOW_CONSOLE)
  add_executable(${PREXENAME} ${mysrc_exe})
else()
  add_executable(${PREXENAME} WIN32 ${mysrc_exe})
endif()

configure_file("./include/osconfig.h.in" "${CMAKE_CURRENT_BINARY_DIR}/generate/osconfig.h")

if(INTERNAL_MYLIB_USAGE)
  target_include_directories(
    ${PREXENAME}
    PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/generate"
    PUBLIC "./include"
    PRIVATE "../library/include"
  )
  target_precompile_headers(${PREXENAME} REUSE_FROM ${SULOTIONNAME}::${MYLIBNAME})
  if(ENABLE_UNITYBUILD)
    set_target_properties(${PREXENAME} PROPERTIES UNITY_BUILD ON)
  endif()
  target_link_libraries(${PREXENAME} ${SULOTIONNAME}::${MYLIBNAME} ${LIB_LINKAGE_VAR})
else()
  target_include_directories(${PREXENAME} PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/generate" PUBLIC "./include")
  target_link_libraries(${PREXENAME} ${LIB_LINKAGE_VAR})
endif()
target_compile_options(${PREXENAME} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:${CUSTOME_FLAGS}>)
# Specify the path to your library (change to your actual path)
# set(MyLibrary_DIR "/path/to/my_project/build")
# Find the library
# find_library(MyLibrary_LIB MYLIBNAME PATHS ${MyLibrary_DIR})
if(STATIC_ANALYZER)
  set_target_properties(${PREXENAME} PROPERTIES CXX_CLANG_TIDY "${CLANG_TIDY_EXE}")
endif()

if(ENABLE_SANITIZER)
  link_directories(
    ${CLANG_SANITIZER_PATH}/clang_rt.asan_dynamic-x86_64.lib
    ${CLANG_SANITIZER_PATH}/clang_rt.asan_dynamic_runtime_thunk-x86_64.lib
  )
  if(${CPPCOMPILER} STREQUAL "clang++" OR ${CPPCOMPILER} STREQUAL "g++")
    message("--------------------------------------------- SANITIZER IS ON IN EXE WITH: ${SANITIZERS}")
    target_compile_options(${PREXENAME} PRIVATE -fsanitize=${SANITIZERS} -fno-omit-frame-pointer)
    target_link_libraries(
      ${PREXENAME} clang_rt.asan_dynamic-x86_64 clang_rt.asan_dynamic_runtime_thunk-x86_64
    )
    # Copy the .dll files to the output directory after the build
    add_custom_command(
      TARGET ${PREXENAME} POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy_if_different
              "${CLANG_SANITIZER_PATH}/clang_rt.asan_dynamic-x86_64.dll" ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    )
  else()
    # this is for msvc
    message("--------------------------------------------- SANITIZER IS ON IN EXE WITH: ${SANITIZERS}")
    target_compile_options(${PREXENAME} PRIVATE /fsanitize=${SANITIZERS} /Zi /MD)
    target_link_libraries(
      ${PREXENAME} clang_rt.asan_dynamic-x86_64 clang_rt.asan_dynamic_runtime_thunk-x86_64
    )
  endif()
endif()
