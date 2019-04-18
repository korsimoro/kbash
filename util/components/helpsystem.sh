#!/bin/bash



function print_component_help() {
  local FUNC=$1
  shift 1
  local HELP_FUNC="oneline_help_kd_$FUNC"
  printf "`cat << EOF
${BLUE}kd $FUNC [COMPONENT] [SUBCOMMAND] ...${NC}

  Goal : ${YELLOW}$($HELP_FUNC )${NC}

  Available Environments:
EOF
`\n\n"
  #echo $FUNC all
  for COMPONENT in $SHELL_PREFIX_COMPONENT_LIST; do
    echo "   $FUNC $COMPONENT"
  done
}

function help_on_empty_or_help() {
  local FUNC=$1
  local ENV=$2

  if [ -z "$ENV" ]; then
    print_component_help $@
    false
  else
    if [ "$ENV" = "help" ]; then
      print_component_help $@
      false
    else
      if [ "$ENV" = "--help" ]; then
        print_component_help $@
        false
      else
        true
      fi
    fi
  fi
}
