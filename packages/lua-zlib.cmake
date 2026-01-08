# ------------------------------------------------------------------------------
# lua-zlib
ExternalProject_Add(lua-zlib
  PREFIX ${PROJECT_NAME}/lua-zlib
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-zlib.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lua-zlib build lua zlib-ng)
