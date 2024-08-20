##############################################
include(${CMAKE_HOME_DIRECTORY}/os.cmake)
# DONT TOUCH THESE 4 BLOW OS NAMES VARIABLES
set(MYOS     "none")
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

# you can set your specific compiler flag on the choosen compiler you select on perivious variable
# add or remove wanted flags but not comment the line you dont want all 3 variable is needed
set(DEBUG_COMPILER_FLAGS_GCC_CLANG "-g;-Wall;-Wextra;-Wpedantic;-Wshadow;-Wconversion;")
set(DEBUG_COMPILER_FLAGS_MSVC "/W4;/WERROR")
set(RELEASE_COMPILER_FLAGS "-O3;-Ofast;-DNDEBUG;-march=native;-fpic;-ftree-vectorize;")
##############################################
OSDISTRO(MYOS)