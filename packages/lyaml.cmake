# ------------------------------------------------------------------------------
# lyaml
# set(LYAML_VER "origin/master")
set(LYAML_VER "v6.2.9-0")
ExternalProject_Add(lyaml
  PREFIX ${PROJECT_NAME}/lyaml
  GIT_REPOSITORY https://github.com/OneLuaPro/lyaml.git
  GIT_TAG ${LYAML_VER}
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
add_dependencies(lyaml lua libyaml ldoc)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lyaml;lyaml/index.html;YAML Encoding and Parsing;📊;Data Processing & Formats;${LYAML_VER}"
)
