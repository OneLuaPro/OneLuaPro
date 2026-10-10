# ------------------------------------------------------------------------------
# sqlean
set(SQLEAN_VER "origin/main")
# set(SQLEAN_VER "0.28.4-19-gb20d4d3")
# Disable dynamic CPU dispatch for sqlean and in particular for sqlite3 by
# using SUPERBUILD_LIGHT_C_FLAGS from top-level CMake
ExternalProject_Add(sqlean
  PREFIX ${PROJECT_NAME}/sqlean
  GIT_REPOSITORY https://github.com/OneLuaPro/sqlean.git
  GIT_TAG ${SQLEAN_VER}
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_LIGHT_C_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_STATIC_LINKER_FLAGS=${SUPERBUILD_STATIC_LINKER_FLAGS}"
  ${GENERATOR_ARGS}
)
# Copy documentaton from BUILDROOT to PREFIX
ExternalProject_Add_Step(sqlean post_install
  COMMENT "Installing Sqlean documentation into ${ONELUAPRO_PREFIX}"
  DEPENDEES install
  # copy docs
  COMMAND ${CMAKE_COMMAND} -E make_directory
  ${ONELUAPRO_PREFIX}/share/doc
  COMMAND ${CMAKE_COMMAND} -E copy_directory
  ${ONELUAPRO_BUILDROOT}/share/doc/sqlean
  ${ONELUAPRO_PREFIX}/share/doc/sqlean
)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "sqlean;sqlean/sqlean.html;SQLite Database Interface Extras;🗄️;Database Interfaces;${SQLEAN_VER}"
)
