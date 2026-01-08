# ------------------------------------------------------------------------------
# crc32c - unaltered, original
ExternalProject_Add(crc32c
  PREFIX ${PROJECT_NAME}/crc32c
  GIT_REPOSITORY https://github.com/google/crc32c.git
  GIT_TAG "origin/main"
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DCRC32C_BUILD_TESTS=OFF"
  "-DCRC32C_BUILD_BENCHMARKS=OFF"
  "-DBUILD_SHARED_LIBS=OFF"
)
