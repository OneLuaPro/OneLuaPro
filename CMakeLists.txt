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
# CMake for creating OneLuaPro Distribution as signed installer and ZIP-archive
# ------------------------------------------------------------------------------
# Setup with Visual Studio 17 2022 generator for x64
# ------------------------------------------------------------------------------
# Visual Studio is a mutlti-configuration generator
# https://stackoverflow.com/questions/24460486/
#
# Basic instructions for out-of-source build and install
# ------------------------------------------------------
# mkdir build && cd build
# cmake .. -G "Visual Studio 17 2022" -A x64 -DCODE_SIGN_ID=OneLuaPro_SelfSignedCert
# cmake --build . --config Release > 00_log.txt
# echo %errorlevel%
# cpack -G NSIS64
# cpack -G ZIP
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

# Make subdir cmake available as module search path
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

if (CODE_SIGN_ID)
endif()

project(OneLuaPro
  LANGUAGES C
  VERSION ${ONELUAPRO_VERSION})

# ------------------------------------------------------------------------------
# Scan for package files in subdir and include them
include(ExternalProject)
file(GLOB ONELUAPRO_PACKAGES "packages/*.cmake")
foreach(PKG ${ONELUAPRO_PACKAGES})
  get_filename_component(BASENAME ${PKG} NAME_WE)
  message(STATUS "Adding OneLuaPro package : ${BASENAME}")
  include(${PKG})
endforeach()

if (CODE_SIGN_ID)
  # Findsigntool will define the following variables:
  # signtool_FOUND : True if the system has the signtool executable.
  # signtool_EXECUTABLE : The signtool command executable with full path.
  # include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/Findsigntool.cmake")
  include(Findsigntool)
  # signtool parameters are neede twice - here as well as in SignDllExe.cmake
  include(CodeSignParams)
  if (signtool_EXECUTABLE)
    # --------------------------------------------------------------------------
    # Part 1: signing all *.dll and *.exe files of the distribution
    # --------------------------------------------------------------------------
    add_custom_target(signDllExe ALL
      COMMAND ${CMAKE_COMMAND}
      -DONELUAPRO_PREFIX=${ONELUAPRO_PREFIX}
      -Dsigntool_EXECUTABLE=${signtool_EXECUTABLE}
      -DCODE_SIGN_ID=${CODE_SIGN_ID}
      -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/SignDllExe.cmake
    )
    # Add deps to this target to enforce file signing is always done last
    foreach (PKG ${ONELUAPRO_PACKAGES})
      get_filename_component(BASENAME ${PKG} NAME_WE)
      add_dependencies(signDllExe ${BASENAME})
    endforeach()
    # --------------------------------------------------------------------------
    # Part 2: Preparations for signing the installer and de-installer
    #         Found on https://stackoverflow.com/questions/72504366
    #         Original author https://stackoverflow.com/users/4165151/msc
    # --------------------------------------------------------------------------
    # https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/NSISAdvancedTips
    # --------------------------------------------------------------------------
    # CPACK_NSIS_FINALIZE_CMD is a variable whose value is to be substituted
    # into the !finalize and !uninstfinalize commands in
    # cmake/modules/NSIS.template.in. This variable is ours. It is not a
    # standard CPACK variable. The name MUST start with CPACK otherwise
    # it will not be defined when cpack runs its configure_file step.
    foreach(param IN LISTS SIGN_PARAMS)
      # Quote the parameters because at least one of them,
      # CODE_SIGN_ID, has spaces. It is easier to quote
      # all of them than determine which have spaces.
      #
      # Insane escaping is needed due to the 2-step process used to
      # configure the final output. First cpack creates CPackConfig.cmake
      # in which the value set here appears, inside quotes, as the
      # argument to a cmake `set` command. That variable's value
      # is then substituted into the output.
      string(APPEND NSIS_SIGN_PARAMS "\\\"${param}\\\" ")
    endforeach()
    # Note 1: cpack/NSIS does not show any output when running signtool,
    # whether it succeeds or fails.
    #
    # Note 2: Do not move the %1 to NSIS.template.in. We need an empty
    # command there when we aren't signing. %1 is replaced by the name
    # of the installer or uninstaller during NSIS compilation.
    set(CPACK_NSIS_FINALIZE_CMD "\\\"${signtool_EXECUTABLE}\\\" sign ${NSIS_SIGN_PARAMS} %1")
    unset(NSIS_SIGN_PARAMS)
  else()
    message(FATAL_ERROR "---> No signtool-executable found! <---")
  endif()
else()
  # We're not signing the package so provide a checksum file.
  set(CPACK_PACKAGE_CHECKSUM SHA256)
endif()


# ------------------------------------------------------------------------------
# NSIS Packager
# https://cmake.org/cmake/help/latest/module/CPack.html
set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
set(CPACK_PACKAGE_VENDOR "OneLuaPro")
set(CPACK_PACKAGE_HOMEPAGE_URL "https://github.com/OneLuaPro")
set(CPACK_PACKAGE_VERSION_MAJOR ${LUA_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${LUA_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${LUA_VERSION_PATCH}.${ONELUAPRO_RELEASE})

set(CPACK_PACKAGE_INSTALL_DIRECTORY ${ONELUAPRO_DISTRO_BASEDIR})
set(CPACK_INSTALLED_DIRECTORIES ${ONELUAPRO_PREFIX} .)
set(CPACK_PACKAGE_FILE_NAME ${ONELUAPRO_DISTRO_BASEDIR})
set(CPACK_RESOURCE_FILE_LICENSE "${PROJECT_SOURCE_DIR}/LICENSE")
set(CPACK_STRIP_FILES ON)

# https://cmake.org/cmake/help/latest/cpack_gen/nsis.html
# https://nsis.sourceforge.io/Docs/Modern%20UI/Readme.html
# set(CPACK_NSIS_INSTALL_ROOT "C:\\Apps")
# set(CPACK_NSIS_WELCOME_TITLE_3LINES OFF)
set(CPACK_NSIS_FINISH_TITLE_3LINES ON)
set(CPACK_NSIS_MODIFY_PATH ON)
set(CPACK_NSIS_DISPLAY_NAME ${ONELUAPRO_DISTRO_BASEDIR})
set(CPACK_NSIS_PACKAGE_NAME ${ONELUAPRO_DISTRO_BASEDIR})
set(CPACK_NSIS_MUI_ICON "${PROJECT_SOURCE_DIR}/logo\\\\lua-logo-olp-dist.ico")
set(CPACK_NSIS_MUI_UNIICON "${PROJECT_SOURCE_DIR}/logo\\\\lua-logo-olp-dist.ico")
set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL ON)
set(CPACK_NSIS_URL_INFO_ABOUT "https://github.com/OneLuaPro")
set(CPACK_NSIS_MUI_HEADERIMAGE
  "${PROJECT_SOURCE_DIR}/logo\\\\lua-logo-olp-dist-header.bmp")
set(CPACK_NSIS_MUI_WELCOMEFINISHPAGE_BITMAP
  "${PROJECT_SOURCE_DIR}/logo\\\\lua-logo-olp-dist-welcome.bmp")
set(CPACK_NSIS_MUI_UNWELCOMEFINISHPAGE_BITMAP
  "${PROJECT_SOURCE_DIR}/logo\\\\lua-logo-olp-dist-welcome.bmp")
set(CPACK_NSIS_BRANDING_TEXT " ")
# set(CPACK_NSIS_IGNORE_LICENSE_PAGE OFF)
set(CPACK_NSIS_MENU_LINKS
  "bin/lua.exe" "Lua Interpreter"
  "share/doc/lua/contents.html" "Lua Reference Manual"
)

# ------------------------------------------------------------------------------
# WIX
# https://cmake.org/cmake/help/latest/cpack_gen/wix.html
# Currently not used
set(CPACK_WIX_UPGRADE_GUID A7B4D8D5-ECF8-43A2-A810-CF803889946E)
set(CPACK_WIX_INSTALL_SCOPE perMachine)
set(CPACK_WIX_PRODUCT_ICON "${PROJECT_SOURCE_DIR}/logo/lua-logo-olp-dist.bmp")



# ------------------------------------------------------------------------------
# Include packager and enforce inclusion of runtime system libs
include(CPack)
include(InstallRequiredSystemLibraries)

# ------------------------------------------------------------------------------
# General Info
# https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/PackageGenerators
# https://stackoverflow.com/questions/75915316/		# cmake set path env
# https://cmake.org/cmake/help/latest/cpack_gen/nsis.html
# https://stackoverflow.com/questions/72504366		# sign binaries for install
