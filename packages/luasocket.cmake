# ------------------------------------------------------------------------------
# luasocket
set(LUASOCKET_VER "v3.1.0-71-gcb1c0e5")
ExternalProject_Add(luasocket
  PREFIX ${PROJECT_NAME}/luasocket
  GIT_REPOSITORY https://github.com/OneLuaPro/luasocket.git
  GIT_TAG ${LUASOCKET_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luasocket build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "luasocket;luasocket/index.html;Network Support (TCP/UDP/HTTP);🌐;Networking & Security;${LUASOCKET_VER}"
)

