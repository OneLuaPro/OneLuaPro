# ------------------------------------------------------------------------------
# libuv - unaltered, original, locally patched
if(CMAKE_C_COMPILER_ID STREQUAL "IntelLLVM")
  set(INTEL_DISABLED_WARNINGS
    "/clang:-Wno-unused-function"
    "/clang:-Wno-unused-variable"
    "/clang:-Wno-unused-but-set-variable"
    "/clang:-Wno-missing-braces"
  )
  list(JOIN INTEL_DISABLED_WARNINGS " " EXTRA_INTEL_FLAGS)
else()
  set(EXTRA_INTEL_FLAGS "")
endif()
ExternalProject_Add(libuv
  PREFIX ${PROJECT_NAME}/libuv
  GIT_REPOSITORY https://github.com/libuv/libuv.git
  GIT_TAG "v1.52.1"
  GIT_PROGRESS FALSE
  PATCH_COMMAND git apply -p1 "${CMAKE_CURRENT_SOURCE_DIR}/packages/libuv.patch"
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DBUILD_TESTING=OFF"
  "-DLIBUV_BUILD_SHARED=OFF"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS} ${EXTRA_INTEL_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_STATIC_LINKER_FLAGS=${SUPERBUILD_STATIC_LINKER_FLAGS}"
  ${GENERATOR_ARGS}
)
