# ------------------------------------------------------------------------------
# libressl
ExternalProject_Add(libressl
  URL https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-4.2.1.tar.gz
  URL_HASH SHA256=6d5c2f58583588ea791f4c8645004071d00dfa554a5bf788a006ca1eb5abd70b
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  DOWNLOAD_NO_PROGRESS TRUE
  PREFIX ${PROJECT_NAME}/libressl
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DLIBRESSL_TESTS=OFF"
  "-DBUILD_SHARED_LIBS=OFF"
)
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
