# A Template to start a Cmake/C++ project

# Windows and linux are now supported
### cmake ,Ninja ,ccache ,clang-tidy ,cppcheck , cmake-format ,and a compiler like clang++/msvc-cl are should be installed and added to your system path env

## this template support clang++ , msvc and c++23 
clang is prefered and work with vs code
msvc generation project is work but for build the codes you should build within the Vs 22 IDE

## the configuration can be customized through the config.cmake or cmakepresets.json 
## if you want to use any open source library as dependencies you can add it to the config.cmake variables 

    (1. add git repo links to REP_URLS)
    (2. add git branch that you want to REP_BRANCH the order of indexes are important)
    (3. add the library linkage name to LIB_LINKAGE_VAR for linking to your exe)

### 1.Edit config.cmake for (Naming Convention , Project Setting , Versioning , Compiler Flag , C++ Standard , and more ... )

### 2.write your translation units in relevent src directory ( as .cc or .cpp )

### 3.if you dont want to use cmake presets you can use build.bat (cmake prests is preferred)

      (in Debug  Safe build all warings,sanitizer,static analyzes(cppcheck, clang-tidy) are enabled for each compiler defienitions)
      (for Release build warning are turn off and optimizations for compile and link time are enabled)
      (Static Analyzers and sanitizer are do increase the build time (not on msvc) ... and have some runtime overhead)

#### sample folder is for your application.exe that means all srcs and includes in that folder are for .exe
#### library folder is for your Name.lib that means all srcs and includes in that folder are for *.lib 
    (you can chose between static and shared lib)
    (or turn off the whole library folder effect within config.cmake (INTERNAL_MYLIB_USAGE OFF) or use preset Nolib)
#### you can write all the headers you want to precompile in pch.hh in library/include/pch
