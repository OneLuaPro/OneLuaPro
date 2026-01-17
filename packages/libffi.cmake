# ------------------------------------------------------------------------------
# libffi
ExternalProject_Add(libffi
  PREFIX ${PROJECT_NAME}/libffi
  GIT_REPOSITORY https://github.com/OneLuaPro/libffi.git
  GIT_TAG "v3.5.2-25-ge74b641"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
)
ExternalProject_Add_StepDependencies(libffi build lua)
