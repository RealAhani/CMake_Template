// "Copyright 2024 Realahani"


int main([[maybe_unused]] int argc, [[maybe_unused]] char* argv[])
{
    // benchmark
    // PROFILE();
    // if u use internal lib

    // project information
#if (OS == 1)                       // current OS is Windwos
    mloge::print("WIN");
#elif (OS == 2)                     // current OS is Linux
    mloge::print("LINUX");
#elif (OS == 3)                     // current OS is MacOS
    mloge::print("MAC");
#endif
    mloge::print(PROJECT_NAME);     // project name
    mloge::print(CPP_VERSION);      // cpp version
    mloge::print(PROJECT_VERSION);  // projecet version
    // project information

    // raylib window init
    InitWindow(0, 0, "Test");
    // #if (OS == 1)
    // ToggleBorderlessWindowed();
    ToggleFullscreen();
    // #endif

    [[maybe_unused]]
    int const width  = {GetScreenWidth()};
    int const height = {GetScreenHeight()};
    bool      isQuit = {false};

    // physics values for box2d
    float const squerWidth  = {50.f};
    float const squerHeight = {50.f};
    float const squerX      = {800.f};
    float const squerY      = {(height / 2.f) - 500.f};
    float const rectWidth   = {5000.f};
    float const rectHeight  = {50.f};
    float const rectX       = {0.f};
    float const rectY       = {(height / 2.f)};
    float const rectDec     = {10.f};

    // creating the box2d init for the world of the game
    b2WorldDef   worldDef = {b2DefaultWorldDef()};
    b2Vec2 const gravity  = {-5.f, -10.f};
    worldDef.gravity      = gravity;
    b2WorldId worldID     = {b2CreateWorld(&worldDef)};
    worldDef.enableSleep  = false;

    // creatig a ground
    b2BodyDef groundDef = {b2DefaultBodyDef()};
    groundDef.position  = b2Vec2 {-rectX, -rectY};
    groundDef.type      = b2_staticBody;
    groundDef.rotation  = b2MakeRot(rectDec * DEG2RAD);

    b2BodyId const groundBodyId = {b2CreateBody(worldID, &groundDef)};
    b2Polygon const groundShape = {
        b2MakeBox(rectWidth / 2.f, rectHeight / 2.f)};
    b2ShapeDef groundShapeDef = {b2DefaultShapeDef()};
    // mass is not need for static object
    groundShapeDef.friction    = 0.3f;
    groundShapeDef.restitution = 0.7f;
    b2CreatePolygonShape(groundBodyId, &groundShapeDef, &groundShape);

    // ground 2
    b2BodyDef groundDef2 = {b2DefaultBodyDef()};
    groundDef2.position  = b2Vec2 {-(rectX + 1400), -(rectY - 300)};
    groundDef2.type      = b2_staticBody;
    groundDef2.rotation  = b2MakeRot(75.f * DEG2RAD);

    b2BodyId const groundBodyId2 = {b2CreateBody(worldID, &groundDef2)};
    b2Polygon const groundShape2 = {
        b2MakeBox(rectWidth / 2.f, rectHeight / 2.f)};
    b2ShapeDef groundShapeDef2 = {b2DefaultShapeDef()};
    // mass is not need for static object
    groundShapeDef2.friction    = 0.3f;
    groundShapeDef2.restitution = 0.7f;
    b2CreatePolygonShape(groundBodyId2, &groundShapeDef2, &groundShape2);

    // create a dynamic box
    b2BodyDef boxDef = {b2DefaultBodyDef()};
    boxDef.position  = b2Vec2 {-squerX, -squerY};
    boxDef.type      = b2_dynamicBody;
    boxDef.rotation  = b2MakeRot(30.f * DEG2RAD);

    b2BodyId const  boxBodyId = {b2CreateBody(worldID, &boxDef)};
    b2Polygon const boxShape  = {
        b2MakeBox(squerWidth / 2.f, squerHeight / 2.f)};
    b2ShapeDef boxShapeDef = {b2DefaultShapeDef()};
    boxShapeDef.density    = 1.f;
    boxShapeDef.friction   = 0.7f;
    b2CreatePolygonShape(boxBodyId, &boxShapeDef, &boxShape);

    // simulating setting
    SetTargetFPS(GetMonitorRefreshRate(0));
    float const  timeStep     = {1.f / 15.f};  // 60HZ
    int8_t const subStepCount = {3};

    // game loop
    while (!WindowShouldClose() && !isQuit)
    {
        // input managment
        if (IsKeyPressed(KEY_ESCAPE)) [[unlikely]]
        {
            isQuit = true;
        }
        // update world state
        b2World_Step(worldID, timeStep, subStepCount);

        // rendering
        ClearBackground(BLACK);
        BeginDrawing();
        DrawFPS(0, 10);
        b2Vec2 const boxPos {b2Body_GetPosition(boxBodyId)};
        b2Vec2 const groundPos {b2Body_GetPosition(groundBodyId)};
        b2Vec2 const groundPos2 {b2Body_GetPosition(groundBodyId2)};

        // draw box
        DrawRectanglePro(Rectangle {.x      = -boxPos.x,
                                    .y      = -boxPos.y,
                                    .width  = squerWidth,
                                    .height = squerHeight},
                         Vector2 {.x = (squerWidth / 2.f),
                                  .y = (squerHeight / 2.f)},
                         b2Rot_GetAngle(b2Body_GetRotation(boxBodyId)) *
                             RAD2DEG,
                         RED);

        // draw straight ground
        DrawRectanglePro(Rectangle {.x      = -groundPos.x,
                                    .y      = -groundPos.y,
                                    .width  = rectWidth,
                                    .height = rectHeight},
                         Vector2 {.x = (rectWidth / 2),
                                  .y = (rectHeight / 2)},
                         b2Rot_GetAngle(b2Body_GetRotation(groundBodyId)) *
                             RAD2DEG,
                         GREEN);

        // draw rotated ground
        DrawRectanglePro(Rectangle {.x      = -groundPos2.x,
                                    .y      = -groundPos2.y,
                                    .width  = rectWidth,
                                    .height = rectHeight},
                         Vector2 {.x = (rectWidth / 2),
                                  .y = (rectHeight / 2)},
                         b2Rot_GetAngle(b2Body_GetRotation(groundBodyId2)) *
                             RAD2DEG,
                         GREEN);

        EndDrawing();
    }
    // clear out all
    b2DestroyWorld(worldID);
    worldID = b2_nullWorldId;
    CloseWindow();
    return 0;
}

// if it is a window app and need WinMain
// #include <windows.h>
// int WINAPI WinMain(HINSTANCE hInstance,
//                    HINSTANCE hPrevInstance,
//                    LPSTR     lpCmdLine,
//                    int       nCmdShow)
// {
//     MessageBox(nullptr, "Hello, World!", "My First WinMain", MB_OK);

//     return 0;
// }
