# ------------------------------------------------------------------------------
# ZeroBraneStudio
ExternalProject_Add(ZeroBraneStudio
  PREFIX ${PROJECT_NAME}/ZeroBraneStudio
  GIT_REPOSITORY https://github.com/OneLuaPro/ZeroBraneStudio.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(ZeroBraneStudio build lua wxLua)
