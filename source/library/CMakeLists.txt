# LIB
include(${CMAKE_HOME_DIRECTORY}/cmake/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/src/src_files.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/static_analyzer.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/sanitizer.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/LibsConfig.cmake)
#if You want u can change it to SHARED

# Add headers directory for android_native_app_glue.c
include_directories($ENV{ANDROID_NDK_HOME}/sources/android/native_app_glue/)

add_library(${MYLIBNAME} ${MYLIB_TYPE} ${mysrc_lib})
configure_file("./include/config.hh.in" "${CMAKE_CURRENT_BINARY_DIR}/generate/config.hh")
target_include_directories(
  ${MYLIBNAME}
  PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/generate"
  PUBLIC "./include"
  PUBLIC "./include/pch"
)

# find_package(SFML COMPONENTS system window graphics CONFIG REQUIRED)
# find_package(box2d CONFIG REQUIRED)
find_package(raylib CONFIG REQUIRED)


fetch_repositories(${MYLIBNAME})

target_precompile_headers(${MYLIBNAME} PUBLIC "./include/pch/pch.hh")
target_link_libraries(${MYLIBNAME} PUBLIC MYBENCHMARK PRIVATE ${LIB_LINKAGE_VAR} ${PAKAGE_LINK_VAR_LIST})

if(ENABLE_UNITYBUILD)
  set_target_properties(${MYLIBNAME} PROPERTIES UNITY_BUILD ON)
endif()
target_compile_options(${MYLIBNAME} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:${CUSTOME_FLAGS}>)
#enable static analyzer
setting_enable_staticanalyzer(${MYLIBNAME})
setting_enable_sanitizer(${MYLIBNAME})

if(ENABLE_PACKAGING)
  include(GNUInstallDirs)
  install(TARGETS ${MYLIBNAME} LIBRARY DESTINATION lib ARCHIVE DESTINATION lib/static)
  install(DIRECTORY include/ TYPE INCLUDE PATTERN "pch" EXCLUDE)
endif()
