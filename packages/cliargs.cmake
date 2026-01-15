# ------------------------------------------------------------------------------
# cliargs
ExternalProject_Add(cliargs
  PREFIX ${PROJECT_NAME}/cliargs
  GIT_REPOSITORY https://github.com/OneLuaPro/lua_cliargs.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(cliargs build lua)
