#include "Log.hpp"
#include "osconfig.h"


int main([[maybe_unused]] int argc, [[maybe_unused]] char* argv[])
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
}

// #include <windows.h>
// int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
// {
//     MessageBox(nullptr, "Hello, World!", "My First WinMain", MB_OK);

//     return 0;
// }