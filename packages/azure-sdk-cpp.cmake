# ------------------------------------------------------------------------------
# Azure SDK for C++ - static, /MT (needed by duckdb's azure extension)
#
# duckdb-azure asks for azure-identity-cpp, azure-storage-blobs-cpp and
# azure-storage-files-datalake-cpp via find_package(... CONFIG). Their
# dependencies azure-core-cpp and azure-storage-common-cpp are built as well.
# All packages live in one monorepo but are versioned and tagged individually
# (<package-name>_<package-version>), so each one is built from its own sdk/...
# subdirectory.
#
# Prerequisites (separate packages):
#   wil              azure-core (WinHTTP is the default transport on Windows)
#                    and azure-identity need it. See wil.cmake for the version.
#   arrow-nanoarrow  azure-storage-blobs >= 12.19.0 needs it.
#
# NOTICE Built with MSVC (cl.exe) like aws-sdk-cpp. Static libs built by cl.exe
# link fine into IntelLLVM builds (same MSVC ABI) as long as both sides use /MT
# and Release.
#
# Consumers (duckdb, luasql) find the packages in ONELUAPRO_BUILDROOT via
# CMAKE_INSTALL_PREFIX. The SDK installs its CMake config files to
# share/azure-*-cpp (not lib/cmake), and the configs of azure-identity and
# azure-storage-blobs call find_dependency() for wil and nanoarrow.

set(AZURE_CORE_TAG      "azure-core_1.16.4")
set(AZURE_IDENTITY_TAG  "azure-identity_1.13.3")
set(AZURE_COMMON_TAG    "azure-storage-common_12.15.0")
set(AZURE_BLOBS_TAG     "azure-storage-blobs_12.19.0")
set(AZURE_DATALAKE_TAG  "azure-storage-files-datalake_12.17.0")

# The SDK's AzureVcpkg module clones and uses vcpkg on its own, unless the
# ENVIRONMENT variable AZURE_SDK_DISABLE_AUTO_VCPKG is defined (a -D cache
# variable does not count). Therefore the configure step is wrapped in
# "cmake -E env" instead of using the default configure command and CMAKE_ARGS.
set(AZURE_CONFIGURE_PREFIX
  ${CMAKE_COMMAND} -E env AZURE_SDK_DISABLE_AUTO_VCPKG=1 ${CMAKE_COMMAND})
set(AZURE_BUILD_COMMAND   ${CMAKE_COMMAND} --build <BINARY_DIR>)
set(AZURE_INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR>)

# Arguments shared by all five packages
set(AZURE_SDK_CMAKE_ARGS
  "-Wno-dev"
  # Install path
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_PREFIX_PATH=${ONELUAPRO_BUILDROOT}"

  # Options
  # Release is explicit on purpose: single-config generator
  "-DCMAKE_BUILD_TYPE=Release"
  "-DBUILD_SHARED_LIBS=OFF"
  "-DBUILD_TESTING=OFF"
  "-DWARNINGS_AS_ERRORS=OFF"
  # The packages require an old CMake only, so their export(PACKAGE) would
  # register the build trees in the user package registry (HKCU)
  "-DCMAKE_EXPORT_NO_PACKAGE_REGISTRY=ON"
  # Select both transport options - duckdb-azure requirs both
  "-DBUILD_TRANSPORT_CURL=ON"
  "-DBUILD_TRANSPORT_WINHTTP=ON"

  "-G${CMAKE_GENERATOR}"
  # Compiler settings (the packages are C++ only)
  # Flags are set explicitly on purpose: CMake seeds CMAKE_CXX_FLAGS from the
  # CXXFLAGS environment variable, which may carry Intel-only options. No
  # SUPERBUILD_* flags and no IPO options here either, they are meant for
  # IntelLLVM.
  "-DCMAKE_CXX_COMPILER=cl.exe"
  "-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /EHsc"
  # Runtime lib settings
  # The packages require an old CMake only and do not have the
  # MSVC_USE_STATIC_CRT logic of the SDK's top-level project, so CMP0091 must be
  # NEW or CMAKE_MSVC_RUNTIME_LIBRARY is silently ignored. Check the result
  # with dumpbin /directives.
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded"
  "-DCMAKE_POLICY_DEFAULT_CMP0091=NEW"
  ${GENERATOR_ARGS}
)

ExternalProject_Add(azure-core-cpp
  PREFIX ${PROJECT_NAME}/azure-core-cpp
  GIT_REPOSITORY https://github.com/Azure/azure-sdk-for-cpp.git
  GIT_TAG "${AZURE_CORE_TAG}"
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  CONFIGURE_COMMAND ${AZURE_CONFIGURE_PREFIX}
  -S <SOURCE_DIR>/sdk/core/azure-core -B <BINARY_DIR>
  ${AZURE_SDK_CMAKE_ARGS}
  BUILD_COMMAND ${AZURE_BUILD_COMMAND}
  INSTALL_COMMAND ${AZURE_INSTALL_COMMAND}
)
add_dependencies(azure-core-cpp wil curl)

ExternalProject_Add(azure-identity-cpp
  PREFIX ${PROJECT_NAME}/azure-identity-cpp
  GIT_REPOSITORY https://github.com/Azure/azure-sdk-for-cpp.git
  GIT_TAG "${AZURE_IDENTITY_TAG}"
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  CONFIGURE_COMMAND ${AZURE_CONFIGURE_PREFIX}
  -S <SOURCE_DIR>/sdk/identity/azure-identity -B <BINARY_DIR>
  ${AZURE_SDK_CMAKE_ARGS}
  BUILD_COMMAND ${AZURE_BUILD_COMMAND}
  INSTALL_COMMAND ${AZURE_INSTALL_COMMAND}
)
add_dependencies(azure-identity-cpp azure-core-cpp)

ExternalProject_Add(azure-storage-common-cpp
  PREFIX ${PROJECT_NAME}/azure-storage-common-cpp
  GIT_REPOSITORY https://github.com/Azure/azure-sdk-for-cpp.git
  GIT_TAG "${AZURE_COMMON_TAG}"
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  CONFIGURE_COMMAND ${AZURE_CONFIGURE_PREFIX}
  -S <SOURCE_DIR>/sdk/storage/azure-storage-common -B <BINARY_DIR>
  ${AZURE_SDK_CMAKE_ARGS}
  BUILD_COMMAND ${AZURE_BUILD_COMMAND}
  INSTALL_COMMAND ${AZURE_INSTALL_COMMAND}
)
add_dependencies(azure-storage-common-cpp azure-identity-cpp)

ExternalProject_Add(azure-storage-blobs-cpp
  PREFIX ${PROJECT_NAME}/azure-storage-blobs-cpp
  GIT_REPOSITORY https://github.com/Azure/azure-sdk-for-cpp.git
  GIT_TAG "${AZURE_BLOBS_TAG}"
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  CONFIGURE_COMMAND ${AZURE_CONFIGURE_PREFIX}
  -S <SOURCE_DIR>/sdk/storage/azure-storage-blobs -B <BINARY_DIR>
  ${AZURE_SDK_CMAKE_ARGS}
  BUILD_COMMAND ${AZURE_BUILD_COMMAND}
  INSTALL_COMMAND ${AZURE_INSTALL_COMMAND}
)
add_dependencies(azure-storage-blobs-cpp arrow-nanoarrow azure-storage-common-cpp)

ExternalProject_Add(azure-storage-files-datalake-cpp
  PREFIX ${PROJECT_NAME}/azure-storage-files-datalake-cpp
  GIT_REPOSITORY https://github.com/Azure/azure-sdk-for-cpp.git
  GIT_TAG "${AZURE_DATALAKE_TAG}"
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  CONFIGURE_COMMAND ${AZURE_CONFIGURE_PREFIX}
  -S <SOURCE_DIR>/sdk/storage/azure-storage-files-datalake -B <BINARY_DIR>
  ${AZURE_SDK_CMAKE_ARGS}
  BUILD_COMMAND ${AZURE_BUILD_COMMAND}
  INSTALL_COMMAND ${AZURE_INSTALL_COMMAND}
)
add_dependencies(azure-storage-files-datalake-cpp azure-storage-blobs-cpp)
