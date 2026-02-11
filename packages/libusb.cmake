# ------------------------------------------------------------------------------
# libusb
ExternalProject_Add(libusb
  PREFIX ${PROJECT_NAME}/libusb
  GIT_REPOSITORY https://github.com/OneLuaPro/libusb.git
  GIT_TAG "v1.0.29-60-gf385e44f"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
)

