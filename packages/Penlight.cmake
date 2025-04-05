# ------------------------------------------------------------------------------
# Penlight
ExternalProject_Add(Penlight
  PREFIX ${PROJECT_NAME}/Penlight
  GIT_REPOSITORY https://github.com/OneLuaPro/Penlight.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(Penlight build lua)
