# ------------------------------------------------------------------------------
# inifile
set(INIFILE_VER "v1.1-1-g43cd83d")
ExternalProject_Add(inifile
  PREFIX ${PROJECT_NAME}/inifile
  GIT_REPOSITORY https://github.com/OneLuaPro/inifile.git
  GIT_TAG ${INIFILE_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(inifile build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "inifile;inifile/README.html;INI Configuration Parser;📊;Data Processing & Formats;${INIFILE_VER}"
)
