# ------------------------------------------------------------------------------
# lua-zlib
#set(LUA_ZLIB_VER "origin/master")
set(LUA_ZLIB_VER "v1.4-6-gdb5b875")
ExternalProject_Add(lua-zlib
  PREFIX ${PROJECT_NAME}/lua-zlib
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-zlib.git
  GIT_TAG ${LUA_ZLIB_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_SHARED_LINKER_FLAGS=${SUPERBUILD_SHARED_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  ${GENERATOR_ARGS}
)
add_dependencies(lua-zlib lua zlib-ng)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lua-zlib;lua-zlib/lua-zlib.html;Zlib Streaming & Compression;📊;Data Processing & Formats;${LUA_ZLIB_VER}"
)
