#!/bin/bash
# view docs

print_help() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX COMPONENT_NAME info${NC}

Info about SHELL_PREFIX COMPONENT_NAME

EOF
`\n"
}

run() (
  echo "Info about SHELL_PREFIX COMPONENT_NAME"
)
