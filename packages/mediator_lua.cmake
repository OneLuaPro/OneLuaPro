# ------------------------------------------------------------------------------
# mediator_lua
#set(MEDIATOR_VER "origin/master")
set(MEDIATOR_VER "v1.1.2-0-8-gefa5daf")
ExternalProject_Add(mediator_lua
  PREFIX ${PROJECT_NAME}/mediator_lua
  GIT_REPOSITORY https://github.com/OneLuaPro/mediator_lua.git
  GIT_TAG ${MEDIATOR_VER}
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
add_dependencies(mediator_lua lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "mediator;mediator/README.html;Publisher/Subscriber Event Aggregator;🧪;Software Engineering & Testing;${MEDIATOR_VER}"
)
