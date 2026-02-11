# ------------------------------------------------------------------------------
# sqlean
set(SQLEAN_VER "0.28.1-8-gf04c377")
ExternalProject_Add(sqlean
  PREFIX ${PROJECT_NAME}/sqlean
  GIT_REPOSITORY https://github.com/OneLuaPro/sqlean.git
  GIT_TAG ${SQLEAN_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
)
