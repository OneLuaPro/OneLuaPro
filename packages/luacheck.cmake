# ------------------------------------------------------------------------------
# luacheck
set(LUACHECK_VER "v1.2.0-34-ge583448")
ExternalProject_Add(luacheck
  PREFIX ${PROJECT_NAME}/luacheck
  GIT_REPOSITORY https://github.com/OneLuaPro/luacheck.git
  GIT_TAG ${LUACHECK_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luacheck build lua argparse luafilesystem lanes)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "luacheck;luacheck/index.html;Static Analysis & Linter;🛠️;Development Tools;${LUACHECK_VER}"
)

