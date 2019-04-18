#!/bin/bash


function oneline_help_SHELL_PREFIX_parallel() {
  echo "Control how many jobs run in parallel."
}

function help_SHELL_PREFIX_parallel() {
printf "`cat << EOF
${BLUE}kd parallel [VALUE]${NC}

Control how many jobs run in parallel

EOF
`\n"
}

function run_SHELL_PREFIX_parallel() {
  local NEWVAL=$(slugify $1)
  if help_on_empty_or_help parallel "$NEWVAL"; then
    SHELL_PREFIX_MAX_PARALLEL=$NEWVAL
  fi
}
