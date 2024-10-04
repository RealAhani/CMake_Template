include_guard()

file(GLOB src_files "${CMAKE_CURRENT_LIST_DIR}/*.cpp" "${CMAKE_CURRENT_LIST_DIR}/*.cc")
set(mysrc_exe ${src_files})

#or if u want to compile specific .cpp
#u can use
# set(src "main.cpp")
# and comment above lines
