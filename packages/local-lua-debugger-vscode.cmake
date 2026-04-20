# ------------------------------------------------------------------------------
# local-lua-debugger-vscode
#set(LOCAL_LUA_DEBUGGER_VSCODE_VER "origin/master")
set(LOCAL_LUA_DEBUGGER_VSCODE_VER "v0.4.0")
ExternalProject_Add(local-lua-debugger-vscode
  PREFIX ${PROJECT_NAME}/local-lua-debugger-vscode
  GIT_REPOSITORY https://github.com/OneLuaPro/local-lua-debugger-vscode.git
  GIT_TAG ${LOCAL_LUA_DEBUGGER_VSCODE_VER}
  GIT_PROGRESS FALSE
  BUILD_IN_SOURCE TRUE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-DCODE_SIGN_ID=${CODE_SIGN_ID}"
  "-DSIGN_PACKAGE=ON"
  "-G${CMAKE_GENERATOR}"
  ${GENERATOR_ARGS}
)
