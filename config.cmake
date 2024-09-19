##############################################
include(${CMAKE_HOME_DIRECTORY}/os.cmake)
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
set(CPPVERSION 20)
set(CPPEXTENTION ON)
set(CPPSTANDARDREQ ON)

##############################################
#DONT CHANGE BUILD TYPE FROM THIS VAR INSTEAD USE -DMYDEBUG_SETTING FROM TERMINAL

#it is very usefull with Ninja Or make -G but maybe can be used with msvc
set(BUILD_TYPE "")
# set(BUILD_TYPE "Debug")
# set(BUILD_TYPE "Release")
##TODO:N1 ADD THIS Bleo var setting in building type they are not working here ==>goto TODO:N1 for more info
# set(BUILD_TYPE "RelWithDebInfo")
# set(BUILD_TYPE "MinSizeRel")

#DONT CHANGE BUILD TYPE FROM THIS VAR INSTEAD USE -DMYDEBUG_SETTING FROM TERMINAL

##############################################

# you can set your specific compiler flag on the choosen compiler you select on perivious variable
# add or remove wanted flags but not comment the line you dont want all 3 variable is needed

set(DEBUG_COMPILER_FLAGS_GCC_CLANG   "-g;-Wall;-Wextra;-Wpedantic;-Wshadow;-Wconversion;")
set(RELEASE_COMPILER_FLAGS_GCC_CLANG "-O3;-Ofast;-DNDEBUG;-flto;-march=native;-ftree-vectorize;")

set(DEBUG_COMPILER_FLAGS_MSVC        "/W4;")
set(RELEASE_COMPILER_FLAGS_MSVC      "")
##############################################
OSDISTRO(MYOS)