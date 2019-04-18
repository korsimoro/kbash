#!/bin/bash

function oneline_help_SHELL_PREFIX_tstfunc() {
  echo "tstfunc home, or into $VAR_PREFIX/[C]."
}

function help_SHELL_PREFIX_tstfunc() {
printf "`cat << EOF
${BLUE}kx tstfunc <repo>${NC}

This is a shell function, which changes the current working
directory to $PREFIX/<repo>
and if no <repo> is provided this is equivalent to ${BLUE}kx home${NC}.

EOF
`\n\n"
}

function run_SHELL_PREFIX_tstfunc() {
  echo "running tstfunc"
}
export -f run_SHELL_PREFIX_tstfunc help_SHELL_PREFIX_tstfunc oneline_help_SHELL_PREFIX_tstfunc
