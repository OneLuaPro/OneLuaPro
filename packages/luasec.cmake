# ------------------------------------------------------------------------------
# luasec
ExternalProject_Add(luasec
  PREFIX ${PROJECT_NAME}/luasec
  GIT_REPOSITORY https://github.com/OneLuaPro/luasec.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luasec build lua luasocket)
