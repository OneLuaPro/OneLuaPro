# ------------------------------------------------------------------------------
# lua4882
set(LUA4882_VER "v1.2.2")
ExternalProject_Add(lua4882
  PREFIX ${PROJECT_NAME}/lua4882
  GIT_REPOSITORY https://github.com/OneLuaPro/lua4882.git
  GIT_TAG ${LUA4882_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(lua4882 build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lua4882;lua4882/lua4882.html;GPIB Instrumentation Interface;🔌;Hardware & System Interfaces;${LUA4882_VER}"
)

