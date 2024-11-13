#ifndef PCH_HH
#define PCH_HH

// c++
#include <chrono>
#include <string>
#include <iostream>
#include <fstream>
#include <mutex>
#include <algorithm>
#include <map>
#include <thread>

// project generated
#include "Benchmark.hh"
#include "config.hh"

//box2d
#include <box2d/box2d.h>
#include <box2d/types.h>
#include <box2d/base.h>
#include <box2d/math_functions.h>
#include <box2d/id.h>
#include <box2d/collision.h>


//raylib
#include <raylib.h>
#include <raymath.h>

#endif //PCH_HH