#ROOT
message("--------------------------------------------- General info:")
include(${CMAKE_SOURCE_DIR}/cmake/config.cmake)
set(CMAKE_CXX_COMPILER ${CPPCOMPILER})
if(${CPPCOMPILER} STREQUAL "g++")
  set(CMAKE_C_COMPILER gcc)
else()
  set(CMAKE_C_COMPILER clang)
endif()

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  list(APPEND DEBUG_COMPILER_FLAGS_GCC_CLANG "-g")
  list(APPEND DEBUG_COMPILER_FLAGS_GCC_CLANG "-fno-limit-debug-info")
  if(ENABLE_WARNING)
    message("============================================= Debuging is ON (all Warnings are enable) ")
    if(NOT ${CPPCOMPILER} STREQUAL "MSVC")
      set(CUSTOME_FLAGS ${DEBUG_COMPILER_FLAGS_GCC_CLANG})
      if(${CPPCOMPILER} STREQUAL "g++")
        set(CUSTOME_FLAGS ${DEBUG_COMPILER_FLAGS_GCC_CLANG}${DEBUG_COMPILER_EXTRA_FLAGS_GCC})
      endif(${CPPCOMPILER} STREQUAL "g++")
    else()
      set(CUSTOME_FLAGS ${DEBUG_COMPILER_FLAGS_MSVC})
    endif(NOT ${CPPCOMPILER} STREQUAL "MSVC")
  endif()
else()
  message(
    "============================================= Debuging is OFF (Release Mode with Full Optimization) "
  )
  # set(BUILD_TYPE "Release")
  if(NOT ${CPPCOMPILER} STREQUAL "MSVC")
    set(CUSTOME_FLAGS ${RELEASE_COMPILER_FLAGS_GCC_CLANG})
  else()
    set(CUSTOME_FLAGS ${RELEASE_COMPILER_FLAGS_MSVC})
  endif(NOT ${CPPCOMPILER} STREQUAL "MSVC")
endif()

find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
  set(CMAKE_CXX_COMPILER_LAUNCHER ccache CACHE STRING "C++ compiler launcher")
  set(CMAKE_C_COMPILER_LAUNCHER ccache CACHE STRING "C compiler launcher")
  message("--------------------------------------------- CCACHE: ON ")
  set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
endif()

if (VCPKG_TARGET_ANDROID)
    include(${CMAKE_SOURCE_DIR}/cmake/vcpkg_android.cmake)
endif()

cmake_minimum_required(VERSION 3.20...3.31)


project(${SULOTIONNAME} VERSION ${PRVERSION} LANGUAGES ${PRLANG})
set(CMAKE_CXX_STANDARD ${CPPVERSION})
set(CMAKE_C_STANDARD ${CVERSION})
set(CMAKE_CXX_STANDARD_REQUIRED ${CPPSTANDARDREQ})
set(CMAKE_CXX_EXTENSIONS ${CPPEXTENTION})

set(BUILD_ARCH "" CACHE STRING "os architecture type")
message("--------------------------------------------- OS: ${MYOS} ")
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  set(BUILD_ARCH "x64")
  message("--------------------------------------------- Arch: ${BUILD_ARCH} ")
else()
  set(BUILD_ARCH "x86")
  message("--------------------------------------------- Arch: ${BUILD_ARCH} ")
endif()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY
    "$<0:>${CMAKE_BINARY_DIR}/out/${BUILD_ARCH}_${CMAKE_BUILD_TYPE}/${PRESET_NAME}/bin"
) # .exe and .dll
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY
    "$<0:>${CMAKE_BINARY_DIR}/out/${BUILD_ARCH}_${CMAKE_BUILD_TYPE}/${PRESET_NAME}/lib"
) # .so and .dylib
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY
    "$<0:>${CMAKE_BINARY_DIR}/out/${BUILD_ARCH}_${CMAKE_BUILD_TYPE}/${PRESET_NAME}/lib"
) # .lib and .a
#TODO:N1 ADD new build type for "RelWithDebInfo" and "MinSizeRel" maybe need change blew condition for appending these

message("--------------------------------------------- C++ COMPILER ID: ${CMAKE_CXX_COMPILER_ID} ")
message("--------------------------------------------- C++ COMPILER: ${CPPCOMPILER} ")
message("--------------------------------------------- C COMPILER: ${CMAKE_C_COMPILER} ")
message("--------------------------------------------- BUILD TYPE: ${CMAKE_BUILD_TYPE}  ")
message("--------------------------------------------- UNITY BUILD: ${ENABLE_UNITYBUILD} ")
message("--------------------------------------------- Compiler Flags: ${CUSTOME_FLAGS} ")
message("--------------------------------------------- CXX Version: ${CPPVERSION} ")
message("--------------------------------------------- Sulotion name : ${SULOTIONNAME} ")
if(INTERNAL_MYLIB_USAGE)
  message("--------------------------------------------- Library name : ${MYLIBNAME} ")
endif()
message("--------------------------------------------- Exe name : ${PREXENAME} ")
message("--------------------------------------------- Version: ${PRVERSION} ")

if(WIN32)
  message("============================================ OPERATING SYS :WINDOWS ")
  set(CURRENTOS 1 CACHE STRING "OS TYPE ")
elseif(LINUX)
  message("============================================ OPERATING SYS :Linux ")
  set(CURRENTOS 2 CACHE STRING "OS TYPE ")
elseif(UNIX)
  message("============================================ OPERATING SYS :UNIX ")
  set(CURRENTOS 3 CACHE STRING "OS TYPE ")
endif()

if(INTERNAL_MYLIB_USAGE)
  add_subdirectory("./source/library")
endif()
add_subdirectory("./source/sample")

if(NOT VCPKG_TARGET_ANDROID)
add_subdirectory("./source/Benchmark")
endif(NOT VCPKG_TARGET_ANDROID)

message("--------------------------------------------- Benchmarking : ${ENABLE_BENCHMARK}")
# Don't even look at tests if we're not top level
if(NOT PROJECT_IS_TOP_LEVEL)
  return()
endif()

# Adding the tests:
if(ENABLE_TESTING)

  message("============================================ TESTING IS ON")
  enable_testing()
  list(APPEND CMAKE_MODULE_PATH ${catch2_SOURCE_DIR}/extras)
  add_subdirectory("test")

endif()
if(ENABLE_PACKAGING)
  # Set package types (e.g., ZIP,External ,WIX (msiinstaller),IFW(qtinstaller),INNOSETUP,NSIS,NSIS64 ,Nuget TBZ2, TGZ, TXZ ,TZ , DEB, RPM, NSIS, etc.)
  if(WIN32)
    set(CPACK_GENERATOR "ZIP;WIX;" CACHE STRING "" FORCE)
  else()
    set(CPACK_GENERATOR "ZIP;DEB;" CACHE STRING "" FORCE)
  endif()
  message("============================================ PACKAGING")
  set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
  set(CPACK_PACKAGE_VERSION ${PRVERSION})
  set(CPACK_PACKAGE_DESCRIPTION_SUMMARY ${DISCRIPTION})
  set(CPACK_PACKAGE_VENDOR ${VENDOR})
  set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Your Name")
  set(CPACK_PACKAGE_CONTACT ${SUPPORTMAIL})
  set(CPACK_PACKAGE_INSTALL_DIRECTORY ${PRNAME})
  # Set architecture (e.g., amd64, i386, etc.)
  set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE ${CMAKE_SYSTEM_PROCESSOR})
  # Set installation prefix (this will be /usr/local by default)
  set(CPACK_PACKAGING_INSTALL_PREFIX "/out")

  # Specify additional files to include in the package
  install(FILES README.md DESTINATION .)
  if(WIN32)
    # Additional settings (Optional)
    set(CPACK_WIX_PRODUCT_GUID "12345678-1234-1234-1234-1234567890AB")
    # Optional: Unique GUID for the installer
    set(CPACK_WIX_UPGRADE_GUID "12345678-1234-1234-1234-1234567890AC")
    # Optional: Upgrade GUID for future versions
    set(CPACK_WIX_LICENSE_RTF "${CMAKE_SOURCE_DIR}/LICENSE")
  endif()
  include(CPack)
endif()

# copying compile_commands.json to root of the build dir for clangd intellisence
# Specify the source and destination paths
set(SOURCE_FILE "${CMAKE_SOURCE_DIR}/build/${CMAKE_HOST_SYSTEM_NAME}/Desktop/compile_commands.json")
set(DESTINATION_DIR "${CMAKE_SOURCE_DIR}/build")
set(TARGET_FILE "${DESTINATION_DIR}/compile_commands.json")

# Add a post-build custom target to copy the file
add_custom_command(
    OUTPUT "${TARGET_FILE}"
    COMMAND ${CMAKE_COMMAND} -E copy_if_different "${SOURCE_FILE}" "${TARGET_FILE}"
    DEPENDS "${SOURCE_FILE}"  # Ensure the command runs only after the file exists
    COMMENT "Copying compile_commands.json to ${DESTINATION_DIR}"
)

add_custom_target(copy_compile_commands ALL DEPENDS "${TARGET_FILE}")
