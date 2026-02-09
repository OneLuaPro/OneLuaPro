# ------------------------------------------------------------------------------
# distro
set(DISTRO_VER "v2.0.0")
ExternalProject_Add(distro
  PREFIX ${PROJECT_NAME}/distro
  GIT_REPOSITORY https://github.com/OneLuaPro/distro.git
  GIT_TAG ${DISTRO_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
  "-DONELUAPRO_VERSION=${ONELUAPRO_VERSION}"
  "-DONELUAPRO_CANDIDATE=${ONELUAPRO_CANDIDATE}"
)
ExternalProject_Add_StepDependencies(distro build lua wxLua)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "distro;distro/README.html;Distribution Management Module;🛠️;Development Tools;${DISTRO_VER}"
)
# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
  "DistroCheck;distro/README.html;Distribution Integrity Checker;🛡️;Maintenance & System;${DISTRO_VER}"
)
