# ------------------------------------------------------------------------------
# lanes
#set(LANES_VER "origin/master")
set(LANES_VER "v4.0.0-42-g70389ef")
ExternalProject_Add(lanes
  PREFIX ${PROJECT_NAME}/lanes
  GIT_REPOSITORY https://github.com/OneLuaPro/lanes.git
  GIT_TAG ${LANES_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_CXX_FLAGS=${SUPERBUILD_CXX_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_MODULE_LINKER_FLAGS=${SUPERBUILD_SHARED_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  ${GENERATOR_ARGS}
)
add_dependencies(lanes lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "Lanes;lanes/index.html;Parallel Execution Framework;🧪;Software Engineering & Testing;${LANES_VER}"
)
