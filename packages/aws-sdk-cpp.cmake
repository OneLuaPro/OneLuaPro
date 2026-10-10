# ------------------------------------------------------------------------------
# aws-sdk-cpp - AWS SDK for C++, static, /MT (needed by duckdb's aws extension)
# ------------------------------------------------------------------------------
# Only the components required by duckdb-aws are built: core, sso, sts,
# identity-management (pulls in cognito-identity), rds, redshift, cloudformation.
#
# NOTICE Use MSVC at all cost here, as IntelLLVM is not able to compile it:
# aws-checksums uses SIMD intrinsics that need target-feature flags (e.g.
# -msse4.2) which CMake does not pass for clang-cl. Static libs built by cl.exe
# link fine into IntelLLVM builds (same MSVC ABI) as long as both sides use
# /MT and Release.
#
# Consumers (duckdb, luasql) find the package in ONELUAPRO_BUILDROOT
# (lib/cmake/AWSSDK) via CMAKE_INSTALL_PREFIX, no CMAKE_PREFIX_PATH needed.
ExternalProject_Add(aws-sdk-cpp
  PREFIX ${PROJECT_NAME}/aws-sdk-cpp
  GIT_REPOSITORY https://github.com/aws/aws-sdk-cpp.git
  GIT_TAG "1.11.906"
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  # placeholder so ';'-separated CMAKE_ARGS values (BUILD_ONLY) survive intact;
  # swapped back to ';' only in the final command line
  LIST_SEPARATOR |
  CMAKE_ARGS
  "-Wno-dev"
  # Install path
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"

  # Options
  # Release is explicit on purpose: single-config generator
  "-DCMAKE_BUILD_TYPE=Release"
  # "-DBUILD_ONLY=core|sso|sts|identity-management|rds|redshift|cloudformation"
  "-DBUILD_ONLY=core|sso|sts|identity-management|rds"
  "-DBUILD_SHARED_LIBS=OFF"
  "-DFORCE_SHARED_CRT=OFF"
  "-DENABLE_TESTING=OFF"
  "-DAWS_SDK_WARNINGS_ARE_ERRORS=OFF"
  # zlib is not found by name (library is called zlibstatic.lib), so give hints
  "-DZLIB_INCLUDE_DIR=${ONELUAPRO_BUILDROOT}/include"
  "-DZLIB_LIBRARY=${ONELUAPRO_BUILDROOT}/lib/zlibstatic.lib"

  "-G${CMAKE_GENERATOR}"
  # Compiler settings
  # Flags are set explicitly on purpose: CMake seeds CMAKE_C_FLAGS/CMAKE_CXX_FLAGS
  # from the CFLAGS/CXXFLAGS environment variables, which may carry Intel-only
  # options. No SUPERBUILD_* flags and no IPO options here either, they are
  # meant for IntelLLVM.
  "-DCMAKE_C_COMPILER=cl.exe"
  "-DCMAKE_CXX_COMPILER=cl.exe"
  "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS"
  "-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /EHsc"
  # Runtime lib settings
  # The SDK requires CMake 3.13 only, so CMP0091 must be NEW or
  # CMAKE_MSVC_RUNTIME_LIBRARY is silently ignored (also by the CRT submodules)
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_POLICY_DEFAULT_CMP0091=NEW"
  ${GENERATOR_ARGS}
)
# zlib must be built first if it is a package of this superbuild, e.g.
add_dependencies(aws-sdk-cpp zlib-ng)
