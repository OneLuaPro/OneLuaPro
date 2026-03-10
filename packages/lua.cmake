# ------------------------------------------------------------------------------
# Lua interpreter, libs and all basic stuff
#set(LUA_VER "origin/main")
set(LUA_VER "v5.5.0-5-g4154493")
ExternalProject_Add(lua
  PREFIX ${PROJECT_NAME}/lua
  GIT_REPOSITORY https://github.com/OneLuaPro/lua.git
  GIT_TAG ${LUA_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_SHARED_LINKER_FLAGS=${SUPERBUILD_SHARED_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_STATIC_LINKER_FLAGS=${SUPERBUILD_STATIC_LINKER_FLAGS}"
  ${GENERATOR_ARGS}
)
ExternalProject_Add_Step(lua post_install
  # After lua bootstrap copy relevant files to post_installaton location
  COMMENT "Installing lua into ${ONELUAPRO_PREFIX}"
  DEPENDEES install
  # copy bin
  COMMAND ${CMAKE_COMMAND} -E copy_directory ${ONELUAPRO_BUILDROOT}/bin
  ${ONELUAPRO_PREFIX}/bin
  # copy lib/lua
  COMMAND ${CMAKE_COMMAND} -E copy_directory ${ONELUAPRO_BUILDROOT}/lib/lua
  ${ONELUAPRO_PREFIX}/lib/lua
  # copy share/doc/lua
  COMMAND ${CMAKE_COMMAND} -E copy_directory ${ONELUAPRO_BUILDROOT}/share/doc/lua
  ${ONELUAPRO_PREFIX}/share/doc/lua
)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "Lua;lua/contents.html;Lua Core Reference;💎;Core & Language;${LUA_VER}"
)
