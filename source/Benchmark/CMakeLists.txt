# BENCHMARK
include(${CMAKE_HOME_DIRECTORY}/cmake/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/src/src_files.cmake)
#if You want u can change it to SHARED
add_library(MYBENCHMARK STATIC ${mysrc_benchmark})
add_library(${SULOTIONNAME}::MYBENCHMARK ALIAS MYBENCHMARK)

target_include_directories(
  MYBENCHMARK PUBLIC "${CMAKE_CURRENT_LIST_DIR}/include" PUBLIC "{CMAKE_CURRENT_LIST_DIR}/src"
)
if(ENABLE_UNITYBUILD)
  set_target_properties(MYBENCHMARK PROPERTIES UNITY_BUILD ON)
endif()
target_compile_options(MYBENCHMARK PRIVATE $<$<COMPILE_LANGUAGE:CXX>:${CUSTOME_FLAGS}>)
