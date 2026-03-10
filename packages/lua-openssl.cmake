# ------------------------------------------------------------------------------
# lua-openssl
#set(LUA_OPENSSL_VER "origin/master")
set(LUA_OPENSSL_VER "0.11.0-3-25-gd068708")
ExternalProject_Add(lua-openssl
  PREFIX ${PROJECT_NAME}/lua-openssl
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-openssl.git
  GIT_TAG ${LUA_OPENSSL_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-DOPENSSL_ROOT_DIR=${ONELUAPRO_BUILDROOT}"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_MODULE_LINKER_FLAGS=${SUPERBUILD_SHARED_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  ${GENERATOR_ARGS}
)
add_dependencies(lua-openssl lua libressl ldoc)
ExternalProject_Get_Property(lua-openssl SOURCE_DIR)
set(LDOC_EXE "${ONELUAPRO_PREFIX}/bin/ldoc.exe")
set(DOC_INST_DIR "${ONELUAPRO_PREFIX}/share/doc/lua-openssl")
ExternalProject_Add_Step(lua-openssl generate_install_docs
  COMMENT "Generate and install docs for lua-openssl..."
  DEPENDEES install
  WORKING_DIRECTORY "${SOURCE_DIR}"
  # Generate docs and direcly install to desired location
  COMMAND ${LDOC_EXE} src -d "${DOC_INST_DIR}" -s .ldoc.css
)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lua-openssl;lua-openssl/topics/readme.md.html;Cryptography & SSL/TLS Toolkit;🌐;Networking & Security;${LUA_OPENSSL_VER}"
)
