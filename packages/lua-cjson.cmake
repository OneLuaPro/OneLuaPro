# ------------------------------------------------------------------------------
# lua-cjson
ExternalProject_Add(lua-cjson
  PREFIX ${PROJECT_NAME}/lua-cjson
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-cjson.git
  GIT_TAG "2.1.0.15-7-g0bfdf82"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-DUSE_INTERNAL_FPCONV=ON"
  "-DMULTIPLE_THREADS=OFF"
)
ExternalProject_Add_StepDependencies(lua-cjson build lua)
