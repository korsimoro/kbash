#!/bin/bash

kbash_load_user_environment() {

  local SHELL_PREFIX=$1
  local VAR_PREFIX=$2
  local USER_LOAD_LIST=$3

  local BASHENV_VAR="${VAR_PREFIX}_BASH"

  for FUNCTION_FILE in $USER_LOAD_LIST; do
    kbash_shell_integrate "$SHELL_PREFIX" "$VAR_PREFIX" "${!BASHENV_VAR}/$FUNCTION_FILE"
  done

  kbash_load_functions_from_dir "$SHELL_PREFIX" "$VAR_PREFIX" "${!BASHENV_VAR}/functions"
}
