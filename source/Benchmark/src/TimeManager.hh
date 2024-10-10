#pragma once
#include <chrono>
namespace AP
{

class TimerManager
{
    using micro        = std::chrono::microseconds;
    using steadyclock = std::chrono::steady_clock;

public:
    using timepoint                                     = std::chrono::steady_clock::time_point;
    TimerManager()                                      = default;
    ~TimerManager()                                     = default;
    TimerManager(const TimerManager& timer)             = delete;
    TimerManager(const TimerManager&& timer)            = delete;
    TimerManager& operator=(const TimerManager& other)  = delete;
    TimerManager& operator=(const TimerManager&& other) = delete;

    int64_t GetTimeSec()
    {
        Calculate_DeltaTime();
        return m_deltatime.count();
    }

    long long int Start_Time()
    {
        Reset_Time();
        m_starttime = steadyclock::now();
        return m_starttime.time_since_epoch().count();
    }

    long long int End_Time()
    {
        m_endtime = steadyclock::now();
        return m_endtime.time_since_epoch().count();
    }

private:
    timepoint m_starttime = {};
    timepoint m_endtime   = {};
    micro      m_deltatime = {};

    void Calculate_DeltaTime()
    {
        using namespace std::chrono;
        m_deltatime = duration_cast<micro>(m_endtime - m_starttime);
    }
    void Reset_Time()
    {
        m_starttime = {};
        m_endtime   = {};
    }
};

} // namespace AP