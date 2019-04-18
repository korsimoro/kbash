#!/bin/bash
# testcmd

function print_help() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX tstcmd${NC}

This is a tstcmd at the root level.

EOF
`\n\n"
}

function run() {
  echo "function tstcmd in SHELL_PREFIX"
}
