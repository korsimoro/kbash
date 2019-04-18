#!/bin/bash
build_environment_COMPONENT_NAME_help() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX build COMPONENT_NAME${NC}

EOF
`\n"
}

build_environment_COMPONENT_NAME() {
  echo "Component[COMPONENT_NAME]:build"
}
