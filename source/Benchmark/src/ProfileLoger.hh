#pragma once
#include <string>
#include <iostream>
#include "TimeManager.hh"
namespace AP
{
class ProfileLoger
{
public:
    ProfileLoger()                               = default;
    ProfileLoger(ProfileLoger&&)                 = delete;
    ProfileLoger(const ProfileLoger&)            = delete;
    ProfileLoger& operator=(ProfileLoger&&)      = delete;
    ProfileLoger& operator=(const ProfileLoger&) = delete;
    explicit ProfileLoger(const std::string& name) : m_name{name}
    {
        m_time.Start_Time();
    }
    ~ProfileLoger()
    {
        m_time.End_Time();
        m_sec = (m_time.GetTimeSec() + 0.001f);
        Write_File();
    }

private:
    AP::TimerManager m_time = {};
    std::string      m_name = {};
    float            m_sec  = {};
    void             Write_File()
    {
        //write data as .json file
        std::cout << "function name : " << m_name << '\n';
        std::cout << "time elapsed : " << m_sec << '\n';
    }
};
} // namespace AP