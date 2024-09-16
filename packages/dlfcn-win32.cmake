# ------------------------------------------------------------------------------
# dlfcn-win32
# Build prerequisite for lua-ffi only, not included in OLP distribution
ExternalProject_Add(dlfcn-win32
  PREFIX ${PROJECT_NAME}/dlfcn-win32
  GIT_REPOSITORY https://github.com/dlfcn-win32/dlfcn-win32.git
  GIT_TAG "v1.4.1"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DBUILD_SHARED_LIBS=OFF"
)
