# ------------------------------------------------------------------------------
# luv
ExternalProject_Add(luv
  PREFIX ${PROJECT_NAME}/luv
  GIT_REPOSITORY https://github.com/OneLuaPro/luv.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luv build lua libuv)
