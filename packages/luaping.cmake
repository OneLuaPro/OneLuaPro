# ------------------------------------------------------------------------------
# luaping
set(LUAPING_VER "v1.1.1")
ExternalProject_Add(luaping
  PREFIX ${PROJECT_NAME}/luaping
  GIT_REPOSITORY https://github.com/OneLuaPro/luaping.git
  GIT_TAG ${LUAPING_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luaping build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "luaping;luaping/luaping.html;ICMP Ping Interface;🌐;Networking & Security;${LUAPING_VER}"
)

