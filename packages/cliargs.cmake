# ------------------------------------------------------------------------------
# cliargs
set(CLIARGS_VER "v3.0.2-7-gc4cf5f0")
ExternalProject_Add(cliargs
  PREFIX ${PROJECT_NAME}/cliargs
  GIT_REPOSITORY https://github.com/OneLuaPro/lua_cliargs.git
  GIT_TAG ${CLIARGS_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-G${CMAKE_GENERATOR}"
  ${GENERATOR_ARGS}
)
add_dependencies(cliargs lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "cliargs;cliargs/README.html;Command-Line Argument Parsing;🛠️;Development Tools;${CLIARGS_VER}"
)
