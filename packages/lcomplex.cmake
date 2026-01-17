# ------------------------------------------------------------------------------
# lcomplex
ExternalProject_Add(lcomplex
  PREFIX ${PROJECT_NAME}/lcomplex
  GIT_REPOSITORY https://github.com/OneLuaPro/lcomplex.git
  GIT_TAG "v1.0"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lcomplex build lua)
