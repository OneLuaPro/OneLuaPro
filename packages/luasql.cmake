# ------------------------------------------------------------------------------
# luasql - forked from lunarmodules for OneLuaPro
set(LUASQL_VER "origin/master")
ExternalProject_Add(luasql
  PREFIX ${PROJECT_NAME}/luasql
  GIT_REPOSITORY https://github.com/OneLuaPro/luasql.git
  GIT_TAG ${LUASQL_VER}
  GIT_SHALLOW TRUE
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
add_dependencies(luasql lua sqlean mariadb-connector-c postgres-connector-c duckdb firebird)
# Help Center registration
# FIXME
#set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
#  "luasql;luasql/luasql.html;SQLite Database Interface;🗄️;Database Interfaces;${LUASQL_VER}"
#)
