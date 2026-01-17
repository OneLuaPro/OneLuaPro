# ------------------------------------------------------------------------------
# inifile
ExternalProject_Add(inifile
  PREFIX ${PROJECT_NAME}/inifile
  GIT_REPOSITORY https://github.com/OneLuaPro/inifile.git
  GIT_TAG "v1.1-1-g43cd83d"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(inifile build lua)
