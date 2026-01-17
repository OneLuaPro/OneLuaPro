# ------------------------------------------------------------------------------
# ZeroBraneStudio
ExternalProject_Add(ZeroBraneStudio
  PREFIX ${PROJECT_NAME}/ZeroBraneStudio
  GIT_REPOSITORY https://github.com/OneLuaPro/ZeroBraneStudio.git
  GIT_TAG "2.01-8-g70c9b503"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(ZeroBraneStudio build lua wxLua api-ms-win-core-path-l1-1-0)
