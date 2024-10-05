# ------------------------------------------------------------------------------
# api-ms-win-core-path-l1-1-0 - required by ZeroBraneStudio in Windows 7 only
# Creates missing api-ms-win-core-path-l1-1-0.dll for Win 7
ExternalProject_Add(api-ms-win-core-path-l1-1-0
  PREFIX ${PROJECT_NAME}/api-ms-win-core-path-l1-1-0
  GIT_REPOSITORY https://github.com/OneLuaPro/api-ms-win-core-path-l1-1-0.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(api-ms-win-core-path-l1-1-0 build ZeroBraneStudio)

