# ------------------------------------------------------------------------------
# ldoc
ExternalProject_Add(ldoc
  PREFIX ${PROJECT_NAME}/ldoc
  GIT_REPOSITORY https://github.com/OneLuaPro/ldoc.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(ldoc build lua Penlight luafilesystem)
