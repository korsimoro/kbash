#!/bin/bash

function oneline_help_kx_tstfunc() {
  echo "tstfunc home, or into $VAR_PREFIX/[C]."
}

function help_kx_tstfunc() {
printf "`cat << EOF
${BLUE}kx tstfunc <repo>${NC}

This is a shell function, which changes the current working
directory to $PREFIX/<repo>
and if no <repo> is provided this is equivalent to ${BLUE}kx home${NC}.

EOF
`\n\n"
}

function run_kx_tstfunc() {
  echo "running tstfunc"
}
export -f run_kx_tstfunc help_kx_tstfunc oneline_help_kx_tstfunc
