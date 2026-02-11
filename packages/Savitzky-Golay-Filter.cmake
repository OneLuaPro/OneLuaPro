# ------------------------------------------------------------------------------
# Savitzky-Golay-Filter
# Build prerequisite for luaSGF
ExternalProject_Add(Savitzky-Golay-Filter
  PREFIX ${PROJECT_NAME}/Savitzky-Golay-Filter
  GIT_REPOSITORY https://github.com/OneLuaPro/Savitzky-Golay-Filter.git
  GIT_TAG "v2.0-14-gb9af1a1"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
)
