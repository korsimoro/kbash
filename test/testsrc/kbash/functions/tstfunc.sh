#!/bin/bash

function oneline_help_ENTRYPOINT_tstfunc() {
  echo "tstfunc home, or into $VAR_PREFIX/[C]."
}

function help_ENTRYPOINT_tstfunc() {
printf "`cat << EOF
${BLUE}ENTRYPOINT tstfunc${NC}

This is an example of a function at the root level.

EOF
`\n\n"
}

function run_ENTRYPOINT_tstfunc() {
  echo "running tstfunc"
}
export -f run_ENTRYPOINT_tstfunc help_ENTRYPOINT_tstfunc oneline_help_ENTRYPOINT_tstfunc
