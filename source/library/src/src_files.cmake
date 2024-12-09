include_guard()

file(GLOB src_files "${CMAKE_CURRENT_LIST_DIR}/*.cpp" "${CMAKE_CURRENT_LIST_DIR}/*.cc")
set(mysrc_lib ${src_files})
# list(APPEND ${mysrc_lib} "$ENV{ANDROID_NDK_HOME}/sources/android/native_app_glue/android_native_app_glue.c")

#or if u want to compile specific .cpp
#u can use
# set(src "main.cpp")
# and comment above lines
