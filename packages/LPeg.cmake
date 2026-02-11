# ------------------------------------------------------------------------------
# LPeg
set(LPEG_VER "v1.1.0-4-g4190cdb")
ExternalProject_Add(LPeg
  PREFIX ${PROJECT_NAME}/LPeg
  GIT_REPOSITORY https://github.com/OneLuaPro/LPeg.git
  GIT_TAG ${LPEG_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(LPeg build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "LPeg;lpeg/index.html;Parsing Expression Grammars;📊;Data Processing & Formats;${LPEG_VER}"
)
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "re;lpeg/re.html;Regex Syntax for LPeg;📊;Data Processing & Formats;${LPEG_VER}"
)
