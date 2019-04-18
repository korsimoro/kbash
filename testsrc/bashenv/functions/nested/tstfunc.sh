#!/bin/bash

function oneline_help_SHELL_PREFIX_nested_tstfunc() {
  echo "nested_tstfunc home, or into $VAR_PREFIX/[C]."
}

function help_SHELL_PREFIX_nested_tstfunc() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX nested_tstfunc <repo>${NC}

This is a shell function, which changes the current working
directory to $PREFIX/<repo>
and if no <repo> is provided this is equivalent to ${BLUE}kx home${NC}.

EOF
`\n\n"
}

function run_SHELL_PREFIX_nested_tstfunc() {
  echo "running nested_tstfunc"
}
export -f run_SHELL_PREFIX_nested_tstfunc help_SHELL_PREFIX_nested_tstfunc oneline_help_SHELL_PREFIX_nested_tstfunc
