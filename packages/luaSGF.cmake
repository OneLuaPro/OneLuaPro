# ------------------------------------------------------------------------------
# Lua bindings for Savitzky-Golay-Filter
# luaSGF
set(LUASGF_VER "v2.0.0")
ExternalProject_Add(luaSGF
  PREFIX ${PROJECT_NAME}/luaSGF
  GIT_REPOSITORY https://github.com/OneLuaPro/luaSGF.git
  GIT_TAG ${LUASGF_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(luaSGF build lua Savitzky-Golay-Filter)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "luaSGF;luaSGF/topics/readme.md.html;Savitzky-Golay Signal Filter;📊;Data Processing & Formats;${LUASGF_VER}"
)
