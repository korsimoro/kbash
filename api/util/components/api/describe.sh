#!/bin/bash
function oneline_help_SHELL_PREFIX_describe() {
  echo "Describe information about this build env"
}

function help_SHELL_PREFIX_describe() {
  SHELL_PREFIX_print_component_help describe
}

function run_SHELL_PREFIX_describe() {
  SHELL_PREFIX_run_component_func describe $@
}

function describe_active_SHELL_PREFIX_environment() {
  #report_node_environmet
  #report_python_environment
  if [ ! -z "$VAR_PREFIX_ACTIVE_DEVENV" ]; then
    echo "Active Bash environment:$VAR_PREFIX_ACTIVE_DEVENV"
    describe_environment_SHELL_PREFIX_$VAR_PREFIX_ACTIVE_DEVENV
  else
    echo "No environment activated"
  fi
}


export -f run_SHELL_PREFIX_describe help_SHELL_PREFIX_describe oneline_help_SHELL_PREFIX_describe
