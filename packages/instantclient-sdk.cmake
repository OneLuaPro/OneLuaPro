# ------------------------------------------------------------------------------
# Oracle Instant Client SDK - headers and import library for the OCI8 driver
# of luasql. Build time only: nothing is installed into ONELUAPRO_PREFIX, so the
# SDK is not redistributed. The runtime (oci.dll etc.) is not part of OneLuaPro.
set(INSTANTCLIENT_VER "23.26.3.0.0")
set(INSTANTCLIENT_URLDIR "2326300")
ExternalProject_Add(instantclient-sdk
  PREFIX ${PROJECT_NAME}/instantclient-sdk
  URL https://download.oracle.com/otn_software/nt/instantclient/${INSTANTCLIENT_URLDIR}/instantclient-sdk-windows.x64-${INSTANTCLIENT_VER}.zip
  URL_HASH SHA256=c37f1a8b47258129d6ca40987fb2cedcd5109856492927526cb5395b07f30864
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
)
# The zip contains the folder instantclient_23_26 (not stripped by
# ExternalProject): headers and libs are below <SOURCE_DIR>/instantclient_23_26/sdk
ExternalProject_Get_Property(instantclient-sdk SOURCE_DIR)
set(INSTANTCLIENT_SDK_ROOT "${SOURCE_DIR}/instantclient_23_26/sdk")
unset(SOURCE_DIR)
