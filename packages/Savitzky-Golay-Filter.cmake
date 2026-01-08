# ------------------------------------------------------------------------------
# Savitzky-Golay-Filter
# Build prerequisite
ExternalProject_Add(Savitzky-Golay-Filter
  PREFIX ${PROJECT_NAME}/Savitzky-Golay-Filter
  GIT_REPOSITORY https://github.com/OneLuaPro/Savitzky-Golay-Filter.git
  GIT_TAG "origin/main"
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DDEFS=FLOAT_DOUBLE" "-DUSE_PARALLEL_SAVGOL=OFF"
)
ExternalProject_Add_StepDependencies(Savitzky-Golay-Filter build lua)
