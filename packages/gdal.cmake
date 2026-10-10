# ------------------------------------------------------------------------------
# GDAL - unaltered, original
if(CMAKE_C_COMPILER_ID STREQUAL "IntelLLVM")
  set(INTEL_DISABLED_WARNINGS
    "/clang:-Wno-deprecated-declarations"
    "/clang:-Wno-unnecessary-virtual-specifier"
    "/clang:-Wno-unknown-argument"
  )
  list(JOIN INTEL_DISABLED_WARNINGS " " EXTRA_INTEL_FLAGS)
else()
  set(EXTRA_INTEL_FLAGS "")
endif()
#
# The options mirror the overlay port of duckdb-spatial (vcpkg_ports/gdal/portfile.cmake,
# built there with GDAL 3.8.5) and are handed over as initial cache entries
# (CMAKE_CACHE_ARGS). ExternalProject writes them into a pre-load script, so they do not
# pollute the cache of this superbuild and do not grow the configure command line.
#

# Vector drivers that duckdb-spatial enables (the last seven need network/curl)
set(GDAL_OGR_DRIVERS
  MEM GEOJSON GML TAB SHAPE KML VRT AVC NTF LVBAG S57 CSV DGN GMT TIGER
  GEOCONCEPT GEORSS DXF PGDUMP GPSBABEL EDIGEO SXF OPENFILEGDB WASP SELAFIN
  JML VDV FLATGEOBUF MAPML GPX SVG SQLITE GPKG OSM XLSX CAD ODS VFK MVT
  PMTILES JSONFG GTFS
  AMIGOCLOUD CARTO WFS NGW ELASTIC CSW PLSCENES)
#
set(GDAL_CACHE_ARGS
  # --- general ---
  "-DBUILD_SHARED_LIBS:BOOL=OFF"
  "-DBUILD_DOCS:BOOL=OFF"
  "-DBUILD_TESTING:BOOL=OFF"
  "-DBUILD_APPS:BOOL=OFF"
  "-DBUILD_PYTHON_BINDINGS:BOOL=OFF"

  # Commented out in DuckDB's portfile, but needed here
  "-DCMAKE_DISABLE_FIND_PACKAGE_CSharp:BOOL=ON"
  "-DCMAKE_DISABLE_FIND_PACKAGE_Java:BOOL=ON"
  "-DCMAKE_DISABLE_FIND_PACKAGE_JNI:BOOL=ON"
  "-DCMAKE_DISABLE_FIND_PACKAGE_SWIG:BOOL=ON"

  # --- dependencies ---
  # Arrow
  "-DGDAL_USE_ARROW:BOOL=OFF"
  "-DCMAKE_DISABLE_FIND_PACKAGE_Arrow:BOOL=ON"

  # Disable all external libraries unless explicitly enabled below
  "-DGDAL_USE_EXTERNAL_LIBS:BOOL=OFF"
  "-DGDAL_USE_INTERNAL_LIBS:BOOL=ON"

  # Disable OpenMP and OpenCL (found, but disabled by GDAL_USE_EXTERNAL_LIBS=OFF anyway)
  "-DGDAL_USE_OPENMP:BOOL=OFF"
  "-DGDAL_USE_OPENCL:BOOL=OFF"

  # Required
  "-DGDAL_USE_ZLIB:BOOL=ON"
  "-DGDAL_USE_ZLIB_INTERNAL:BOOL=OFF"

  # Disabled (raster formats are not supported by duckdb-spatial)
  "-DGDAL_USE_PNG:BOOL=OFF"
  "-DGDAL_USE_JPEG:BOOL=OFF"
  "-DGDAL_USE_PNG_INTERNAL:BOOL=OFF"
  "-DGDAL_USE_JPEG_INTERNAL:BOOL=OFF"
  "-DGDAL_USE_GIF:BOOL=OFF"
  "-DGDAL_USE_GIF_INTERNAL:BOOL=OFF"
  "-DGDAL_USE_QHULL:BOOL=OFF"
  "-DGDAL_USE_QHULL_INTERNAL:BOOL=OFF"
  "-DGDAL_USE_LERC:BOOL=OFF"
  "-DGDAL_USE_LERC_INTERNAL:BOOL=OFF"
  "-DGDAL_USE_HDF5:BOOL=OFF"
  "-DCMAKE_DISABLE_FIND_PACKAGE_HDF5:BOOL=ON"
  "-DGDAL_USE_LIBKML:BOOL=OFF"

  # Used by the supported drivers
  "-DGDAL_USE_GEOS:BOOL=ON"
  "-DGDAL_USE_SQLITE3:BOOL=ON"
  "-DGDAL_USE_EXPAT:BOOL=ON"
  "-DGDAL_USE_CURL:BOOL=ON"
  "-DGDAL_USE_OPENSSL:BOOL=ON"
  "-DOPENSSL_USE_STATIC_LIBS:BOOL=ON"

  # GDAL defines ZLIB_DLL (dllimport) on MSVC unless told that zlib is static;
  # zlibstatic.lib is
  "-DZLIB_IS_STATIC:BOOL=ON"

  # One libtiff for GDAL and PROJ: GDAL's internal copy clashes with the tiff.lib
  # that PROJ pulls in
  "-DGDAL_USE_TIFF:BOOL=ON"
  "-DGDAL_USE_TIFF_INTERNAL:BOOL=OFF"

  # DuckDB notes: "This is not true, but a bug in gdal's cmake files"
  "-DACCEPT_MISSING_SQLITE3_RTREE:BOOL=ON"
  "-DACCEPT_MISSING_SQLITE3_MUTEX_ALLOC:BOOL=ON"

  # --- drivers ---
  "-DGDAL_BUILD_OPTIONAL_DRIVERS:BOOL=OFF"
  "-DOGR_BUILD_OPTIONAL_DRIVERS:BOOL=OFF"
)
#
foreach(_drv IN LISTS GDAL_OGR_DRIVERS)
  list(APPEND GDAL_CACHE_ARGS "-DOGR_ENABLE_DRIVER_${_drv}:BOOL=ON")
endforeach()
unset(_drv)
#
ExternalProject_Add(gdal
  PREFIX ${PROJECT_NAME}/gdal
  GIT_REPOSITORY https://github.com/OSGeo/gdal.git
  GIT_TAG "v3.9.3"
  GIT_SHALLOW TRUE
  GIT_PROGRESS FALSE
  CMAKE_CACHE_ARGS ${GDAL_CACHE_ARGS}
  CMAKE_ARGS
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_BUILDROOT}"
  "-DSQLite3_LIBRARY=${ONELUAPRO_BUILDROOT}/lib/sqlean.lib"
  #
  "-G${CMAKE_GENERATOR}"
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
  "-DCMAKE_MSVC_RUNTIME_LIBRARY=${CMAKE_MSVC_RUNTIME_LIBRARY}"
  "-DCMAKE_C_FLAGS=${SUPERBUILD_C_FLAGS} ${EXTRA_INTEL_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_CXX_FLAGS=${SUPERBUILD_CXX_FLAGS} ${EXTRA_INTEL_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_EXE_LINKER_FLAGS=${SUPERBUILD_EXE_LINKER_FLAGS} ${SUPERBUILD_IPO_OPTS}"
  "-DCMAKE_STATIC_LINKER_FLAGS=${SUPERBUILD_STATIC_LINKER_FLAGS}"
  ${GENERATOR_ARGS}
)
add_dependencies(gdal proj geos sqlean curl expat libtiff winflexbison swig)
