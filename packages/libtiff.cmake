# ------------------------------------------------------------------------------
# libtiff - unaltered, original
ExternalProject_Add(libtiff
  PREFIX ${PROJECT_NAME}/libtiff
  GIT_REPOSITORY https://github.com/libsdl-org/libtiff.git
  GIT_TAG "v4.7.2"
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  PATCH_COMMAND ${CMAKE_COMMAND} -DGIT=git "-DPATCH_FILE=${CMAKE_CURRENT_SOURCE_DIR}/packages/libtiff.patch" -P "${CMAKE_CURRENT_SOURCE_DIR}/cmake/ApplyPatchOnce.cmake"
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DBUILD_SHARED_LIBS=OFF"
  "-Dtiff-tools=OFF"
  "-Dtiff-tests=OFF"
  "-Dtiff-contrib=OFF"
  "-Dtiff-docs=OFF"
  "-Dtiff-deprecated=OFF"
  # 
  "-DCMAKE_POLICY_DEFAULT_CMP0091=NEW"
  #
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_CXX_FLAGS=${SUPERBUILD_CXX_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_STATIC_LINKER_FLAGS=${SUPERBUILD_STATIC_LINKER_FLAGS}"
  ${GENERATOR_ARGS}
)
add_dependencies(libtiff zlib-ng minizip-ng zstd)
