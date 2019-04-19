#!/bin/bash
activate_environment_SHELL_PREFIX_COMPONENT_NAME_help() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX activate COMPONENT_NAME${NC}

EOF
`\n"
}
export -f activate_environment_SHELL_PREFIX_COMPONENT_NAME_help

activate_environment_SHELL_PREFIX_COMPONENT_NAME() {
  echo "Component[COMPONENT_NAME]:activate"
}
export -f activate_environment_SHELL_PREFIX_COMPONENT_NAME
