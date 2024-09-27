rm -rf build
mkdir build
cd build

# if you want safty please turn WALL=TRUE                                 e.x(-DWALL=TRUE)
# if you want to build it with makefiles and gcc uncomment the blew code

#REM -G can be "Ninja" Or "Unix Makefiles" Or ...
cmake -S .. -B . -G"Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON  --fresh
cmake --build . --parallel 8