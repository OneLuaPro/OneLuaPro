# MIT License
#
# Copyright (c) 2023-2024 Kritzel Kratzel.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in 
# the Software without restriction, including without limitation the rights to 
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all 
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# ------------------------------------------------------------------------------
# CMake for OneLuaPro
# ------------------------------------------------------------------------------
# Setup with Visual Studio 17 2022 generator for x64
# ------------------------------------------------------------------------------
# Visual Studio is a mutlti-configuration generator
# https://stackoverflow.com/questions/24460486/
#
# Basic instructions for out-of-source build and install
# ------------------------------------------------------
# mkdir build && cd build
# cmake .. -G "Visual Studio 17 2022" -A x64
# cmake --build . --config Release > 00_log.txt
# echo %errorlevel%
#
# After build check return value %errorlevel% (must be 0) and content of 
# 00_log.txt. Suggested search patterns: "error C", "warning C", ...
#
# Available architectures are: Win32, x64, ARM, ARM64

# ------------------------------------------------------------------------------
# General definitions
cmake_minimum_required(VERSION 3.23 FATAL_ERROR)

# OneLuaPro Version
set(LUA_VERSION_MAJOR 5)
set(LUA_VERSION_MINOR 4)
set(LUA_VERSION_PATCH 7)
set(ONELUAPRO_RELEASE 2)
set(LUA_VERSION ${LUA_VERSION_MAJOR}.${LUA_VERSION_MINOR}.${LUA_VERSION_PATCH})
set(ONELUAPRO_VERSION ${LUA_VERSION}.${ONELUAPRO_RELEASE})

# Bootstrap and post_installation paths
set(ONELUAPRO_PREFIX "C:/Apps/OneLuaPro-${ONELUAPRO_VERSION}-${CMAKE_GENERATOR_PLATFORM}")
set(CMAKE_VERBOSE_MAKEFILE ON)
set(ONELUAPRO_BOOTSTRAP "C:/Temp/ONELUAPRO_BOOTSTRAP")

project(OneLuaPro
  LANGUAGES C
  VERSION ${ONELUAPRO_VERSION})
include(ExternalProject)

# ------------------------------------------------------------------------------
# Lua interpreter, libs and all basic stuff
ExternalProject_Add(lua
  PREFIX ${PROJECT_NAME}/lua
  GIT_REPOSITORY https://github.com/OneLuaPro/lua.git
  GIT_TAG "origin/main"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BOOTSTRAP}"
)
ExternalProject_Add_Step(lua post_install
  # After lua bootstrap copy relevant files to post_installaton location
  COMMENT "Installing lua into ${ONELUAPRO_PREFIX}"
  DEPENDEES install
  # copy bin
  COMMAND ${CMAKE_COMMAND} -E copy_directory ${ONELUAPRO_BOOTSTRAP}/bin
  ${ONELUAPRO_PREFIX}/bin
  # copy share/doc/lua
  COMMAND ${CMAKE_COMMAND} -E copy_directory ${ONELUAPRO_BOOTSTRAP}/share/doc/lua
  ${ONELUAPRO_PREFIX}/share/doc/lua
)

# ------------------------------------------------------------------------------
# luasocket
ExternalProject_Add(luasocket
  PREFIX ${PROJECT_NAME}/luasocket
  GIT_REPOSITORY https://github.com/OneLuaPro/luasocket.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BOOTSTRAP}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luasocket build lua)

# ------------------------------------------------------------------------------
# librs232
ExternalProject_Add(librs232
  PREFIX ${PROJECT_NAME}/librs232
  GIT_REPOSITORY https://github.com/OneLuaPro/librs232.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BOOTSTRAP}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(librs232 build lua)

# ------------------------------------------------------------------------------
# luafilesystem
ExternalProject_Add(luafilesystem
  PREFIX ${PROJECT_NAME}/luafilesystem
  GIT_REPOSITORY https://github.com/OneLuaPro/luafilesystem.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BOOTSTRAP}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luafilesystem build lua)

# ------------------------------------------------------------------------------
# argparse
ExternalProject_Add(argparse
  PREFIX ${PROJECT_NAME}/argparse
  GIT_REPOSITORY https://github.com/OneLuaPro/argparse.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BOOTSTRAP}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(argparse build lua)

# ------------------------------------------------------------------------------
# luacheck
ExternalProject_Add(luacheck
  PREFIX ${PROJECT_NAME}/luacheck
  GIT_REPOSITORY https://github.com/OneLuaPro/luacheck.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BOOTSTRAP}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luacheck build lua argparse luafilesystem)

# ------------------------------------------------------------------------------
# lsleep
ExternalProject_Add(lsleep
  PREFIX ${PROJECT_NAME}/lsleep
  GIT_REPOSITORY https://github.com/OneLuaPro/lsleep.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BOOTSTRAP}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lsleep build lua)

# ------------------------------------------------------------------------------
# libffi
ExternalProject_Add(libffi
  PREFIX ${PROJECT_NAME}/libffi
  GIT_REPOSITORY https://github.com/OneLuaPro/libffi.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BOOTSTRAP}"
)
ExternalProject_Add_StepDependencies(libffi build lua)

# ------------------------------------------------------------------------------
# winflexbison
# Build prerequisite for lua-ffi only, not included in OLP distribution
ExternalProject_Add(winflexbison
  PREFIX ${PROJECT_NAME}/winflexbison
  GIT_REPOSITORY https://github.com/lexxmark/winflexbison.git
  GIT_TAG "v2.5.25"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BOOTSTRAP}/bin"
)

# ------------------------------------------------------------------------------
# dlfcn-win32
# Build prerequisite for lua-ffi only, not included in OLP distribution
ExternalProject_Add(dlfcn-win32
  PREFIX ${PROJECT_NAME}/dlfcn-win32
  GIT_REPOSITORY https://github.com/dlfcn-win32/dlfcn-win32.git
  GIT_TAG "v1.4.1"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BOOTSTRAP}"
  "-DBUILD_SHARED_LIBS=OFF"
)

# ------------------------------------------------------------------------------
# lua-ffi
ExternalProject_Add(lua-ffi
  PREFIX ${PROJECT_NAME}/lua-ffi
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-ffi.git
  GIT_TAG "origin/main"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BOOTSTRAP}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-DCMAKE_PREFIX_PATH=${ONELUAPRO_BOOTSTRAP}"
)
ExternalProject_Add_StepDependencies(lua-ffi build libffi winflexbison dlfcn-win32)

# ------------------------------------------------------------------------------
# libusb
ExternalProject_Add(libusb
  PREFIX ${PROJECT_NAME}/libusb
  GIT_REPOSITORY https://github.com/OneLuaPro/libusb.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BOOTSTRAP}"
)
ExternalProject_Add_StepDependencies(libusb build lua)

# ------------------------------------------------------------------------------
# moonusb
ExternalProject_Add(moonusb
  PREFIX ${PROJECT_NAME}/moonusb
  GIT_REPOSITORY https://github.com/OneLuaPro/moonusb.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BOOTSTRAP}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(moonusb build lua libusb)

# ------------------------------------------------------------------------------
# libuv - unaltered, original
ExternalProject_Add(libuv
  PREFIX ${PROJECT_NAME}/libuv
  GIT_REPOSITORY https://github.com/libuv/libuv.git
  GIT_TAG "v1.48.0"
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BOOTSTRAP}"
  "-DBUILD_TESTING=OFF"
  "-DLIBUV_BUILD_SHARED=OFF"
)
ExternalProject_Add_StepDependencies(libuv build lua)

# ------------------------------------------------------------------------------
# luv
ExternalProject_Add(luv
  PREFIX ${PROJECT_NAME}/luv
  GIT_REPOSITORY https://github.com/OneLuaPro/luv.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BOOTSTRAP}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luv build lua libuv)

# ------------------------------------------------------------------------------
# lanes
ExternalProject_Add(lanes
  PREFIX ${PROJECT_NAME}/lanes
  GIT_REPOSITORY https://github.com/OneLuaPro/lanes.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BOOTSTRAP}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lanes build lua)

# ------------------------------------------------------------------------------
# luaping
ExternalProject_Add(luaping
  PREFIX ${PROJECT_NAME}/luaping
  GIT_REPOSITORY https://github.com/OneLuaPro/luaping.git
  GIT_TAG "origin/main"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BOOTSTRAP}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luaping build lua)

# ------------------------------------------------------------------------------
# luadaqmx
ExternalProject_Add(luadaqmx
  PREFIX ${PROJECT_NAME}/luadaqmx
  GIT_REPOSITORY https://github.com/OneLuaPro/luadaqmx.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BOOTSTRAP}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luadaqmx build lua)

# ------------------------------------------------------------------------------
# lua4882
ExternalProject_Add(lua4882
  PREFIX ${PROJECT_NAME}/lua4882
  GIT_REPOSITORY https://github.com/OneLuaPro/lua4882.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BOOTSTRAP}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lua4882 build lua)

# ------------------------------------------------------------------------------
# LPeg
ExternalProject_Add(LPeg
  PREFIX ${PROJECT_NAME}/LPeg
  GIT_REPOSITORY https://github.com/OneLuaPro/LPeg.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BOOTSTRAP}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(LPeg build lua)

# ------------------------------------------------------------------------------
# wxWidgets
ExternalProject_Add(wxWidgets
  PREFIX ${PROJECT_NAME}/wxWidgets
  GIT_REPOSITORY https://github.com/wxWidgets/wxWidgets.git
  GIT_TAG "v3.2.5"
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BOOTSTRAP}"
  "-DwxBUILD_SHARED=OFF"
)
ExternalProject_Add_StepDependencies(wxWidgets build lua)

# ------------------------------------------------------------------------------
# wxLua
ExternalProject_Add(wxLua
  PREFIX ${PROJECT_NAME}/wxLua
  GIT_REPOSITORY https://github.com/pkulchenko/wxlua.git
  GIT_TAG origin/master
  GIT_PROGRESS FALSE
  SOURCE_SUBDIR wxLua
  CMAKE_ARGS
  "-Wno-dev"
  "-DCMAKE_BUILD_TYPE=Release"
  "-DBUILD_SHARED_LIBS=FALSE"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BOOTSTRAP}"
  "-DwxLua_LUA_LIBRARY_USE_BUILTIN=FALSE"
  "-DwxLua_LUA_INCLUDE_DIR=${ONELUAPRO_PREFIX}/include"
  "-DwxLua_LUA_LIBRARY=${ONELUAPRO_PREFIX}/lib/liblua.lib"
  "-DwxWidgets_ROOT_DIR=${ONELUAPRO_BOOTSTRAP}"
  "-DwxWidgets_CONFIGURATION=mswu"
  "-DBUILD_USE_SOLUTION_FOLDERS=TRUE"
)
ExternalProject_Add_StepDependencies(wxLua build lua wxWidgets)
ExternalProject_Add_Step(wxLua post_install
  COMMENT "Installing xwLua into ${ONELUAPRO_PREFIX}"
  DEPENDEES install
  COMMAND ${CMAKE_COMMAND} -E copy
  ${ONELUAPRO_BOOTSTRAP}/bin/wx.dll
  ${ONELUAPRO_PREFIX}/lib/lua/${LUA_VERSION_MAJOR}.${LUA_VERSION_MINOR}/
  COMMAND ${CMAKE_COMMAND} -E copy_directory
  ${ONELUAPRO_BOOTSTRAP}/doc/wxLua
  ${ONELUAPRO_PREFIX}/share/doc/wxLua
  COMMAND ${CMAKE_COMMAND} -E copy_directory
  ${ONELUAPRO_BOOTSTRAP}/samples
  ${ONELUAPRO_PREFIX}/share/doc/wxLua/samples
)
