# ------------------------------------------------------------------------------
# busted
set(BUSTED_VER "v2.3.0-2-g15cd4a7")
ExternalProject_Add(busted
  PREFIX ${PROJECT_NAME}/busted
  GIT_REPOSITORY https://github.com/OneLuaPro/busted.git
  GIT_TAG ${BUSTED_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(busted build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "busted;busted/index.html;Unit Testing Framework;🧪;Software Engineering & Testing;${BUSTED_VER}"
)
