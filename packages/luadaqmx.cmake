# ------------------------------------------------------------------------------
# luadaqmx
set(LUADAQMX_VER "v0.1.1")
ExternalProject_Add(luadaqmx
  PREFIX ${PROJECT_NAME}/luadaqmx
  GIT_REPOSITORY https://github.com/OneLuaPro/luadaqmx.git
  GIT_TAG ${LUADAQMX_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luadaqmx build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "luadaqmx;luadaqmx/luadaqmx.html;NI-DAQmx Hardware Interface;🔌;Hardware & System Interfaces;${LUADAQMX_VER}"
)
