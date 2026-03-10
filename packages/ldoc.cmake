# ------------------------------------------------------------------------------
# ldoc
#set(LDOC_VER "origin/master")
set(LDOC_VER "v1.5.0-23-g38be0fa")
ExternalProject_Add(ldoc
  PREFIX ${PROJECT_NAME}/ldoc
  GIT_REPOSITORY https://github.com/OneLuaPro/ldoc.git
  GIT_TAG ${LDOC_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_CXX_FLAGS=${SUPERBUILD_CXX_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_STATIC_LINKER_FLAGS=${SUPERBUILD_STATIC_LINKER_FLAGS}"
  ${GENERATOR_ARGS}
)
add_dependencies(ldoc lua Penlight luafilesystem)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "ldoc;ldoc/manual.html;Lua Documentation Generator;🛠️;Development Tools;${LDOC_VER}"
)
