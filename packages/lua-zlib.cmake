# ------------------------------------------------------------------------------
# lua-zlib
ExternalProject_Add(lua-zlib
  PREFIX ${PROJECT_NAME}/lua-zlib
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-zlib.git
  GIT_TAG "v1.4-5-g2dd8f48"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lua-zlib build lua zlib-ng)
