#!/bin/bash
function oneline_help_ENTRYPOINT_describe() {
  echo "Describe information about this build env"
}
function cmdline_help_ENTRYPOINT_describe() {
  echo "[COMPONENT]"
}
export -f cmdline_help_ENTRYPOINT_describe

function help_ENTRYPOINT_describe() {
  ENTRYPOINT_print_component_help describe
}

function run_ENTRYPOINT_describe() {
  ENTRYPOINT_run_component_func describe $@
}

function describe_active_ENTRYPOINT_environment() {
  #report_node_environmet
  #report_python_environment
  if [ ! -z "$VAR_PREFIX_ACTIVE_DEVENV" ]; then
    echo "Active Bash environment:$VAR_PREFIX_ACTIVE_DEVENV"
    describe_environment_ENTRYPOINT_$VAR_PREFIX_ACTIVE_DEVENV
  else
    echo "No environment activated"
  fi
}


export -f run_ENTRYPOINT_describe help_ENTRYPOINT_describe oneline_help_ENTRYPOINT_describe
