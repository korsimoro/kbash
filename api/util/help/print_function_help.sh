#!/bin/bash

ENTRYPOINT_print_function_help() {
  local FUNC=$1
  shift 1
  local HELP_FUNC="help_ENTRYPOINT_$FUNC"
  local CMDLINE_HELP_FUNC="cmdline_help_ENTRYPOINT_$FUNC"
  local ONELINE_HELP_FUNC="oneline_help_ENTRYPOINT_$FUNC"
  printf "`cat << EOF
${BLUE}ENTRYPOINT $FUNC [help|--help|-help|-h|?] $($CMDLINE_HELP_FUNC )${NC}

${YELLOW}$($ONELINE_HELP_FUNC )${NC}

EOF
`\n\n"

  $HELP_FUNC

  printf "\n\n"
}
export -f ENTRYPOINT_print_function_help
