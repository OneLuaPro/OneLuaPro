# ------------------------------------------------------------------------------
# LPeg
#set(LPEG_VER "origin/master")
set(LPEG_VER "v1.1.0-6-g645d404")
ExternalProject_Add(LPeg
  PREFIX ${PROJECT_NAME}/LPeg
  GIT_REPOSITORY https://github.com/OneLuaPro/LPeg.git
  GIT_TAG ${LPEG_VER}
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
add_dependencies(LPeg lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "LPeg;lpeg/index.html;Parsing Expression Grammars;📊;Data Processing & Formats;${LPEG_VER}"
)
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "re;lpeg/re.html;Regex Syntax for LPeg;📊;Data Processing & Formats;${LPEG_VER}"
)
