# ------------------------------------------------------------------------------
# sqlean
# set(SQLEAN_VER "origin/main")
set(SQLEAN_VER 0.28.1-12-g4141d89)
# Disable dynamic CPU dispatch for sqlean and in particular for sqlite3
if(CMAKE_C_COMPILER_ID STREQUAL "IntelLLVM")
  set(EXTRA_INTEL_FLAGS "/Qax-")
else()
  set(EXTRA_INTEL_FLAGS "")
endif()
ExternalProject_Add(sqlean
  PREFIX ${PROJECT_NAME}/sqlean
  GIT_REPOSITORY https://github.com/OneLuaPro/sqlean.git
  GIT_TAG ${SQLEAN_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS} ${EXTRA_INTEL_FLAGS} ${SUPERBUILD_IPO_OPTS}"
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
  "sqlean;sqlean/sqlean.html;SQLite Database Interface Extras;📊;Data Processing & Formats;${SQLEAN_VER}"
)
