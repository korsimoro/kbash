#!/bin/bash
function oneline_help_ENTRYPOINT_clean() {
  echo "Remove as many artifacts for [C] as we know about"
}
function help_ENTRYPOINT_clean() {
  ENTRYPOINT_print_component_help clean
}

function run_ENTRYPOINT_clean() {
  ENTRYPOINT_run_component_func clean $@
}
export -f run_ENTRYPOINT_clean help_ENTRYPOINT_clean oneline_help_ENTRYPOINT_clean
