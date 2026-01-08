# ------------------------------------------------------------------------------
# wxWidgets
ExternalProject_Add(wxWidgets
  PREFIX ${PROJECT_NAME}/wxWidgets
  GIT_REPOSITORY https://github.com/wxWidgets/wxWidgets.git
  GIT_TAG "v3.2.9"
  GIT_PROGRESS FALSE
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DwxBUILD_SHARED=OFF"
)
ExternalProject_Add_Step(wxWidgets post_install
  # There is a difference beween wxWidgets v3.2.8.1 and v3.2.9 in the sense of
  # how coniguration types are installed:
  #
  # wxWidgets v3.2.8.1 (and before) installs:
  #    wxWidgets\lib\vc_x64_lib\mswu\build.cfg
  # wxWidgets v3.2.9 installs:
  #    wxWidgets\lib\vc_x64_lib\mswu\build.cfg
  #    wxWidgets\lib\vc_x64_lib\mswud <empty>
  #
  # This is an annoying side effect of https://github.com/wxWidgets/wxWidgets/pull/25442
  # See the code changes in:
  # https://github.com/wxWidgets/wxWidgets/blob/v3.2.8.1/build/cmake/install.cmake#L39
  # https://github.com/wxWidgets/wxWidgets/blob/v3.2.9/build/cmake/install.cmake#L41
  #
  # The side effect manifests in wxLua cmake error messages ...
  # CUSTOMBUILD : * warning : Could not find wxWidgets! Please see help above.
  # CUSTOMBUILD : warning : Unable to find requested wxWidgets component : ...
  # ..., because FindwxWidgets() (from cmake installation) thinks there are two
  # configuration types to be considered (here: mswu and mswud), but mswud is
  # not present.
  #
  # The check for configuration types is simply a check for existence of
  # directories. Actual presence of configuration types data (here: build.cfg) is
  # not checked, neither in MSVC's older cmake version v3.31.6 nor in the most recent
  # cmake version v4.2.1:
  # - MSVC 2022 Build Tools v17.14.23 cmake version is 3.31.6-msvc6:
  #    https://github.com/Kitware/CMake/blob/v3.31.6/Modules/FindwxWidgets.cmake#L603
  # - Current cmake version is v4.2.1
  #    https://github.com/Kitware/CMake/blob/v4.2.1/Modules/FindwxWidgets.cmake#L767
  #
  # Solution for me:
  # Remove empty directory ${ONELUAPRO_BUILDROOT}/lib/vc_x64_lib/mswud
  #
  COMMENT "Removing empty debug configuration dirs..."
  DEPENDEES install
  # forced directory removal of ALL debug configurations after install step
  COMMAND ${CMAKE_COMMAND} -E rm -rf ${ONELUAPRO_BUILDROOT}/lib/vc_x64_lib/mswud
  COMMAND ${CMAKE_COMMAND} -E rm -rf ${ONELUAPRO_BUILDROOT}/lib/vc_Win32_lib/mswud
  COMMAND ${CMAKE_COMMAND} -E rm -rf ${ONELUAPRO_BUILDROOT}/lib/vc_ARM_lib/mswud
  COMMAND ${CMAKE_COMMAND} -E rm -rf ${ONELUAPRO_BUILDROOT}/lib/vc_ARM64_lib/mswud
)
