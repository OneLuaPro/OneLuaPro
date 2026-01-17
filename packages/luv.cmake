# ------------------------------------------------------------------------------
# luv
ExternalProject_Add(luv
  PREFIX ${PROJECT_NAME}/luv
  GIT_REPOSITORY https://github.com/OneLuaPro/luv.git
  GIT_TAG "v1.51.0-1-40-g6f6ae21"
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DUSE_ONELUAPRO=ON" 
  "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luv build lua libuv)
