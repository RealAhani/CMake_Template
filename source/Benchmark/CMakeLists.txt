# BENCHMARK
include(${CMAKE_HOME_DIRECTORY}/cmake/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/src/src_files.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/static_analyzer.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/sanitizer.cmake)
#if You want u can change it to SHARED
add_library(MYBENCHMARK STATIC ${mysrc_benchmark})
add_library(${SULOTIONNAME}::MYBENCHMARK ALIAS MYBENCHMARK)

target_include_directories(MYBENCHMARK PUBLIC "./include")
target_precompile_headers(MYBENCHMARK PUBLIC "../library/include/pch/pch.hh")
if(ENABLE_UNITYBUILD)
  set_target_properties(MYBENCHMARK PROPERTIES UNITY_BUILD ON)
endif()
target_compile_options(MYBENCHMARK PRIVATE $<$<COMPILE_LANGUAGE:CXX>:${CUSTOME_FLAGS}>)
#enable static analyzer
