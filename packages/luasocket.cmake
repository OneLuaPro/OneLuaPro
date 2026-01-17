# ------------------------------------------------------------------------------
# luasocket
ExternalProject_Add(luasocket
  PREFIX ${PROJECT_NAME}/luasocket
  GIT_REPOSITORY https://github.com/OneLuaPro/luasocket.git
  GIT_TAG "v3.1.0-71-gcb1c0e5"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luasocket build lua)
