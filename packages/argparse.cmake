# ------------------------------------------------------------------------------
# argparse
set(ARGPARSE_VER "0.7.1-13-gdebe947")
ExternalProject_Add(argparse
  PREFIX ${PROJECT_NAME}/argparse
  GIT_REPOSITORY https://github.com/OneLuaPro/argparse.git
  GIT_TAG ${ARGPARSE_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(argparse build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
    "argparse;argparse/index.html;Command Line Parser;🛠️;Development Tools;${ARGPARSE_VER}"
)
