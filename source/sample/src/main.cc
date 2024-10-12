#include "Log.hh"
#include "osconfig.h"
// if u dont use inner library use iostream
// #include <iostream>

int main([[maybe_unused]] int argc, [[maybe_unused]] char* argv[])
{
    PROFILE();
    const char* str[2]{"sdf", "sdfsdfs"};
    std::cout << str[32];
//if u use internal lib
#if (OS == 1)
    mloge::print("WIN");
#elif (OS == 2)
    mloge::print("LINUX");
#elif (OS == 3)
    mloge::print("MAC");
#endif
    mloge::print("Hello_World");
    // std::cin.get();
    // if u DONT use internal lib
    // #if (OS == 1)
    //     std::cout << ("WIN");
    // #elif (OS == 2)
    //     std::cout << ("LINUX");
    // #elif (OS == 3)
    //     std::cout << ("MAC");
    // #endif
    std::cin.get();
    return 0;
}

//if it is a window app and need WinMain
// #include <windows.h>
// int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
// {
//     MessageBox(nullptr, "Hello, World!", "My First WinMain", MB_OK);

//     return 0;
// }