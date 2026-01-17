# ------------------------------------------------------------------------------
# moonusb
ExternalProject_Add(moonusb
  PREFIX ${PROJECT_NAME}/moonusb
  GIT_REPOSITORY https://github.com/OneLuaPro/moonusb.git
  GIT_TAG "v0.1-28-g5d71db5"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(moonusb build lua libusb)
