# ------------------------------------------------------------------------------
# luacrc32c
set(LUACRC32C_VER "v1.0")
ExternalProject_Add(luacrc32c
  PREFIX ${PROJECT_NAME}/luacrc32c
  GIT_REPOSITORY https://github.com/OneLuaPro/luacrc32c.git
  GIT_TAG ${LUACRC32C_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luacrc32c build lua crc32c)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "luacrc32c;luacrc32c/luacrc32c.html;Hardware-Accelerated CRC32C;📊;Data Processing & Formats;${LUACRC32C_VER}"
)

