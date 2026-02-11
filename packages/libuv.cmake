# ------------------------------------------------------------------------------
# libuv - unaltered, original
ExternalProject_Add(libuv
  PREFIX ${PROJECT_NAME}/libuv
  GIT_REPOSITORY https://github.com/libuv/libuv.git
  GIT_TAG "v1.52.0"
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DBUILD_TESTING=OFF"
  "-DLIBUV_BUILD_SHARED=OFF"
)
