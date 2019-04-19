#!/bin/bash
setup_environment_SHELL_PREFIX_COMPONENT_NAME_help() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX setup COMPONENT_NAME${NC}

EOF
`\n"
}
export -f setup_environment_SHELL_PREFIX_COMPONENT_NAME_help

setup_environment_SHELL_PREFIX_COMPONENT_NAME() {
  echo "Component[COMPONENT_NAME]:setup"
}
export -f setup_environment_SHELL_PREFIX_COMPONENT_NAME
