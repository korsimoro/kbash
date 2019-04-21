#!/bin/bash

SHELL_PREFIX_print_component_help() {
  local FUNC=$1
  shift 1
  local HELP_FUNC="oneline_help_SHELL_PREFIX_$FUNC"
  printf "`cat << EOF
${BLUE}SHELL_PREFIX $FUNC [COMPONENT] ...${NC}

  Goal : ${YELLOW}$($HELP_FUNC )${NC}

  Available Environments:
EOF
`\n\n"
  for COMPONENT in $VAR_PREFIX_COMPONENT_LIST; do
    local HELP_FUNC="oneline_description_of_SHELL_PREFIX_$COMPONENT"
    echo "   $COMPONENT  $($HELP_FUNC )"
  done
}
export -f SHELL_PREFIX_print_component_help
