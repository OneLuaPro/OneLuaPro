# ------------------------------------------------------------------------------
# Lua bindings for Savitzky-Golay-Filter
# luaSGF
ExternalProject_Add(luaSGF
  PREFIX ${PROJECT_NAME}/luaSGF
  GIT_REPOSITORY https://github.com/OneLuaPro/luaSGF.git
  GIT_TAG "origin/master"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luaSGF build lua Savitzky-Golay-Filter)
