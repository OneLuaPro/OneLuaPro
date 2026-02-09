# ------------------------------------------------------------------------------
# moonusb
set(MOONUSB_VER "v0.1-28-g5d71db5")
ExternalProject_Add(moonusb
  PREFIX ${PROJECT_NAME}/moonusb
  GIT_REPOSITORY https://github.com/OneLuaPro/moonusb.git
  GIT_TAG ${MOONUSB_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(moonusb build lua libusb)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "moonusb;moonusb/index.html;USB Device Interface (libusb);🔌;Hardware & System Interfaces;${MOONUSB_VER}"
)
