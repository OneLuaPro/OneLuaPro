# ------------------------------------------------------------------------------
# lsleep
ExternalProject_Add(lsleep
  PREFIX ${PROJECT_NAME}/lsleep
  GIT_REPOSITORY https://github.com/OneLuaPro/lsleep.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lsleep build lua)
