#!/bin/bash
build_environment_SHELL_PREFIX_COMPONENT_NAME_help() {
printf "`cat << EOF
${BLUE}SHELL_PREFIX build COMPONENT_NAME${NC}

EOF
`\n"
}
export -f build_environment_SHELL_PREFIX_COMPONENT_NAME_help

build_environment_SHELL_PREFIX_COMPONENT_NAME() {
  echo "Component[COMPONENT_NAME]:build"
}
export -f build_environment_SHELL_PREFIX_COMPONENT_NAME
