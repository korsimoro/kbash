#!/bin/bash
clean_environment_SHELL_PREFIX_COMPONENT_NAME_help() {
  printf "`cat << EOF
${BLUE}kd build COMPONENT_NAME${NC}

EOF
`\n"
}

clean_environment_SHELL_PREFIX_COMPONENT_NAME() {
  echo "Component[COMPONENT_NAME]:clean"
}
