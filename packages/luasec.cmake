# ------------------------------------------------------------------------------
# luasec
set(LUASEC_VER "v1.3.2-4-g3219920")
ExternalProject_Add(luasec
  PREFIX ${PROJECT_NAME}/luasec
  GIT_REPOSITORY https://github.com/OneLuaPro/luasec.git
  GIT_TAG ${LUASEC_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luasec build lua luasocket)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "luasec;luasec/luasec.html;TLS/SSL Communication;🌐;Networking & Security;${LUASEC_VER}"
)
