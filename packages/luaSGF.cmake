# ------------------------------------------------------------------------------
# Lua bindings for Savitzky-Golay-Filter
# luaSGF
#set(LUASGF_VER "origin/master")
set(LUASGF_VER "v2.0.1")
ExternalProject_Add(luaSGF
  PREFIX ${PROJECT_NAME}/luaSGF
  GIT_REPOSITORY https://github.com/OneLuaPro/luaSGF.git
  GIT_TAG ${LUASGF_VER}
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
add_dependencies(luaSGF lua Savitzky-Golay-Filter ldoc)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "luaSGF;luaSGF/topics/readme.md.html;Savitzky-Golay Signal Filter;📊;Data Processing & Formats;${LUASGF_VER}"
)
