# ------------------------------------------------------------------------------
# lua-ffi
set(LUA_FFI_VER "v1.1.0-22-gb95c731")
ExternalProject_Add(lua-ffi
  PREFIX ${PROJECT_NAME}/lua-ffi
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-ffi.git
  GIT_TAG ${LUA_FFI_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-DCMAKE_PREFIX_PATH=${ONELUAPRO_BUILDROOT}"
)
ExternalProject_Add_StepDependencies(lua-ffi build libffi winflexbison dlfcn-win32)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lua-ffi;lua-ffi/lua-ffi.html;C Foreign Function Interface;🔌;Hardware & System Interfaces;${LUA_FFI_VER}"
)
