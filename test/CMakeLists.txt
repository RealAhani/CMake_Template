#TEST
include(${CMAKE_CURRENT_LIST_DIR}/src/src_files.cmake)
if(PROJECT_IS_TOP_LEVEL OR ENABLE_TESTING)
  find_package(Catch2 CONFIG REQUIRED)
  add_executable(${TESTNAME} ${mysrc_test})
  target_compile_options(${TESTNAME} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:${CUSTOME_FLAGS}>)
  target_include_directories(
    ${TESTNAME} PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/generate" PRIVATE "../source/library/include"
  )
  target_link_libraries(${TESTNAME} PRIVATE Catch2::Catch2WithMain ${MYLIBNAME})
  include(CTest)
  include(Catch)
  catch_discover_tests(${TESTNAME})
  if(ENABLE_PACKAGING)
    # Set package types (e.g., ZIP,External ,WIX (msiinstaller),IFW(qtinstaller),INNOSETUP,NSIS,NSIS64 ,Nuget TBZ2, TGZ, TXZ ,TZ , DEB, RPM, NSIS, etc.)
    install(TARGETS ${TESTNAME} RUNTIME DESTINATION bin)
  endif()
endif()
