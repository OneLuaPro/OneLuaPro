# ------------------------------------------------------------------------------
# ldoc
set(LDOC_VER "v1.5.0-14-gc5e6601")
ExternalProject_Add(ldoc
  PREFIX ${PROJECT_NAME}/ldoc
  GIT_REPOSITORY https://github.com/OneLuaPro/ldoc.git
  GIT_TAG ${LDOC_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(ldoc build lua Penlight luafilesystem)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "ldoc;ldoc/manual.html;Lua Documentation Generator;🛠️;Development Tools;${LDOC_VER}"
)
