# ------------------------------------------------------------------------------
# lua4882
ExternalProject_Add(lua4882
  PREFIX ${PROJECT_NAME}/lua4882
  GIT_REPOSITORY https://github.com/OneLuaPro/lua4882.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lua4882 build lua)
