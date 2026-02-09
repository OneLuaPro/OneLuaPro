# ------------------------------------------------------------------------------
# lua-cjson
set(LUA_CJSON_VER "2.1.0.16-10-gf369ca1")
ExternalProject_Add(lua-cjson
  PREFIX ${PROJECT_NAME}/lua-cjson
  GIT_REPOSITORY https://github.com/OneLuaPro/lua-cjson.git
  GIT_TAG ${LUA_CJSON_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-DUSE_INTERNAL_FPCONV=ON"
  "-DMULTIPLE_THREADS=OFF"
)
ExternalProject_Add_StepDependencies(lua-cjson build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lua-cjson;lua-cjson/lua-cjson-manual.html;High-Performance JSON Parser;📊;Data Processing & Formats;${LUA_CJSON_VER}"
)
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "lua-cjson;lua-cjson/lua-cjson-manual-extras.html;High-Performance JSON Parser (Extras);📊;Data Processing & Formats;${LUA_CJSON_VER}"
)
