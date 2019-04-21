#!/bin/bash
# testcmd

function print_help() {
printf "`cat << EOF
${BLUE}ENTRYPOINT tstcmd${NC}

This is a tstcmd at the root level.

EOF
`\n\n"
}

function run() {
  echo "function tstcmd in ENTRYPOINT"
}
