##############################################
include(${CMAKE_HOME_DIRECTORY}/os.cmake)
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
#your cpp standard version you want to use in this project
set(CPPVERSION 20)
set(CPPEXTENTION OFF)
set(CPPSTANDARDREQ ON)

#chode between g++ or MSVC
set(CPPCOMPILER "g++")
# set(CPPCOMPILER "MSVC")
##############################################
OSDISTRO(MYOS)