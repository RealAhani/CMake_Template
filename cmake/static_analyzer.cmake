macro(setting_enable_staticanalyzer target_link)
  if(STATIC_ANALYZER)
    find_program(CMAKE_CXX_CPPCHECK NAMES cppcheck)
    if(CMAKE_CXX_CPPCHECK)
      message("--------------------------------------------- CPP-Check ${target_link}:  ON ")
      if(CMAKE_GENERATOR MATCHES ".*Visual Studio.*")
        set(CPPCHECK_TEMPLATE "vs")
      else()
        set(CPPCHECK_TEMPLATE "gcc")
      endif()
      message(
        "--------------------------------------------- CPP-Check Template ${target_link}:  ${CPPCHECK_TEMPLATE} "
      )
      list(
        APPEND
        CMAKE_CXX_CPPCHECK
        "--template=${CPPCHECK_TEMPLATE}"
        "--enable=style,performance,warning,portability"
        "--inline-suppr"
        # We cannot act on a bug/missing feature of cppcheck
        "--suppress=cppcheckError"
        "--suppress=internalAstError"
        # if a file does not have an internalAstError, we get an unmatchedSuppression error
        "--suppress=unmatchedSuppression"
        # noisy and incorrect sometimes
        "--suppress=passedByValue"
        # ignores code that cppcheck thinks is invalid C++
        "--suppress=syntaxError"
        "--suppress=preprocessorErrorDirective"
        "--inconclusive"
      )
    endif()
    find_program(CLANG_TIDY_EXE NAMES "clang-tidy" REQUIRED)
    if(CLANG_TIDY_EXE)
      message("--------------------------------------------- CLANG-TIDY ${target_link}: ON ")
    endif()
  else()
    message("--------------------------------------------- CPP-Check ${target_link}:  OFF ")
    message("--------------------------------------------- CLANG-TIDY ${target_link}: OFF ")
  endif()
  set_target_properties(${target_link} PROPERTIES CXX_CLANG_TIDY "${CLANG_TIDY_EXE}")
endmacro()
