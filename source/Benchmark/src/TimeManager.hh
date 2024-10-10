#pragma once
#include <chrono>
namespace AP
{

class TimerManager
{
    using mili        = std::chrono::milliseconds;
    using timepoint   = std::chrono::steady_clock::time_point;
    using steadyclock = std::chrono::steady_clock;

public:
    TimerManager()                                      = default;
    ~TimerManager()                                     = default;
    TimerManager(const TimerManager& timer)             = delete;
    TimerManager(const TimerManager&& timer)            = delete;
    TimerManager& operator=(const TimerManager& other)  = delete;
    TimerManager& operator=(const TimerManager&& other) = delete;

    float GetTimeSec()
    {
        Calculate_DeltaTime();
        return static_cast<float>(m_deltatime.count()) / 1000.f;
    }

    void Start_Time()
    {
        Reset_Time();
        m_starttime = steadyclock::now();
    }
    void End_Time()
    {
        m_endtime = steadyclock::now();
    }

private:
    timepoint m_starttime = {};
    timepoint m_endtime   = {};
    mili      m_deltatime = {};

    void Calculate_DeltaTime()
    {
        using namespace std::chrono;
        m_deltatime = duration_cast<mili>(m_endtime - m_starttime);
    }
    void Reset_Time()
    {
        m_starttime = {};
        m_endtime   = {};
    }
};

} // namespace AP