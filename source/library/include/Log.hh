/*
 * Copyright (C) 2024 RealAhani - All Rights Reserved
 * You may use, distribute and modify this code under the
 * terms of the MIT license, which unfortunately won't be
 * written for another century.
 * You should have received a copy of the MIT license with
 * this file.
 */

#pragma once
// Some place holder code

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