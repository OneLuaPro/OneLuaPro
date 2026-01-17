# ------------------------------------------------------------------------------
# luaping
ExternalProject_Add(luaping
  PREFIX ${PROJECT_NAME}/luaping
  GIT_REPOSITORY https://github.com/OneLuaPro/luaping.git
  GIT_TAG "v1.1.1"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luaping build lua)
