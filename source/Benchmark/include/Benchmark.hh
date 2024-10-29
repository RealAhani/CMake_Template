#pragma once

//this is debug mode
#ifndef NDEBUG
#define PROFILE()           BENCHMARK(__FUNCTION__)
#define PROFILE_SCOPE(NAME) BENCHMARK(NAME)
#define BENCHMARK(NAME)     Profiler::BenchMark profile##__LINE__(NAME);
#else //this is release mode
#define PROFILE()           ;
#define PROFILE_SCOPE(NAME) ;
#endif // !NDEBUG

namespace Profiler
{
class Timer
{
    using micro       = std::chrono::microseconds;
    using steadyclock = std::chrono::steady_clock;

    Timer(const Timer& timer)             = delete;
    Timer(const Timer&& timer)            = delete;
    Timer& operator=(const Timer& other)  = delete;
    Timer& operator=(const Timer&& other) = delete;

public:
    using timepoint = std::chrono::steady_clock::time_point;
    Timer()         = default;
    ~Timer()        = default;

    [[nodiscard]] long long Get_DeltaTime_MicroSec() noexcept
    {
        using namespace std::chrono;
        return duration_cast<micro>(m_endTime - m_startTime).count();
    }

    [[maybe_unused]] long long Start_Timer() noexcept
    {
        Reset_Timer();
        m_startTime = steadyclock::now();
        return m_startTime.time_since_epoch().count();
    }

    [[maybe_unused]] long long End_Timer() noexcept
    {
        m_endTime = steadyclock::now();
        return m_endTime.time_since_epoch().count();
    }

private:
    timepoint m_startTime = {};
    timepoint m_endTime   = {};

    void Reset_Timer() noexcept
    {
        m_startTime = {};
        m_endTime   = {};
    }
};

struct Benchmark_Data
{
    std::string m_name      = {};
    long long   m_duration  = {};
    long long   m_startTime = {};
    std::size_t threadID    = {};
};

class FileHandle
{
public:
    static void Write_BenchMark(const Benchmark_Data& data) noexcept
    {
        FileHandle::Make_Instance().Write_Info(data);
    }

private:
    FileHandle(FileHandle&&)                 = delete;
    FileHandle(const FileHandle&)            = delete;
    FileHandle& operator=(FileHandle&&)      = delete;
    FileHandle& operator=(const FileHandle&) = delete;
    FileHandle() noexcept
    {
        m_fileStream = std::ofstream(s_outFileName);
        Write_Header();
    }
    ~FileHandle() noexcept
    {
        Write_Footer();
    }
    void Write_Header() noexcept
    {
        m_fileStream << "{\"otherData\": {},\"traceEvents\":[";
    }
    void Write_Footer() noexcept
    {
        m_fileStream << "]}";
    }
    void Write_Info(const Benchmark_Data& data) noexcept
    {
        std::lock_guard<std::mutex> lock(m_lock);
        if (m_counter++ > 0) [[likely]]
        {
            m_fileStream << ",";
        }
        m_fileStream << "\n{";
        m_fileStream << "\"cat\":\"function\",";
        m_fileStream << "\"dur\":" << data.m_duration << ',';
        m_fileStream << "\"name\":\"" << data.m_name << "\",";
        m_fileStream << "\"ph\":\"X\",";
        m_fileStream << "\"pid\":0,";
        m_fileStream << "\"tid\":" << data.threadID << ',';
        m_fileStream << "\"ts\":" << data.m_startTime;
        m_fileStream << "}";
    }
    static FileHandle& Make_Instance() noexcept
    {
        static FileHandle instance{};
        return instance;
    }

private:
    static inline const std::string s_outFileName = {std::string_literals::operator""s("BenchMark.json", 14)};
    std::ofstream                   m_fileStream  = {};
    std::mutex                      m_lock        = {};
    size_t                          m_counter     = {};
};


class BenchMark
{
public:
    explicit BenchMark(const std::string& name) noexcept
    {
        m_data.m_name      = name;
        m_data.m_duration  = 0;
        m_data.m_startTime = m_timer.Start_Timer();
        m_data.threadID    = std::hash<std::thread::id>{}(std::this_thread::get_id());
    }
    ~BenchMark() noexcept
    {
        m_timer.End_Timer();
        m_data.m_duration = m_timer.Get_DeltaTime_MicroSec();
        FileHandle::Write_BenchMark(m_data);
    }

private:
    BenchMark()                            = delete;
    BenchMark(BenchMark&&)                 = delete;
    BenchMark(const BenchMark&)            = delete;
    BenchMark& operator=(BenchMark&&)      = delete;
    BenchMark& operator=(const BenchMark&) = delete;

    Timer          m_timer = {};
    Benchmark_Data m_data  = {};
};
} // namespace Profiler