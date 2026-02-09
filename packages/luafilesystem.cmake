# ------------------------------------------------------------------------------
# luafilesystem
set(LUAFILESYSTEM_VER "v1_9_0-9-gc499d80")
ExternalProject_Add(luafilesystem
  PREFIX ${PROJECT_NAME}/luafilesystem
  GIT_REPOSITORY https://github.com/OneLuaPro/luafilesystem.git
  GIT_TAG ${LUAFILESYSTEM_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luafilesystem build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "LuaFileSystem;luafilesystem/index.html;File System Operations;🔌;Hardware & System Interfaces;${LUAFILESYSTEM_VER}"
)

