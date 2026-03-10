# ------------------------------------------------------------------------------
# wxLanesBridge
#set(WXLANESBRIDGE_VER "origin/master")
set(WXLANESBRIDGE_VER "v1.0.1")
ExternalProject_Add(wxLanesBridge
  PREFIX ${PROJECT_NAME}/wxLanesBridge
  GIT_REPOSITORY https://github.com/OneLuaPro/wxLanesBridge.git
  GIT_TAG ${WXLANESBRIDGE_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_CXX_FLAGS=${SUPERBUILD_CXX_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_SHARED_LINKER_FLAGS=${SUPERBUILD_SHARED_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  ${GENERATOR_ARGS}
)
add_dependencies(wxLanesBridge lua ldoc lanes wxLua wxWidgets)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "wxLanesBridge;wxLanesBridge/topics/readme.md.html;GUI & Multi-Threading Bridge;🖥️;GUI Development;${WXLANESBRIDGE_VER}"
)
