# ------------------------------------------------------------------------------
# zstd - unaltered, original
ExternalProject_Add(zstd
  PREFIX ${PROJECT_NAME}/zstd
  GIT_REPOSITORY https://github.com/facebook/zstd.git
  GIT_TAG "v1.5.7"
  GIT_PROGRESS FALSE
  SOURCE_SUBDIR "build/cmake"
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DZSTD_BUILD_SHARED=OFF"
  "-DCMAKE_POLICY_DEFAULT_CMP0091=NEW"
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_STATIC_LINKER_FLAGS=${SUPERBUILD_STATIC_LINKER_FLAGS}"
  ${GENERATOR_ARGS}
)
ExternalProject_Add_Step(zstd post_install
  # Rename static lib after install
  COMMENT "Renaming zstd_static.lib into zstd.lib ..."
  DEPENDEES install
  # rename
  COMMAND ${CMAKE_COMMAND} -E rename ${ONELUAPRO_BUILDROOT}/lib/zstd_static.lib
  ${ONELUAPRO_BUILDROOT}/lib/zstd.lib
)
