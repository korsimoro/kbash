#!/bin/bash
activate_environment_COMPONENT_NAME_help() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX activate COMPONENT_NAME${NC}

EOF
`\n"
}


activate_environment_COMPONENT_NAME() {
  echo "Component[COMPONENT_NAME]:activate"
}
