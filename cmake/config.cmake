include_guard()
##############################################
include(${CMAKE_SOURCE_DIR}/cmake/LibsConfig.cmake)
##############################################
#your Solution name
set(SULOTIONNAME "NAME" CACHE STRING "" FORCE)
#your Project Versioning numbers
set(PRVERSION_MAJOR "0" CACHE STRING "" FORCE)
set(PRVERSION_MINOR "0" CACHE STRING "" FORCE)
set(PRVERSION_PATCH "1" CACHE STRING "" FORCE)
set(PRVERSION "${PRVERSION_MAJOR}.${PRVERSION_MINOR}.${PRVERSION_PATCH}" CACHE STRING "" FORCE)
#your project name
set(PRNAME ${SULOTIONNAME}${PRVERSION} CACHE STRING "" FORCE)
#your project language
set(PRLANG "CXX" CACHE STRING "" FORCE)
#your exe name
set(PREXENAME "${SULOTIONNAME}_EXE" CACHE STRING "" FORCE)
#your test name
set(TESTNAME "${SULOTIONNAME}_TEST" CACHE STRING "" FORCE)

##############################################
#your cpp standard version you want to use in this project
set(CPPVERSION 23 CACHE STRING "" FORCE)
set(CPPEXTENTION ON CACHE BOOL "" FORCE)
set(CPPSTANDARDREQ ON CACHE BOOL "" FORCE)
##############################################
# you can set your specific compiler flag on the choosen compiler you select on perivious variable
# add or remove wanted flags but not comment the line you dont want all 3 variable is needed

set(DEBUG_COMPILER_FLAGS_GCC_CLANG
    "-g;-Wall;-Wextra;-Wpedantic;-Wshadow;-Wconversion;-Wnon-virtual-dtor;-Wcast-align;-Wunused;-Woverloaded-virtual;-Wsign-conversion;-Wdouble-promotion;-Wformat=2;-Wimplicit-fallthrough;-Wsuggest-override;-Wnull-dereference;-Wold-style-cast"
    CACHE STRING "" FORCE
)
#             -Werror
#             -Wall
#             -Wextra # reasonable and standard
#             -Wshadow # warn the user if a variable declaration shadows one from a parent context
#             -Wnon-virtual-dtor # warn the user if a class with virtual functions has a non-virtual destructor. This helps catch hard to track down memory errors
#             -Wcast-align # warn for potential performance problem casts
#             -Wunused # warn on anything being unused
#             -Woverloaded-virtual # warn if you overload (not override) a virtual function
#             -Wconversion # warn on type conversions that may lose data
#             -Wsign-conversion # warn on sign conversions
#             -Wdouble-promotion # warn if float is implicit promoted to double
#             -Wformat=2 # warn on security issues around functions that format output (ie printf)
#             -Wimplicit-fallthrough # warn when a missing break causes control flow to continue at the next case in a switch statement
#             -Wsuggest-override # warn when 'override' could be used on a member function overriding a virtual function
#             -Wnull-dereference # warn if a null dereference is detected
#             -Wold-style-cast # warn for c-style casts
#             -Wpedantic # warn if non-standard C++ is used
#             ${OS_ANDROID}:-Wno-main>
set(DEBUG_COMPILER_EXTRA_FLAGS_GCC "-Wmisleading-indentation;-Wduplicated-cond;-Wlogical-op" CACHE STRING ""
                                                                                                   FORCE
)
#             -Wmisleading-indentation # warn if indentation implies blocks where blocks do not exist
#             -Wduplicated-cond # warn if if / else chain has duplicated conditions
#             -Wlogical-op # warn about logical operations being used where bitwise were probably wanted
#             # -Wuseless-cast # warn if you perform a cast to the same type (disabled because it is not portable as some type aliases might vary between platforms)
#             $<$<VERSION_GREATER_EQUAL:${CMAKE_CXX_COMPILER_VERSION},8.1>:-Wduplicated-branches> # warn if if / else branches have duplicated code

#flto is not working currently with linux
set(RELEASE_COMPILER_FLAGS_GCC_CLANG "-O3;-Ofast;-DNDEBUG;-march=native;-ftree-vectorize" CACHE STRING ""
                                                                                                FORCE
)

set(DEBUG_COMPILER_FLAGS_MSVC
    "/W4;/w14242;/w14254;/w14263;/w14265;/w14287;/we4289;/w14296;/w14311;/w14545;/w14546;/w14547;/w14549;/w14555;/w14619;/w14640;/w14826;/w14905;/w14906;/w14928;/permissive-;/wd4068;/wd4505;/wd4800;/wd4275"
    CACHE STRING "" FORCE
)
#             /WX     # Werror
#             /W4     # Baseline reasonable warnings
#             /w14242 # 'identifier': conversion from 'type1' to 'type1', possible loss of data
#             /w14254 # 'operator': conversion from 'type1:field_bits' to 'type2:field_bits', possible loss of data
#             /w14263 # 'function': member function does not override any base class virtual member function
#             /w14265 # 'classname': class has virtual functions, but destructor is not virtual instances of this class may not be destructed correctly
#             /w14287 # 'operator': unsigned/negative constant mismatch
#             /we4289 # nonstandard extension used: 'variable': loop control variable declared in the for-loop is used outside the for-loop scope
#             /w14296 # 'operator': expression is always 'boolean_value'
#             /w14311 # 'variable': pointer truncation from 'type1' to 'type2'
#             /w14545 # expression before comma evaluates to a function which is missing an argument list
#             /w14546 # function call before comma missing argument list
#             /w14547 # 'operator': operator before comma has no effect; expected operator with side-effect
#             /w14549 # 'operator': operator before comma has no effect; did you intend 'operator'?
#             /w14555 # expression has no effect; expected expression with side- effect
#             /w14619 # pragma warning: there is no warning number 'number'
#             /w14640 # Enable warning on thread un-safe static member initialization
#             /w14826 # Conversion from 'type1' to 'type_2' is sign-extended. This may cause unexpected runtime behavior.
#             /w14905 # wide string literal cast to 'LPSTR'
#             /w14906 # string literal cast to 'LPWSTR'
#             /w14928 # illegal copy-initialization; more than one user-defined conversion has been implicitly applied
#             /permissive- # standards conformance mode

#             # Disables, remove when appropriate
#             /wd4068 # disable warnings about unknown pragmas (e.g. #pragma GCC)
#             /wd4505 # disable warnings about unused functions that might be platform-specific
#             /wd4800 # disable warnings regarding implicit conversions to bool
#             /wd4275 # disable warnings about exporting non DLL-interface classes
set(RELEASE_COMPILER_FLAGS_MSVC "/O2;/Oi;/DNDEBUG;/Ob2;/GF;/GT;/Gy;/GL" CACHE STRING "" FORCE)
##############################################
#the externall library that you want from github whitout using package manager (vcpkg)
# add the repo here in seprate string "[1]" "[2]"
set(REP_URLS "https://github.com/erincatto/box2d.git" CACHE STRING "" FORCE)
#the branch that you want for each repo "[1]" "[2]"
set(REP_BRANCH "main" CACHE STRING "" FORCE)
#the lib linkage vars "sfml:window;sfml:main;..."
set(LIB_LINKAGE_VAR "box2d" CACHE STRING "" FORCE)
##############################################
#the externall library that you want from vcpkg
#the pakage_link_var that you want for each pakage_list
set(PAKAGE_LINK_VAR_LIST # "box2d::box2d;raylib"
    "raylib" CACHE STRING "" FORCE
)
##############################################
#chose between g++/clang++ or MSVC
# set(CPPCOMPILER "g++" CACHE STRING "" FORCE)
# set(CPPCOMPILER "MSVC" CACHE STRING "" FORCE)
set(CPPCOMPILER "clang++" CACHE STRING "")
##############################################
#the internal library usage setting (MYLIBNAME)
#internal library activiating
set(INTERNAL_MYLIB_USAGE ON CACHE BOOL "")
#your Library name
set(MYLIBNAME "${SULOTIONNAME}_LIB" CACHE STRING "" FORCE)
#you should provide extern "C" __declspec(dllexport/dllimport) For SHARED build in source code of each functions in .hpp
# It can be STATIC or SHARED
set(MYLIB_TYPE "STATIC" CACHE STRING "")
#you should provide wnmain function for hiding the console
#if it is a console app just let it be to ON
# It can be ON or OFF if you want win only set it to false and provide winmain entry point
set(SHOW_CONSOLE ON CACHE BOOL "" FORCE)
##############################################
set(STATIC_ANALYZER ON CACHE BOOL "")
##############################################
# this enable asan ,ubsan,
set(ENABLE_SANITIZER ON CACHE BOOL "")
# set(CLANG_SANITIZER_PATH "C:/Program Files/LLVM/lib/clang/17/lib/windows" CACHE STRING "" FORCE)
set(SANITIZERS "-address,-undefined,-memory,-pointer-compare,-pointer-subtract;")
# set(SANITIZERS "address,undefined" CACHE STRING "")
##############################################
set(ENABLE_WARNING ON CACHE BOOL "")
##############################################
set(ENABLE_UNITYBUILD ON CACHE BOOL "")
##############################################
set(ENABLE_TESTING ON CACHE BOOL "")
##############################################
# set(CMAKE_TOOLCHAIN_FILE "F:/VcPakage/vcpkg/scripts/buildsystems/vcpkg.cmake" CACHE STRING "" FORCE)
set(CMAKE_TOOLCHAIN_FILE "/home/alireza/Apps/vcpkg-2024.09.30/scripts/buildsystems/vcpkg.cmake"
    CACHE STRING "" FORCE
)
##############################################
set(ENABLE_PACKAGING ON CACHE BOOL "")
set(DISCRIPTION "MyProject - A brief description" CACHE STRING "")
set(VENDOR "YOUR COMPANY" CACHE STRING "")
set(SUPPORTMAIL "support@mycompany.com" CACHE STRING "")
##############################################
set(ENABLE_BENCHMARK "1" CACHE STRING "")
# Make sure CMake prefers static libraries
# A triplet specifies the following:
#     Architecture: e.g., x64 or x86
#     Platform: e.g., windows, linux, osx
#     Linkage: either static or nothing(dynamic) (for static or shared libraries)
# The triplet format is typically <architecture>-<platform>-<linkage>
# set(VCPKG_TARGET_TRIPLET "x64-windows-static" CACHE STRING "")
# set(VCPKG_TARGET_TRIPLET "x64-windows")
##############################################
