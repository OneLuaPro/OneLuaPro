# ------------------------------------------------------------------------------
# luacrc32c
ExternalProject_Add(luacrc32c
  PREFIX ${PROJECT_NAME}/luacrc32c
  GIT_REPOSITORY https://github.com/OneLuaPro/luacrc32c.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luacrc32c build lua crc32c)
