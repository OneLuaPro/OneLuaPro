# ------------------------------------------------------------------------------
# argparse
ExternalProject_Add(argparse
  PREFIX ${PROJECT_NAME}/argparse
  GIT_REPOSITORY https://github.com/OneLuaPro/argparse.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(argparse build lua)
