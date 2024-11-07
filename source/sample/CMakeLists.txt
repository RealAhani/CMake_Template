# EXE
include(${CMAKE_SOURCE_DIR}/cmake/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/src/src_files.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/static_analyzer.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/sanitizer.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/LibsConfig.cmake)

if(SHOW_CONSOLE)
  add_executable(${PREXENAME} ${mysrc_exe})
else()
  add_executable(${PREXENAME} WIN32 ${mysrc_exe})
endif()

# find_package(SFML COMPONENTS system window graphics CONFIG REQUIRED)
find_package(raylib CONFIG REQUIRED)

if(INTERNAL_MYLIB_USAGE)
  target_precompile_headers(${PREXENAME} REUSE_FROM ${MYLIBNAME})
  if(ENABLE_UNITYBUILD)
    set_target_properties(${PREXENAME} PROPERTIES UNITY_BUILD ON)
  endif()
  target_link_libraries(
    ${PREXENAME} PRIVATE ${MYLIBNAME} MYBENCHMARK ${LIB_LINKAGE_VAR} ${PAKAGE_LINK_VAR_LIST}
  )
else()
  fetch_repositories()
  target_include_directories(${PREXENAME} PUBLIC "./include")
  target_link_libraries(${PREXENAME} PRIVATE MYBENCHMARK ${LIB_LINKAGE_VAR} ${PAKAGE_LINK_VAR_LIST})
endif()

target_compile_options(${PREXENAME} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:${CUSTOME_FLAGS}>)

#enable static analyzer
setting_enable_staticanalyzer(${PREXENAME})
setting_enable_sanitizer(${PREXENAME})

if(ENABLE_PACKAGING)
  install(TARGETS ${PREXENAME} RUNTIME DESTINATION bin)
endif()
