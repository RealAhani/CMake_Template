include_guard()

macro(OSDISTRO OSName)

  if(LINUX)
    set(${OSName} "LINUX")

  elseif(WIN32)
    set(${OSName} "WIN")

  elseif(UNIX)
    set(${OSName} "MAC")

  endif()
endmacro()
