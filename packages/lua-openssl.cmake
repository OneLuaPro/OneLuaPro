# ------------------------------------------------------------------------------
# lua-openssl
set(LUA_OPENSSL_VER "0.11.0-2-5-gb4cc37c")
ExternalProject_Add(lua-openssl
  PREFIX ${PROJECT_NAME}/lua-openssl
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-openssl.git
  GIT_TAG ${LUA_OPENSSL_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-DLUA_INCLUDE_DIR=${ONELUAPRO_BUILDROOT}/include"
  "-DLUA_LIBRARIES=${ONELUAPRO_BUILDROOT}/lib/liblua.lib"
  "-DOPENSSL_ROOT_DIR=${ONELUAPRO_BUILDROOT}"
)
ExternalProject_Add_StepDependencies(lua-openssl build lua libressl ldoc)
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
  "lua-openssl;lua-openssl/index.html;Cryptography & SSL/TLS Toolkit;🌐;Networking & Security;${LUA_OPENSSL_VER}"
)
