# ------------------------------------------------------------------------------
# minizip-ng - zip library, static, OpenSSL (LibreSSL) crypto
# Needed by duckdb's excel extension: find_package(minizip-ng CONFIG) and
# target MINIZIP::minizip-ng
ExternalProject_Add(minizip-ng
  PREFIX ${PROJECT_NAME}/minizip-ng
  GIT_REPOSITORY https://github.com/zlib-ng/minizip-ng.git
  GIT_TAG "4.2.2"
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  # Install path
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"

  "-DBUILD_SHARED_LIBS=OFF"
  "-DMZ_OPENSSL=ON"
  # Only without the compat layer the project gets the "-ng" suffix, i.e.
  # package minizip-ng and target MINIZIP::minizip-ng, as asked for by
  # duckdb-excel
  "-DMZ_COMPAT=OFF"
  # minizip-ng requires: cmake_minimum_required(VERSION 3.13)
  # -DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY} will be
  # ignored silently, therefore enforce policy CMP0091
  "-DCMAKE_POLICY_DEFAULT_CMP0091=NEW"

  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_STATIC_LINKER_FLAGS=${SUPERBUILD_STATIC_LINKER_FLAGS}"
  ${GENERATOR_ARGS}
)
add_dependencies(minizip-ng libressl zlib-ng zstd)
