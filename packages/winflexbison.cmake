# ------------------------------------------------------------------------------
# winflexbison
# Build prerequisite for lua-ffi only, not included in OLP distribution
ExternalProject_Add(winflexbison
  PREFIX ${PROJECT_NAME}/winflexbison
  GIT_REPOSITORY https://github.com/lexxmark/winflexbison.git
  GIT_TAG "v2.5.25"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}/bin"
)
