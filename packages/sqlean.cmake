# ------------------------------------------------------------------------------
# sqlean
set(SQLEAN_VER "0.28.1-9-gd134592")
ExternalProject_Add(sqlean
  PREFIX ${PROJECT_NAME}/sqlean
  GIT_REPOSITORY https://github.com/OneLuaPro/sqlean.git
  GIT_TAG ${SQLEAN_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
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
