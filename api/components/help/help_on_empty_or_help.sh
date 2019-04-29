#!/bin/bash
ENTRYPOINT_help_on_empty_or_help() {
  local FUNC=$1
  local ENV=$2

  if [ -z "$ENV" ]; then
    ENTRYPOINT_print_component_help $@
    false
  else
    if [ "$ENV" = "help" ]; then
      ENTRYPOINT_print_component_help $@
      false
    else
      if [ "$ENV" = "--help" ]; then
        ENTRYPOINT_print_component_help $@
        false
      else
        true
      fi
    fi
  fi
}
export -f ENTRYPOINT_help_on_empty_or_help
