# ------------------------------------------------------------------------------
# Lua interpreter, libs and all basic stuff
set(LUA_VER "v5.4.8-1-gfdac66f")
ExternalProject_Add(lua
  PREFIX ${PROJECT_NAME}/lua
  GIT_REPOSITORY https://github.com/OneLuaPro/lua.git
  GIT_TAG ${LUA_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
)
ExternalProject_Add_Step(lua post_install
  # After lua bootstrap copy relevant files to post_installaton location
  COMMENT "Installing lua into ${ONELUAPRO_PREFIX}"
  DEPENDEES install
  # copy bin
  COMMAND ${CMAKE_COMMAND} -E copy_directory ${ONELUAPRO_BUILDROOT}/bin
  ${ONELUAPRO_PREFIX}/bin
  # copy share/doc/lua
  COMMAND ${CMAKE_COMMAND} -E copy_directory ${ONELUAPRO_BUILDROOT}/share/doc/lua
  ${ONELUAPRO_PREFIX}/share/doc/lua
)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "Lua;lua/contents.html;Lua Core Reference;💎;Core & Language;${LUA_VER}"
)
