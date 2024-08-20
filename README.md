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
      (if you want safty in your code you can turn WALL=TRUE in build.bat)
      (the default build setting is on debug mode but you can change it to 
      release in build.bat . or run release.bat after build.bat)
### sample folder is for your application.exe that means all srcs and includes in that is for *.exe project
### source/src folder is for your library.lib that means all srcs and includes in that is for *.lib project
### you can write all the headers you want to precompile in pch.h in source/include/pch
