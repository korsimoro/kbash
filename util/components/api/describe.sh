#!/bin/bash
function oneline_help_SHELL_PREFIX_describe() {
  echo "MacGyver It! : Troubleshooting information"
}

function help_SHELL_PREFIX_describe() {
  print_component_help describe
}

function run_SHELL_PREFIX_describe() {
  run_component_func describe $@
}
