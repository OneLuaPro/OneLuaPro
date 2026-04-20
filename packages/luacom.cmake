# ------------------------------------------------------------------------------
# luacom
#set(LUACOM_VER "origin/master")
set(LUACOM_VER "v1.4.1-93-g16aebd4")
ExternalProject_Add(luacom
  PREFIX ${PROJECT_NAME}/luacom
  GIT_REPOSITORY https://github.com/OneLuaPro/luacom.git
  GIT_TAG ${LUACOM_VER}
  GIT_PROGRESS FALSE
  SOURCE_SUBDIR "build"
  CMAKE_ARGS
  "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_CXX_FLAGS=${SUPERBUILD_CXX_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_SHARED_LINKER_FLAGS=${SUPERBUILD_SHARED_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  ${GENERATOR_ARGS}
)
add_dependencies(luacom lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "LuaCOM;luacom/luacom.html;Component Object Model (COM) Bindings;🤖;Process Communication & Automation;${LUACOM_VER}"
)
