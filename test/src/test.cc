// "Copyright 2024 RealAhani"

#include "Log.hh"
#include <catch2/catch_test_macros.hpp>


TEST_CASE("first test", "[myfirsttest]")
{
    REQUIRE(mloge::myfirsttest(0) == 0);
    REQUIRE(mloge::myfirsttest(1) == 1);
    REQUIRE(mloge::myfirsttest(2) == 2);
    REQUIRE(mloge::myfirsttest(3) == 3);
    REQUIRE(mloge::myfirsttest(10) == 10);
}