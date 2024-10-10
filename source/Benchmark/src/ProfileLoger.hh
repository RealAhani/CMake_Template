#pragma once
#include <string>
#include <iostream>
#include <fstream>
#include <mutex>
#include <algorithm>
#include <map>
#include "TimeManager.hh"
namespace AP
{
struct Time_Data
{
    std::string m_name      = {"Default"};
    int64_t     m_sec       = {};
    int64_t     m_startTime = {};
    std::size_t threadID    = {};
};

class FileHandle
{
public:
    void Log_Info(const Time_Data& data)
    {
        std::lock_guard<std::mutex> lock(m_lock);
        if (m_counter++ > 0)
        {
            m_fileStream << ",";
        }
        std::string name{data.m_name};
        std::replace(name.begin(), name.end(), '"', '\'');
        m_fileStream << "\n{";
        m_fileStream << "\"cat\":\"function\",";
        m_fileStream << "\"dur\":" << data.m_sec << ',';
        m_fileStream << "\"name\":\"" << name << "\",";
        m_fileStream << "\"ph\":\"X\",";
        m_fileStream << "\"pid\":0,";
        m_fileStream << "\"tid\":" << data.threadID << ',';
        m_fileStream << "\"ts\":" << data.m_startTime;
        m_fileStream << "}";
    }
    static FileHandle& MakeSingle()
    {
        static FileHandle instance{};
        return instance;
    }

private:
    FileHandle(FileHandle&&)                 = delete;
    FileHandle(const FileHandle&)            = delete;
    FileHandle& operator=(FileHandle&&)      = delete;
    FileHandle& operator=(const FileHandle&) = delete;
    FileHandle() : m_fileStream{std::ofstream(m_outFileName)}
    {
        Write_Header();
    }
    ~FileHandle()
    {
        Write_Footer();
    }
    void Write_Header()
    {
        m_fileStream << "{\"otherData\": {},\"traceEvents\":[";
    }
    void Write_Footer()
    {
        m_fileStream << "]}";
    }

private:
    std::string   m_outFileName = {"RunTimeBenchMark.json"};
    std::ofstream m_fileStream  = {};
    std::mutex    m_lock        = {};
    size_t        m_counter     = {};
};


class Timer
{
public:
    explicit Timer(const std::string& name)
    {
        m_data.m_name      = name;
        m_data.m_sec       = 0;
        m_data.m_startTime = m_manager.Start_Time();
        m_data.threadID    = std::hash<std::thread::id>{}(std::this_thread::get_id());
    }
    ~Timer()
    {
        m_manager.End_Time();
        m_data.m_sec = m_manager.GetTimeSec();
        Write_File();
    }

private:
    Timer()                        = delete;
    Timer(Timer&&)                 = delete;
    Timer(const Timer&)            = delete;
    Timer& operator=(Timer&&)      = delete;
    Timer& operator=(const Timer&) = delete;

    AP::TimerManager m_manager = {};
    Time_Data        m_data    = {};
    void             Write_File()
    {
        FileHandle::MakeSingle().Log_Info(m_data);
    }
};
} // namespace AP