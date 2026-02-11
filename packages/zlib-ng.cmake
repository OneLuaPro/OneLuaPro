# ------------------------------------------------------------------------------
# zlib-ng - unaltered, original
ExternalProject_Add(zlib-ng
  PREFIX ${PROJECT_NAME}/zlib-ng
  GIT_REPOSITORY https://github.com/zlib-ng/zlib-ng.git
  GIT_TAG "2.3.3"
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DBUILD_SHARED_LIBS=OFF"
  "-DBUILD_TESTING=OFF"
  "-DZLIB_COMPAT=ON"
)
