# Import CODE_SIGN_ID from CPack.cmake
# The configuration files created by CPack.cmake will contain all the
# variables that begin with "CPACK_" in the current project. 
set(CODE_SIGN_ID ${CPACK_CODE_SIGN_ID})	# Import CODE_SIGN_ID
# Set unified code signing parameters
include(CodeSignParams)
# Sign all MSI files
foreach(f IN LISTS CPACK_PACKAGE_FILES)
  if(f MATCHES "\\.msi$")
    message("Signing MSI-Installer: ${f}")
    execute_process(
      COMMAND ${CPACK_signtool_EXECUTABLE} sign ${SIGN_PARAMS} "${f}"
      COMMAND_ECHO NONE	# for debug: STDOUT
      RESULT_VARIABLE res
    )
    if(NOT res EQUAL 0)
      message(FATAL_ERROR "Signing failed for ${f}")
    endif()
  endif()
endforeach()
