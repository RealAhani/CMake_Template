rm -r build
mkdir build 
cd build

# if you want safty please turn WALL=TRUE                                 e.x(-DWALL=TRUE)
# if you want to build it with makefiles and gcc on windows uncomment the blew code
cmake -S .. -B . -G"MinGW Makefiles" -DWALL=TRUE

# if you want safty please turn WALL=TRUE                                 e.x(-DWALL=TRUE)
# if you want to build it with visual studio and msvc++ on windows uncomment the blew code
# cmake -S .. -B . -G"Visual Studio 17 2022" -DWALL=FALSE
cmake --build . --config=Debug