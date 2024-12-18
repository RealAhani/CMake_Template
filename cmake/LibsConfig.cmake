include_guard()
include(FetchContent)
set(FETCHCONTENT_BASE_DIR ${CMAKE_BINARY_DIR}/dependencies)

function(fetch_repositories target)
  set_property(GLOBAL PROPERTY USE_FOLDERS ON)
  set(INDEX 0)
  if(REP_URLS)
    list(LENGTH REP_URLS repo_count)
    if(repo_count GREATER 0)
      foreach(repo_url IN LISTS REP_URLS)
        string(REGEX REPLACE ".*/(.*)\\.git" "\\1" repo_name ${repo_url})
        list(GET REP_BRANCH ${INDEX} repo_branch)
        FetchContent_Declare(
          ${repo_name}
          GIT_REPOSITORY ${repo_url}
          GIT_TAG ${repo_branch}
          GIT_SHALLOW TRUE
          GIT_PROGRESS TRUE
        )
        FetchContent_MakeAvailable(${repo_name})
        math(EXPR INDEX "${INDEX} + 1")
        include_directories(${${repo_name}_SOURCE_DIR}/include)
        message(
          "******************************************************* ${repo_name} GIT_REPOSITORY ${repo_url} GIT_TAG ${repo_branch} "
        )
        target_include_directories(${target} PRIVATE (${${repo_name}_SOURCE_DIR}/include))
      endforeach()
    endif()
  endif()
endfunction()

# target_link_libraries(MyApp PRIVATE sfml-graphics sfml-window sfml-system)
# target_include_directories(MyApp PRIVATE ${SFML_SOURCE_DIR}/include)
