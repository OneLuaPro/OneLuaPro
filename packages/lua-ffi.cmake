# ------------------------------------------------------------------------------
# lua-ffi
ExternalProject_Add(lua-ffi
  PREFIX ${PROJECT_NAME}/lua-ffi
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-ffi.git
  GIT_TAG "origin/main"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-DCMAKE_PREFIX_PATH=${ONELUAPRO_BUILDROOT}"
)
ExternalProject_Add_StepDependencies(lua-ffi build libffi winflexbison dlfcn-win32)
