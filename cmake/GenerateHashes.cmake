# GenerateHashes.cmake
# - Generates SHA256 values for each file of the OneLuaPro installation
# - Compiles this checksum list into a DLL

# Find all files recursively in TARGET_DIR
file(GLOB_RECURSE ALL_FILES RELATIVE "${TARGET_DIR}" "${TARGET_DIR}/*")

# Inits
set(CHKSUM_FILE "chksum.txt")
set(CHKSUM_CONTENT "")

message(STATUS "Generating SHA256 checksums in: ${TARGET_DIR}")

foreach(FILE_PATH IN LISTS ALL_FILES)
  set(FULL_PATH "${TARGET_DIR}/${FILE_PATH}")
  
    # Security and integrity checks:
    # - Exclude the checksum file itself to prevent self-inclusion
    # - Ensure only files are processed as file(SHA256) does not support directories    
    if(NOT FILE_PATH STREQUAL "${STREQUAL}" AND NOT IS_DIRECTORY "${FULL_PATH}")
        
        # Calculate SHA256 digest
        file(SHA256 "${FULL_PATH}" FILE_HASH)

	# Use native Windows path separator "\"
	file(TO_NATIVE_PATH "${FILE_PATH}" NATIVE_FILE_PATH)
        
        # Digest, binary mode, path\filename 
        string(APPEND CHKSUM_CONTENT "${FILE_HASH} *${NATIVE_FILE_PATH}\n")
        
    endif()
endforeach()

# Write file
file(WRITE "${SAVETO_DIR}/${CHKSUM_FILE}" "${CHKSUM_CONTENT}")
message(STATUS "All checksums generated in ${SAVETO_DIR}/${CHKSUM_FILE}")


if(WIN32)
  # Temp build directory for DLL
  set(DLL_BUILD_DIR "${SAVETO_DIR}/make-checksum-dll")
  file(MAKE_DIRECTORY "${DLL_BUILD_DIR}")

  # Copy chksum.txt into build-dir such that rc-file can find it
  file(COPY "${SAVETO_DIR}/chksum.txt" DESTINATION "${DLL_BUILD_DIR}")

  # Launch cmake command for configuring the DLL build
  execute_process(COMMAND ${CMAKE_COMMAND}
    -S "${CMAKE_CURRENT_LIST_DIR}/ChecksumDll" -B "${DLL_BUILD_DIR}"
    WORKING_DIRECTORY "${DLL_BUILD_DIR}"
    RESULT_VARIABLE cmake_res
  )

  # Build DLL
  if(cmake_res EQUAL 0)
    execute_process(
      COMMAND ${CMAKE_COMMAND} --build . --config Release
      WORKING_DIRECTORY "${DLL_BUILD_DIR}"
    )
        
    # Move built DLL into desired directory
    file(GLOB_RECURSE BUILT_DLL "${DLL_BUILD_DIR}/*/chksum.dll" "${DLL_BUILD_DIR}/chksum.dll")
    if(BUILT_DLL)
      file(INSTALL "${BUILT_DLL}" DESTINATION "${TARGET_DIR}")
    endif()
  else()
    message(FATAL_ERROR "Could not configure ChecksumResource sub-project.")
  endif()

  # done
  message(STATUS "Chksum-DLL created.")
else()
  message(FATAL_ERROR "Not yet implemented.")
endif()

