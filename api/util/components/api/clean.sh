#!/bin/bash
function oneline_help_SHELL_PREFIX_clean() {
  echo "Remove as many artifacts for [C] as we know about"
}
function help_SHELL_PREFIX_clean() {
  SHELL_PREFIX_print_component_help clean
}

function run_SHELL_PREFIX_clean() {
  SHELL_PREFIX_run_component_func clean $@
}
export -f run_SHELL_PREFIX_clean help_SHELL_PREFIX_clean oneline_help_SHELL_PREFIX_clean
