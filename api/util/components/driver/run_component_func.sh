#!/bin/bash

ENTRYPOINT_run_component_func() {
  local FUNC=$1
  shift 1
  local COMPONENT=$(slugify $1)

  if ENTRYPOINT_help_on_empty_or_help $FUNC "$COMPONENT"; then
    clear
    local CMD=""$FUNC"_environment_ENTRYPOINT_"$COMPONENT
    if vet_environment_ENTRYPOINT_$COMPONENT; then
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
export -f ENTRYPOINT_run_component_func
