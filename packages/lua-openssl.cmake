# ------------------------------------------------------------------------------
# lua-openssl
ExternalProject_Add(lua-openssl
  PREFIX ${PROJECT_NAME}/lua-openssl
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-openssl.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-DLUA_INCLUDE_DIR=${ONELUAPRO_BUILDROOT}/include"
  "-DLUA_LIBRARIES=${ONELUAPRO_BUILDROOT}/lib/liblua.lib"
  "-DOPENSSL_ROOT_DIR=${ONELUAPRO_BUILDROOT}"
)
ExternalProject_Add_StepDependencies(lua-openssl build lua libressl)