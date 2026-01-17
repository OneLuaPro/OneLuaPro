# ------------------------------------------------------------------------------
# luafilesystem
ExternalProject_Add(luafilesystem
  PREFIX ${PROJECT_NAME}/luafilesystem
  GIT_REPOSITORY https://github.com/OneLuaPro/luafilesystem.git
  GIT_TAG "v1_9_0-9-gc499d80"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luafilesystem build lua)
