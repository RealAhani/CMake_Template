cd build
@REM -j: When used with a number (e.g., -j4), it instructs the build system to use 4 threads for parallel building. Without a number, it will typically use as many threads as there are CPU cores on your machine.
cmake --build . -j 