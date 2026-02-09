# ------------------------------------------------------------------------------
# lsleep
set(LSLEEP_VER "v1.05-5-g9e4bdf2")
ExternalProject_Add(lsleep
  PREFIX ${PROJECT_NAME}/lsleep
  GIT_REPOSITORY https://github.com/OneLuaPro/lsleep.git
  GIT_TAG ${LSLEEP_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lsleep build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lsleep;lsleep/index.html;High Resolution Sleep;💎;Core & Language;${LSLEEP_VER}"
)

