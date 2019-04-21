#!/bin/bash


function oneline_help_ENTRYPOINT_tron() {
  echo "Start bash execution trace."
}
export -f oneline_help_ENTRYPOINT_tron

function cmdline_help_ENTRYPOINT_tron() {
  echo ""
}
export -f cmdline_help_ENTRYPOINT_tron

function help_ENTRYPOINT_tron() {
printf "`cat << EOF
Equivalent to
  set -x
EOF
`\n"
}
export -f help_ENTRYPOINT_tron

function run_ENTRYPOINT_tron() {
  set -x
}
export -f run_ENTRYPOINT_tron
