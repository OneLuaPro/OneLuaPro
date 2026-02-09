# ------------------------------------------------------------------------------
# say
set(SAY_VER "v1.4.1-2-ge4436ea")
ExternalProject_Add(say
  PREFIX ${PROJECT_NAME}/say
  GIT_REPOSITORY https://github.com/OneLuaPro/say.git
  GIT_TAG ${SAY_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(say build lua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "say;say/README.html;String Localization Library;💎;Core & Language;${SAY_VER}"
)
