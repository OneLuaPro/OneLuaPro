# ------------------------------------------------------------------------------
# luasystem
set(LUASYSTEM_VER "v0.6.3-6-g18ee3a4")
ExternalProject_Add(luasystem
  PREFIX ${PROJECT_NAME}/luasystem
  GIT_REPOSITORY https://github.com/OneLuaPro/luasystem.git
  GIT_TAG ${LUASYSTEM_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "luasystem;luasystem/api/index.html;System Discovery & Time;💎;Core & Language;${LUASYSTEM_VER}"
)
