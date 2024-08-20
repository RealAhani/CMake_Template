rm -rf build
mkdir build
cd build

# if you want safty please turn WALL=TRUE                                 e.x(-DWALL=TRUE)
# if you want to build it with makefiles and gcc uncomment the blew code
cmake -S .. -B . -G"Unix Makefiles" -DMYDEBUG_SETTING=TRUE -DCMAKE_EXPORT_COMPILE_COMMANDS=ON 

# if you want to build it with Xcode uncomment the blew code
# cmake -S .. -B . -G"Xcode" -DWALL=FALSE

# if you want safty please turn WALL=TRUE                                 e.x(-DWALL=TRUE)
# if you want to build it with visual studio and msvc++ on windows uncomment the blew code
# cmake -S .. -B . -G"Visual Studio 17 2022" -DWALL=FALSE
cmake --build . --config=Debug