# Flags for manual compilation
# use with cmake -C <this file>

# CACHE Types: STRING BOOL PATH
set(CMAKE_GENERATOR "Ninja" CACHE STRING "Generator Type")
set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build Type")

# C Compiler
set(CMAKE_C_COMPILER "icx" CACHE STRING "C Compiler")
set(CMAKE_C_EXTRA_FLAGS "/DCURL_STATICLIB /DDUCKDB_STATIC_BUILD /D_CRT_NONSTDC_NO_WARNINGS /DXML_STATIC /DXML_LARGE_SIZE /D_CRT_SECURE_NO_WARNINGS")
set(CMAKE_C_FLAGS
  "/DWIN32 /D_WINDOWS /O2 /fp:precise /EHsc ${CMAKE_C_EXTRA_FLAGS}"
  CACHE STRING "C Compiler Flags" FORCE)

# C++ Compiler
set(CMAKE_CXX_COMPILER "icx" CACHE STRING "C++ Compiler")
set(CMAKE_CXX_EXTRA_FLAGS "/DCURL_STATICLIB /DDUCKDB_STATIC_BUILD /D_CRT_NONSTDC_NO_WARNINGS /DXML_STATIC /DXML_LARGE_SIZE /D_CRT_SECURE_NO_WARNINGS /clang:-Wno-pass-failed")
set(CMAKE_CXX_FLAGS
  "/DWIN32 /D_WINDOWS /O2 /fp:precise /EHsc ${CMAKE_CXX_EXTRA_FLAGS}"
  CACHE STRING "C++ Compiler Flags" FORCE)

# Runtime Lib
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>"
  CACHE STRING "CRT Settings")

# Linker Settings
set(CMAKE_EXE_LINKER_FLAGS "/Qoption,link,/machine:x64 /Qlibs-static"
  CACHE STRING "EXE Linker Flags" FORCE)
set(CMAKE_SHARED_LINKER_FLAGS "/Qoption,link,/machine:x64 /Qlibs-static"
  CACHE STRING "SHARED Linker Flags" FORCE)
set(CMAKE_STATIC_LINKER_FLAGS "/Qoption,link,/machine:x64"
  CACHE STRING "STATIC Linker Flags" FORCE)

# Paths
set(ONELUAPRO_BUILDROOT "c:/misc/OneLuaPro/intel/ONELUAPRO_BUILDROOT" CACHE PATH "BUILDROOT Path" FORCE)
# set(LUA_HINTS "${ONELUAPRO_BUILDROOT}" CACHE PATH "Lua Path")
set(CMAKE_INSTALL_PREFIX "${ONELUAPRO_BUILDROOT}" CACHE PATH "BUILDROOT Path")

# Options
set(BUILD_UNITTESTS OFF CACHE BOOL "Disable BUILD_UNITTESTS" FORCE)
set(ENABLE_UNITTEST_CPP_TESTS OFF CACHE BOOL "Disable ENABLE_UNITTEST_CPP_TESTS" FORCE)
set(BUILD_SHELL OFF CACHE BOOL "Disable BUILD_SHELL" FORCE)
set(ENABLE_SANITIZER OFF CACHE BOOL "Disable ENABLE_SANITIZER" FORCE)
set(ENABLE_UBSAN OFF CACHE BOOL "Disable ENABLE_UBSAN" FORCE)
set(ENABLE_JEMALLOC OFF CACHE BOOL "Disable ENABLE_JEMALLOC" FORCE)
set(EXTENSION_STATIC_BUILD ON CACHE BOOL "Statically link extensions into DuckDB" FORCE)
set(FETCHCONTENT_QUIET ON CACHE BOOL "Make fetch verbose" FORCE)

# Ignore the CMake package registries: stale build-tree exports must not win over the install
set(CMAKE_FIND_USE_PACKAGE_REGISTRY OFF CACHE BOOL "No user package registry" FORCE)
set(CMAKE_FIND_USE_SYSTEM_PACKAGE_REGISTRY OFF CACHE BOOL "No system package registry" FORCE)

# Standard extensions linked into DuckDB
set(BUILD_EXTENSIONS "core_functions;parquet;json")

# Add loadable extensions as statically linked in objects
#
# Needs adjustments in duckdb/.github/config/extensions/postgres_scanner.cmake
# Needs adjustments in duckdb/.github/config/extensions/mysql_scanner.cmake
# Needs adjustments in duckdb/.github/config/extensions/sqlite_scanner.cmake
# Needs adjustments in duckdb/extension/extension_build_tools.cmake
# Needs patch file duckdb/.github/patches/extensions/postgres_scanner/0001-static-link-libs.patch
# Needs patch file duckdb/.github/patches/extensions/mysql_scanner/0001-static-link-mariadb.patch
# Needs patch file duckdb/.github/patches/extensions/sqlite_scanner/0001-static-link-sqlite.patch
# Needs patch file duckdb/.github/patches/extensions/odbc_scanner/0001-static-link-odbc.patch
#
# Loadable extension postgres_scanner - here statically linked in
string(APPEND BUILD_EXTENSIONS ";postgres_scanner")
set(PostgreSQL_INCLUDE_DIR "${ONELUAPRO_BUILDROOT}/include" CACHE PATH "includes" FORCE)
set(PostgreSQL_LIBRARY "${ONELUAPRO_BUILDROOT}/lib/pq.lib" CACHE FILEPATH "lib" FORCE)

# Loadable extension mysql_scanner - here statically linked in
string(APPEND BUILD_EXTENSIONS ";mysql_scanner")

# Loadable extension sqlite_scanner - here statically linked in, using our own sqlite3/sqlean
string(APPEND BUILD_EXTENSIONS ";sqlite_scanner")
set(SQLite3_INCLUDE_DIR "${ONELUAPRO_BUILDROOT}/include" CACHE PATH "sqlite3 includes" FORCE)
set(SQLite3_LIBRARY "${ONELUAPRO_BUILDROOT}/lib/sqlean.lib" CACHE FILEPATH "sqlite3 (sqlean) lib" FORCE)

# Loadable extension odbc_scanner - here statically linked in
string(APPEND BUILD_EXTENSIONS ";odbc_scanner")

# Loadable extension httpfs - here statically linked in
string(APPEND BUILD_EXTENSIONS ";httpfs")
set(CURL_INCLUDE_DIR "${ONELUAPRO_BUILDROOT}/include" CACHE PATH "curl includes" FORCE)
set(CURL_LIBRARY "${ONELUAPRO_BUILDROOT}/lib/libcurl.lib" CACHE FILEPATH "curl lib" FORCE)

# Loadable extension excel - here statically linked in
string(APPEND BUILD_EXTENSIONS ";excel")

# Loadable extension fts - here statically linked in
string(APPEND BUILD_EXTENSIONS ";fts")

# Loadable extension aws - here statically linked in
string(APPEND BUILD_EXTENSIONS ";aws")
set(ZLIB_INCLUDE_DIR "${ONELUAPRO_BUILDROOT}/include" CACHE PATH "zlib includes" FORCE)
set(ZLIB_LIBRARY "${ONELUAPRO_BUILDROOT}/lib/zlibstatic.lib" CACHE FILEPATH "zlib lib" FORCE)

# Loadable extension azure - here statically linked in
string(APPEND BUILD_EXTENSIONS ";azure")

# Loadable extension vss - here statically linked in
string(APPEND BUILD_EXTENSIONS ";vss")

# Loadable extension spatial - here statically linked in
string(APPEND BUILD_EXTENSIONS ";spatial")

# Finally set all extensions
set(BUILD_EXTENSIONS "${BUILD_EXTENSIONS}" CACHE STRING "Complete Extension List" FORCE)



# set(BUILD_EXTENSIONS CACHE STRING "core_functions;parquet;json;postgres_scanner;excel")


#set(minizip-ng_INCLUDE_DIR CACHE STRING "${ONELUAPRO_BUILDROOT}/include")
#set(minizip-ng_LIBRARY CACHE STRING "${ONELUAPRO_BUILDROOT}/lib/minizip.lib")

# -Wno-dev
