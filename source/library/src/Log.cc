#include "Log.hh"
#include "Benchmark.hh"
namespace mloge
{
void print(const std::string& str)
{
    PROFILE_ALL();
    {
        PROFILE_SCOPE("TEST");
    }
    std::cout << str << '\n';
}

int myfirsttest(int id)
{
    return id;
}
} // namespace mloge
