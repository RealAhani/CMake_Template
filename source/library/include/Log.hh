// "Copyright 2024 RealAhani"

#pragma once
// #include "osconfig.h"
// #if (OS == 1)
// #ifdef MYLIB_EXPORTS
// #define MYLIB_API __declspec(dllexport)
// #else
// #define MYLIB_API __declspec(dllimport)
// #endif
// #else
// #define MYLIB_API
// #endif
namespace mloge
{

/*extern "C" MYLIB_API*/ void print(std::string const & str);
int                           myfirsttest(int id);
}  // namespace mloge