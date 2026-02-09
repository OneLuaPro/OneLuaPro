# ------------------------------------------------------------------------------
# lcomplex
set(LCOMPLEX_VER "v1.0")
ExternalProject_Add(lcomplex
  PREFIX ${PROJECT_NAME}/lcomplex
  GIT_REPOSITORY https://github.com/OneLuaPro/lcomplex.git
  GIT_TAG ${LCOMPLEX_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lcomplex build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lcomplex;lcomplex/lcomplex.html;Complex Number Arithmetic;📊;Data Processing & Formats;${LCOMPLEX_VER}"
)
