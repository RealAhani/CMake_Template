macro(setting_enable_staticanalyzer target_link)
  if(STATIC_ANALYZER)

    # CPP_CHECK Setup
    find_program(CMAKE_CXX_CPPCHECK NAMES cppcheck REQUIRED)
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
      set_target_properties(${target_link} PROPERTIES CXX_CPPCHECK "${CMAKE_CXX_CPPCHECK}")
    else()
        message("--------------------------------------------- CPP-CHECK is not found on this ${target_link} ")
    endif()

    # CLANG_TIDY Setup
    find_program(CMAKE_CXX_CLANG_TIDY NAMES clang-tidy REQUIRED)
    if(CMAKE_CXX_CLANG_TIDY)
      message("--------------------------------------------- CLANG-TIDY ${target_link}: ON ")
      set_target_properties(${target_link} PROPERTIES CXX_CLANG_TIDY "${CMAKE_CXX_CLANG_TIDY}")
    else()
        message("--------------------------------------------- CLANG-TIDY is not found on this ${target_link} ")
    endif()

    # CPPLINT Setup
    find_program(CMAKE_CXX_CPPLINT NAMES cpplint REQUIRED)
    if(CMAKE_CXX_CPPLINT)
        message("--------------------------------------------- CPP-lint ${target_link}:  ON ")
        set_target_properties(${target_link} PROPERTIES CXX_CPPLINT "${CMAKE_CXX_CPPLINT}")
    else()
        message("--------------------------------------------- CPP-lint is not found on this ${target_link} ")
    endif()

# INCLUDE_WHAT_YOU_USE Setup
    # find_program(CMAKE_CXX_INCLUDE_WHAT_YOU_USE NAMES include-what-you-use REQUIRED)
    # if(CMAKE_CXX_INCLUDE_WHAT_YOU_USE)
    #     message("--------------------------------------------- IWYU ${target_link}:  ON ")
    #     set_target_properties(${target_link} PROPERTIES CXX_INCLUDE_WHAT_YOU_USE "${CMAKE_CXX_INCLUDE_WHAT_YOU_USE}")
    # else()
    #     message("--------------------------------------------- IWYU is not found on this ${target_link} ")
    # endif()

# static_analyzer is OFF
  else()
    message("--------------------------------------------- CPP-Check ${target_link}:  OFF ")
    message("--------------------------------------------- CLANG-TIDY ${target_link}: OFF ")
    message("--------------------------------------------- CPP_LINT ${target_link}: OFF ")
    message("--------------------------------------------- INCLUDE_WHAT_YOU_USE ${target_link}: OFF ")
  endif()
endmacro()
