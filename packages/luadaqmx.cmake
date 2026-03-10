# ------------------------------------------------------------------------------
# luadaqmx
#set(LUADAQMX_VER "origin/master")
set(LUADAQMX_VER "v0.1.2")
ExternalProject_Add(luadaqmx
  PREFIX ${PROJECT_NAME}/luadaqmx
  GIT_REPOSITORY https://github.com/OneLuaPro/luadaqmx.git
  GIT_TAG ${LUADAQMX_VER}
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
add_dependencies(luadaqmx lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "luadaqmx;luadaqmx/luadaqmx.html;NI-DAQmx Hardware Interface;🔌;Hardware & System Interfaces;${LUADAQMX_VER}"
)
