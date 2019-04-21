#!/bin/bash

ENTRYPOINT_print_component_help() {
  local FUNC=$1
  shift 1
  local HELP_FUNC="oneline_help_ENTRYPOINT_$FUNC"
  printf "`cat << EOF
${BLUE}ENTRYPOINT $FUNC [COMPONENT] ...${NC}

  Goal : ${YELLOW}$($HELP_FUNC )${NC}

EOF
`\n\n"
  ENTRYPOINT_print_component_list
}
export -f ENTRYPOINT_print_component_help
