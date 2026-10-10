# Flags for manual compilation
# use with cmake -C <this file>

# CACHE Types: STRING BOOL PATH
set(CMAKE_GENERATOR "Ninja" CACHE STRING "Generator Type")
set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build Type")

# C Compiler
set(CMAKE_C_COMPILER "icx" CACHE STRING "C Compiler")
set(CMAKE_C_EXTRA_FLAGS "-Wno-recommended-option")
set(CMAKE_C_FLAGS
  "/DWIN32 /D_WINDOWS /DCURL_STATICLIB /O2 /fp:precise /arch:AVX /QaxCORE-AVX2,CORE-AVX512 /EHsc ${CMAKE_C_EXTRA_FLAGS}"
  CACHE STRING "C Compiler Flags")

# C++ Compiler
set(CMAKE_CXX_COMPILER "icx" CACHE STRING "C++ Compiler")
set(CMAKE_CXX_EXTRA_FLAGS "-Wno-recommended-option")
set(CMAKE_CXX_FLAGS
  "/DWIN32 /D_WINDOWS /EHsc /O2 /fp:precise /arch:AVX /QaxCORE-AVX2,CORE-AVX512 /EHsc ${CMAKE_CXX_EXTRA_FLAGS}"
  CACHE STRING "C++ Compiler Flags")

# Runtime Lib
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>"
  CACHE STRING "CRT Settings")

# Linker Settings
set(CMAKE_EXE_LINKER_FLAGS "/Qoption,link,/machine:x64 /Qlibs-static"
  CACHE STRING "EXE Linker Flags")
set(CMAKE_SHARED_LINKER_FLAGS "/Qoption,link,/machine:x64 /Qlibs-static"
  CACHE STRING "SHARED Linker Flags")
set(CMAKE_STATIC_LINKER_FLAGS "/Qoption,link,/machine:x64"
  CACHE STRING "STATIC Linker Flags")

# Paths
set(LUA_HINTS "c:/misc/OneLuaPro/intel/ONELUAPRO_BUILDROOT" CACHE PATH "Lua Path")
set(CMAKE_INSTALL_PREFIX "c:/Apps/OneLuaPro" CACHE PATH "OneLuaPro Installation")
