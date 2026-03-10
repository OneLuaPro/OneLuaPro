# ------------------------------------------------------------------------------
# libressl
ExternalProject_Add(libressl
  PREFIX ${PROJECT_NAME}/libressl
  GIT_REPOSITORY https://github.com/OneLuaPro/libressl.git
  GIT_TAG "v4.2.1-1-gc88f4da"
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DLIBRESSL_TESTS=OFF"
  "-DBUILD_SHARED_LIBS=OFF"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_STATIC_LINKER_FLAGS=${SUPERBUILD_STATIC_LINKER_FLAGS}"
  ${GENERATOR_ARGS}
)
# ------------------------------------------------------------------------------
ExternalProject_Add_Step(libressl post_install
  COMMENT "Installing libressl executables into ${ONELUAPRO_PREFIX}/share/doc/luasec/samples/certs"
  DEPENDEES install
  # create target directory
  COMMAND ${CMAKE_COMMAND} -E make_directory
  ${ONELUAPRO_PREFIX}/share/doc/luasec/samples/certs
  # copy openssl.exe
  COMMAND ${CMAKE_COMMAND} -E copy
  ${ONELUAPRO_BUILDROOT}/bin/openssl.exe
  ${ONELUAPRO_PREFIX}/share/doc/luasec/samples/certs/
  # copy ocspcheck.exe
  COMMAND ${CMAKE_COMMAND} -E copy
  ${ONELUAPRO_BUILDROOT}/bin/ocspcheck.exe
  ${ONELUAPRO_PREFIX}/share/doc/luasec/samples/certs/
)
