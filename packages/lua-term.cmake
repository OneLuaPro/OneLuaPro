# ------------------------------------------------------------------------------
# lua-term
set(LUA_TERM_VER "0.8-6-g1fc5955")
ExternalProject_Add(lua-term
  PREFIX ${PROJECT_NAME}/lua-term
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-term.git
  GIT_TAG ${LUA_TERM_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lua-term build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lua-term;term/README.html;Terminal & Console Control;🔌;Hardware & System Interfaces;${LUA_TERM_VER}"
)

