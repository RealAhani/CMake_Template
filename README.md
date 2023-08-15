# A Template for start a Cmake/C++ project 
## 1.Edit config.cmake for naming convention and project setting
## 2.write your translation units in relevent src_files.cmake
## 3.just run build.bat to build your project(you can edit the .bat files for your needs)
      (if you want safty in your code you can turn WALL=TRUE in build.bat)
      (the default build setting is on debug mode but you can change it to 
      release in build.bat or run release.bat after build.bat)
### sample folder is for your application.exe that mean all src and includes in that is for .exe project
### source/src folder is for your library.lib that mean all src and includes in that is for .lib project
### you can put all the headers you want to precompile in pch.h in source/include/pch