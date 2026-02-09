# ------------------------------------------------------------------------------
# luv
set(LUV_VER "1.51.0-2-24-geb9176d")
ExternalProject_Add(luv
  PREFIX ${PROJECT_NAME}/luv
  GIT_REPOSITORY https://github.com/OneLuaPro/luv.git
  GIT_TAG ${LUV_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DUSE_ONELUAPRO=ON" 
  "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luv build lua libuv)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "luv;luv/docs.html;Asynchronous I/O (libuv);🔌;Hardware & System Interfaces;${LUV_VER}"
)
