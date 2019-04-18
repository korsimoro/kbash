#!/bin/bash
function oneline_help_SHELL_PREFIX_setup() {
  echo "Initialize a setup environment"
}
function help_SHELL_PREFIX_setup() {
  print_component_help setup
}

function run_SHELL_PREFIX_setup() {
  local ENV=$(slugify $1)

  if [ "all" = "$ENV" ]; then
    for COMPONENT in $SHELL_PREFIX_COMPONENT_LIST ; do
      SHELL_PREFIX_run_component_func setup $COMPONENT
    done
  else
    if SHELL_PREFIX_help_on_empty_or_help setup "$ENV"; then
      clear

      if SHELL_PREFIX_run_component_func setup $@; then
        echo "Setup"
      fi
    else
      echo "use SHELL_PREFIX setup all to setup all"
    fi
  fi
}
export -f run_SHELL_PREFIX_setup help_SHELL_PREFIX_setup oneline_help_SHELL_PREFIX_setup
