# Script for finding and signing *.exe and *.dll files

# Find relevant files requirering signature
file(GLOB_RECURSE DLL_LIST "${ONELUAPRO_PREFIX}/*.dll")
file(GLOB_RECURSE EXE_LIST "${ONELUAPRO_PREFIX}/*.exe")

# Include signtool cmd line args (sets SIGN_PARAMS)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
include(CodeSignParams)

# Sign *.exe and *.dll files
if(EXE_LIST OR DLL_LIST)
  execute_process(
    COMMAND ${signtool_EXECUTABLE} sign ${SIGN_PARAMS} ${EXE_LIST} ${DLL_LIST}
    COMMAND_ECHO NONE	# for debug: STDOUT
  )
endif()
