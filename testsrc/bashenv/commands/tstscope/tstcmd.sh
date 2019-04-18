#!/bin/bash
# testcmd

function print_help() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX tstscope tstcmd${NC}

This is a test function nested in a scope

EOF
`\n\n"
}

function run() {
  echo "function tstcmd in scoped SHELL_PREFIX"
}
