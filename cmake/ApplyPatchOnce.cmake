# Apply a patch only if it is not applied yet, so that a re-run of the patch
# step on an already patched source tree does not fail.
# Run in the source directory:
#   cmake -DGIT=<git> [-DAPPLY_ARGS=<extra git apply options>] -DPATCH_FILE=<patch> -P ApplyPatchOnce.cmake
execute_process(COMMAND "${GIT}" apply -p1 ${APPLY_ARGS} --reverse --check "${PATCH_FILE}"
  RESULT_VARIABLE already_applied OUTPUT_QUIET ERROR_QUIET)
if(already_applied EQUAL 0)
  message(STATUS "Patch already applied: ${PATCH_FILE}")
else()
  execute_process(COMMAND "${GIT}" apply -p1 ${APPLY_ARGS} "${PATCH_FILE}" RESULT_VARIABLE rc)
  if(NOT rc EQUAL 0)
    message(FATAL_ERROR "Patch does not apply: ${PATCH_FILE}")
  endif()
  message(STATUS "Patch applied: ${PATCH_FILE}")
endif()
