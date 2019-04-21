#!/bin/bash
function oneline_help_ENTRYPOINT_setup() {
  echo "Initialize a development environment"
}
function help_ENTRYPOINT_setup() {
  print_component_help setup
}

function run_ENTRYPOINT_setup() {
  local ENV=$(slugify $1)

  if [ "all" = "$ENV" ]; then
    for COMPONENT in $ENTRYPOINT_COMPONENT_LIST ; do
      ENTRYPOINT_run_component_func setup $COMPONENT
    done
  else
    if ENTRYPOINT_help_on_empty_or_help setup "$ENV"; then
      clear

      if ENTRYPOINT_run_component_func setup $@; then
        echo "Setup"
      fi
    else
      echo "use ENTRYPOINT setup all to setup all"
    fi
  fi
}
export -f run_ENTRYPOINT_setup help_ENTRYPOINT_setup oneline_help_ENTRYPOINT_setup
