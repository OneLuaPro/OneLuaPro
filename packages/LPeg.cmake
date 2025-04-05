# ------------------------------------------------------------------------------
# LPeg
ExternalProject_Add(LPeg
  PREFIX ${PROJECT_NAME}/LPeg
  GIT_REPOSITORY https://github.com/OneLuaPro/LPeg.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(LPeg build lua)
