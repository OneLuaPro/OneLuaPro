# ------------------------------------------------------------------------------
# luassert
set(LUASSERT_VER "v1.9.0-12-gcad10e9")
ExternalProject_Add(luassert
  PREFIX ${PROJECT_NAME}/luassert
  GIT_REPOSITORY https://github.com/OneLuaPro/luassert.git
  GIT_TAG ${LUASSERT_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luassert build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "luassert;luassert/README.html;Assertion Library for Testing;🧪;Software Engineering & Testing;${LUASSERT_VER}"
)

