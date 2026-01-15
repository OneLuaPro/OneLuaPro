# ------------------------------------------------------------------------------
# say
ExternalProject_Add(say
  PREFIX ${PROJECT_NAME}/say
  GIT_REPOSITORY https://github.com/OneLuaPro/say.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(say build lua)
