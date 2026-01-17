# ------------------------------------------------------------------------------
# busted
ExternalProject_Add(busted
  PREFIX ${PROJECT_NAME}/busted
  GIT_REPOSITORY https://github.com/OneLuaPro/busted.git
  GIT_TAG "v2.3.0-1-g6034609"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(busted build lua)
