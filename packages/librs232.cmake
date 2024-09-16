# ------------------------------------------------------------------------------
# librs232
ExternalProject_Add(librs232
  PREFIX ${PROJECT_NAME}/librs232
  GIT_REPOSITORY https://github.com/OneLuaPro/librs232.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(librs232 build lua)
