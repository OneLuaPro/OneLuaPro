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
# CMake for creating OneLuaPro Distribution as ZIP-archive
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
set(ONELUAPRO_DISTRO_BASEDIR "OneLuaPro-${ONELUAPRO_VERSION}-${CMAKE_GENERATOR_PLATFORM}")
set(ONELUAPRO_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/${ONELUAPRO_DISTRO_BASEDIR}")
set(ONELUAPRO_BUILDROOT "${CMAKE_CURRENT_BINARY_DIR}/ONELUAPRO_BUILDROOT")
set(CMAKE_VERBOSE_MAKEFILE OFF)

project(OneLuaPro
  LANGUAGES C
  VERSION ${ONELUAPRO_VERSION})

# Scan for package files in subdir and include them
include(ExternalProject)
file(GLOB ONELUAPRO_PACKAGES "packages/*.cmake")
foreach(PKG ${ONELUAPRO_PACKAGES})
  get_filename_component(BASENAME ${PKG} NAME_WE)
  message(STATUS "Adding OneLuaPro package : ${BASENAME}")
  include(${PKG})
endforeach()

# Define the desired ZIP-file containing the whole distribution
set(ONELUAPRO_ZIP_DISTRO
  "${CMAKE_CURRENT_BINARY_DIR}/${ONELUAPRO_DISTRO_BASEDIR}.zip")

# Add a custom command the build the distribution
add_custom_command(OUTPUT ${ONELUAPRO_ZIP_DISTRO}
  COMMAND ${CMAKE_COMMAND} -E tar "cf" "${CMAKE_CURRENT_BINARY_DIR}/${ONELUAPRO_DISTRO_BASEDIR}.zip"
  --format=zip "${ONELUAPRO_PREFIX}"
  COMMENT "Generating ZIP-file : ${CMAKE_CURRENT_BINARY_DIR}/${ONELUAPRO_DISTRO_BASEDIR}.zip"
)

# Add a custom target which is always triggered
add_custom_target(create_distro ALL DEPENDS ${ONELUAPRO_ZIP_DISTRO})

# Add dependencies to this target to enforce the distro is build as last step
foreach (PKG ${ONELUAPRO_PACKAGES})
  get_filename_component(BASENAME ${PKG} NAME_WE)
  add_dependencies(create_distro ${BASENAME})
endforeach()
# ------------------------------------------------------------------------------
# TODO
# https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/PackageGenerators
