#pragma once
//Benchmark is ON
#if (PROFILER == 1)
#define PROFILE()           BENCHMARK(__FUNCTION__)
#define PROFILE_SCOPE(NAME) BENCHMARK(NAME)
#define BENCHMARK(NAME)     Profiler::BenchMark profile##__LINE__(NAME);
#else //Benchmark is OFF
#define PROFILE()           ;
#define PROFILE_SCOPE(NAME) ;
#endif // !PPP