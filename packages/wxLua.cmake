# ------------------------------------------------------------------------------
# wxLua
#set(WXLUA_VER "origin/master")
set(WXLUA_VER "v3.2.0.2-18-gc5e0cbb")
ExternalProject_Add(wxLua
  PREFIX ${PROJECT_NAME}/wxLua
  GIT_REPOSITORY https://github.com/OneLuaPro/wxlua.git
  GIT_TAG ${WXLUA_VER}
  GIT_PROGRESS FALSE
  SOURCE_SUBDIR wxLua
  CMAKE_ARGS
  "-Wno-dev"
  "-DBUILD_SHARED_LIBS=FALSE"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DwxLua_LUA_LIBRARY_USE_BUILTIN=FALSE"
  "-DwxLua_LUA_INCLUDE_DIR=${ONELUAPRO_BUILDROOT}/include"
  "-DwxLua_LUA_LIBRARY=${ONELUAPRO_BUILDROOT}/lib/liblua.lib"
  "-DwxWidgets_ROOT_DIR=${ONELUAPRO_BUILDROOT}"
  "-DwxWidgets_CONFIGURATION=mswu"
  "-DBUILD_USE_SOLUTION_FOLDERS=TRUE"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS}"
  "-DCMAKE_CXX_FLAGS=${SUPERBUILD_CXX_FLAGS}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_SHARED_LINKER_FLAGS=${SUPERBUILD_SHARED_LINKER_FLAGS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS}"
  ${GENERATOR_ARGS}
)
add_dependencies(wxLua lua wxWidgets)
ExternalProject_Add_Step(wxLua post_install
  COMMENT "Installing wxLua into ${ONELUAPRO_PREFIX}"
  DEPENDEES install
  # copy dll
  COMMAND ${CMAKE_COMMAND} -E make_directory
  ${ONELUAPRO_PREFIX}/lib/lua/${LUA_VERSION_MAJOR}.${LUA_VERSION_MINOR}
  COMMAND ${CMAKE_COMMAND} -E copy
  ${ONELUAPRO_BUILDROOT}/bin/wx.dll
  ${ONELUAPRO_PREFIX}/lib/lua/${LUA_VERSION_MAJOR}.${LUA_VERSION_MINOR}/
  # copy docs
  COMMAND ${CMAKE_COMMAND} -E make_directory
  ${ONELUAPRO_PREFIX}/share/doc
  COMMAND ${CMAKE_COMMAND} -E copy_directory
  ${ONELUAPRO_BUILDROOT}/doc/wxLua
  ${ONELUAPRO_PREFIX}/share/doc/wxLua
  # copy samples
  COMMAND ${CMAKE_COMMAND} -E make_directory
  ${ONELUAPRO_PREFIX}/share/doc/wxLua
  COMMAND ${CMAKE_COMMAND} -E copy_directory
  ${ONELUAPRO_BUILDROOT}/samples
  ${ONELUAPRO_PREFIX}/share/doc/wxLua/samples
)
# Help Center registration
# 1. User Manual
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "wxLua;wxLua/wxlua.html;wxLua User Manual;🖥️;GUI Development;${WXLUA_VER}"
)
# 2. Reference Manual
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "wxLua;wxLua/wxluaref.html;wxLua API Reference;🖥️;GUI Development;${WXLUA_VER}"
)
# 3. Binding Guide
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "wxLua;wxLua/binding.html;Writing & Generating Bindings;🖥️;GUI Development;${WXLUA_VER}"
)
# 4. FAQ
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "wxLua;wxLua/FAQ.html;wxLua Frequently Asked Questions;🖥️;GUI Development;${WXLUA_VER}"
)
