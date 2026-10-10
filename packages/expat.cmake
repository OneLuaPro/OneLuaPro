# ------------------------------------------------------------------------------
# expat
# Consumers of this build (i.e. duckdb) must be compiled with
#   /DXML_STATIC /DXML_LARGE_SIZE
#   XML_STATIC      - otherwise expat.h declares all functions as dllimport
#   XML_LARGE_SIZE  - must match EXPAT_LARGE_SIZE=ON below (changes the
#                     XML_Index/XML_Size types visible in the header)
ExternalProject_Add(expat
  PREFIX ${PROJECT_NAME}/expat
  GIT_REPOSITORY https://github.com/libexpat/libexpat.git
  GIT_TAG "R_2_8_5"
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  SOURCE_SUBDIR expat
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  #
  "-DCMAKE_BUILD_TYPE=Release"
  "-DBUILD_SHARED_LIBS=OFF"
  "-DEXPAT_SHARED_LIBS=OFF"
  "-DEXPAT_MSVC_STATIC_CRT=ON"
  "-DEXPAT_LARGE_SIZE=ON"
  "-DEXPAT_BUILD_TOOLS=OFF"
  "-DEXPAT_BUILD_EXAMPLES=OFF"
  "-DEXPAT_BUILD_TESTS=OFF"
  "-DEXPAT_BUILD_DOCS=OFF"
  "-DEXPAT_BUILD_PKGCONFIG=OFF"
  "-DEXPAT_BUILD_FUZZERS=OFF"
  #
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_LIGHT_C_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_STATIC_LINKER_FLAGS=${SUPERBUILD_STATIC_LINKER_FLAGS}"
  ${GENERATOR_ARGS}
)
