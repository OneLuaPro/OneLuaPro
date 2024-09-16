# ------------------------------------------------------------------------------
# lanes
ExternalProject_Add(lanes
  PREFIX ${PROJECT_NAME}/lanes
  GIT_REPOSITORY https://github.com/OneLuaPro/lanes.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lanes build lua)
