# Mini CMake Project for compiling SHA256 checksums into a DLL
cmake_minimum_required(VERSION 3.31)
project(ChecksumResource C)

# Define ressource file for entry-less DLL
set(RC_FILE "${CMAKE_CURRENT_BINARY_DIR}/chksum.rc")
file(WRITE "${RC_FILE}" "101 RCDATA \"chksum.txt\"\n")

# Build DLL without code entry
add_library(chksum_dll SHARED "${RC_FILE}")
set_target_properties(chksum_dll PROPERTIES
  LINK_FLAGS "/NOENTRY"
  OUTPUT_NAME "chksum"
)
