# ------------------------------------------------------------------------------
# wxLua
ExternalProject_Add(wxLua
  PREFIX ${PROJECT_NAME}/wxLua
  GIT_REPOSITORY https://github.com/pkulchenko/wxlua.git
  GIT_TAG origin/master
  GIT_PROGRESS FALSE
  SOURCE_SUBDIR wxLua
  CMAKE_ARGS
  "-Wno-dev"
  "-DCMAKE_BUILD_TYPE=Release"
  "-DBUILD_SHARED_LIBS=FALSE"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DwxLua_LUA_LIBRARY_USE_BUILTIN=FALSE"
  "-DwxLua_LUA_INCLUDE_DIR=${ONELUAPRO_PREFIX}/include"
  "-DwxLua_LUA_LIBRARY=${ONELUAPRO_PREFIX}/lib/liblua.lib"
  "-DwxWidgets_ROOT_DIR=${ONELUAPRO_BUILDROOT}"
  "-DwxWidgets_CONFIGURATION=mswu"
  "-DBUILD_USE_SOLUTION_FOLDERS=TRUE"
)
ExternalProject_Add_StepDependencies(wxLua build lua wxWidgets)
ExternalProject_Add_Step(wxLua post_install
  COMMENT "Installing xwLua into ${ONELUAPRO_PREFIX}"
  DEPENDEES install
  COMMAND ${CMAKE_COMMAND} -E copy
  ${ONELUAPRO_BUILDROOT}/bin/wx.dll
  ${ONELUAPRO_PREFIX}/lib/lua/${LUA_VERSION_MAJOR}.${LUA_VERSION_MINOR}/
  COMMAND ${CMAKE_COMMAND} -E copy_directory
  ${ONELUAPRO_BUILDROOT}/doc/wxLua
  ${ONELUAPRO_PREFIX}/share/doc/wxLua
  COMMAND ${CMAKE_COMMAND} -E copy_directory
  ${ONELUAPRO_BUILDROOT}/samples
  ${ONELUAPRO_PREFIX}/share/doc/wxLua/samples
)
