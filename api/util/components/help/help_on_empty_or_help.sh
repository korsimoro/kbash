#!/bin/bash
SHELL_PREFIX_help_on_empty_or_help() {
  local FUNC=$1
  local ENV=$2

  if [ -z "$ENV" ]; then
    SHELL_PREFIX_print_component_help $@
    false
  else
    if [ "$ENV" = "help" ]; then
      SHELL_PREFIX_print_component_help $@
      false
    else
      if [ "$ENV" = "--help" ]; then
        SHELL_PREFIX_print_component_help $@
        false
      else
        true
      fi
    fi
  fi
}
export -f SHELL_PREFIX_help_on_empty_or_help
