# ------------------------------------------------------------------------------
# librs232
set(LIBRS232_VER "v1.0.3-118-g1171731")
ExternalProject_Add(librs232
  PREFIX ${PROJECT_NAME}/librs232
  GIT_REPOSITORY https://github.com/OneLuaPro/librs232.git
  GIT_TAG ${LIBRS232_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(librs232 build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "librs232;librs232/librs232.html;Serial Communication (RS-232);🔌;Hardware & System Interfaces;${LIBRS232_VER}"
)
