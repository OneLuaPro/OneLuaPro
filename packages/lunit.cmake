# ------------------------------------------------------------------------------
# lunit
set(LUNIT_VER "0.8.1-1-g61e9b3a")
ExternalProject_Add(lunit
  PREFIX ${PROJECT_NAME}/lunit
  GIT_REPOSITORY https://github.com/OneLuaPro/lunit.git
  GIT_TAG ${LUNIT_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lunit build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lunit;lunit/README.html;Unit Testing Framework;🧪;Software Engineering & Testing;${LUNIT_VER}"
)

