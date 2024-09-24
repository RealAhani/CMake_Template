rm -r build
mkdir build 
cd build

@REM if you want safty please turn WALL=TRUE                                 e.x(-DWALL=TRUE)
@REM if you want to build it with makefiles and gcc on windows uncomment the blew code
@REM cmake -S .. -B . -G"MinGW Makefiles" -DWALL=TRUE

@REM if you want safty please turn WALL=TRUE                                 e.x(-DWALL=TRUE)
@REM if you want to build it with visual studio and msvc++ on windows uncomment the blew code
@REM -G can be "Visual Studio 17 2022" Or "Ninja" Or "Unix Makefiles" Or ...
cmake -S .. -B . -G"Ninja" -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DMYDEBUG_SETTING=ON -DSTATIC_ANALYZERS=ON -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
@REM -j: When used with a number (e.g., -j4), it instructs the build system to use 4 threads for parallel building. Without a number, it will typically use as many threads as there are CPU cores on your machine.
cmake --build . -j