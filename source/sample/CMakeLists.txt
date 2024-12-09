# EXE
include(${CMAKE_SOURCE_DIR}/cmake/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/src/src_files.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/static_analyzer.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/sanitizer.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/LibsConfig.cmake)

# Add headers directory for android_native_app_glue.c
include_directories($ENV{ANDROID_NDK_HOME}/sources/android/native_app_glue/)
if(NOT VCPKG_TARGET_ANDROID)
if(SHOW_CONSOLE)#its a Desktop
  add_executable(${PREXENAME} ${mysrc_exe})
else() # its Desktop without console
  add_executable(${PREXENAME} WIN32 ${mysrc_exe})
endif(SHOW_CONSOLE)
else()#its not Desktop maybe Android
add_library(${PREXENAME} ${MYLIB_TYPE} ${mysrc_exe})
endif(NOT VCPKG_TARGET_ANDROID)


# find_package(SFML COMPONENTS system window graphics CONFIG REQUIRED)
# find_package(box2d CONFIG REQUIRED) # if this is came from vcpkg
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
  fetch_repositories(${PREXENAME})
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
