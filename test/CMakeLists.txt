#TEST
include(${CMAKE_CURRENT_LIST_DIR}/src/src_files.cmake)
project(CmakeConfigPackageTests LANGUAGES CXX)
cmake_minimum_required(VERSION 3.30)
project(${TESTNAME} VERSION ${PRVERSION} LANGUAGES ${PRLANG})

# include(FetchContent)
# FetchContent_Declare(Catch2 GIT_REPOSITORY https://github.com/catchorg/Catch2.git GIT_TAG v3.4.0)
# FetchContent_MakeAvailable(Catch2)
if(PROJECT_IS_TOP_LEVEL OR ENABLE_TESTING)
  find_package(Catch2 CONFIG REQUIRED)
  add_executable(${TESTNAME} ${mysrc_test})
  target_compile_options(${TESTNAME} INTERFACE --coverage -O0 -g)
  target_link_libraries(${TESTNAME} INTERFACE --coverage)
  target_link_libraries(${TESTNAME} PRIVATE ${SULOTIONNAME}::${MYLIBNAME} Catch2::Catch2WithMain)
  target_include_directories(
    ${TESTNAME} PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/generate" PRIVATE "../source/library/include"
  )
  include(CTest)
  include(Catch)
  catch_discover_tests(${TESTNAME})
endif()
