# ------------------------------------------------------------------------------
# luasystem
ExternalProject_Add(luasystem
  PREFIX ${PROJECT_NAME}/luasystem
  GIT_REPOSITORY https://github.com/OneLuaPro/luasystem.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)

