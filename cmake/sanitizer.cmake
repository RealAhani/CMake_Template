macro(setting_enable_sanitizer target_link)
  if(ENABLE_SANITIZER)
    link_directories(
      ${CLANG_SANITIZER_PATH}/clang_rt.asan_dynamic-x86_64.lib
      ${CLANG_SANITIZER_PATH}/clang_rt.asan_dynamic_runtime_thunk-x86_64.lib
    )
    if(${CPPCOMPILER} STREQUAL "clang++" OR ${CPPCOMPILER} STREQUAL "g++" OR ${CPPCOMPILER} STREQUAL
                                                                             "clang-cl"
    )
      message(
        "--------------------------------------------- SANITIZER IS ON IN ${target_link} WITH: ${SANITIZERS}"
      )
      target_compile_options(${target_link} PRIVATE -fsanitize=${SANITIZERS} -fno-omit-frame-pointer)
      target_link_libraries(
        ${target_link} clang_rt.asan_dynamic-x86_64 clang_rt.asan_dynamic_runtime_thunk-x86_64
      )
      # Copy the .dll files to the output directory after the build
      add_custom_command(
        TARGET ${target_link} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
                "${CLANG_SANITIZER_PATH}/clang_rt.asan_dynamic-x86_64.dll" ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
      )
    else()
      # this is for msvc
      message(
        "--------------------------------------------- SANITIZER IS ON IN ${target_link} WITH: ${SANITIZERS}"
      )
      target_compile_options(${target_link} PRIVATE /fsanitize=${SANITIZERS} /Zi /MD)
      target_link_libraries(
        ${target_link} clang_rt.asan_dynamic-x86_64 clang_rt.asan_dynamic_runtime_thunk-x86_64
      )
    endif()
  endif()
endmacro()
