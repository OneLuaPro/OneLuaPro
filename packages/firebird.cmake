# ------------------------------------------------------------------------------
# firebird - static client library (fbclient_static.lib) for luasql.firebird
#
# Built with Firebird's own scripts (MSVC, MSBuild) from a fixed commit of the
# master branch (git checkout; the commit id pins the content): the optional
# static client build is not part of a released version yet (v5.0.4 does not
# have it). Its config files, scripts and the
# rename of all non-public symbols (__fbclient_ prefix, done by
# fix_fbclient_static.bat) are Firebird's, see doc/README.StaticClient.md.
#
# What the application has to link: fbclient_static.lib, tomcrypt.lib,
# tommath.lib, and the system libraries (at least ws2_32 and mpr). decnumber is
# merged into fbclient_static.lib.
#
# To move to another commit: change FIREBIRD_COMMIT (the full 40 characters).
# This commit (master, 10 Oct 2026) is Firebird 6.0.0.2210, version string
# WI-T6.0.0.2210 ("Firebird 6.0 Initial", a development snapshot, type T), as
# written in src/jrd/build_no.h. The build number grows with every build, so it
# also tells whether another snapshot is newer.
set(FIREBIRD_COMMIT "5976482c2769c5b7d2f066afef0c63ba95eaf4ca")
find_package(Git REQUIRED)

# fix_fbclient_static.bat needs llvm-ar, llvm-nm and llvm-objcopy in the PATH.
# The Intel oneAPI compiler brings them, in the folder "compiler" below the
# folder of icx.
get_filename_component(FIREBIRD_ICX_BIN "${CMAKE_C_COMPILER}" DIRECTORY)
set(FIREBIRD_LLVM_DIR "${FIREBIRD_ICX_BIN}/compiler")
foreach(FIREBIRD_TOOL llvm-ar llvm-nm llvm-objcopy)
  if(NOT EXISTS "${FIREBIRD_LLVM_DIR}/${FIREBIRD_TOOL}.exe")
    message(FATAL_ERROR
      "firebird: ${FIREBIRD_TOOL}.exe not found in ${FIREBIRD_LLVM_DIR}")
  endif()
endforeach()
file(TO_NATIVE_PATH "${FIREBIRD_LLVM_DIR}" FIREBIRD_LLVM_DIR_NATIVE)

# Build wrapper: sets the PATH for the llvm tools, runs the client-only build
# without the installer (JUSTBUILD: no packaging, so no sed is needed) and
# checks the result, because run_all.bat does not always report a failure.
# %1 is the source directory.
# FB_PROCESSOR_ARCHITECTURE: setenvvar.bat takes the platform from
# PROCESSOR_ARCHITECTURE, which is x86 in a 32-bit cmd.exe (started by a 32-bit
# process through ninja), so the build would be Win32. Forced to x64 here.
# _CL_: Firebird's property sheets set /MD (MultiThreadedDLL); everything else in
# OneLuaPro uses the static runtime (/MT). cl.exe appends _CL_ to its command
# line, so /MT wins; cl prints the harmless warning D9025 for it.
file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/firebird-build.bat"
  "@echo off\r\n"
  "set \"PATH=${FIREBIRD_LLVM_DIR_NATIVE};%PATH%\"\r\n"
  "set FB_PROCESSOR_ARCHITECTURE=AMD64\r\n"
  "set \"_CL_=/MT\"\r\n"
  "cd /d \"%~1\\builds\\win32\" || exit /b 1\r\n"
  "call run_all.bat CLIENT_ONLY=STATIC JUSTBUILD\r\n"
  "if errorlevel 1 exit /b 1\r\n"
  "if not exist \"%~1\\output_x64_release\\lib\\fbclient_static_ms.lib\" exit /b 1\r\n"
  "exit /b 0\r\n"
)
file(TO_NATIVE_PATH "${CMAKE_CURRENT_BINARY_DIR}/firebird-build.bat"
  FIREBIRD_BUILD_BAT)

ExternalProject_Add(firebird
  PREFIX ${PROJECT_NAME}/firebird
  # A shallow clone of a commit id only gets the tips of the branches, so it
  # fails as soon as master has moved on (cmake 3.31 does not fetch the id
  # directly). Fetch exactly this commit. No submodules (vcpkg is not needed).
  DOWNLOAD_COMMAND
  ${GIT_EXECUTABLE} init -q <SOURCE_DIR>
  COMMAND ${GIT_EXECUTABLE} -C <SOURCE_DIR> fetch --depth 1
  https://github.com/FirebirdSQL/firebird.git ${FIREBIRD_COMMIT}
  COMMAND ${GIT_EXECUTABLE} -C <SOURCE_DIR> checkout -q FETCH_HEAD
  UPDATE_COMMAND ""
  # Firebird builds in its own tree (temp\, output_x64_release\)
  BUILD_IN_SOURCE TRUE
  # make_all.bat calls "timeout /t 1 /nobreak", which refuses to run without a
  # console ("Input redirection is not supported"). Ninja gives the step the
  # terminal with this option. Needs an interactive console.
  USES_TERMINAL_BUILD TRUE
  CONFIGURE_COMMAND ""
  BUILD_COMMAND cmd /c ${FIREBIRD_BUILD_BAT} <SOURCE_DIR>
  INSTALL_COMMAND
  ${CMAKE_COMMAND} -E make_directory
  "${ONELUAPRO_BUILDROOT}/include" "${ONELUAPRO_BUILDROOT}/lib"
  COMMAND ${CMAKE_COMMAND} -E copy_directory
  "<SOURCE_DIR>/output_x64_release/include" "${ONELUAPRO_BUILDROOT}/include"
  COMMAND ${CMAKE_COMMAND} -E copy
  "<SOURCE_DIR>/output_x64_release/lib/fbclient_static_ms.lib"
  "${ONELUAPRO_BUILDROOT}/lib/fbclient_static.lib"
  COMMAND ${CMAKE_COMMAND} -E copy
  "<SOURCE_DIR>/extern/libtomcrypt/lib/x64/Release/tomcrypt.lib"
  "${ONELUAPRO_BUILDROOT}/lib"
  COMMAND ${CMAKE_COMMAND} -E copy
  "<SOURCE_DIR>/extern/libtommath/lib/x64/Release/tommath.lib"
  "${ONELUAPRO_BUILDROOT}/lib"
)
