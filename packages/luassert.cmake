# ------------------------------------------------------------------------------
# luassert
ExternalProject_Add(luassert
  PREFIX ${PROJECT_NAME}/luassert
  GIT_REPOSITORY https://github.com/OneLuaPro/luassert.git
  GIT_TAG "v1.9.0-12-gcad10e9"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luassert build lua)
