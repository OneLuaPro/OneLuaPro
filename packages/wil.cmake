# ------------------------------------------------------------------------------
# wil - Windows Implementation Library (header-only)
# Build prerequisite for azure-core (WinHTTP transport) and azure-identity,
# both of which call find_package(wil CONFIG REQUIRED) on Windows.
#
# NOTICE Version v1.0.250325.1 on purpose: newer releases (tested:
# v1.0.260126.7) need C++17 (if constexpr, std::scoped_lock), but the Azure SDK
# packages are compiled as C++14 (they set CMAKE_CXX_STANDARD 14 themselves).
# Do not update without building azure-core and azure-identity again.
#
# Header-only, so the compiler is irrelevant for the result; cl.exe like the
# packages that use it.
ExternalProject_Add(wil
  PREFIX ${PROJECT_NAME}/wil
  GIT_REPOSITORY https://github.com/microsoft/wil.git
  GIT_TAG "v1.0.250325.1"
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  # Install path
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"

  # Options
  "-DCMAKE_BUILD_TYPE=Release"
  "-DWIL_BUILD_TESTS=OFF"

  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=cl.exe"
  "-DCMAKE_CXX_COMPILER=cl.exe"
  ${GENERATOR_ARGS}
)
