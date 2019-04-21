#!/bin/bash
setup_environment_ENTRYPOINT_COMPONENT_NAME_help() {
printf "`cat << EOF
${BLUE}ENTRYPOINT setup COMPONENT_NAME${NC}

EOF
`\n"
}
export -f setup_environment_ENTRYPOINT_COMPONENT_NAME_help

setup_environment_ENTRYPOINT_COMPONENT_NAME() {
  echo "Component[COMPONENT_NAME]:setup"
}
export -f setup_environment_ENTRYPOINT_COMPONENT_NAME
