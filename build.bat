rm -r build2
mkdir build2
cd build2

@REM if you want safty please turn WALL=TRUE                                 e.x(-DWALL=TRUE)
@REM if you want to build it with makefiles and gcc on windows uncomment the blew code
@REM cmake -S .. -B . -G"MinGW Makefiles" -DWALL=TRUE

@REM if you want safty please turn WALL=TRUE                                 e.x(-DWALL=TRUE)
@REM if you want to build it with visual studio and msvc++ on windows uncomment the blew code
@REM -G can be "Visual Studio 17 2022" Or "Ninja" Or "Unix Makefiles" Or ...

@REM for Ninja generator use CMAKE_BUILD_TYPE Debug/Release 
@REM Ninja Multi-Config
cmake -S .. -B . -G"Ninja Multi-Config" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON --fresh
cmake --build . --config=Debug --parallel 12

@REM -A is just for vs and xcode
@REM -G"Visual Studio 17 2022" -A win32
@REM -G"Visual Studio 17 2022" -A x64
@REM --parallel <number>/ -j: When used with a number (e.g., -j4), it instructs the build system to use 4 threads for parallel building. Without a number, it will typically use as many threads as there are CPU cores on your machine.
@REM --config Debug/Release just work with visual studio and xcode generator 
@REM cmake -S .. -B . -G"Visual Studio 17 2022" -A x64 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON --fresh
@REM cmake --build .  --parallel 12
@REM #REM -G can be "Ninja" Or "Unix Makefiles" Or ...
@REM cmake -S .. -B . -G"Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON  --fresh
@REM cmake --build . --parallel 8