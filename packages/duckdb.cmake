# ------------------------------------------------------------------------------
# duckdb - original but heavily patched for statically linked-in extensions
set(EXTRA_DUCKDB_DEFS
  "/DCURL_STATICLIB /DDUCKDB_STATIC_BUILD /D_CRT_NONSTDC_NO_WARNINGS /DXML_STATIC /DXML_LARGE_SIZE /D_CRT_SECURE_NO_WARNINGS /clang:-Wno-pass-failed")
# using SUPERBUILD_LIGHT_CXX_FLAGS from top-level CMake
# using SUPERBUILD_LIGHT_C_FLAGS from top-level CMake
ExternalProject_Add(duckdb
  PREFIX ${PROJECT_NAME}/duckdb
  GIT_REPOSITORY https://github.com/duckdb/duckdb.git
  GIT_TAG "v1.5.6"
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  # Apply core patch to be able to build duckdb for OneLuaPro
  PATCH_COMMAND git apply -p1 --whitespace=nowarn "${CMAKE_CURRENT_SOURCE_DIR}/packages/duckdb-core.patch"
  #
  # Create patch directory for duckdb-mysql
  COMMAND ${CMAKE_COMMAND} -E make_directory "<SOURCE_DIR>/.github/patches/extensions/mysql_scanner"
  # Copy duckdb-mysql patch to designated location in preparation of duckdb's own patch mechanism
  COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/packages/duckdb-mysql.patch"
  "<SOURCE_DIR>/.github/patches/extensions/mysql_scanner/9999-duckdb-mysql.patch"
  #
  # Create patch directory for odbc-scanner
  COMMAND ${CMAKE_COMMAND} -E make_directory "<SOURCE_DIR>/.github/patches/extensions/odbc_scanner"
  # Copy duckdb-odbc patch to designated location in preparation of duckdb's own patch mechanism
  COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/packages/duckdb-odbc.patch"
  "<SOURCE_DIR>/.github/patches/extensions/odbc_scanner/9999-duckdb-odbc.patch"
  #
  # Create patch directory for duckdb-postgres
  COMMAND ${CMAKE_COMMAND} -E make_directory "<SOURCE_DIR>/.github/patches/extensions/postgres_scanner"
  # Copy duckdb-postgres patch to designated location in preparation of duckdb's own patch mechanism
  COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/packages/duckdb-postgres.patch"
  "<SOURCE_DIR>/.github/patches/extensions/postgres_scanner/9999-duckdb-postgres.patch"
  #
  # Create patch directory for duckdb-sqlite
  COMMAND ${CMAKE_COMMAND} -E make_directory "<SOURCE_DIR>/.github/patches/extensions/sqlite_scanner"
  # Copy duckdb-postgres patch to designated location in preparation of duckdb's own patch mechanism
  COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/packages/duckdb-sqlite.patch"
  "<SOURCE_DIR>/.github/patches/extensions/sqlite_scanner/9999-duckdb-sqlite.patch"
  #
  # Create patch directory for duckdb-httpfs
  COMMAND ${CMAKE_COMMAND} -E make_directory "<SOURCE_DIR>/.github/patches/extensions/httpfs"
  # Copy duckdb-httpfs patch to designated location in preparation of duckdb's own patch mechanism
  COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/packages/duckdb-httpfs.patch"
  "<SOURCE_DIR>/.github/patches/extensions/httpfs/9999-duckdb-httpfs.patch"
  #
  # Currently no patch for duckdb-excel required
  #
  # Currently no patch for duckdb-fts required
  #
  # Currently no patch for duckdb-aws required
  #
  # Currently no patch for duckdb-azure required
  #
  # Currently no patch for duckdb-vss required
  #
  # Create patch directory for duckdb-spatial
  COMMAND ${CMAKE_COMMAND} -E make_directory "<SOURCE_DIR>/.github/patches/extensions/spatial"
  # Copy duckdb-spatial patch to designated location in preparation of duckdb's own patch mechanism
  COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/packages/duckdb-spatial.patch"
  "<SOURCE_DIR>/.github/patches/extensions/spatial/9999-duckdb-spatial.patch"
  #
  # placeholder so ';'-separated CMAKE_ARGS values (e.g. BUILD_EXTENSIONS) survive intact
  # Will be swapped back to ';' only in the final command line
  LIST_SEPARATOR |
  CMAKE_ARGS
  # Install and build-paths
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DONELUAPRO_BUILDROOT=${ONELUAPRO_BUILDROOT}"

  # Ignore the CMake package registries: stale build-tree exports must not win over the install
  "-DCMAKE_FIND_USE_PACKAGE_REGISTRY=OFF"
  "-DCMAKE_FIND_USE_SYSTEM_PACKAGE_REGISTRY=OFF"
  
  # Options
  "-DBUILD_UNITTESTS=OFF"
  "-DENABLE_UNITTEST_CPP_TESTS=OFF"
  "-DBUILD_SHELL=OFF"
  "-DENABLE_SANITIZER=OFF"
  "-DENABLE_UBSAN=OFF"
  "-DENABLE_JEMALLOC=OFF"
  "-DEXTENSION_STATIC_BUILD=ON"
  "-DFETCHCONTENT_QUIET=OFF"

  # Extension settings
  "-DPostgreSQL_INCLUDE_DIR=${ONELUAPRO_BUILDROOT}/include"
  "-DPostgreSQL_LIBRARY=${ONELUAPRO_BUILDROOT}/lib/pq.lib"
  "-DSQLite3_INCLUDE_DIR=${ONELUAPRO_BUILDROOT}/include"
  "-DSQLite3_LIBRARY=${ONELUAPRO_BUILDROOT}/lib/sqlean.lib"
  "-DCURL_INCLUDE_DIR=${ONELUAPRO_BUILDROOT}/include"
  "-DCURL_LIBRARY=${ONELUAPRO_BUILDROOT}/lib/libcurl.lib"
  "-DZLIB_INCLUDE_DIR=${ONELUAPRO_BUILDROOT}/include"
  "-DZLIB_LIBRARY=${ONELUAPRO_BUILDROOT}/lib/zlibstatic.lib"
  "-DBUILD_EXTENSIONS=core_functions|parquet|json|postgres_scanner|mysql_scanner|sqlite_scanner|odbc_scanner|httpfs|excel|fts|aws|azure|vss|spatial"
  
  "-G${CMAKE_GENERATOR}"
  # Compiler settings
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_C_FLAGS=${EXTRA_DUCKDB_DEFS} ${SUPERBUILD_LIGHT_C_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
  "-DCMAKE_CXX_FLAGS=${EXTRA_DUCKDB_DEFS} ${SUPERBUILD_LIGHT_CXX_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  # Runtime lib settings
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  # Linker settings
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_SHARED_LINKER_FLAGS=${SUPERBUILD_SHARED_LINKER_FLAGS}"
  "-DCMAKE_STATIC_LINKER_FLAGS=${SUPERBUILD_STATIC_LINKER_FLAGS}"
  ${GENERATOR_ARGS}
)
add_dependencies(duckdb curl mariadb-connector-c postgres-connector-c sqlean expat minizip-ng aws-sdk-cpp azure-core-cpp azure-identity-cpp azure-storage-common-cpp azure-storage-blobs-cpp azure-storage-files-datalake-cpp gdal proj geos)
