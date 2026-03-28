# ------------------------------------------------------------------------------
# lsqlite3
set(LSQLITE3_VER "v0.9.6-2")
ExternalProject_Add(lsqlite3
  PREFIX ${PROJECT_NAME}/lsqlite3
  GIT_REPOSITORY https://github.com/OneLuaPro/lsqlite3.git
  GIT_TAG ${LSQLITE3_VER}
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
add_dependencies(lsqlite3 lua sqlean)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lsqlite3;lsqlite3/lsqlite3.html;SQLite Database Interface;📊;Data Processing & Formats;${LSQLITE3_VER}"
)
