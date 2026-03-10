# ------------------------------------------------------------------------------
# lua-ffi
#set(LUA_FFI_VER "origin/main")
set(LUA_FFI_VER "v1.1.0-24-gbc3fc37")
ExternalProject_Add(lua-ffi
  PREFIX ${PROJECT_NAME}/lua-ffi
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-ffi.git
  GIT_TAG ${LUA_FFI_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-DCMAKE_PREFIX_PATH=${ONELUAPRO_BUILDROOT}"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_MODULE_LINKER_FLAGS=${SUPERBUILD_SHARED_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  ${GENERATOR_ARGS}
)
add_dependencies(lua-ffi libffi winflexbison dlfcn-win32)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lua-ffi;lua-ffi/lua-ffi.html;C Foreign Function Interface;🔌;Hardware & System Interfaces;${LUA_FFI_VER}"
)
