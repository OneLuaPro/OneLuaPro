# ------------------------------------------------------------------------------
# libffi
ExternalProject_Add(libffi
  PREFIX ${PROJECT_NAME}/libffi
  GIT_REPOSITORY https://github.com/OneLuaPro/libffi.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
)
ExternalProject_Add_StepDependencies(libffi build lua)
