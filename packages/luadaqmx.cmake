# ------------------------------------------------------------------------------
# luadaqmx
ExternalProject_Add(luadaqmx
  PREFIX ${PROJECT_NAME}/luadaqmx
  GIT_REPOSITORY https://github.com/OneLuaPro/luadaqmx.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luadaqmx build lua)
