# ------------------------------------------------------------------------------
# dkjson
# set(DKJSON_VER "origin/master")
set(DKJSON_VER "v2.8-1-gf1b7c93")
ExternalProject_Add(dkjson
  PREFIX ${PROJECT_NAME}/dkjson
  GIT_REPOSITORY https://github.com/OneLuaPro/dkjson.git
  GIT_TAG ${DKJSON_VER}
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
add_dependencies(dkjson lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "dkjson;dkjson/dkjson.html;Pure Lua JSON Library;📊;Data Processing & Formats;${DKJSON_VER}"
)
