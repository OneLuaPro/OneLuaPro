# ------------------------------------------------------------------------------
# distro
ExternalProject_Add(distro
  PREFIX ${PROJECT_NAME}/distro
  GIT_REPOSITORY https://github.com/OneLuaPro/distro.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-DONELUAPRO_VERSION=${ONELUAPRO_VERSION}"
  "-DONELUAPRO_CANDIDATE=${ONELUAPRO_CANDIDATE}"
)
ExternalProject_Add_StepDependencies(distro build lua)
