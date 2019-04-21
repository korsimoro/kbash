#!/bin/bash


function oneline_help_ENTRYPOINT_parallel() {
  echo "Control how many jobs run in parallel."
}

function cmdline_help_ENTRYPOINT_parallel() {
  echo "MAXJOBS"
}

function help_ENTRYPOINT_parallel() {
printf "`cat << EOF

Control how many jobs run in parallel

EOF
`\n"
}

function run_ENTRYPOINT_parallel() {
  local NEWVAL=$(slugify $1)
  if ENTRYPOINT_help_on_empty_or_help parallel "$NEWVAL"; then
    ENTRYPOINT_MAX_PARALLEL=$NEWVAL
  fi
}
export -f run_ENTRYPOINT_parallel help_ENTRYPOINT_parallel oneline_help_ENTRYPOINT_parallel
