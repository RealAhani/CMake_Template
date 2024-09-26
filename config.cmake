##############################################
include(${CMAKE_HOME_DIRECTORY}/os.cmake)
include(${CMAKE_HOME_DIRECTORY}/LibsConfig.cmake)
# DONT TOUCH THESE 4 BLOW OS NAMES VARIABLES
set(MYOS     "NONE_VALID")
set(WINDOWS  "WIN")
set(LINUXOS  "LINUX")
set(MACOS    "MAC")
##############################################
#your Solution name
set(SULOTIONNAME "NAME")
#your Project Versioning numbers
set(PRVERSION_MAJOR "0")
set(PRVERSION_MINOR "0")
set(PRVERSION_PATCH "1")
set(PRVERSION "${PRVERSION_MAJOR}.${PRVERSION_MINOR}.${PRVERSION_PATCH}")
#your project name
set(PRNAME ${SULOTIONNAME}${PRVERSION})
#your Library name
set(MYLIBNAME "${SULOTIONNAME}_LIB")
#your project language
set(PRLANG "CXX")
#your exe name
set(PREXENAME "${SULOTIONNAME}_EXE")
##############################################
#chose between g++/clang++ or MSVC
# set(CPPCOMPILER "g++")
# set(CPPCOMPILER "MSVC")
set(CPPCOMPILER "clang++")
##############################################
#your cpp standard version you want to use in this project
set(CPPVERSION 23)
set(CPPEXTENTION ON)
set(CPPSTANDARDREQ ON)
##############################################
set(STATIC_ANALYZER OFF)
##############################################

# you can set your specific compiler flag on the choosen compiler you select on perivious variable
# add or remove wanted flags but not comment the line you dont want all 3 variable is needed

set(DEBUG_COMPILER_FLAGS_GCC_CLANG   "-Wall;-Wextra;-Wpedantic;-Wshadow;-Wconversion;-Wnon-virtual-dtor;-Wcast-align;-Wunused;-Woverloaded-virtual;-Wsign-conversion;-Wdouble-promotion;-Wformat=2;-Wimplicit-fallthrough;-Wsuggest-override;-Wnull-dereference;-Wold-style-cast;")
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
set(DEBUG_COMPILER_EXTRA_FLAGS_GCC "-Wmisleading-indentation;-Wduplicated-cond;-Wlogical-op;")
#             -Wmisleading-indentation # warn if indentation implies blocks where blocks do not exist
#             -Wduplicated-cond # warn if if / else chain has duplicated conditions
#             -Wlogical-op # warn about logical operations being used where bitwise were probably wanted
#             # -Wuseless-cast # warn if you perform a cast to the same type (disabled because it is not portable as some type aliases might vary between platforms)
#             $<$<VERSION_GREATER_EQUAL:${CMAKE_CXX_COMPILER_VERSION},8.1>:-Wduplicated-branches> # warn if if / else branches have duplicated code

set(RELEASE_COMPILER_FLAGS_GCC_CLANG "-O3;-Ofast;-DNDEBUG;-flto;-march=native;-ftree-vectorize;")

set(DEBUG_COMPILER_FLAGS_MSVC        "/WX;/W4;/w14242;/w14254;/w14263;/w14265;/w14287;/we4289;/w14296;/w14311;/w14545;/w14546;/w14547;/w14549;/w14555;/w14619;/w14640;/w14826;/w14905;/w14906;/w14928;/permissive-;/wd4068;/wd4505;/wd4800;/wd4275;")
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
set(RELEASE_COMPILER_FLAGS_MSVC      "/O2;/Oi;/DNDEBUG;/Ob2;/GF;/GT;/Gy;/GL;")
##############################################
set(REP_URLS "https://github.com/google/googletest.git"
             "https://github.com/SFML/SFML.git"
             # add more repo here
             )
set(REP_BRANCH "main" "2.6.x")
set(LIB_LINKAGE_VAR "sfml-graphics;sfml-window;sfml-system;")
##############################################
OSDISTRO(MYOS)
fetch_repositories()