# ------------------------------------------------------------------------------
# lua-zlib
set(LUA_ZLIB_VER "v1.4-5-g2dd8f48")
ExternalProject_Add(lua-zlib
  PREFIX ${PROJECT_NAME}/lua-zlib
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-zlib.git
  GIT_TAG ${LUA_ZLIB_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lua-zlib build lua zlib-ng)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lua-zlib;lua-zlib/lua-zlib.html;Zlib Streaming & Compression;📊;Data Processing & Formats;${LUA_ZLIB_VER}"
)

