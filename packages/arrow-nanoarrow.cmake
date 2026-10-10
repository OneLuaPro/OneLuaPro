# ------------------------------------------------------------------------------
# arrow-nanoarrow - minimal C library for Apache Arrow, built with IPC support
# Build prerequisite for azure-storage-blobs >= 12.19.0, which calls
# find_package(nanoarrow) and links nanoarrow::nanoarrow_static and
# nanoarrow::nanoarrow_ipc_static.
#
# NANOARROW_IPC=ON also installs flatccrt.lib (FlatBuffers runtime). It is not a
# package of its own here; nanoarrow's configure step apparently fetches and
# builds it itself, so that step needs network access.
#
# Built with IntelLLVM like the other C libraries, with the options of the
# manual build only: no IPO options, as the shared nanoarrow libraries are
# built as well and are linked without matching linker flags.
# CMP0091 NEW: the project requires an old CMake only, so
# CMAKE_MSVC_RUNTIME_LIBRARY would be silently ignored otherwise.
ExternalProject_Add(arrow-nanoarrow
  PREFIX ${PROJECT_NAME}/arrow-nanoarrow
  GIT_REPOSITORY https://github.com/apache/arrow-nanoarrow.git
  GIT_TAG "apache-arrow-nanoarrow-0.9.0"
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DNANOARROW_IPC=ON"
  "-DCMAKE_POLICY_DEFAULT_CMP0091=NEW"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS} ${LUA_IPO_OPTS}"
  "-DCMAKE_CXX_FLAGS=${SUPERBUILD_CXX_FLAGS} ${LUA_IPO_OPTS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${LUA_IPO_OPTS}"
  "-DCMAKE_SHARED_LINKER_FLAGS=${SUPERBUILD_SHARED_LINKER_FLAGS} ${LUA_IPO_OPTS}"
  "-DCMAKE_STATIC_LINKER_FLAGS=${SUPERBUILD_STATIC_LINKER_FLAGS}"
  ${GENERATOR_ARGS}
)
