#!/bin/bash
# testcmd

function print_help() {
printf "`cat << EOF
${BLUE}ENTRYPOINT tstscope tstcmd${NC}

This is a test function nested in a scope

EOF
`\n\n"
}

function run() {
  echo "function tstcmd in scoped ENTRYPOINT"
}
