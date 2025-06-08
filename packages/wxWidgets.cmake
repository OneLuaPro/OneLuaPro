# ------------------------------------------------------------------------------
# wxWidgets
ExternalProject_Add(wxWidgets
  PREFIX ${PROJECT_NAME}/wxWidgets
  GIT_REPOSITORY https://github.com/wxWidgets/wxWidgets.git
  GIT_TAG "v3.2.8.1"
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DwxBUILD_SHARED=OFF"
)

