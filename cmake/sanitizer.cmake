include(${CMAKE_SOURCE_DIR}/cmake/os.cmake)
macro(setting_enable_sanitizer target_link)
  if(ENABLE_SANITIZER)

    if(LINUX) # this is linux
      if(${CPPCOMPILER} STREQUAL "clang++" OR ${CPPCOMPILER} STREQUAL "g++")
        message(
          "--------------------------------------------- SANITIZER IS ON IN (GNU) ${target_link} WITH: ${SANITIZERS}"
        )
        set(CMAKE_CXX_FLAGS_DEBUG
            "${CMAKE_CXX_FLAGS_DEBUG} -fno-omit-frame-pointer -fsanitize=address,undefined,leak"
        )
        set(CMAKE_LINKER_FLAGS_DEBUG
            "${CMAKE_LINKER_FLAGS_DEBUG} -fno-omit-frame-pointer -fsanitize=address,undefined,leak"
        )
        # target_compile_options(${target_link} PRIVATE -fsanitize=${SANITIZERS})
        # target_link_libraries(
        #   ${target_link} PUBLIC clang_rt.asan_dynamic-x86_64 clang_rt.asan_dynamic_runtime_thunk-x86_64
        # )
      endif()
    else() # this is windows
      link_directories(
        ${CLANG_SANITIZER_PATH}/clang_rt.asan_dynamic-x86_64.lib
        ${CLANG_SANITIZER_PATH}/clang_rt.asan_dynamic_runtime_thunk-x86_64.lib
      )
      if(${CPPCOMPILER} STREQUAL "clang++" OR ${CPPCOMPILER} STREQUAL "g++" OR ${CPPCOMPILER} STREQUAL
                                                                               "clang-cl"
      )
        message(
          "--------------------------------------------- SANITIZER IS ON IN (GNU) ${target_link} WITH: ${SANITIZERS}"
        )
        target_compile_options(${target_link} PUBLIC -fsanitize=${SANITIZERS} -fno-omit-frame-pointer)
        target_link_libraries(
          ${target_link} PUBLIC clang_rt.asan_dynamic-x86_64 clang_rt.asan_dynamic_runtime_thunk-x86_64
        )
        # Copy the .dll files to the output directory after the build
        add_custom_command(
          TARGET ${target_link}
          POST_BUILD
          COMMAND
            ${CMAKE_COMMAND} -E copy_if_different "${CLANG_SANITIZER_PATH}/clang_rt.asan_dynamic-x86_64.dll"
            ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
        )
      else()
        # this is for msvc
        message(
          "--------------------------------------------- SANITIZER IS ON IN (MSVC) ${target_link} WITH: ${SANITIZERS}"
        )
        target_compile_options(${target_link} PUBLIC /fsanitize=${SANITIZERS} /Zi /MD)
        target_link_libraries(
          ${target_link} PUBLIC clang_rt.asan_dynamic-x86_64 clang_rt.asan_dynamic_runtime_thunk-x86_64
        )
      endif()
    endif()

  endif()
endmacro()
