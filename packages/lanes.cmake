# ------------------------------------------------------------------------------
# lanes
set(LANES_VER "v4.0.0-pre-df58a33")
ExternalProject_Add(lanes
  PREFIX ${PROJECT_NAME}/lanes
  GIT_REPOSITORY https://github.com/OneLuaPro/lanes.git
  GIT_TAG ${LANES_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lanes build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "Lanes;lanes/index.html;Parallel Execution Framework;🧪;Software Engineering & Testing;${LANES_VER}"
)
