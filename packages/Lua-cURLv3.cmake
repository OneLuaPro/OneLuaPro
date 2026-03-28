# ------------------------------------------------------------------------------
# Lua-cURLv3
#set(LUA_CURLV3_VER "origin/master")
set(LUA_CURLV3_VER "v0.3.13-6-gbd885bd")
ExternalProject_Add(Lua-cURLv3
  PREFIX ${PROJECT_NAME}/Lua-cURLv3
  GIT_REPOSITORY https://github.com/OneLuaPro/Lua-cURLv3.git
  GIT_TAG ${LUA_CURLV3_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-DONELUAPRO=ON"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS}"	# no SUPERBUILD_IPO_OPTS here
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_SHARED_LINKER_FLAGS=${SUPERBUILD_SHARED_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  ${GENERATOR_ARGS}
)
add_dependencies(Lua-cURLv3 lua curl ldoc)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "Lua-cURLv3;Lua-cURLv3/doc/manual/readme.md.html;Client-side URL transfer library (cURL);🌐;Networking & Security;${LUA_CURLV3_VER}"
)
