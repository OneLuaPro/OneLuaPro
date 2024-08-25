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
# cmake --build . --config Release
#
# Available architectures are: Win32, x64, ARM, ARM64

# ------------------------------------------------------------------------------
# General definitions
cmake_minimum_required(VERSION 3.23 FATAL_ERROR)

# OneLuaPro Version
set(ONELUAPRO_VERSION 5.4.7.0)

# Bootstrap and installation path
set(ONELUAPRO_PREFIX "C:/Apps/OneLuaPro-${ONELUAPRO_VERSION}-${CMAKE_GENERATOR_PLATFORM}")
set(CMAKE_VERBOSE_MAKEFILE ON)

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
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)

# ------------------------------------------------------------------------------
# luasocket
ExternalProject_Add(luasocket
  PREFIX ${PROJECT_NAME}/luasocket
  GIT_REPOSITORY https://github.com/OneLuaPro/luasocket.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luasocket build lua)

# ------------------------------------------------------------------------------
# librs232
ExternalProject_Add(librs232
  PREFIX ${PROJECT_NAME}/librs232
  GIT_REPOSITORY https://github.com/OneLuaPro/librs232.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(librs232 build lua)

# ------------------------------------------------------------------------------
# luafilesystem
ExternalProject_Add(luafilesystem
  PREFIX ${PROJECT_NAME}/luafilesystem
  GIT_REPOSITORY https://github.com/OneLuaPro/luafilesystem.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luafilesystem build lua)

# ------------------------------------------------------------------------------
# argparse
ExternalProject_Add(argparse
  PREFIX ${PROJECT_NAME}/argparse
  GIT_REPOSITORY https://github.com/OneLuaPro/argparse.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(argparse build lua)

# ------------------------------------------------------------------------------
# luacheck
ExternalProject_Add(luacheck
  PREFIX ${PROJECT_NAME}/luacheck
  GIT_REPOSITORY https://github.com/OneLuaPro/luacheck.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luacheck build lua argparse luafilesystem)

# ------------------------------------------------------------------------------
# lsleep
ExternalProject_Add(lsleep
  PREFIX ${PROJECT_NAME}/lsleep
  GIT_REPOSITORY https://github.com/OneLuaPro/lsleep.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lsleep build lua)

# ------------------------------------------------------------------------------
# libffi
ExternalProject_Add(libffi
  PREFIX ${PROJECT_NAME}/libffi
  GIT_REPOSITORY https://github.com/OneLuaPro/libffi.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(libffi build lua)

# ------------------------------------------------------------------------------
# libusb
ExternalProject_Add(libusb
  PREFIX ${PROJECT_NAME}/libusb
  GIT_REPOSITORY https://github.com/OneLuaPro/libusb.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(libusb build lua)

# ------------------------------------------------------------------------------
# moonusb
ExternalProject_Add(moonusb
  PREFIX ${PROJECT_NAME}/moonusb
  GIT_REPOSITORY https://github.com/OneLuaPro/moonusb.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
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
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
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
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luv build lua libuv)

# ------------------------------------------------------------------------------
# lanes
ExternalProject_Add(lanes
  PREFIX ${PROJECT_NAME}/lanes
  GIT_REPOSITORY https://github.com/OneLuaPro/lanes.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lanes build lua)

# ------------------------------------------------------------------------------
# luaping
ExternalProject_Add(luaping
  PREFIX ${PROJECT_NAME}/luaping
  GIT_REPOSITORY https://github.com/OneLuaPro/luaping.git
  GIT_TAG "origin/main"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luaping build lua)
