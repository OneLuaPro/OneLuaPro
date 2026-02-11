# ------------------------------------------------------------------------------
# wxLanesBridge
set(WXLANESBRIDGE_VER "v1.0")
ExternalProject_Add(wxLanesBridge
  PREFIX ${PROJECT_NAME}/wxLanesBridge
  GIT_REPOSITORY https://github.com/OneLuaPro/wxLanesBridge.git
  GIT_TAG ${WXLANESBRIDGE_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(wxLanesBridge build lua ldoc)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "wxLanesBridge;wxLanesBridge/topics/readme.md.html;GUI & Multi-Threading Bridge;🖥️;GUI Development;${WXLANESBRIDGE_VER}"
)
