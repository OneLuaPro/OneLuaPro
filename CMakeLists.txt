# MIT License
#
# Copyright (c) 2023-2026 The OneLuaPro project authors
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
# CMake Superbuild for OneLuaPro Distribution as signed installer and ZIP-archive
# ------------------------------------------------------------------------------
# Setup with Visual Studio 17 2022 generator for x64
# ------------------------------------------------------------------------------
# Visual Studio is a mutlti-configuration generator
# https://stackoverflow.com/questions/24460486/
#
# Basic instructions for out-of-source build and install
# ------------------------------------------------------
# mkdir build64 && cd build64
# cmake .. -G "Visual Studio 17 2022" -A x64 -DCODE_SIGN_ID="Open Source Developer"
# cmake --build . --config Release > 00_log.txt
# echo %errorlevel%
# cpack
#
# After build check return value %errorlevel% (must be 0) and content of 
# 00_log.txt. Suggested search patterns: "fatal", "error ", "error C",
#                                        "warning C", ...
#
# Available architectures are: Win32, x64, ARM, ARM64

# ------------------------------------------------------------------------------
# General definitions
cmake_minimum_required(VERSION 3.31 FATAL_ERROR)

# OneLuaPro Version
set(LUA_VERSION_MAJOR 5)
set(LUA_VERSION_MINOR 4)
set(LUA_VERSION_PATCH 8)
set(ONELUAPRO_RELEASE 3)
set(ONELUAPRO_CANDIDATE "")	# e.g. "-RC1", leave "" for no RC
set(LUA_VERSION ${LUA_VERSION_MAJOR}.${LUA_VERSION_MINOR}.${LUA_VERSION_PATCH})
set(ONELUAPRO_VERSION ${LUA_VERSION}.${ONELUAPRO_RELEASE})

project(OneLuaPro
  LANGUAGES NONE
  VERSION ${ONELUAPRO_VERSION})

# Make subdir cmake available as module search path
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

# Bootstrap and post_installation paths
set(ONELUAPRO_FULL_DISTRO_NAME "OneLuaPro-${ONELUAPRO_VERSION}${ONELUAPRO_CANDIDATE}-${CMAKE_GENERATOR_PLATFORM}")
set(ONELUAPRO_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/${ONELUAPRO_FULL_DISTRO_NAME}")
set(ONELUAPRO_BUILDROOT "${CMAKE_CURRENT_BINARY_DIR}/ONELUAPRO_BUILDROOT")
set(CMAKE_VERBOSE_MAKEFILE OFF)

# ------------------------------------------------------------------------------
# Scan for package files in subdir and include them
include(ExternalProject)
set_property(GLOBAL PROPERTY ONELUAPRO_DOC_LIST "")
file(GLOB ONELUAPRO_PACKAGES "packages/*.cmake")
foreach(PKG ${ONELUAPRO_PACKAGES})
  get_filename_component(BASENAME ${PKG} NAME_WE)
  message(STATUS "Adding OneLuaPro package : ${BASENAME}")
  include(${PKG})
endforeach()

# ------------------------------------------------------------------------------
if (CODE_SIGN_ID)
  # Findsigntool will define the following variables:
  # signtool_FOUND : True if the system has the signtool executable.
  # signtool_EXECUTABLE : The signtool command executable with full path.
  # include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/Findsigntool.cmake")
  include(Findsigntool)
  # Export signtool_EXECUTABLE to CPack via adding "CPACK_" prefix
  # The configuration files created by CPack.cmake will contain all the
  # variables that begin with "CPACK_" in the current project.
  set(CPACK_signtool_EXECUTABLE ${signtool_EXECUTABLE})
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
    # Export CODE_SIGN_ID to CPack via adding "CPACK_" prefix
    # The configuration files created by CPack.cmake will contain all the
    # variables that begin with "CPACK_" in the current project.
    set(CPACK_CODE_SIGN_ID ${CODE_SIGN_ID})
  else()
    message(FATAL_ERROR "---> No signtool-executable found! <---")
  endif()
else()
  # We're not signing the package so provide a checksum file.
  set(CPACK_PACKAGE_CHECKSUM SHA256)
endif()

# ------------------------------------------------------------------------------
# Generate SHA256 digests of the full OneLuaPro installation and compile them
# into a DLL as resource. 
# Read out all collected build targets
get_directory_property(ALL_EXTERNAL_PROJECTS BUILDSYSTEM_TARGETS)
if (CODE_SIGN_ID)
  # force code signing of all EXE and DLL before hashing
  list(APPEND ALL_EXTERNAL_PROJECTS signDllExe)
endif()
# Create empty dummy project and make it dependent on all ALL_EXTERNAL_PROJECTS.
# This dummy project is the door-opener for the attached external project added
# steps.
ExternalProject_Add(finalize_install
  DOWNLOAD_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  DEPENDS ${ALL_EXTERNAL_PROJECTS}
)
# Add first step to dummy project to create the SHA256 checksums and to compile
# them into a DLL
ExternalProject_Add_Step(finalize_install generate_checksums
  COMMAND ${CMAKE_COMMAND} -DTARGET_DIR=${ONELUAPRO_PREFIX}
  -DSAVETO_DIR=${CMAKE_CURRENT_BINARY_DIR}
  -P "${CMAKE_CURRENT_SOURCE_DIR}/cmake/GenerateHashes.cmake"
  DEPENDEES install
  COMMENT "Generating SHA256 checksums for all installed data ..."
)
if (CODE_SIGN_ID)
  # Add second step to dummy project for signing the created DLL containing all
  # checksums
  ExternalProject_Add_Step(finalize_install sign_checksum
    COMMAND ${CMAKE_COMMAND}
    -DONELUAPRO_PREFIX=${ONELUAPRO_PREFIX}
    -Dsigntool_EXECUTABLE=${signtool_EXECUTABLE}
    -DCODE_SIGN_ID=${CODE_SIGN_ID}
    -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/SignChksumDll.cmake
    DEPENDEES generate_checksums
    COMMENT "Signing chksum.dll ..."
  )
endif()

# ------------------------------------------------------------------------------
# Aggreate Documentation into Help Center
# Setup documentation assets directory
string(TIMESTAMP BUILD_DATE "%Y-%m-%d %H:%M")
file(MAKE_DIRECTORY "${ONELUAPRO_PREFIX}/share/doc/assets")
# Copy branding assets
file(COPY "${CMAKE_CURRENT_SOURCE_DIR}/logo/lua-logo-olp-dist.png" 
  DESTINATION "${ONELUAPRO_PREFIX}/share/doc/assets")
file(COPY "${CMAKE_SOURCE_DIR}/cmake/doc-gen/oneluapro.css" 
  DESTINATION "${ONELUAPRO_PREFIX}/share/doc/assets")
# Generate Dashboard Content
get_property(OLP_DOCS GLOBAL PROPERTY ONELUAPRO_DOC_LIST)
list(LENGTH OLP_DOCS _doc_count)
if(_doc_count GREATER 0)
  # 1. Collect all categories
  set(_categories "")
  math(EXPR _doc_max "${_doc_count} - 1")
  foreach(_i RANGE 0 ${_doc_max} 6)
    math(EXPR _cat_idx "${_i} + 4")
    list(GET OLP_DOCS ${_cat_idx} _cat)
    list(APPEND _categories ${_cat})
  endforeach()
  list(REMOVE_DUPLICATES _categories)
  list(SORT _categories)

  # 2. Generate HTML per Category
  set(HUB_CONTENT "")
  foreach(_current_cat IN LISTS _categories)
    string(APPEND HUB_CONTENT "<h2 class='category-title'>${_current_cat}</h2>\n<div class='grid'>\n")

    # Collect all entries for the current category to sort them individually
    set(_entries_in_cat "")
    foreach(_i RANGE 0 ${_doc_max} 6)
      math(EXPR _cat_idx "${_i} + 4")
      list(GET OLP_DOCS ${_cat_idx} _cat)
      
      if(_cat STREQUAL _current_cat)
        math(EXPR _l_idx "${_i} + 2")
        list(GET OLP_DOCS ${_l_idx} _label)
        
        # Use a custom separator (e.g., '###') to avoid CMake list splitting
        list(APPEND _entries_in_cat "${_label}###${_i}")
      endif()
    endforeach()

    # Sort entries alphabetically by label, ignoring case
    list(SORT _entries_in_cat CASE INSENSITIVE)

    # Move "Lua" entry to the top if it exists
    set(_lua_entry "")
    foreach(_entry IN LISTS _entries_in_cat)
      # Check for exact prefix "Lua###"
      if(_entry MATCHES "^Lua Core Reference###")
        set(_lua_entry "${_entry}")
        break()
      endif()
    endforeach()
    if(_lua_entry)
      list(REMOVE_ITEM _entries_in_cat "${_lua_entry}")
      list(INSERT _entries_in_cat 0 "${_lua_entry}")
    endif()

    # Generate HTML from the sorted temporary list
    foreach(_entry IN LISTS _entries_in_cat)
      # Extract the original index by getting everything after the last '###'
      string(REGEX REPLACE ".*###" "" _i "${_entry}")      

      list(GET OLP_DOCS ${_i} _name)
      math(EXPR _p "${_i} + 1")
      list(GET OLP_DOCS ${_p} _path)
      math(EXPR _l "${_i} + 2")
      list(GET OLP_DOCS ${_l} _label)
      math(EXPR _ic "${_i} + 3")
      list(GET OLP_DOCS ${_ic} _icon)
      math(EXPR _v  "${_i} + 5")
      list(GET OLP_DOCS ${_v} _version)

      string(APPEND HUB_CONTENT 
        "<div class='card'>\n"
        "  <a href='${_path}' class='card-link' target='_blank' rel='noopener noreferrer'>\n"
        "    <span class='icon'>${_icon}</span>\n"
        "    <div class='info'>\n"
        "      <strong>${_label}</strong>\n"
        "      <small>${_name} <span class='version-tag'>${_version}</span></small>\n"
        "    </div>\n"
        "  </a>\n"
        "  <button class='copy-btn' onclick=\"copyToClipboard(event, '${_path}')\" title='Copy folder path to clipboard'>\n"
        "    <span class='btn-icon'>📁</span>\n"
        "  </button>\n"
        "</div>\n")
    endforeach()
    
    string(APPEND HUB_CONTENT "</div>\n")
  endforeach()
endif()

# Create Documentation Launch Pad
configure_file(cmake/doc-gen/hub.html.in
  "${ONELUAPRO_PREFIX}/share/doc/index.html"
  @ONLY)

# ------------------------------------------------------------------------------
# NSIS Packager
# https://cmake.org/cmake/help/latest/module/CPack.html

set(CPACK_GENERATOR "NSIS64;ZIP;WIX")

# set(CPACK_PACKAGE_NAME "OneLuaPro")
set(CPACK_PACKAGE_NAME ${ONELUAPRO_FULL_DISTRO_NAME})
set(CPACK_PACKAGE_VENDOR "OneLuaPro Organization")
set(CPACK_PACKAGE_HOMEPAGE_URL "https://github.com/OneLuaPro")
set(CPACK_PACKAGE_VERSION_MAJOR ${LUA_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${LUA_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${LUA_VERSION_PATCH}.${ONELUAPRO_RELEASE})

set(CPACK_PACKAGE_INSTALL_DIRECTORY ${CMAKE_PROJECT_NAME})
set(CPACK_INSTALLED_DIRECTORIES ${ONELUAPRO_PREFIX} .)
set(CPACK_PACKAGE_FILE_NAME ${ONELUAPRO_FULL_DISTRO_NAME})
set(CPACK_RESOURCE_FILE_LICENSE "${PROJECT_SOURCE_DIR}/LICENSE.txt")
set(CPACK_STRIP_FILES ON)

# https://cmake.org/cmake/help/latest/cpack_gen/nsis.html
# https://nsis.sourceforge.io/Docs/Modern%20UI/Readme.html
set(CPACK_NSIS_INSTALL_ROOT "$LOCALAPPDATA")
set(CPACK_NSIS_DEFINES "RequestExecutionLevel user")
set(CPACK_NSIS_FINISH_TITLE_3LINES ON)
set(CPACK_NSIS_MODIFY_PATH ON)
#set(CPACK_NSIS_DISPLAY_NAME ${ONELUAPRO_FULL_DISTRO_NAME})
#set(CPACK_NSIS_PACKAGE_NAME ${ONELUAPRO_FULL_DISTRO_NAME})
set(CPACK_NSIS_DISPLAY_NAME ${CPACK_PACKAGE_NAME})
set(CPACK_NSIS_PACKAGE_NAME ${CPACK_PACKAGE_NAME})
set(CPACK_NSIS_MUI_ICON "${PROJECT_SOURCE_DIR}/logo\\\\lua-logo-olp-dist.ico")
set(CPACK_NSIS_MUI_UNIICON "${PROJECT_SOURCE_DIR}/logo\\\\lua-logo-olp-dist.ico")
set(CPACK_NSIS_INSTALLED_ICON_NAME "bin\\\\lua.exe")
set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL ON)
set(CPACK_NSIS_URL_INFO_ABOUT "https://github.com/OneLuaPro")
set(CPACK_NSIS_MUI_HEADERIMAGE
  "${PROJECT_SOURCE_DIR}/logo\\\\lua-logo-olp-dist-header.bmp")
set(CPACK_NSIS_MUI_WELCOMEFINISHPAGE_BITMAP
  "${PROJECT_SOURCE_DIR}/logo\\\\lua-logo-olp-dist-welcome.bmp")
set(CPACK_NSIS_MUI_UNWELCOMEFINISHPAGE_BITMAP
  "${PROJECT_SOURCE_DIR}/logo\\\\lua-logo-olp-dist-welcome.bmp")
set(CPACK_NSIS_BRANDING_TEXT "https://github.com/OneLuaPro")
set(CPACK_NSIS_MENU_LINKS
  "opt/ZeroBraneStudio/zbstudio.exe" "Lua IDE - ZeroBrane Studio"
  "opt/DistroCheck/DistroCheck.exe" "DistroCheck - Distribution Integrity Checker"
  "bin/lua.exe" "Lua Command Line Interpreter"
  "share/doc/index.html" "OneLuaPro Help Center"  
)

# ------------------------------------------------------------------------------
# WIX
# https://cmake.org/cmake/help/latest/cpack_gen/wix.html
set(CPACK_WIX_UPGRADE_GUID A7B4D8D5-ECF8-43A2-A810-CF803889946E)
set(CPACK_WIX_INSTALL_SCOPE "perMachine")
set(CPACK_WIX_UI_DIALOG "${PROJECT_SOURCE_DIR}/logo/WixUIDialogBmp.bmp")
set(CPACK_WIX_UI_BANNER "${PROJECT_SOURCE_DIR}/logo/WixUIBannerBmp.bmp")
set(CPACK_WIX_PRODUCT_ICON "${PROJECT_SOURCE_DIR}/logo/lua-logo-olp-dist.ico")
# Sign MSI-Installer
if (CODE_SIGN_ID)
  set(CPACK_POST_BUILD_SCRIPTS "${CMAKE_CURRENT_SOURCE_DIR}/cmake/SignMSI.cmake")
endif()
# Configure start Menue Folder Name
set(MENU_FOLDER_NAME "${ONELUAPRO_FULL_DISTRO_NAME}")
configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/wix/start_menu_folder_name.wxs.in"
  "${CMAKE_CURRENT_BINARY_DIR}/wix/start_menu_folder_name.wxs"
  @ONLY
)
# Add WXS-File for start menue entries
set(CPACK_WIX_EXTRA_SOURCES
  "${CMAKE_CURRENT_SOURCE_DIR}/wix/shortcuts.wxs"
  "${CMAKE_CURRENT_BINARY_DIR}/wix/start_menu_folder_name.wxs"
)
# Add XML-patch file for handling of PATH variable, accepting shortcuts at all
# and for creating a sub-dir in Start Menu for all Module's documentation
set(CPACK_WIX_PATCH_FILE
  "${CMAKE_CURRENT_SOURCE_DIR}/wix/path_patch.xml"
  "${CMAKE_CURRENT_SOURCE_DIR}/wix/shortcuts_patch.xml"
)

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
