# ------------------------------------------------------------------------------
# lsqlite3
set(LSQLITE3_VER "v0.9.6-0")
ExternalProject_Add(lsqlite3
  PREFIX ${PROJECT_NAME}/lsqlite3
  GIT_REPOSITORY https://github.com/OneLuaPro/lsqlite3.git
  GIT_TAG ${LSQLITE3_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lsqlite3 build lua sqlean)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lsqlite3;lsqlite3/lsqlite3.html;SQLite Database Interface;📊;Data Processing & Formats;${LSQLITE3_VER}"
)

