#!/bin/bash
# testcmd

function print_help() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX tstfunc <repo>${NC}

This is a shell function, which changes the current working
directory to $PREFIX/<repo>
and if no <repo> is provided this is equivalent to ${BLUE}kx home${NC}.

EOF
`\n\n"
}

function run() {
  echo "function tstcmd in SHELL_PREFIX"
}
