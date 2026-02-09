# ------------------------------------------------------------------------------
# Penlight
set(PENLIGHT_VER "1.15.0-12-g04b70d4")
ExternalProject_Add(Penlight
  PREFIX ${PROJECT_NAME}/Penlight
  GIT_REPOSITORY https://github.com/OneLuaPro/Penlight.git
  GIT_TAG ${PENLIGHT_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(Penlight build lua luafilesystem)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "Penlight;Penlight/index.html;Penlight Utility Collection;💎;Core & Language;${PENLIGHT_VER}"
)

