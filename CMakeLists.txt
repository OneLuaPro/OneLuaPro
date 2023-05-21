# MIT License
#
# Copyright (c) 2023 Kritzel Kratzel.
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
# Setup with Visual Studio 17 2022 generator for Win32
# ------------------------------------------------------------------------------
# Visual Studio is a mutlti-configuration generator
# https://stackoverflow.com/questions/24460486/
#
# Basic instructions for out-of-source build and install
# ------------------------------------------------------
# mkdir build
# cd build
# cmake .. -G "Visual Studio 17 2022" -A Win32
# cmake --build . --config Release
#
# Available architectures (-A ...) are: Win32, x64, ARM, ARM64
# Installation goes into C:/Apps/OneLuaPro
# Extend Path variable manually by C:/Apps/OneLuaPro/bin

# ------------------------------------------------------------------------------
# General definitions
cmake_minimum_required(VERSION 3.25 FATAL_ERROR)

set(ONELUAPRO_PREFIX "C:/Apps/OneLuaPro")
set(CMAKE_VERBOSE_MAKEFILE ON)

project(OneLuaPro LANGUAGES C)
include(ExternalProject)

# ------------------------------------------------------------------------------
# Lua interpreter, libs and all basic stuff
ExternalProject_Add(lua
  PREFIX ${PROJECT_NAME}/lua
  GIT_REPOSITORY https://github.com/KritzelKratzel/lua.git
  GIT_TAG "origin/main"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)

# ------------------------------------------------------------------------------
# luasocket
ExternalProject_Add(luasocket
  PREFIX ${PROJECT_NAME}/luasocket
  GIT_REPOSITORY https://github.com/KritzelKratzel/luasocket.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luasocket build lua)

# ------------------------------------------------------------------------------
# librs232
ExternalProject_Add(librs232
  PREFIX ${PROJECT_NAME}/librs232
  GIT_REPOSITORY https://github.com/KritzelKratzel/librs232.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(librs232 build lua)

# ------------------------------------------------------------------------------
# luafilesystem
ExternalProject_Add(luafilesystem
  PREFIX ${PROJECT_NAME}/luafilesystem
  GIT_REPOSITORY https://github.com/KritzelKratzel/luafilesystem.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luafilesystem build lua)

# ------------------------------------------------------------------------------
# argparse
ExternalProject_Add(argparse
  PREFIX ${PROJECT_NAME}/argparse
  GIT_REPOSITORY https://github.com/KritzelKratzel/argparse.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(argparse build lua)

# ------------------------------------------------------------------------------
# luacheck
ExternalProject_Add(luacheck
  PREFIX ${PROJECT_NAME}/luacheck
  GIT_REPOSITORY https://github.com/KritzelKratzel/luacheck.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luacheck build lua argparse luafilesystem)
