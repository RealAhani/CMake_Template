#include "Log.hpp"
#include "osconfig.h"

int main(int argc, char *argv[])
{
#if (OS == 1)
    mloge::print("WIN");
#elif (OS == 2)
    mloge::print("LINUX");
#elif (OS == 3)
    mloge::print("MAC");
#endif
    mloge::print("Hello_World");
    std::cin.get();
    return 0;
}