# ------------------------------------------------------------------------------
# Penlight
#set(PENLIGHT_VER "origin/master")
set(PENLIGHT_VER "1.15.0-19-g9ece351")
ExternalProject_Add(Penlight
  PREFIX ${PROJECT_NAME}/Penlight
  GIT_REPOSITORY https://github.com/OneLuaPro/Penlight.git
  GIT_TAG ${PENLIGHT_VER}
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
add_dependencies(Penlight lua luafilesystem)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "Penlight;Penlight/index.html;Penlight Utility Collection;💎;Core & Language;${PENLIGHT_VER}"
)
