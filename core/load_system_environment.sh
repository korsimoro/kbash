#!/bin/bash
kbash_load_system_environment() {
  local SHELL_PREFIX=$1
  local VAR_PREFIX=$2
  local SYSTEM_LOAD_LIST=$3

  kbash_load_functions_from_dir "$SHELL_PREFIX" "$VAR_PREFIX" "$kbash_BASE/functions"

  for FUNCTION_FILE in $SYSTEM_LOAD_LIST; do
    kbash_shell_integrate "$SHELL_PREFIX" "$VAR_PREFIX" "$kbash_BASE/$FUNCTION_FILE"
  done
}
