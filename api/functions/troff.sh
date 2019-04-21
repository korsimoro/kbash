#!/bin/bash


function oneline_help_ENTRYPOINT_troff() {
  echo "Stop bash execution trace."
}
export -f oneline_help_ENTRYPOINT_troff

function cmdline_help_ENTRYPOINT_troff() {
  echo ""
}
export -f cmdline_help_ENTRYPOINT_troff

function help_ENTRYPOINT_troff() {
printf "`cat << EOF
Equivalent to
  set +x
EOF
`\n"
}
export -f help_ENTRYPOINT_troff

function run_ENTRYPOINT_troff() {
  set +x
}
export -f run_ENTRYPOINT_troff
