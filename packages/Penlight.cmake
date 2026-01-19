# ------------------------------------------------------------------------------
# Penlight
ExternalProject_Add(Penlight
  PREFIX ${PROJECT_NAME}/Penlight
  GIT_REPOSITORY https://github.com/OneLuaPro/Penlight.git
  GIT_TAG "1.15.0-12-g04b70d4"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(Penlight build lua luafilesystem)
