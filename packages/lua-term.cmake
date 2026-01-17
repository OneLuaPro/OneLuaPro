# ------------------------------------------------------------------------------
# lua-term
ExternalProject_Add(lua-term
  PREFIX ${PROJECT_NAME}/lua-term
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-term.git
  GIT_TAG "0.8-6-g1fc5955"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lua-term build lua)
