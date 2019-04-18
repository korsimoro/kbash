#!/bin/bash
function oneline_help_SHELL_PREFIX_clean() {
  echo "Remove as many artifacts for [C] as we know about"
}
function help_SHELL_PREFIX_clean() {
  print_component_help clean
}

function run_SHELL_PREFIX_clean() {
  run_component_func clean $@
}
