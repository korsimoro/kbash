#!/bin/bash

function oneline_help_ENTRYPOINT_nested_tstfunc() {
  echo "nested_tstfunc home, or into $VAR_PREFIX/[C]."
}

function help_ENTRYPOINT_nested_tstfunc() {
printf "`cat << EOF
${BLUE}ENTRYPOINT nested_tstfunc${NC}

This is an example of a nested function

EOF
`\n\n"
}

function run_ENTRYPOINT_nested_tstfunc() {
  echo "running nested_tstfunc"
}
export -f run_ENTRYPOINT_nested_tstfunc help_ENTRYPOINT_nested_tstfunc oneline_help_ENTRYPOINT_nested_tstfunc
