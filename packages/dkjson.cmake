# ------------------------------------------------------------------------------
# dkjson
ExternalProject_Add(dkjson
  PREFIX ${PROJECT_NAME}/dkjson
  GIT_REPOSITORY https://github.com/OneLuaPro/dkjson.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(dkjson build lua)
