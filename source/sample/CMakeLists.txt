# EXE
include(${CMAKE_SOURCE_DIR}/cmake/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/src/src_files.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/static_analyzer.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/sanitizer.cmake)
if(SHOW_CONSOLE)
  add_executable(${PREXENAME} ${mysrc_exe})
else()
  add_executable(${PREXENAME} WIN32 ${mysrc_exe})
endif()

configure_file("./include/osconfig.h.in" "${CMAKE_CURRENT_BINARY_DIR}/generate/osconfig.h")

if(INTERNAL_MYLIB_USAGE)
  target_include_directories(
    ${PREXENAME}
    PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/generate"
    PUBLIC "./include"
    PRIVATE "../library/include"
  )
  target_precompile_headers(${PREXENAME} REUSE_FROM ${SULOTIONNAME}::${MYLIBNAME})
  if(ENABLE_UNITYBUILD)
    set_target_properties(${PREXENAME} PROPERTIES UNITY_BUILD ON)
  endif()
  target_link_libraries(${PREXENAME} PRIVATE ${SULOTIONNAME}::${MYLIBNAME} ${LIB_LINKAGE_VAR})
else()
  target_include_directories(${PREXENAME} PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/generate" PUBLIC "./include")
  target_link_libraries(${PREXENAME} ${LIB_LINKAGE_VAR})
endif()
target_compile_options(${PREXENAME} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:${CUSTOME_FLAGS}>)
# Specify the path to your library (change to your actual path)
# set(MyLibrary_DIR "/path/to/my_project/build")
# Find the library
# find_library(MyLibrary_LIB MYLIBNAME PATHS ${MyLibrary_DIR})

#enable static analyzer
setting_enable_staticanalyzer(${PREXENAME})
setting_enable_sanitizer(${PREXENAME})
