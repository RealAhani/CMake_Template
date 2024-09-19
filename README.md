# A Template to start a Cmake/C++ project 

# Windows
* Run build.bat
# Linux/Mac
* for linux shell terminal ===> bash ./build.sh
* Run build.sh 
      (edit the build.sh for xcode or unix make file based on you os)

## 1.Edit config.cmake for naming convention and project setting
## 2.write your translation units in relevent src_files.cmake
## 3.just run build.bat to build your project(you can edit the .bat files for your needs)
      (Wall and all warning is enable by defualt on Debug build type )
      (Cpp_check is enable by defualt)
      (the build type setting can be change through -DMY_DEBUG_SETTING=TRUE OR FALSE in build.bat/sh )
### sample folder is for your application.exe that means all srcs and includes in that is for *.exe project
### source/src folder is for your library.lib that means all srcs and includes in that is for *.lib project
### you can write all the headers you want to precompile in pch.h in source/include/pch
