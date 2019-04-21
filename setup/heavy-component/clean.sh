#!/bin/bash
clean_environment_ENTRYPOINT_COMPONENT_NAME_help() {
  printf "`cat << EOF
${BLUE}ENTRYPOINT clean COMPONENT_NAME${NC}

EOF
`\n"
}
export -f clean_environment_ENTRYPOINT_COMPONENT_NAME_help

clean_environment_ENTRYPOINT_COMPONENT_NAME() {
  echo "Component[COMPONENT_NAME]:clean"
}
export -f clean_environment_ENTRYPOINT_COMPONENT_NAME
