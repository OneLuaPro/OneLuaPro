# ------------------------------------------------------------------------------
# mediator_lua
set(MEDIATOR_VER "v1.1.2-0-8-gefa5daf")
ExternalProject_Add(mediator_lua
  PREFIX ${PROJECT_NAME}/mediator_lua
  GIT_REPOSITORY https://github.com/OneLuaPro/mediator_lua.git
  GIT_TAG ${MEDIATOR_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(mediator_lua build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "mediator;mediator/README.html;Publisher/Subscriber Event Aggregator;🧪;Software Engineering & Testing;${MEDIATOR_VER}"
)

