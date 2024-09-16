# ------------------------------------------------------------------------------
# luacheck
ExternalProject_Add(luacheck
  PREFIX ${PROJECT_NAME}/luacheck
  GIT_REPOSITORY https://github.com/OneLuaPro/luacheck.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luacheck build lua argparse luafilesystem lanes)
