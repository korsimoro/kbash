#!/bin/bash

SHELL_PREFIX_run_component_func() {
  local FUNC=$1
  shift 1
  local COMPONENT=$(slugify $1)

  if SHELL_PREFIX_help_on_empty_or_help $FUNC "$COMPONENT"; then
    clear
    local CMD=""$FUNC"_environment_SHELL_PREFIX_"$COMPONENT
    if vet_environment_SHELL_PREFIX_$COMPONENT; then
    	if ! $CMD "$@"; then
        echo "Failed to $CMD for $COMPONENT"
        false
      else
        true
      fi
    else
      false
    fi
  else
    false
  fi
}
export -f SHELL_PREFIX_run_component_func
