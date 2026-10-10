# ------------------------------------------------------------------------------
# ca-bundle - CA certificates published by the curl project (Mozilla's CA store
# as PEM), shipped with the distribution as etc/ssl/cert.pem.
# lua.exe points CURL_CA_INFO to it at startup (the azure extension reads it).
# To update: change the date and the hash together, after checking the hash
# against https://curl.se/ca/cacert-<date>.pem.sha256.
set(CA_BUNDLE_DATE "2026-09-25")
ExternalProject_Add(ca-bundle
  PREFIX ${PROJECT_NAME}/ca-bundle
  URL "https://curl.se/ca/cacert-${CA_BUNDLE_DATE}.pem"
  URL_HASH SHA256=a41b5d356aea97a529fe27e0f7316d2f9d946d75927476cf9cf1b90637d00505
  DOWNLOAD_NO_EXTRACT TRUE
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ${CMAKE_COMMAND} -E make_directory "${ONELUAPRO_PREFIX}/etc/ssl"
  COMMAND ${CMAKE_COMMAND} -E copy <DOWNLOADED_FILE> "${ONELUAPRO_PREFIX}/etc/ssl/cert.pem"
)
