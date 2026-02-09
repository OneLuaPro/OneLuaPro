# Script for signing chksum.dll

# Set the desired DLL
set(CHKSUM_DLL "${ONELUAPRO_PREFIX}/chksum.dll")

# Include signtool cmd line args (sets SIGN_PARAMS)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
include(CodeSignParams)

# Sign *.exe and *.dll files
if(CHKSUM_DLL)
  execute_process(
    COMMAND ${signtool_EXECUTABLE} sign ${SIGN_PARAMS} ${CHKSUM_DLL}
    COMMAND_ECHO NONE	# for debug: STDOUT
  )
endif()
