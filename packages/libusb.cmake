# ------------------------------------------------------------------------------
# libusb
ExternalProject_Add(libusb
  PREFIX ${PROJECT_NAME}/libusb
  GIT_REPOSITORY https://github.com/OneLuaPro/libusb.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
)

