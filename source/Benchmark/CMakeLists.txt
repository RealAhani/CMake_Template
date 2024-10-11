# BENCHMARK is a header only library that uses lib pch for his includes
include(${CMAKE_HOME_DIRECTORY}/cmake/config.cmake)
#if You want u can change it to SHARED
add_library(MYBENCHMARK INTERFACE)
add_library(${SULOTIONNAME}::MYBENCHMARK ALIAS MYBENCHMARK)

target_include_directories(MYBENCHMARK INTERFACE "${CMAKE_CURRENT_LIST_DIR}/include")
if(ENABLE_UNITYBUILD)
  set_target_properties(MYBENCHMARK PROPERTIES UNITY_BUILD ON)
endif()
target_compile_options(MYBENCHMARK INTERFACE $<$<COMPILE_LANGUAGE:CXX>:${CUSTOME_FLAGS}>)
