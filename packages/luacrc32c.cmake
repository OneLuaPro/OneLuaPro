# ------------------------------------------------------------------------------
# luacrc32c
#set(LUACRC32C_VER "origin/master")
set(LUACRC32C_VER "v1.0.1")
ExternalProject_Add(luacrc32c
  PREFIX ${PROJECT_NAME}/luacrc32c
  GIT_REPOSITORY https://github.com/OneLuaPro/luacrc32c.git
  GIT_TAG ${LUACRC32C_VER}
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
add_dependencies(luacrc32c lua crc32c)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "luacrc32c;luacrc32c/luacrc32c.html;Hardware-Accelerated CRC32C;📊;Data Processing & Formats;${LUACRC32C_VER}"
)
