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
    local HELP_FUNC="oneline_description_of_$COMPONENT"
    echo "   $COMPONENT  $($HELP_FUNC )"
  done
}

SHELL_PREFIX_help_on_empty_or_help() {
  local FUNC=$1
  local ENV=$2

  if [ -z "$ENV" ]; then
    SHELL_PREFIX_print_component_help $@
    false
  else
    if [ "$ENV" = "help" ]; then
      SHELL_PREFIX_print_component_help $@
      false
    else
      if [ "$ENV" = "--help" ]; then
        SHELL_PREFIX_print_component_help $@
        false
      else
        true
      fi
    fi
  fi
}
export -f SHELL_PREFIX_help_on_empty_or_help SHELL_PREFIX_print_component_help
