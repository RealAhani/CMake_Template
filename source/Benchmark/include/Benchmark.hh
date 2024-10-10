#pragma once
#include "../src/ProfileLoger.hh"

#ifdef NDEBUG //this is release mode
#define BENCHMARK_FUNC() ;
#define PROFILE_ALL()    ;
#define PROFILE_SCOPE()  ;
#else //this is debug mode
#define PROFILE_ALL()        BENCHMARK_FUNC(__FUNCTION__)
#define PROFILE_SCOPE(NAME)  BENCHMARK_FUNC(NAME)
#define BENCHMARK_FUNC(NAME) AP::ProfileLoger timer##__LINE__(NAME);
#endif
