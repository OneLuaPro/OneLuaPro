# ------------------------------------------------------------------------------
# winflexbison
# Build prerequisite for lua-ffi only, not included in OLP distribution
#
# NOTICE Use MSVC at all cost here, as IntelLLVM is not able to compile
#
ExternalProject_Add(winflexbison
  PREFIX ${PROJECT_NAME}/winflexbison
  GIT_REPOSITORY https://github.com/lexxmark/winflexbison.git
  GIT_TAG "v2.5.25"
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-Wno-dev"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}/bin"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=cl.exe"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=/O2 /Ob2 /DNDEBUG" 
  ${GENERATOR_ARGS}
)
