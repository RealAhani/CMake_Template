# A Template to start a Cmake/C++ project

# Windows

- Run build.bat

# Linux/Mac

- for linux shell terminal ===> bash ./build.sh
- Run build.sh
  (edit the build.sh for xcode or unix make file based on you os)

## this template support g++, clang++ , msvc and c++23

### 0.install (cmake ,Ninja ,ccache ,clang-tidy ,cppcheck ,and a compiler like clang++/g++)

### 1.Edit config.cmake for (Naming Convention , Project Setting , Versioning , Compiler Flag ,C++ Standard )

### 2.write your translation units in relevent src_files.cmake or add \*.cpp / \*.hpp (don`t use .h)

### 3.just run build.bat/sh to build your project(you can edit the .bat files to your needs)

      (the build type setting can be change through -DCMAKE_BUILD_TYPE=Debug OR Release in build.bat/sh  Dont use --config=Debug)
      (in Debug build all warings is enabled for each compiler defiend)
      (for Release build warning are turn off and optimization for compile and link time are enabled)
      (Cpp_check and clang-tidy can be enable by config.cmake stati_analyzer ON/OFF  )
      (Static Analyzers do increase the build time (not on msvc) ... )

#### sample folder is for your application.exe that means all srcs and includes in that is for \*.exe project

#### source/src folder is for your library.lib that means all srcs and includes in that is for \*.lib project

#### you can write all the headers you want to precompile in pch.h in source/include/pch
