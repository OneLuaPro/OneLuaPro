# ------------------------------------------------------------------------------
# say
ExternalProject_Add(say
  PREFIX ${PROJECT_NAME}/say
  GIT_REPOSITORY https://github.com/OneLuaPro/say.git
  GIT_TAG "v1.4.1-2-ge4436ea"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(say build lua)
