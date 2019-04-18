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
export -f run_SHELL_PREFIX_describe help_SHELL_PREFIX_describe oneline_help_SHELL_PREFIX_describe
