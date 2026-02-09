# ------------------------------------------------------------------------------
# dkjson
set(DKJSON_VER "v2.8")
ExternalProject_Add(dkjson
  PREFIX ${PROJECT_NAME}/dkjson
  GIT_REPOSITORY https://github.com/OneLuaPro/dkjson.git
  GIT_TAG ${DKJSON_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(dkjson build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "dkjson;dkjson/dkjson.html;Pure Lua JSON Library;📊;Data Processing & Formats;${DKJSON_VER}"
)
