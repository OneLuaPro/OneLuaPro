# ------------------------------------------------------------------------------
# luautf8
ExternalProject_Add(luautf8
  PREFIX ${PROJECT_NAME}/luautf8
  GIT_REPOSITORY https://github.com/OneLuaPro/luautf8.git
  GIT_TAG "0.2.0-2-g9d0c813"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luautf8 build lua)
