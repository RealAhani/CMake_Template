// "Copyright 2024 RealAhani"

#pragma once

namespace Profiler
{
class Timer
{
    using micro       = std::chrono::microseconds;
    using steadyclock = std::chrono::steady_clock;

    Timer(Timer const & timer)              = delete;
    Timer(Timer const && timer)             = delete;
    Timer & operator=(Timer const & other)  = delete;
    Timer & operator=(Timer const && other) = delete;

public:

    using timepoint = std::chrono::steady_clock::time_point;
    Timer()         = default;
    ~Timer()        = default;

    [[nodiscard]]
    long long getDeltaTieMicroSec() noexcept
    {
        using namespace std::chrono;
        return duration_cast<micro>(m_endTime - m_startTime).count();
    }

    [[maybe_unused]]
    long long startTimer() noexcept
    {
        resetTimer();
        m_startTime = steadyclock::now();
        return m_startTime.time_since_epoch().count();
    }

    [[maybe_unused]]
    long long endTimer() noexcept
    {
        m_endTime = steadyclock::now();
        return m_endTime.time_since_epoch().count();
    }

private:

    timepoint m_startTime;
    timepoint m_endTime;

    void resetTimer() noexcept
    {
        m_startTime = {};
        m_endTime   = {};
    }
};

struct BenchmarkData
{
    std::string name;
    long long   duration;
    long long   startTime;
    std::size_t threadID = {};
};

class FileHandle
{
public:

    static void writeBenchmark(BenchmarkData const & data) noexcept
    {
        FileHandle::makeInstance().writeInfo(data);
    }

private:

    FileHandle(FileHandle &&)                  = delete;
    FileHandle(FileHandle const &)             = delete;
    FileHandle & operator=(FileHandle &&)      = delete;
    FileHandle & operator=(FileHandle const &) = delete;
    FileHandle() noexcept
    {
        m_fileStream = std::ofstream(outFileName);
        writeHeader();
    }
    ~FileHandle() noexcept
    {
        writeFooter();
    }
    void writeHeader() noexcept
    {
        m_fileStream << "{\"otherData\": {},\"traceEvents\":[";
    }
    void writeFooter() noexcept
    {
        m_fileStream << "]}";
    }
    void writeInfo(BenchmarkData const & data) noexcept
    {
        std::lock_guard<std::mutex> lock(m_lock);

        if (m_counter++ > 0) [[likely]]
        {
            m_fileStream << ",";
        }
        m_fileStream << "\n{";
        m_fileStream << "\"cat\":\"function\",";
        m_fileStream << "\"dur\":" << data.duration << ',';
        m_fileStream << "\"name\":\"" << data.name << "\",";
        m_fileStream << "\"ph\":\"X\",";
        m_fileStream << "\"pid\":0,";
        m_fileStream << "\"tid\":" << data.threadID << ',';
        m_fileStream << "\"ts\":" << data.startTime;
        m_fileStream << "}";
    }
    static FileHandle & makeInstance() noexcept
    {
        static FileHandle instance {};
        return instance;
    }

    // This Section is for member variables
    inline static std::string const outFileName = {
        std::string_literals::operator""s("BenchMark.json", 14)};
    std::ofstream m_fileStream;
    std::mutex    m_lock;
    size_t        m_counter = {};
};


class BenchMark
{
public:

    explicit BenchMark(std::string const & name) noexcept
    {
        m_data.name      = name;
        m_data.duration  = 0;
        m_data.startTime = m_timer.startTimer();
        m_data.threadID  = std::hash<std::thread::id> {}(
            std::this_thread::get_id());
    }
    ~BenchMark() noexcept
    {
        m_timer.endTimer();
        m_data.duration = m_timer.getDeltaTieMicroSec();
        FileHandle::writeBenchmark(m_data);
    }

private:

    BenchMark()                              = delete;
    BenchMark(BenchMark &&)                  = delete;
    BenchMark(BenchMark const &)             = delete;
    BenchMark & operator=(BenchMark &&)      = delete;
    BenchMark & operator=(BenchMark const &) = delete;

    Timer         m_timer;
    BenchmarkData m_data = {};
};
}  // namespace Profiler