# ------------------------------------------------------------------------------
# lcomplex
#set(LCOMPLEX_VER "origin/master")
set(LCOMPLEX_VER "v1.1.0")
ExternalProject_Add(lcomplex
  PREFIX ${PROJECT_NAME}/lcomplex
  GIT_REPOSITORY https://github.com/OneLuaPro/lcomplex.git
  GIT_TAG ${LCOMPLEX_VER}
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
add_dependencies(lcomplex lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lcomplex;lcomplex/lcomplex.html;Complex Number Arithmetic;📊;Data Processing & Formats;${LCOMPLEX_VER}"
)
