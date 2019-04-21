#!/bin/bash
# kbash_load_functions_from_dir SHELL_PREFIX VAR_PREFIX DIR_TO_SCAN
#
# - ```SHELL_PREFIX``` - passed to ```kbash_shell_integrate```
# - ```VAR_PREFIX``` - passed to ```kbash_shell_integrate```
# - ```DIR_TO_SCAN``` - directory containing hierarchy of functions
#
#
kbash_load_functions_from_dir() {
  # rename command line
  local SHELL_PREFIX=$1
  local VAR_PREFIX=$2
  local DIR_TO_SCAN=$3

  # recursively scan $DIR_TO_SCAN and return a set of relative pointers to
  # all of the .sh files in the hierarchy.
  local FUNC_FILES=$(find_dot_sh $DIR_TO_SCAN)

  # calculate the name of the environment's _FUNCTION_LIST
  local BASHENV_VAR="${VAR_PREFIX}_FUNCTION_LIST"

  for FUNCTION_FILE in $FUNC_FILES; do
    local FUNC_NAME=$(function_slug "$FUNCTION_FILE" )
    kbash_shell_integrate "$SHELL_PREFIX" "$VAR_PREFIX" "$DIR_TO_SCAN/$FUNCTION_FILE"
    eval $BASHENV_VAR=\"$(echo "${!BASHENV_VAR} $FUNC_NAME")\"
  done
  eval $BASHENV_VAR=\"$(sort_list "${!BASHENV_VAR}")\"
}
