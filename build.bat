rm -r build
mkdir build 
cd build

@REM if you want safty please turn WALL=TRUE                                 e.x(-DWALL=TRUE)
@REM if you want to build it with makefiles and gcc on windows uncomment the blew code
@REM cmake -S .. -B . -G"MinGW Makefiles" -DWALL=TRUE

@REM if you want safty please turn WALL=TRUE                                 e.x(-DWALL=TRUE)
@REM if you want to build it with visual studio and msvc++ on windows uncomment the blew code
cmake -S .. -B . -G"Visual Studio 17 2022" -DMYDEBUG_SETTING=TRUE -DCMAKE_EXPORT_COMPILE_COMMANDS=ON 
cmake --build . --config=Debug