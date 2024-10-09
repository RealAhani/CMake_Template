# LIB
include(${CMAKE_HOME_DIRECTORY}/cmake/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/src/src_files.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/static_analyzer.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/sanitizer.cmake)
#if You want u can change it to SHARED
add_library(${MYLIBNAME} ${MYLIB_TYPE} ${mysrc_lib})
add_library(${SULOTIONNAME}::${MYLIBNAME} ALIAS ${MYLIBNAME})
configure_file("./include/osconfig.h.in" "${CMAKE_CURRENT_BINARY_DIR}/generate/osconfig.h")

target_include_directories(
  ${MYLIBNAME}
  PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/generate"
  PUBLIC "./include"
  PUBLIC "../Benchmark/include"
)
target_precompile_headers(${MYLIBNAME} PUBLIC "./include/pch/pch.hh")
target_link_libraries(${MYLIBNAME} PUBLIC ${SULOTIONNAME}::MYBENCHMARK PRIVATE ${LIB_LINKAGE_VAR})
if(ENABLE_UNITYBUILD)
  set_target_properties(${MYLIBNAME} PROPERTIES UNITY_BUILD ON)
endif()
target_compile_options(${MYLIBNAME} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:${CUSTOME_FLAGS}>)
#enable static analyzer
setting_enable_staticanalyzer(${MYLIBNAME})
setting_enable_sanitizer(${MYLIBNAME})
