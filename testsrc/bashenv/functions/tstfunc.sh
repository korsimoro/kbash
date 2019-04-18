#!/bin/bash

function oneline_help_SHELL_PREFIX_tstfunc() {
  echo "tstfunc home, or into $VAR_PREFIX/[C]."
}

function help_SHELL_PREFIX_tstfunc() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX tstfunc${NC}

This is an example of a function at the root level.

EOF
`\n\n"
}

function run_SHELL_PREFIX_tstfunc() {
  echo "running tstfunc"
}
export -f run_SHELL_PREFIX_tstfunc help_SHELL_PREFIX_tstfunc oneline_help_SHELL_PREFIX_tstfunc
