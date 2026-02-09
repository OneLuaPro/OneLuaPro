# ------------------------------------------------------------------------------
# luautf8
set(LUA_UTF8_VER "0.2.0-2-g9d0c813")
ExternalProject_Add(luautf8
  PREFIX ${PROJECT_NAME}/luautf8
  GIT_REPOSITORY https://github.com/OneLuaPro/luautf8.git
  GIT_TAG ${LUA_UTF8_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luautf8 build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lua-utf8;lua-utf8/README.html;UTF-8 Support for Lua;💎;Core & Language;${LUA_UTF8_VER}"
)

